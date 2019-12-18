Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF4CC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734A22176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsNnZgRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734A22176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihgCZ-0003rf-Kh
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 15:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihgBO-0002ct-KG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihgBN-0005zm-0I
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:44:34 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihgBM-0005u6-El
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:44:32 -0500
Received: by mail-pl1-x641.google.com with SMTP id b22so1492230pls.12
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 12:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hx95OyaG6MqHCdsFBIXIiXsvovMiVCSH3FKPDjN/6WY=;
 b=UsNnZgRbhrHE74s+Y0gT23UUgUs1jGC47yo1iLtrOGZpR4nYucTXmbtGGb5MHA8dIf
 4RjYWukG1+PXQgM+WvoXqVwMd6dsnhsfeEMp88gTGi4zssIU56jIuRyN7bZikZvg2oY9
 5QQuOB2CeEqjG58lsS8yJD/HI14Mceq4BGE4194tENFkxkdHkhutttnJWQ/maa/3v5hI
 xMwybm+viLIQQ7O1Gcl1QrHWU/IAjO25g2gWwUJOMsOfK1R/rsApvajg5atogy1fnnM1
 9M2b7yzgi7/2Es3mOzVpzZnNu/farTn+N3wof0vTuOa2VGjnAwijYOV/f+sMP9a6wTKe
 WPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hx95OyaG6MqHCdsFBIXIiXsvovMiVCSH3FKPDjN/6WY=;
 b=QWfggdG12kPPuhcx4sBkE7rdu5jLxiSsyNAkFsCiUxkhLnMF+lt3ZhxYSoO3xIX8gn
 fKebBS+gc0LQorZk/xGzoSe4BIx0FOm93j273MLWri7siO//yeznJCqCbyO4ARrRVIx+
 i12l+OVz5w1cYXz4beTz3dn8kgIytDst+O+gsPVOsG3KoE3ZzlydOPrMW8LxPDGJyxh6
 a1CtoLkGWrObJmYMYLwBIltuWH5bS9lEjavYTHhFL5sb9rb110ijs7UrAEJo0o6pbcOK
 8748bSBOAVIXGClIDiqM6WT7GKV52EkxHTNXmxdzIjg8/9SqxagT5mgylHL6Iwl+8OCF
 hHaQ==
X-Gm-Message-State: APjAAAUihNxTKwVm8kHK6KdWom8ofdLL9WzVu/cg0e6oWMTcpdQmw+z4
 S0cKG9RuYvWs0AfmmIjjmION0w==
X-Google-Smtp-Source: APXvYqwVxVL3Hy6fs5yv8x16VFaZHBLw+vLi/oQiTCjEj3vG/sK7eDsdh4TZ3GUPpQeDAknI3gdWsg==
X-Received: by 2002:a17:902:363:: with SMTP id 90mr4845316pld.71.1576701871230; 
 Wed, 18 Dec 2019 12:44:31 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id ep12sm2325545pjb.7.2019.12.18.12.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 12:44:30 -0800 (PST)
Subject: Re: [RFC PATCH v2 14/14] chardev: Use QEMUChrEvent enum in
 IOEventHandler typedef
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191218172009.8868-1-philmd@redhat.com>
 <20191218172009.8868-15-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a733dce0-4a2e-c0d7-38d5-2ab64ca4d968@linaro.org>
Date: Wed, 18 Dec 2019 10:44:23 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218172009.8868-15-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Alberto Garcia <berto@igalia.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, Michael Walle <michael@walle.cc>,
 Palmer Dabbelt <palmer@dabbelt.com>, Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 7:20 AM, Philippe Mathieu-Daudé wrote:
> The Chardev events are listed in the QEMUChrEvent enum.
> 
> By using the enum in the IOEventHandler typedef we:
> 
> - make the IOEventHandler type more explicit (this handler
>   process out-of-band information, while the IOReadHandler
>   is in-band),
> - help static code analyzers.
> 
> This patch was produced with the following spatch script:
> 
>   @match@
>   expression backend, opaque, context, set_open;
>   identifier fd_can_read, fd_read, fd_event, be_change;
>   @@
>   qemu_chr_fe_set_handlers(backend, fd_can_read, fd_read, fd_event,
>                            be_change, opaque, context, set_open);
> 
>   @depends on match@
>   identifier opaque, event;
>   identifier match.fd_event;
>   @@
>    static
>   -void fd_event(void *opaque, int event)
>   +void fd_event(void *opaque, QEMUChrEvent event)
>    {
>    ...
>    }
> 
> Then the following files were manually modified:
> 
>   - include/chardev/char-fe.h
>   - include/chardev/char.h
>   - include/chardev/char-mux.h
>   - chardev/char.c
>   - chardev/char-mux.c

My guess is that the only change that must be done at the same time as the
spatch is the typedef in char-fe.h.

In particular,

> -static void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
> +static void mux_chr_send_event(MuxChardev *d, int mux_nr, QEMUChrEvent event)

this doesn't appear to be required -- int will implicitly convert to enum when
performing the call, and it can't be related to the typedef.

Yes, we do want to propagate the type up the call stack, but it would be nice
to see the spatch results on their own.


r~

