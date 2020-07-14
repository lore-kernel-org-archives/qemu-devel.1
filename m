Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96943C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8DD22200
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LM0Wc16u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8DD22200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvI2W-0005i8-Ef
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 06:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvI1m-0004s7-3w
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:19:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60228
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvI1j-0007Vu-Jh
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594721946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fQj098M9Q9Ug7cVC43OrGrwumLip2+Q+GCT4sGB58Ic=;
 b=LM0Wc16uLEIIUiU0cGCfHpCqTscR+0xkTzMf8YTAEcc+Sq24hyPEt+YOIOC9NMXAT+skpJ
 xl2iPILkvwyPL4iPzxKtLqg1NHc2uPcXE4CtCKZ+Z8RH/QGcbulXoYDlGS7YaVTxEq3dzo
 YoAHrObonHbRu+SvgrDEyVg53Ug9Y3I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-KhkSeE8HPs-KTCZd0hYO7g-1; Tue, 14 Jul 2020 06:19:01 -0400
X-MC-Unique: KhkSeE8HPs-KTCZd0hYO7g-1
Received: by mail-wm1-f72.google.com with SMTP id t18so3214989wmj.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 03:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fQj098M9Q9Ug7cVC43OrGrwumLip2+Q+GCT4sGB58Ic=;
 b=qx/sh84dJCQW6PK7ZSg+7CHtcCTSdNq0EndAeGmRHlTGRMmZasOGdK+W4huiKZDCri
 NVDgd0TIAVEFGF2gK7FHSEswMXODoAS7i1A8CpmesCQo5/jUxa7asnNytVXPB0VGIC1Y
 2vSGg3ISKxyWbzirW1qcYJQU7DJbro4U7A2AJjEySE9XFxOYe5H3RmjaTwmY3DqOTiI7
 NGzEiyopB3qtrIl6L8rD00jMXfrMEKkftRJidl4nqTvL9f7NbAlT0ZGYLlmxKyNLl1Dt
 c6tFdfMwwT9BOVNrs2aeflXtVM9okswcqyrhs67x9uvZy4heyxGaI3gP0NBxbwmEBQcA
 BqRQ==
X-Gm-Message-State: AOAM533ad12D2O79G4W1eRkFXfhRoCz5nAqY7e4I9LSrD9+XdIpXmMuL
 PKHG6c5SzVf2Z6hwp890HPU+J3gETbdjIx+jIxocKqa65qbaWtpbfzBa2C129yUDw/4nj6LYyM4
 Lach2CTzMNLwXCqA=
X-Received: by 2002:a7b:c013:: with SMTP id c19mr3456166wmb.158.1594721939460; 
 Tue, 14 Jul 2020 03:18:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0KUN7LYt8b6xhaKfPy3B9sDipGiodbwGdKmafAJb96mjSiD5NqeQW6gt4MCdFZ0nGFSn6Mg==
X-Received: by 2002:a7b:c013:: with SMTP id c19mr3456118wmb.158.1594721938890; 
 Tue, 14 Jul 2020 03:18:58 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id x1sm27445304wrp.10.2020.07.14.03.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 03:18:58 -0700 (PDT)
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
To: P J P <ppandit@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <ee963076-4201-222b-65de-3c1fbe714175@redhat.com>
Date: Tue, 14 Jul 2020 12:18:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714083631.888605-2-ppandit@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Prasad,

