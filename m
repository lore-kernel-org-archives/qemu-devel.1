Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3F4C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263A520728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxCFeVXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263A520728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiUB-0004Kr-9G
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiSE-0001VP-B3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiSD-0008Kj-Pw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:28:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35168
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRiSD-0008Hl-C9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587673692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baPPwrzNTDJ6+3bcSFtDWAegoRJD1dWcpXdLL8AC5P8=;
 b=HxCFeVXvPegiRvsGownGznFchse7BxD5twDD19IsBzeCnwvSrydimlAS5X12HM12Zkv1xL
 mae6ph97BPRAwvz3/N3/6gJMzEGVHpKvKOARJmCq1YkdMG+9LZP/Bp3zwY9DZ+JEo8LsFL
 /CjFMG0pDDryEf5ePsBs82zz+TiZ4ws=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-TpSdp77PP02qLsjOl-0f4w-1; Thu, 23 Apr 2020 16:28:10 -0400
X-MC-Unique: TpSdp77PP02qLsjOl-0f4w-1
Received: by mail-wr1-f69.google.com with SMTP id o8so2952621wrm.11
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WLrOSvaYgsgoIhCLb1NvPYqf9dYuqLdl1DXO+3FeeNs=;
 b=E7pAaYhesNTsSG+LJIVFjSePy9nxbaXZO/svCOQ65yn0nDWgDFa8U4L3F+42H7AeCK
 YptFsxPrLLEQV9Ke78hZH/Gci6JgEEGWNhnIUX/G6DdbKLrO02a7Ehuf7jtn6iZfprhA
 OTwOZ4lSgvoQD+Nd6CxQagOTqtK7kURYBLh2MUb2LWMOGArabKa96WRZkCZiBj42Sij2
 RXJ8y+eBgvVve3pM/2MfDu7XptqGOtQiCnUK22ImqZCDYVES49lZGQuoglydi5SVRAjF
 nt83ksNBdFKe/q9iLEyIAHTuIVw5JboL0+nq4lsXDmyCRZu7dDpdUiQ6LrJb+WZYAOzD
 QjpA==
X-Gm-Message-State: AGi0PuYthaV7YiMxsUPdXQ+D+xzREiBU+1EM54W496NJqKVGnqPPxc0m
 SpvrUaWuEIdYblX0GU2HzC4TSf+qtMsJm2QCsunhOqupavb9lZtAcUKjbXAU85Wh7XtmmY25T5K
 JD8fHZzJDZbbqFLY=
X-Received: by 2002:a1c:2042:: with SMTP id g63mr6012233wmg.70.1587673689439; 
 Thu, 23 Apr 2020 13:28:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypKXv5wdhfh3cFt6np3BaglROlSM5Du1lBZxVDM5IG/06RR9yBjTsGs4UDG14RP6ZY8vPa6k6g==
X-Received: by 2002:a1c:2042:: with SMTP id g63mr6012216wmg.70.1587673689162; 
 Thu, 23 Apr 2020 13:28:09 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h188sm5694878wme.8.2020.04.23.13.28.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 13:28:08 -0700 (PDT)
Subject: Re: [PATCH v1 14/14] .travis.yml: drop MacOSX
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200423170557.31106-1-alex.bennee@linaro.org>
 <20200423170557.31106-15-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dacef34d-244e-e57b-da97-afab11b8401d@redhat.com>
Date: Thu, 23 Apr 2020 22:28:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200423170557.31106-15-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 16:25:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 7:05 PM, Alex Benn=C3=A9e wrote:
> This keeps breaking on Travis so lets just fall back to the Cirrus CI
> builds which seem to be better maintained. Fix up the comments while
> we are doing this as we never had a windows build.

I certainly vouch this.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 28 +---------------------------
>   1 file changed, 1 insertion(+), 27 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index a4c3c6c805..49267b73b3 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -9,9 +9,8 @@ compiler:
>   cache:
>     # There is one cache per branch and compiler version.
>     # characteristics of each job are used to identify the cache:
> -  # - OS name (currently, linux, osx, or windows)
> +  # - OS name (currently only linux)
>     # - OS distribution (for Linux, xenial, trusty, or precise)
> -  # - macOS image name (e.g., xcode7.2)
>     # - Names and values of visible environment variables set in .travis.=
yml or Settings panel
>     timeout: 1200
>     ccache: true
> @@ -271,31 +270,6 @@ jobs:
>           - TEST_CMD=3D""
>  =20
>  =20
> -    # MacOSX builds - cirrus.yml also tests some MacOS builds including =
latest Xcode
> -
> -    - name: "OSX Xcode 10.3"
> -      env:
> -        - BASE_CONFIG=3D"--disable-docs --enable-tools"
> -        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softm=
mu,m68k-softmmu,x86_64-softmmu"
> -      os: osx
> -      osx_image: xcode10.3
> -      compiler: clang
> -      addons:
> -        homebrew:
> -          packages:
> -            - ccache
> -            - glib
> -            - pixman
> -            - gnu-sed
> -            - python
> -          update: true
> -      before_script:
> -        - brew link --overwrite python
> -        - export PATH=3D"/usr/local/opt/ccache/libexec:$PATH"
> -        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
> -        - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.=
log && exit 1; }
> -
> -
>       # Python builds
>       - name: "GCC Python 3.5 (x86_64-softmmu)"
>         env:
>=20


