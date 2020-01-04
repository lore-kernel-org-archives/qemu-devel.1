Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75495C3276F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 11:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460E224649
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 11:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMEtyPH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460E224649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inhXQ-0007ou-9W
	for qemu-devel@archiver.kernel.org; Sat, 04 Jan 2020 06:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inhWk-0007Jr-8U
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 06:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inhWh-0007wF-8Y
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 06:23:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35084
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inhWh-0007ql-1F
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 06:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578137000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cqSrU+fcykwBhVx5ExH3a7Abr8AUvuKrBkpk9Iqj318=;
 b=dMEtyPH+nU6tPpnPRXDPFU1hip25oX/7ltRcwY/qFFFlfhyHMRbtOlYIn1R9GQpLabk5xZ
 /ONHGBr+e9Yf9b+xjMXydZJD/x7MQmadWw0vDQJkt1LrBVj7gkUz2DCNBabZ7+5B68xwRP
 wZwj4kzR72YICxuqR9P2Hydvw373JYo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-V3ZKky1QN-2vWr_M_bPA7A-1; Sat, 04 Jan 2020 06:23:17 -0500
Received: by mail-wr1-f71.google.com with SMTP id w6so23155453wrm.16
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2020 03:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PEXjquDI4DL/1zHLv/GjuOu0r/0418IZfnZPM32Rwso=;
 b=JtWQ3aqmWkYP7yzApkHtEIkHcUMHoylrRwXDu0rPVKuqxfoCUMOoQwQfYyiQ+4CLL3
 Fn90IU6T04ptkqTeOAeBWRL9UmMr4Zq43SnwTJAf4z/EXqRVHpVOwHsCNitoLWU9mu9C
 38CFL+UYorb1AUpw+CHpYcwJO6K/36uS1eWnaKTFA3Sis8bg62uNTsFBR261A3/sBomi
 s2qICoEfRqbwZBEXUzgmsZfu/Hooh6I1+Qn9RsX9FJeLAF9hICrFDUYX4tJzCRYDL3jV
 GvrrueOey1HMJxXozvKwjZxydxnqJXVPNdaGRVKZr3Xwu8IW+9wg5x9GX1PmSZd1aX23
 yYXA==
X-Gm-Message-State: APjAAAX31NF53eL+o282b1I/w0ryh2R6+XJqnlv+d7FWQuqPDT61dlzY
 6fvX7DV5otLTO6Tv4i4rgoXBvHVLvRubMapJ/4w4J2J0xbyGec5VWAXe84SXWAWgNbSs1rYS5ch
 PNpbZQuBQ2rjRafU=
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr24469354wmq.65.1578136996433; 
 Sat, 04 Jan 2020 03:23:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqz+4shmDHJsNde4gQJhWD3/1gXbiPfM6X26ciDa70CRh1bWEq2uISDrwzrJwav6siZOedMCjA==
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr24469334wmq.65.1578136996158; 
 Sat, 04 Jan 2020 03:23:16 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id o7sm15172766wmh.11.2020.01.04.03.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2020 03:23:15 -0800 (PST)
Subject: Re: [PATCH 1/3] capstone: Update to next
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20200103212500.14384-1-richard.henderson@linaro.org>
 <20200103212500.14384-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7433d1e5-28af-caa6-1565-6d8a02b8793f@redhat.com>
Date: Sat, 4 Jan 2020 12:23:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103212500.14384-2-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: V3ZKky1QN-2vWr_M_bPA7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/3/20 10:24 PM, Richard Henderson wrote:
> Update to aaffb38c44fa.  Choose this over the "current" 4.0.1 tag
> because next now includes the s390x z13 vector opcodes, and also
> the insn tables are now read-only.
>=20

As Thomas suggested,
Fixes: https://bugs.launchpad.net/qemu/+bug/1826175

With GCC on Linux:
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   Makefile  | 1 +
>   capstone  | 2 +-
>   configure | 2 +-
>   3 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 6b5ad1121b..12e129ac9d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -499,6 +499,7 @@ dtc/%: .git-submodule-status
>   # Remove all the extra -Warning flags that QEMU uses that Capstone does=
n't;
>   # no need to annoy QEMU developers with such things.
>   CAP_CFLAGS =3D $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS))
> +CAP_CFLAGS +=3D -I$(SRC_PATH)/capstone/include
>   CAP_CFLAGS +=3D -DCAPSTONE_USE_SYS_DYN_MEM
>   CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM
>   CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM64
> diff --git a/capstone b/capstone
> index 22ead3e0bf..aaffb38c44 160000
> --- a/capstone
> +++ b/capstone
> @@ -1 +1 @@
> -Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
> +Subproject commit aaffb38c44fa58f510ba9b6264f7079bfbba4c8e

Looking at https://github.com/aquynh/capstone/pull/1549, this is=20
unfortunate the upstream project use the 'squash merge request' feature :(

Since I already reviewed various of the 1589 patches in the earlier=20
version of this patch (22ead3e0bf..418d36d695) I'll only focus on the=20
291 'squashed' commits added on top:

   $ git log --oneline 418d36d695..aaffb38c44|wc -l
   291

Most of the commits contains a single line of description, and various=20
of them have hundreds of lines of changes.

Similarly to my previous review, I skipped the architecture we don't=20
support and X86. Still to many ARM/Aarch64 patches to review, so I'm=20
focusing on the buildsys and changes on the API we use:

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> diff --git a/configure b/configure
> index 940bf9e87a..de96bfe017 100755
> --- a/configure
> +++ b/configure
> @@ -5062,7 +5062,7 @@ case "$capstone" in
>         git_submodules=3D"${git_submodules} capstone"
>       fi
>       mkdir -p capstone
> -    QEMU_CFLAGS=3D"$QEMU_CFLAGS -I\$(SRC_PATH)/capstone/include"
> +    QEMU_CFLAGS=3D"$QEMU_CFLAGS -I\$(SRC_PATH)/capstone/include/capstone=
"
>       if test "$mingw32" =3D "yes"; then
>         LIBCAPSTONE=3Dcapstone.lib
>       else
>=20


