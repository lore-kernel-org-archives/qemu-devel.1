Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FE9C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8FA2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8FA2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJPu-0002y1-6q
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 15:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAJOh-0002FJ-1w
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAJOg-000587-1f
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:44:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44869)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAJOf-00057q-Qf
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:44:21 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C256C85A07
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 19:44:20 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k67so1269904wmf.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 12:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hP7H0FfJiWoqapYSTYRmCPTGc6Kquaa+iE+x41nO6O8=;
 b=HMpfhNBaWJoWDHc3oUHnFu69VZ5gpwQJnHnBmIGZmdHzh7+rQoZmvsxvJgIwVRRHKC
 y47tv+P0ja4VWPbDobIFpqC79JPSTRrUrMUOh5zmzrEnFZlLd3nLRL2BcqTqhNiNr/Oy
 NW7GR+S8uopWxVCFuxahoFxQFq2TEk1lTNUNkCcNj88QbYFX6VzkOWtfujdOXF2JdBwx
 dHJhD6QinrT3pAmXN3qZ943C+1qySxNP3iBIfXkoYtC3vQzzvR99DLGmCc4g9NG4jg5c
 LMwyMLLaxC/FLIuWtkTGjNx9sX79Cmg6gWO8AmV4IbCYD/ITxbOA8eg1k3xMm2MaaRSi
 Yrtw==
X-Gm-Message-State: APjAAAWXumdvdwBsb/IDU/9LVWDPcqzuFLiXg/09/QnZzA3qluTu/MT+
 pdzCD2ujrNbghEoUauljenJXyGCZ8+5d4btjXgwK5x5cnUmMzIGg8JYOD7zqvt97rez/vmOZ3i7
 IAv5mrnY4T0yFVEM=
X-Received: by 2002:a05:600c:295b:: with SMTP id
 n27mr4156579wmd.128.1568749459548; 
 Tue, 17 Sep 2019 12:44:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz/ScH8vt74+UydtVZNUyqh2thjTZ7hV94MrCPbT961jTHcnGPPr7hP1WzGHH5BxCuAWNMlrg==
X-Received: by 2002:a05:600c:295b:: with SMTP id
 n27mr4156570wmd.128.1568749459379; 
 Tue, 17 Sep 2019 12:44:19 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id o22sm5354998wra.96.2019.09.17.12.44.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 12:44:18 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org, John Snow <jsnow@redhat.com>
References: <20190917184109.12564-1-alex.bennee@linaro.org>
 <20190917184109.12564-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5b77d03b-753b-5ea6-af17-bfccac2614d5@redhat.com>
Date: Tue, 17 Sep 2019 21:44:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190917184109.12564-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 2/9] tests/docker: fix
 DOCKER_PARTIAL_IMAGES
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
Cc: Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 8:41 PM, Alex Benn=C3=A9e wrote:
> Finger trouble in a previous clean-up inadvertently set
> DEBIAN_PARTIAL_IMAGES instead of DOCKER_PARTIAL_IMAGES.

Arf :)

> Fixes: 44d5a8bf5d2
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 50a400b573a..0d033bfbea8 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -7,7 +7,7 @@ DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfi=
les
>  DOCKER_DEPRECATED_IMAGES :=3D debian
>  # we don't run tests on intermediate images (used as base by another i=
mage)
>  DOCKER_PARTIAL_IMAGES :=3D debian debian8 debian9 debian10 debian-sid
> -DEBIAN_PARTIAL_IMAGES +=3D debian8-mxe debian-9-mxe debian-ports debia=
n-bootstrap
> +DOCKER_PARTIAL_IMAGES +=3D debian8-mxe debian-9-mxe debian-ports debia=
n-bootstrap

As John noticed, we have another typo: "debian-9-mxe" -> "debian9-mxe"

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(n=
otdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
>=20

