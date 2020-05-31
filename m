Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB70C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193F120707
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtnr1XvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193F120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfLcT-0008OR-CQ
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 06:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jfLbf-0007uc-7Q
 for qemu-devel@nongnu.org; Sun, 31 May 2020 06:54:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jfLbd-0004Z8-VP
 for qemu-devel@nongnu.org; Sun, 31 May 2020 06:54:18 -0400
Received: by mail-wr1-x443.google.com with SMTP id j10so8525672wrw.8
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 03:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fArpJ2tNrQAkmFgtJ9gv8DT7HSEXD98VTJXEmu6N9Q0=;
 b=mtnr1XvX6sK/zU9zGZb8WLFs7yMtF1hfioxVjuU8/ioa+o4VcRnG9068+X82NMgFgm
 aoi/xxdg96v0QXNWTJZMy5ONi7ImGodmXep7EuSL+/HCEReStTb1kCxQfcmUEXkRNOEe
 W6bnF4vWdJBent58M947tKgOjGAAd8vpxle4rBH0cil3EN7uc34VtlTww7xEKY3uAMNF
 MkHAv9MnF2J28Q8H7lG8x1TAwVXbTECdTsrGb07Yk/i+WGj/rTwE2+J17LiKUdL2Atv8
 0FIMYsq35lV0sLZ9oldSN47NJqvO6hjb9z4FJ5Jn+YJ981PocwHEU8gRDARi6aVYhBTb
 IeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fArpJ2tNrQAkmFgtJ9gv8DT7HSEXD98VTJXEmu6N9Q0=;
 b=Yc3A8GxAXVQP7Zqd/s7UkqpZUNaWmzaxDQNemv3NbF5UZHW6E+ceO6c09YXABGwtx1
 mSbgozq9m2LOpLRoZ+vtV2L/WaV1+EGdpbUNqEwZ3n4OcxzccMaE/5nxxTmSf8f2YbSJ
 McHAcTZsImyyexs+V7k+KJDj7TwBpLvNR4Y6K6Luf3QgIVEDjsg9V0+FnKv+qwDZedAP
 vvt6rODCqKvf2bzmiZmZBlEqHPBYjr/4njzlxB9ULacex2YG44jx09pmj5MPDaWF8t1q
 thn6CCT1YZgKUJaqNfLFZz8HkqGCgbzqk8T8j/XJ1dOxjcL9lsaEa5xpaDWgqWH8PGUy
 HmfQ==
X-Gm-Message-State: AOAM532tNcR5EhVAEFTauD/J/R0i9+RBHgZh7W93th594aKOdrzzlZdo
 JG5zxuGeY9CekOFKJWfCYcIsqw==
X-Google-Smtp-Source: ABdhPJzhfpj9YRr0EtjZnPBWTDy8vg3Lhn58WJ4T5Cn0nrXFdlsVBx7l0ZCZ0gT/L4Xo/p5NBDAQ7A==
X-Received: by 2002:adf:f389:: with SMTP id m9mr16052616wro.195.1590922456109; 
 Sun, 31 May 2020 03:54:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c25sm6975861wmb.44.2020.05.31.03.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 03:54:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 47A7E1FF7E;
 Sun, 31 May 2020 11:54:14 +0100 (BST)
References: <20200529203458.1038-1-robert.foley@linaro.org>
 <20200529203458.1038-9-robert.foley@linaro.org>
 <6f29b51c-b8d6-772c-eb24-b4c88c6c2d62@redhat.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v8 08/12] tests/vm: Added a new script for ubuntu.aarch64.
In-reply-to: <6f29b51c-b8d6-772c-eb24-b4c88c6c2d62@redhat.com>
Date: Sun, 31 May 2020 11:54:14 +0100
Message-ID: <878sh8v0h5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, peter.puhov@linaro.org,
 Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Robert,
>
> On 5/29/20 10:34 PM, Robert Foley wrote:
<snip>
>> diff --git a/configure b/configure
>> index d82de47fdd..8a286e75a5 100755
>> --- a/configure
>> +++ b/configure
>> @@ -411,6 +411,7 @@ prefix=3D"/usr/local"
>>  mandir=3D"\${prefix}/share/man"
>>  datadir=3D"\${prefix}/share"
>>  firmwarepath=3D"\${prefix}/share/qemu-firmware"
>> +efi_aarch64=3D""
>>  qemu_docdir=3D"\${prefix}/share/doc/qemu"
>>  bindir=3D"\${prefix}/bin"
>>  libdir=3D"\${prefix}/lib"
>> @@ -1099,6 +1100,8 @@ for opt do
>>    ;;
>>    --firmwarepath=3D*) firmwarepath=3D"$optarg"
>>    ;;
>> +  --efi-aarch64=3D*) efi_aarch64=3D"$optarg"
>> +  ;;
>>    --host=3D*|--build=3D*|\
>>    --disable-dependency-tracking|\
>>    --sbindir=3D*|--sharedstatedir=3D*|\
>> @@ -1753,6 +1756,7 @@ Advanced options (experts only):
>>    --sysconfdir=3DPATH        install config in PATH$confsuffix
>>    --localstatedir=3DPATH     install local state in PATH (set at runtim=
e on win32)
>>    --firmwarepath=3DPATH      search PATH for firmware files
>> +  --efi-aarch64=3DPATH       PATH of efi file to use for aarch64 VMs.
>>    --with-confsuffix=3DSUFFIX suffix for QEMU data inside datadir/libdir=
/sysconfdir [$confsuffix]
>>    --with-pkgversion=3DVERS   use specified string as sub-version of the=
 package
>>    --enable-debug           enable common debug build options
>> @@ -3548,6 +3552,20 @@ EOF
>>    fi
>>  fi
>>=20=20
>> +############################################
>> +# efi-aarch64 probe
>> +# Check for efi files needed by aarch64 VMs.
>> +# By default we will use the efi included with QEMU.
>> +# Allow user to override the path for efi also.
>> +if ! test -f "$efi_aarch64"; then
>> +    if test -f $source_path/pc-bios/edk2-aaarch64-code.fd.bz2; then
>> +        # valid after build
>> +        efi_aarch64=3D$PWD/pc-bios/edk2-aarch64-code.fd
>> +    else
>> +        efi_aarch64=3D""
>> +    fi
>> +fi
>> +
<snip>
>>=20=20
>>  IMAGES_DIR :=3D $(HOME)/.cache/qemu-vm/images
>> @@ -23,6 +26,11 @@ vm-help vm-test:
>>  ifneq ($(GENISOIMAGE),)
>>  	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, wi=
th Docker"
>>  	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 V=
M"
>> +ifneq ($(EFI_AARCH64),)
>> +	@echo "  vm-build-ubuntu.aarch64         - Build QEMU in ubuntu aarch6=
4 VM"
>> +else
>> +	@echo "  (install qemu-efi-aarch64 to build centos/ubuntu aarch64 imag=
es.)"
>
> I'm not sure your test is working well, I have qemu-efi-aarch64
> installed and it not automatically discovered.
>
> # apt install qemu-efi-aarch64
> qemu-efi-aarch64 is already the newest version
> (0~20191122.bd85bf54-2ubuntu3).
>
> Hint: I'm using out-of-tree builds.

I think efi_aarch64=3D"" needs to be the default path, which can then be
overridden by the command line or finally fall back to the built in
image.

--=20
Alex Benn=C3=A9e

