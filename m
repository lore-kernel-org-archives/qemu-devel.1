Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF73CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953C1222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIHeeTWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953C1222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTS7-0002So-NG
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLTRD-0001XM-FM
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLTRB-0006Bb-HI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:41:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36970
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLTRB-0006BA-3I
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571409664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWeKtn6eR9QC+WVONFJjz3QmmV8kQ+pcC06Ski1WN2A=;
 b=YIHeeTWRSVwTV3Uva9Yh5oVQFgOCacQ5KcYOgXi0NgrLf4TeV2/tPrYTSAj6Ag7wdU/W6a
 vXMQVzoQ82T5O28PM5N2EaPM/ZIYYwDIjM+h1mlo4Nk5IL7qVI2SZARrUJuwzq4zflApP3
 WoBIsllQt7xYE7qJq3kRpofa8yPNiD0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-6Q9xi5b1PUS_xmbwIrfuvw-1; Fri, 18 Oct 2019 10:41:00 -0400
Received: by mail-wm1-f70.google.com with SMTP id f63so2437642wma.7
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=91AjpsYdeTXsqmoSwLNcJm1QQVeJZj8Bu1IQXUWHeVo=;
 b=KLuiGot4xAohzYXHXuoJV/wKounJLO3vhTy+bXvmo7ZLOBj0CuudfqJjyAGH85TX5D
 xxm8+V+M1lAvQDgDZFED0HXgP8sFn+zfr/TWeUP45/oorePGpvGhrm+U3UAttRtmVSBY
 ExPtejogQlOyjraWwymo/YqrjKADtnDb1bPJ1peuIsFoQhpkGiQuVwk1X/deIP96mTb4
 aa9BVxc6HjKuDJsomLSjCF8TqklMJG7F5amrJeitEvl5jjk1053wTWqPLOcEhVeF++S+
 QLEPCjweRL1hGF0VCVMwyQZ2vwI8SB2nqyA6SQ8MSsza0m3qMUTK3BIENg2AL3Utp0ls
 3TYA==
X-Gm-Message-State: APjAAAWl/oljanvj2of0GHiW4DNL64fZADRgvoEy/mBK2m7YBD+40EgO
 bAuU7VqNT6bEGfYItYIqQkxo6+ED7KM+db8jECMorKhzsE7K7EuPlvHALO2okM4XWhabxRJX/7G
 ROHHX2SlydulGr+o=
X-Received: by 2002:a5d:4341:: with SMTP id u1mr8319715wrr.306.1571409659289; 
 Fri, 18 Oct 2019 07:40:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw2nkbJdYy+U67M0q5H2U/ge+Aq5b4CAn6TVzSld60ws82dPH55QR+XVUvHGkk520Ff8xLg8g==
X-Received: by 2002:a5d:4341:: with SMTP id u1mr8319695wrr.306.1571409659089; 
 Fri, 18 Oct 2019 07:40:59 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id q3sm5963086wru.33.2019.10.18.07.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2019 07:40:58 -0700 (PDT)
Subject: Re: [PATCH v2] .travis.yml: Test the release tarball
To: qemu-devel@nongnu.org
References: <20191007160450.3619-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4fbafa72-321c-2062-f97e-502616ec6c32@redhat.com>
Date: Fri, 18 Oct 2019 16:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007160450.3619-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: 6Q9xi5b1PUS_xmbwIrfuvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 10/7/19 6:04 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Add a job to generate the release tarball and build/install few
> QEMU targets from it.
>=20
> Ideally we should build the 'efi' target from the 'roms' directory,
> but it is too time consuming.
>=20
> This job is only triggered when a tag starting with 'v' is pushed,
> which is the case with release candidate tags.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: addressed mdroth comments
>=20
> This job is quick enough: Ran for 16 min 33 sec
> https://travis-ci.org/philmd/qemu/jobs/594565293
>=20
> Based-on: <20191007133540.30623-1-philmd@redhat.com>
> pull request including "Fix tarball builds of UEFI/EDK2 firmware"
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg02734.html
> ---
>   .travis.yml | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index d0b9e099b9..d881ea0849 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -339,3 +339,26 @@ matrix:
>           - CONFIG=3D"--target-list=3Dxtensa-softmmu,arm-softmmu,aarch64-=
softmmu,alpha-softmmu"
>           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> +
> +
> +    # Release builds
> +    # The make-release script expect a QEMU version, so our tag must sta=
rt with a 'v'.
> +    # This is the case when release candidate tags are created.
> +    - if: tag IS present AND tag =3D~ /^v\d+\.\d+(\.\d+)?(-\S*)?$/
> +      env:
> +        # We want to build from the release tarball
> +        - BUILD_DIR=3D"release/build/dir" SRC_DIR=3D"../../.."
> +        - BASE_CONFIG=3D"--prefix=3D$PWD/dist"
> +        - CONFIG=3D"--target-list=3Dx86_64-softmmu,aarch64-softmmu,armeb=
-linux-user,ppc-linux-user"
> +        - TEST_CMD=3D"make install -j3"
> +        - QEMU_VERSION=3D"${TRAVIS_TAG:1}"
> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> +      before_script:
> +        - command -v ccache && ccache --zero-stats
> +        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
> +      script:
> +        - make -C ${SRC_DIR} qemu-${QEMU_VERSION}.tar.bz2
> +        - ls -l ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2
> +        - tar -xf ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2 && cd qemu-${Q=
EMU_VERSION}
> +        - ./configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && ex=
it 1; }
> +        - make install
>=20