On 7/14/20 10:36 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> QEMU supports numerous virtualisation and emulation use cases.
> It also offers many features to support guest's function(s).
> 
> All of these use cases and features are not always security relevant.
> Because some maybe used in trusted environments only. Some may still
> be in experimental stage. While other could be very old and not
> used or maintained actively.
> 
> For security bug analysis we generally consider use cases wherein
> QEMU is used in conjunction with the KVM hypervisor, which enables
> guest to use hardware processor's virtualisation features.
> 
> The CVE (or Security or Trust) Quotient field tries to capture this
> sensitivity pertaining to a feature or section of the code.
> 
> It indicates whether a potential issue should be treated as a security
> one OR it could be fixed as a regular non-security bug.
> 
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  MAINTAINERS | 324 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 324 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe8139f367..badf1dab6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -33,6 +33,14 @@ Descriptions of section entries:
>  	   Obsolete:	Old code. Something tagged obsolete generally means
>  			it has been replaced by a better system and you
>  			should be using that.
> +	C: CVE/Security/Trust Quotient
> +	   H:High - Feature (or code) is meant to be safe and used by untrusted
> +	            guests. So any potential security issue must be processed with
> +	            due care and be considered as a CVE issue.
> +	   L:Low  - Feature (or code) is not meant to be safe OR is experimental
> +	            OR is used in trusted environments only OR is not well
> +	            maintained. So any potential security issue can be processed
> +	            and fixed as regular non-security bug. No need for a CVE.

I'm not sure we need this separation of good/bad citizen.

We already have the 'S' flag:

        S: Status, one of the following:
           Supported:   Someone is actually paid to look after this.
           Maintained:  Someone actually looks after it.
           Odd Fixes:   It has a maintainer but they don't have time to
                        do much other than throw the odd patch in. See
                        below.
           Orphan:      No current maintainer [but maybe you could take
                        the role as you write your new code].
           Obsolete:    Old code. Something tagged obsolete generally
                        means it has been replaced by a better system
                        and you should be using that.

I think the 'Supported' status already describes a feature that
important enough to a company to have an employee looking at it.

If a section is not 'Supported', it is unlikely the maintainer
have time to deal with security issues.

I disagree with the High/Low tag, but I still reviewed the rest.

>  	F: Files and directories with wildcard patterns.
>  	   A trailing slash includes all files and subdirectory files.
>  	   F:	drivers/net/	all files in and below drivers/net
> @@ -87,6 +95,7 @@ S390 general architecture support
>  M: Cornelia Huck <cohuck@redhat.com>
>  M: Thomas Huth <thuth@redhat.com>
>  S: Supported
> +C: High
>  F: default-configs/s390x-softmmu.mak
>  F: gdb-xml/s390*.xml
>  F: hw/char/sclp*.[hc]

> @@ -149,6 +161,7 @@ ARM TCG CPUs
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
> +C: Low
>  F: target/arm/

There is KVM code there.

>  F: tests/tcg/arm/
>  F: tests/tcg/aarch64/
> @@ -164,6 +177,7 @@ ARM SMMU
>  M: Eric Auger <eric.auger@redhat.com>
>  L: qemu-arm@nongnu.org
>  S: Maintained
> +C: High
>  F: hw/arm/smmu*
>  F: include/hw/arm/smmu*
>  
...

> @@ -270,6 +294,7 @@ PowerPC TCG CPUs
>  M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
>  S: Maintained
> +C: High

You might want to split this section in 2 to keep various
areas in Low.

>  F: target/ppc/
>  F: hw/ppc/
>  F: include/hw/ppc/
...

> @@ -440,6 +482,7 @@ M: Cameron Esfahani <dirty@apple.com>
>  M: Roman Bolshakov <r.bolshakov@yadro.com>
>  W: https://wiki.qemu.org/Features/HVF
>  S: Maintained
> +C: Low
>  F: accel/stubs/hvf-stub.c
>  F: target/i386/hvf/
>  F: include/sysemu/hvf.h
> @@ -447,6 +490,7 @@ F: include/sysemu/hvf.h
>  WHPX CPUs
>  M: Sunil Muthuswamy <sunilmut@microsoft.com>
>  S: Supported
> +C: Low

I think this is High.

