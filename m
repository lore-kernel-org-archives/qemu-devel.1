Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C6C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E565F206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E565F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5pAL-0005xj-1n
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5p7z-0003BG-9B
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5p7y-0007oR-9O
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5p7y-0007mP-13
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:36:34 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A91381DF7
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 10:36:33 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id c188so769096wmd.9
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 03:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FoKVWEmRN4jQK3vb53+eWr1jAPLWqlzYcwN0mplCSqY=;
 b=jjdUDAhOp6Xlf/17uhyPYbJBeupFQ+MEgRgJslAYR0wFF6w7rap4xime0lELjvK+ed
 N6JalVQwbf7yMjLkp9UFvUBF04MpGj4jJUytkZUjZnjOgSqbWdFsY6PGSOlGXLBNVdr+
 8AImDnepzB//C0IWikADiL92df+zAwp7TOEGxJJEps2tS70khMkewWlSEO5I6m6O97+9
 KAZni2Sl85Tf2pLUKkYhYzLWaKuR3rw80W2Lsr4IJesOmcpxd7CSwYuLssk1l3p919Ew
 KNhj4mC1N4C9nTFwPTohjmfGGZhGG+DCtxPsrRu1ZG5OUEVULRNOtkgWiJHgrX5sib5A
 bZWQ==
X-Gm-Message-State: APjAAAV2HU6U+BOXOb5IZqf4amWrT4qeodQm0SW71a4tvx/qxJk7f1o5
 T8NlI0M2jzylPlBGR/5Csfc8TO/xl/AKrTSgV057FSIuOgWg8SxL9hs/CdpOj0IEG6IxUYL3XpS
 TmiKN3MI7x6KDAGA=
X-Received: by 2002:adf:db01:: with SMTP id s1mr2103861wri.164.1567679791877; 
 Thu, 05 Sep 2019 03:36:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEbcrStHCS5h8BBrV37+tGd6Bq+hfJCh+aGRWyQGWN9YW5/X/U4rDSoraTgQHPQo6sT83G+g==
X-Received: by 2002:adf:db01:: with SMTP id s1mr2103838wri.164.1567679791708; 
 Thu, 05 Sep 2019 03:36:31 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id f23sm1701406wmj.37.2019.09.05.03.36.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2019 03:36:31 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-25-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a918f157-438c-0a8b-ea5e-4d6dbb6e4912@redhat.com>
Date: Thu, 5 Sep 2019 12:36:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-25-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 24/42] tests/docker: add debian9-mxe to
 DEBIAN_PARTIAL_IMAGES
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
> Another image that can't be used directly to build QEMU.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 8d7f9376578..2c8cb790ad0 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -6,7 +6,7 @@ DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>  DOCKER_DEPRECATED_IMAGES :=3D debian
>  # we don't run tests on intermediate images (used as base by another i=
mage)
> -DOCKER_PARTIAL_IMAGES :=3D debian debian8 debian9 debian10 debian8-mxe=
 debian-ports debian-bootstrap
> +DOCKER_PARTIAL_IMAGES :=3D debian debian8 debian9 debian10 debian8-mxe=
 debian9-mxe debian-ports debian-bootstrap
>  DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(n=
otdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

