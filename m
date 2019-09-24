Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54CFC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A825214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A825214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCn9X-0008Ux-5V
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCmNn-0008PH-7K
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCmNl-0005Nj-4b
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:05:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCmNk-0005NP-Ts
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:05:37 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 27AFD2D6A3F
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:05:36 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id k9so181935wmb.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Akw+NMEbOIq+0gkdjyK1hG8E93w0sSINVS7gM9l49t8=;
 b=hgTtlM+Ga2SuWo0KFFSiFNKC5P4JZDJvX354bsmGbzlFA2A8qH0Ehrj7Mr2ulCi7nH
 OIHnGxPYd41GL0NYkqPKUyYX0UR48fe2z7PCWTlf1Uf0YfeFE4I+n4LeETMh4Z9fYkW9
 7ydmNwyY0GBhalgXludjfHbmlqrGLitgyKRRZAtO7RirksXftmDv1FhKbD4lMEg4t0Dk
 GDDBlg00YKA8+8Cb2drF61GRf3axOKfDTbQNfCaBuXG+1ah9ABqT38wtyj3H/VklgcKb
 rdPDyaS/deIcpA84TOpo8XQDRPfMSDa3Fslkq5hNHRd4CqBN0yo6SJk7hoiZFIHkXtLu
 1gbg==
X-Gm-Message-State: APjAAAUIKOkO4vA1OhLDNwkJPho5sROYVUr2VeD71dyjmsn6X33pIyHc
 FyQt/6MlDBee05qFnwOzQSLc1aibe7JAt/DlAqNRJAoOmcQDeDoYlatRc86COod46/fUpklQBOx
 Pr1xdWazaQKRgXFU=
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr483015wml.173.1569337534656; 
 Tue, 24 Sep 2019 08:05:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwwk9YsRGNGiJWfI0i1Hsm/h89TJu7mV6E+ek3sQ049b5FCLyOwBCWAUz+LEDOQ//YLdRQsVA==
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr482986wml.173.1569337534451; 
 Tue, 24 Sep 2019 08:05:34 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b5sm325533wmj.18.2019.09.24.08.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 08:05:33 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] docker: remove 'deprecated' image definitions
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190923181140.7235-1-jsnow@redhat.com>
 <20190923181140.7235-4-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c990f39e-5748-c6a3-b071-0d4f279d2a1c@redhat.com>
Date: Tue, 24 Sep 2019 17:05:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190923181140.7235-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 8:11 PM, John Snow wrote:
> There isn't a debian.dockerfile anymore,
> so perform some ghost-busting.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/docker/Makefile.include | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index b20a810016..983224ad96 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -4,11 +4,10 @@
> =20
>  DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
> -DOCKER_DEPRECATED_IMAGES :=3D debian
>  # we don't run tests on intermediate images (used as base by another i=
mage)
> -DOCKER_PARTIAL_IMAGES :=3D debian debian9 debian10 debian-sid
> +DOCKER_PARTIAL_IMAGES :=3D debian9 debian10 debian-sid
>  DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-ports debian-bootstrap
> -DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(n=
otdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
> +DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILE=
S_DIR)/*.docker))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
>  DOCKER_CCACHE_DIR :=3D $$HOME/.cache/qemu-docker-ccache
> @@ -159,7 +158,7 @@ docker-image-debian-powerpc-user-cross: docker-binf=
mt-image-debian-powerpc-user
>  DOCKER_USER_IMAGES +=3D debian-powerpc-user
> =20
>  # Expand all the pre-requistes for each docker image and test combinat=
ion
> -$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(D=
OCKER_DEPRECATED_IMAGES)), \
> +$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
>  	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
>  		$(eval .PHONY: docker-$t@$i) \
>  		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

