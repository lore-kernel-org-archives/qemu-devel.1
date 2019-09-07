Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03320C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 12:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C965821848
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 12:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C965821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6ZV7-0000NO-22
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 08:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i6ZTs-00083f-F2
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 08:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i6ZTq-0004gj-89
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 08:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i6ZTp-0004cY-Vr
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 08:06:14 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 27AAB85537
 for <qemu-devel@nongnu.org>; Sat,  7 Sep 2019 12:06:12 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id a4so2623513wrg.8
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 05:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=agi1abhkd2s1Ak+X3J1+TJQ2PgBWBHg2fJKe6dsls+g=;
 b=Fovkb8TeEV2jwMCqym0NyXk5zseThkDkQikBOVnBWK+gGlwfLqGdl6eq9p79JFLuZY
 cToEbQPm85c61HK/H2kqCUBUnlJ6hAyYH5d+T3JXgeZ1S2KrAZI4WjyFkfMmVgpxi6Bx
 b8A9tLDch0G8+V03HMTQEiEY7urE/MMFb00JYnV/5GnZfx2x5iJj3MgMbjl13gF36ay5
 JHnMLDoHwuRx9enfjVwKP+rvwozrKQOT6h0T5RFSNuHKzUCGCIDdcfaHbUgFF9uy4OCG
 1lu7FOlkWiajHXB+xi/2z55Gm6tlQVLW5kEXE6yypmjpuCVwwSZayjYZJ3wD09anEKLF
 8MZA==
X-Gm-Message-State: APjAAAVnVhYD6sderYanad2vZLVeCbRSkmwIAoKTLQud8d0Ono86hCfX
 WFzYV16nDYQMpp/AgFEZkV041oseo9RrqRKh+VF4e3wWewacaCd6eR/rpl06h7GautDmHYNhMxg
 3qq9SttogmYfA1lc=
X-Received: by 2002:a1c:a617:: with SMTP id p23mr11105823wme.166.1567857970940; 
 Sat, 07 Sep 2019 05:06:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwEYCBvxzrgmk+Ak2fX7Ept+pdOLIgW/JciMaoJI5VT+aCV8xChnRQj4zv6cGoL8VHWIQAxPg==
X-Received: by 2002:a1c:a617:: with SMTP id p23mr11105765wme.166.1567857970138; 
 Sat, 07 Sep 2019 05:06:10 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id l62sm11395088wml.13.2019.09.07.05.06.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Sep 2019 05:06:09 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-24-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c9ac9758-c8a9-e194-96db-e64764db24ca@redhat.com>
Date: Sat, 7 Sep 2019 14:06:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-24-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 23/42] tests/docker: add
 debian-xtensa-cross to DEBIAN_PARTIAL_IMAGES
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/19 10:29 PM, Alex Benn=C3=A9e wrote:
> This should have been marked when the docker recipe was added to

Oops

... was added (in c72d9df1818) to ...?

> prevent it being used for cross compiling QEMU. Sort the
> DEBIAN_PARTIAL_IMAGE list while we are at it.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index f4e9dfc0120..8d7f9376578 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -115,10 +115,15 @@ docker-image-travis: NOUSER=3D1
>  docker-image-tricore-cross: docker-image-debian9
> =20
>  # These images may be good enough for building tests but not for test =
builds
> -DOCKER_PARTIAL_IMAGES +=3D debian-alpha-cross debian-hppa-cross debian=
-m68k-cross debian-sh4-cross
> -DOCKER_PARTIAL_IMAGES +=3D debian-sparc64-cross debian-mips64-cross de=
bian-riscv64-cross
> -DOCKER_PARTIAL_IMAGES +=3D debian-tricore-cross debian-powerpc-cross d=
ebian-ppc64-cross fedora-i386-cross
> -DOCKER_PARTIAL_IMAGES +=3D fedora-cris-cross
> +DOCKER_PARTIAL_IMAGES +=3D debian-alpha-cross
> +DOCKER_PARTIAL_IMAGES +=3D debian-hppa-cross
> +DOCKER_PARTIAL_IMAGES +=3D debian-m68k-cross debian-mips64-cross

If possible, let's use one image per line
(I think it is acceptable if you do it before your pull
request, no need to respin).

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +DOCKER_PARTIAL_IMAGES +=3D debian-powerpc-cross debian-ppc64-cross
> +DOCKER_PARTIAL_IMAGES +=3D debian-riscv64-cross
> +DOCKER_PARTIAL_IMAGES +=3D debian-sh4-cross debian-sparc64-cross
> +DOCKER_PARTIAL_IMAGES +=3D debian-tricore-cross
> +DOCKER_PARTIAL_IMAGES +=3D debian-xtensa-cross
> +DOCKER_PARTIAL_IMAGES +=3D fedora-i386-cross fedora-cris-cross
> =20
>  # Rules for building linux-user powered images
>  #
>=20

