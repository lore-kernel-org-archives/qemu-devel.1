Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C0EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F17208FE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cL3dJUbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F17208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6N4-0006Am-4h
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kb6Lq-0005IL-9u
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:20:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kb6Lo-0004Al-BZ
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604686839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yb2hUuidUfRqYTLbucNq8j7Pt7L3YOxL3HCfS/WwPao=;
 b=cL3dJUbcQmhqUhPzNF8LlYkbyx5YjpIikobnL/HTL1P9X5lWTi7EI54RF7OY1POBqt/CjU
 GiGt6TyQL9lelwB9gG4CZ2CktqgMOoQq3eGBnoQgT3JZUKgG36o8tmwPip7m9L1vrD4E+C
 VvpJIZBzpNMYqt7/u9X2xiLxw/UDW8M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-T3_FhjNVOwWLKh0ZASAQdQ-1; Fri, 06 Nov 2020 13:20:37 -0500
X-MC-Unique: T3_FhjNVOwWLKh0ZASAQdQ-1
Received: by mail-wr1-f71.google.com with SMTP id q1so766719wrn.5
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 10:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yb2hUuidUfRqYTLbucNq8j7Pt7L3YOxL3HCfS/WwPao=;
 b=hOqioRuQT/OGsByjJfOzBtqS97UfEP1p2bhm+9Tircdrne+Lq1M5jqmlLq9HaSnnST
 65ejmdtzSBInEgSGBDREskbp47/H53vZs8jANga+6IXQdYcLrv6U7dTmb2mPG7S2f3V3
 MXxsjQjv1hx84Qdrtu9kKJ7gYbaKPZy60f180MKV8Ni9T6tuX4quvF7GzDKbl+zf8t0a
 hKKkGM2pRgaGJs3IklVl8OejgY0ifbT2sBm2m+di/6xRkKfeA8PBHy1lWlvWfVWUxroI
 qb3iNVgYXwF/lA7j4S1WPRb4/cVzM0Twyvfz+kBN6Y1I6tbopDvFI70boZqB8BPFpdg3
 ZxKQ==
X-Gm-Message-State: AOAM530w0R1zFYoarqqditYXDbXxXTig4NiYloRGa7O0okSgH33wn/HU
 hhS61hHtGhbUdG6BW4LPAOV75ucSvukaSJnBNV/uFM1qnFxuUEJxHQ0NssObddeozSnZSK397eI
 gPx2qcnlQYZSZ9pU=
X-Received: by 2002:a7b:ce0c:: with SMTP id m12mr874131wmc.114.1604686836029; 
 Fri, 06 Nov 2020 10:20:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxy1Fp5OYnSzX77LozgIFMY/qLNmEaWWyguAnGRHmw1dGZ5G635lUlxB4ia1WlAJvPnB9dGLw==
X-Received: by 2002:a7b:ce0c:: with SMTP id m12mr874120wmc.114.1604686835857; 
 Fri, 06 Nov 2020 10:20:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id u6sm3434154wmj.40.2020.11.06.10.20.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 10:20:34 -0800 (PST)
Subject: Re: [PATCH 2/2] qemu-option: warn for short-form boolean options
To: Markus Armbruster <armbru@redhat.com>
References: <20201105142731.623428-1-pbonzini@redhat.com>
 <20201105142731.623428-3-pbonzini@redhat.com>
 <87361mfn1d.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c094f89-11b6-b6cc-690b-df688e425fd9@redhat.com>
Date: Fri, 6 Nov 2020 19:20:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87361mfn1d.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 06:30:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/11/20 17:49, Markus Armbruster wrote:
>> Deprecate all this, except for -chardev and -spice where it is in
>> wide use.
> I consider this a misuse of deprecation, to be frank.  If something is
> known to be unused, we just remove it.  Deprecation is precisely for
> things that are used.  I'm with Daniel here: let's deprecate this sugar
> everywhere.
> 
> Wide use may justify extending the deprecation grace period.

Fair enough.  However now that I think of it I'd have to remove the 
coverage of the "feature" in tests, because they'd warn.

Paolo