>  F: target/i386/whpx-all.c
>  F: target/i386/whp-dispatch.h
>  F: accel/stubs/whpx-stub.c
> @@ -460,6 +504,7 @@ M: Anthony Perard <anthony.perard@citrix.com>
>  M: Paul Durrant <paul@xen.org>
>  L: xen-devel@lists.xenproject.org
>  S: Supported
> +C: High
>  F: */xen*
>  F: accel/xen/*
>  F: hw/9pfs/xen-9p*
> @@ -486,6 +531,7 @@ M: Colin Xu <colin.xu@intel.com>
>  L: haxm-team@intel.com
>  W: https://github.com/intel/haxm/issues
>  S: Maintained
> +C: Low

Ditto.

>  F: accel/stubs/hax-stub.c
>  F: include/sysemu/hax.h
>  F: target/i386/hax-*
> @@ -497,12 +543,14 @@ M: Michael S. Tsirkin <mst@redhat.com>
>  M: Cornelia Huck <cohuck@redhat.com>
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> +C: High
>  F: linux-headers/
>  F: scripts/update-linux-headers.sh
...
> @@ -1631,11 +1782,13 @@ Character devices
>  M: Marc-AndrÃƒÆ’Ã‚Â© Lureau <marcandre.lureau@redhat.com>
>  R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Odd Fixes
> +C: High
>  F: hw/char/
>  
>  Network devices
>  M: Jason Wang <jasowang@redhat.com>
>  S: Odd Fixes
> +C: High
>  F: hw/net/
>  F: include/hw/net/
>  F: tests/qtest/virtio-net-test.c

These two don't make sense to me. You can not be low class citizen
only maintained for 'Odd Fixes' and aim for security. Choose one.

>  SD (Secure Card)
>  M: Philippe Mathieu-DaudÃƒÆ’Ã‚Â© <f4bug@amsat.org>
>  S: Odd Fixes
> +C: Low
>  F: include/hw/sd/sd*
>  F: hw/sd/core.c
>  F: hw/sd/sd*
> @@ -1684,6 +1842,7 @@ F: tests/qtest/sd*
>  USB
>  M: Gerd Hoffmann <kraxel@redhat.com>
>  S: Maintained
> +C: High
>  F: hw/usb/*

Similarly to PPC, you might want to split this one to reduce
coverage.

>  F: tests/qtest/usb-*-test.c
>  F: docs/usb2.txt
> @@ -1696,11 +1855,13 @@ USB (serial adapter)
>  M: Gerd Hoffmann <kraxel@redhat.com>
>  M: Samuel Thibault <samuel.thibault@ens-lyon.org>
>  S: Maintained
> +C: High
>  F: hw/usb/dev-serial.c
...

>  tulip
>  M: Sven Schnelle <svens@stackframe.org>
>  S: Maintained
> +C: High

Low.

>  F: hw/net/tulip.c
>  F: hw/net/tulip.h
>  
>  Generic Loader
>  M: Alistair Francis <alistair@alistair23.me>
>  S: Maintained
> +C: High
>  F: hw/core/generic-loader.c
>  F: include/hw/core/generic-loader.h
>  F: docs/generic-loader.txt

I'm not sure about this one.

> @@ -1921,12 +2108,14 @@ F: docs/generic-loader.txt
>  Intel Hexadecimal Object File Loader
>  M: Su Hang <suhang16@mails.ucas.ac.cn>
>  S: Maintained
> +C: Low
>  F: tests/qtest/hexloader-test.c
>  F: tests/data/hex-loader/test.hex
...

>  EDID Generator
>  M: Gerd Hoffmann <kraxel@redhat.com>
>  S: Maintained
> +C: Low
>  F: hw/display/edid*
>  F: include/hw/display/edid.h
>  F: qemu-edid.c

I'm not sure, but maybe.

> @@ -2012,6 +2211,7 @@ PIIX4 South Bridge (i82371AB)
>  M: HervÃƒÆ’Ã‚Â© Poussineau <hpoussin@reactos.org>
>  M: Philippe Mathieu-DaudÃƒÆ’Ã‚Â© <f4bug@amsat.org>
>  S: Maintained
> +C: High

No, this one is low (which is why it has is own section,
to not bother MST).

>  F: hw/isa/piix4.c
>  F: include/hw/southbridge/piix.h
...

>  Device Tree
>  M: Alistair Francis <alistair.francis@wdc.com>
>  R: David Gibson <david@gibson.dropbear.id.au>
>  S: Maintained
> +C: Low
>  F: device_tree.c
>  F: include/sysemu/device_tree.h

This one is consumed by the Virt machine, maybe High?

>  
>  Dump
>  S: Supported
> +C: Low
>  M: Marc-AndrÃƒÆ’Ã‚Â© Lureau <marcandre.lureau@redhat.com>
>  F: dump/
>  F: hw/misc/vmcoreinfo.c
...

>  QObject
>  M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
> +C: Low
>  F: qobject/
>  F: include/qapi/qmp/
>  X: include/qapi/qmp/dispatch.h

Low? Odd.

> @@ -2385,6 +2620,7 @@ T: git https://repo.or.cz/qemu/armbru.git qapi-next
>  QEMU Guest Agent
>  M: Michael Roth <mdroth@linux.vnet.ibm.com>
>  S: Maintained
> +C: Low

Odd too.

>  F: qga/
>  F: docs/interop/qemu-ga.rst
>  F: scripts/qemu-guest-agent/
> @@ -2397,6 +2633,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
>  R: Daniel P. Berrange <berrange@redhat.com>
>  R: Eduardo Habkost <ehabkost@redhat.com>
>  S: Supported
> +C: High
>  F: docs/qdev-device-use.txt
>  F: hw/core/qdev*
>  F: hw/core/bus.c
...

>  Register API
>  M: Alistair Francis <alistair@alistair23.me>
>  S: Maintained
> +C: High

No, Low.

>  F: hw/core/register.c
>  F: include/hw/register.h
>  F: include/hw/registerfields.h
> @@ -2456,6 +2697,7 @@ F: include/hw/registerfields.h
...

>  Tracing
>  M: Stefan Hajnoczi <stefanha@redhat.com>
>  S: Maintained
> +C: Low

Some backends are High.

>  F: trace/
>  F: trace-events
>  F: docs/qemu-option-trace.rst.inc
> @@ -2488,6 +2733,7 @@ T: git https://github.com/stefanha/qemu.git tracing
>  TPM
>  M: Stefan Berger <stefanb@linux.ibm.com>
>  S: Maintained
> +C: Low

High!!!

>  F: tpm.c
>  F: stubs/tpm.c
>  F: hw/tpm/*
> @@ -2500,12 +2746,14 @@ T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
...

> @@ -2601,6 +2859,7 @@ L: qemu-block@nongnu.org
>  UUID
>  M: Fam Zheng <fam@euphon.net>
>  S: Supported
> +C: Low

High?

>  F: util/uuid.c
>  F: include/qemu/uuid.h
>  F: tests/test-uuid.c
> @@ -2608,6 +2867,7 @@ F: tests/test-uuid.c
...

>  Null Block Driver
>  M: Fam Zheng <fam@euphon.net>
>  L: qemu-block@nongnu.org
>  S: Supported
> +C: Low

High?

>  F: block/null.c
>  
>  NVMe Block Driver
>  M: Fam Zheng <fam@euphon.net>
>  L: qemu-block@nongnu.org
>  S: Supported
> +C: Low

Certainly High.

>  F: block/nvme*
>  
>  Bootdevice
>  M: Gonglei <arei.gonglei@huawei.com>
>  S: Maintained
> +C: Low
>  F: bootdevice.c
...

>  Replication
>  M: Wen Congyang <wencongyang2@huawei.com>
>  M: Xie Changlong <xiechanglong.d@gmail.com>
>  S: Supported
> +C: Low

High?

>  F: replication*
>  F: block/replication.c
>  F: tests/test-replication.c
> @@ -2997,6 +3309,7 @@ PVRDMA
>  M: Yuval Shaia <yuval.shaia.ml@gmail.com>
>  M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>  S: Maintained
> +C: High
>  F: hw/rdma/*
>  F: hw/rdma/vmw/*
>  F: docs/pvrdma.txt
...


