Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1023C4646D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADAFD218AD
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAFD218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hidnk-0000ka-Ro
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 07:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44092)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hidlG-0006n4-6f
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hidlF-0000sf-04
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:49:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hidlC-0000hj-Lw
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:49:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so2420835wre.12
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 04:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wS73TaJtl0+rzEbhXLWXW/ez1DXckwVei2RBCU9vSS8=;
 b=ECoGUOndRV/Zlk2lUjHWPO/sqFAkRBrzDc2TDcr7uBPZ8ChAZamKJGxjUG/vuXRj3j
 8DTl8YiOvlaI6oC4SLHEA8TdrRISSxwYS8yNkcMA/k0g5I7AVIX4e1jUsULZpVZFA9hh
 7YC0jkfb51yQ0INEMUhP1RIyoiiZGOen15NVeAnxHB4gdkC3natIZ8VVqwMnvif+n9+6
 /5z6xZAEjpZl4LQc0Y8Z6cDVlu7IDVxY4q457dHZxsQoDD5CUyIDCxHMh/rSMTfEW8SB
 Fj78KH+Aarpg4fCbD72wKduecBNFOEzM9vXahVcH1K4jmIC7eUVnX4k3L9AuV2LEcj4C
 adsw==
X-Gm-Message-State: APjAAAVi7nC9Ae3krLPI2aXxw0AeL3L1/ZC6nrVhyxdp798eANK+aRkN
 JEfoV6s6gsi8ooynMJkB3oNyGw==
X-Google-Smtp-Source: APXvYqyPvyYkaU4QwxSrC/8MiSGS/N+IoU54l3qyx55P/mmfL4Qz2m1R8obt7CvGEwG/AVAI8ek4/w==
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr30923658wrw.26.1562154545436; 
 Wed, 03 Jul 2019 04:49:05 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id 60sm4088176wrc.68.2019.07.03.04.49.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 04:49:04 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190528082308.22032-1-armbru@redhat.com>
 <20190528082308.22032-4-armbru@redhat.com>
 <87muhvwecf.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8b47584b-734e-3423-521d-0ffe3ab501b8@redhat.com>
Date: Wed, 3 Jul 2019 13:49:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87muhvwecf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 3/4] Makefile: Rename targets for make
 recursion
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
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 1:24 PM, Markus Armbruster wrote:
> Peter pointed out that this makes an incremental build without -k fail
> once.  By "once", I mean it works fine when you retry.  Squashing in the
> appended patch to avoid this inconvenience.
> 
> 
> diff --git a/Makefile b/Makefile
> index e68982bd99..34bbcfc590 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -500,6 +500,12 @@ capstone/all: .git-submodule-status
>  slirp/all: .git-submodule-status
>  	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
>  
> +# Compatibility gunk to keep make working across the rename of targets
> +# for recursion, to be removed some time after 4.1.
> +subdir-dtc: dtc/all
> +subdir-capstone: capstone/all
> +subdir-slirp: slirp/all
> +
>  $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) \
>  	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
>  

Both tags stand:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
(on top of previous patch)

