Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AA2C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7A92074B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNwee64b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7A92074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPPq-000828-Bs
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXP0v-0001md-II
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXP0t-0007V5-Qp
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603805267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7opIyTrwRWqtBX3s3719/1lE0QiMqv4CYXfb1cNUZeA=;
 b=iNwee64b6bgPApjnNIHTazwD7wGxm3w7ZFryCrLPmpGrX+nEmDyXh1cBG/tGEtNHXDMBfG
 GHjGXqddn2Z5vCWnmt/W2/vIuv+qqg8Thq0k7DzJQ5SdE43lAuD9WrxzWlkla8IWazUeYF
 MbL+BXItSaiw8k8mVkzyzLecM10O5lc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-t4f64jIbMNioaC33zEYKWQ-1; Tue, 27 Oct 2020 09:27:45 -0400
X-MC-Unique: t4f64jIbMNioaC33zEYKWQ-1
Received: by mail-wr1-f71.google.com with SMTP id j13so411624wrn.4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7opIyTrwRWqtBX3s3719/1lE0QiMqv4CYXfb1cNUZeA=;
 b=XNZkMU/+qkdzU3Z/cHusjQgCTNBrRo47afv+yS/nu/NgPmszkkB+GNWOolOzC2oT8u
 NH3amyhaU3/VQhzbVqgpJowyBnUANUrbJD7IDduRVWWMcg4iOfmY/SJcdVxbpHFeb9C0
 WCtzBFQxb+6ClGSaWn9j4aRITPTib+RKO4H8MUxerhaPHnuHuGXpVuFWKUJkWgml6wJX
 sIKwxTWjAL2QKEFMo4T3kcnY6ITCXlzTXwKQpRUK77H9nLcoi2mp4Pj2MBBMZE8eTFtj
 YOlLNtKoGdMLq2CJn5FP3a8eR/xC7qBaXETP/iyVrprsTIWDZAThwAQz6QUdP/mcDBYr
 tjjA==
X-Gm-Message-State: AOAM533l/L2DpzZLM5J+qQvVUcGarFBKyBOFMwz4Rk0W2Mjj6L4zpqrd
 UoUyRGKJ2nhjy08kKYqDC96MwxH8TX1Q63LIHLTZ3Qqzhg7M9EUdNPBSVPn3ohNJwCh8/cjjqYe
 FGwJmZz8J1Umromg=
X-Received: by 2002:a1c:f612:: with SMTP id w18mr2817461wmc.11.1603805264439; 
 Tue, 27 Oct 2020 06:27:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQVEeg52ZGVWimCPRCtEEPwMTgwy2PuxVHipsEymUhRcLt7HSEVhdGNkh+f8q7MwU3SPRHmA==
X-Received: by 2002:a1c:f612:: with SMTP id w18mr2817448wmc.11.1603805264260; 
 Tue, 27 Oct 2020 06:27:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id x18sm2205496wrg.4.2020.10.27.06.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 06:27:43 -0700 (PDT)
Subject: Re: [PULL 01/17] build: fix macOS --enable-modules build
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201026135131.3006712-1-pbonzini@redhat.com>
 <20201026135131.3006712-2-pbonzini@redhat.com>
 <d87ec2b2-225e-353f-e561-e46c2d15b7b1@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f610856-6afe-d3ad-515e-dc736cea0995@redhat.com>
Date: Tue, 27 Oct 2020 14:27:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <d87ec2b2-225e-353f-e561-e46c2d15b7b1@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Emmanuel Blot <eblot.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/10/20 10:27, Philippe Mathieu-Daudé wrote:
> I'm confused as this broke the catalina-xcode test:
> 
> PASS 5 qtest-aarch64/device-introspect-test
> /aarch64/device/introspect/abstract-interfaces
> missing object type 'virtio-gpu-device'
> Broken pipe
> ../tests/qtest/libqtest.c:176: kill_qemu() detected QEMU death from
> signal 6 (Abort trap: 6)
> ERROR qtest-aarch64/device-introspect-test - too few tests run (expected
> 6, got 5)
> gmake: *** [Makefile.mtest:905: run-test-111] Error 1
> 

It's showing that there is still a bug with macOS modules, Gerd was
looking at it (Emmanuel could so as well :)).

Paolo


