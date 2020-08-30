Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDB8C433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 09:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22D620738
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 09:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+1sjeJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22D620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCJmg-00086D-1h
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 05:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCJm4-0007hZ-0N
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCJm1-0001vz-Ra
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598780236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fKSW2oWZNc25WyqkY4O+QnA9Q9l4qni1Hb6PUUy+w7U=;
 b=h+1sjeJEByxQLlPHeTVvOWcF1TgN1JBIAJWxvfEAahg5q9dkcwh2nompo5+oWBEoqyXzcC
 23c0959yw95fb2P6/PTA0jU3dBg8v/+F31TqBrdCSPcxUub2iye2yW2g6/5AoqPWbeTRI+
 ImgngG1dJIJnFTBMEzBJFXKUKdHYAPQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-S_S__INcN4iEWMPkqUQorg-1; Sun, 30 Aug 2020 05:37:14 -0400
X-MC-Unique: S_S__INcN4iEWMPkqUQorg-1
Received: by mail-wr1-f70.google.com with SMTP id l17so1861313wrw.11
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 02:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fKSW2oWZNc25WyqkY4O+QnA9Q9l4qni1Hb6PUUy+w7U=;
 b=RCUGCrz5x93sc/sLU8GCS7t90V8/F+7C+6OF1OuokC+YuiTvXe4w9i+A6Nt4eKtRNr
 dsGKkcYMem+BT5zoeWZhavPuI0p+c0FqRJlwbDzTSC0DZZ6v0aG4VCbC+lzGbef9Bu/x
 uU9CC5URNHlbGtLwDEBUlBzJPrUo0UvA6RXA4SnZIthbwfK/QR5+Oq07bPRqQj2WGOxp
 bDS7SE3RWlQumdM2rps1dLjiU9fPFUr9XRVlBD7Hz55dY48ssV7+tB2/nHR7HwsElifQ
 3+zPHXkoKcXdSWof8tQxGZcM0+V7p5oUlN7eLgt64nFi7nYJaNJ0QI9BJHO7GENdW52c
 DHUg==
X-Gm-Message-State: AOAM532ZTzumi8bzipmly26F6a6RB8gf/JSk7jovhqzGHg/6crrOTbEg
 P+L/i3IU0i68cLNP9PsrMLVlX6JKCkXOaBv2nsx3N3Fpcl10HqcWYR7nHqXWWTKQc31u3Lu8P1t
 8WlpdlGYGXQwCKqo=
X-Received: by 2002:a7b:c156:: with SMTP id z22mr6313897wmi.101.1598780233257; 
 Sun, 30 Aug 2020 02:37:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0ZODzd1QmcLrULtqZ74PRNL6wp2GG6xTR2u0IRKmXx7QAa4wD1h2JoG4Vqxh3fVMSGlMQUw==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr6313884wmi.101.1598780233021; 
 Sun, 30 Aug 2020 02:37:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9d8:ed0a:2dde:9ff7?
 ([2001:b07:6468:f312:9d8:ed0a:2dde:9ff7])
 by smtp.gmail.com with ESMTPSA id c8sm6746999wrm.62.2020.08.30.02.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2020 02:37:12 -0700 (PDT)
Subject: Re: [PATCH] meson: set colorout to auto
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20200825064342.2037-1-kraxel@redhat.com>
 <CAJ+F1CJ0J5E2sJ=jvG7m=5pttOYohGvwqUjMFM1Vz5qBmhnk5Q@mail.gmail.com>
 <20200825080657.saqysz6rugvhomrl@sirius.home.kraxel.org>
 <CAJ+F1CLJY0Rc7_abUsqGrzoVTDp=Oe3GEE4X6F9AeQOo9Y0n4Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e7392dae-8d2d-d789-7750-f7c721646cb2@redhat.com>
Date: Sun, 30 Aug 2020 11:37:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLJY0Rc7_abUsqGrzoVTDp=Oe3GEE4X6F9AeQOo9Y0n4Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 05:37:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/08/20 10:11, Marc-André Lureau wrote:
> 
>     As far I know make doesn't redirect output.  Or maybe it redirects using
>     a pty (instead of a pipe) in case stdout is a terminal.  At least auto
>     mode for colored gcc warnings works fine with make.  It is colored when
>     started in a terminal, it isn't when started in emacs (and piped through
>     the emacs message parser).
> 
> Then it looks like you have a legit patch. We can revert it when we
> switch back to ninja some day.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com
> <mailto:marcandre.lureau@redhat.com>>
> 

make has the same issue if you use -O/--output-sync.  Programs are
supposed to check MAKE_TERMOUT and MAKE_TERMERR to decide whether to
colorize output, but I think pretty much no one does?

In any case this would not be a new issue, so b_colorout=auto is
preferrable.

Paolo


