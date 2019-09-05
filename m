Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB9DC3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E49206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E49206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5p8j-0003S8-CN
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5p6I-0001ba-EV
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5p6G-0005pw-FR
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:34:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5p6F-0005ot-DR
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:34:48 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 513CEC05AA65
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 10:34:44 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id x1so791757wrn.11
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 03:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MskqRSfMmldDBq052oeVPt4LwzWaViN8dwyvU8hLxOA=;
 b=hsFZsayhazy7XpiF14W0iO2KdokWLIfK0Cx6/JTBdRSXRmRp9bnoCdwbDrrKgI1VJ4
 knVFcCHJrPs2N/cJ+57XCnVEGMAn+LoRo6XklS+44rls4mpZiYB0pjYJyw/ACYvPpi2V
 jyp15/vM5tY9q1kYWIYlEkUbmKDjvu21kCHx7fHn1jsTSSnkk8JFjJ84ZgHtXNw+WZ13
 w7EmaPPRb925jzWvnWxCUBFxEg4Y6myQjw7gotgGU49c0yAuNH947aWkaOUbrMCvsUOQ
 BAh4nCNUn+hzx2zh2B7SuYuTG2cjfdjdcvZ7Khm0naAE3lRxgEduF8CNc2QgBzyZJX2v
 C0lQ==
X-Gm-Message-State: APjAAAUpPsKQUzID0KZDfSn2+aDJzDnfsaq4jxk7m7uxxhnpMd/t3d9Y
 qsXW0w18bMUVhQ9ESpCyNFTndGjyzZzS12vBADRpt8VAgMSbMNl2tURISQQpN3lr47coBOI+y3S
 bqM4ooK6khYEE37w=
X-Received: by 2002:a1c:1981:: with SMTP id 123mr2313607wmz.88.1567679683128; 
 Thu, 05 Sep 2019 03:34:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAIIGQhGZWPr89VtE+Fmdca5nohrKQ8v3srXmNeLNPmImhd6LDC+1QReeigZLgZctukvQC6Q==
X-Received: by 2002:a1c:1981:: with SMTP id 123mr2313577wmz.88.1567679682917; 
 Thu, 05 Sep 2019 03:34:42 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id i93sm1834484wri.57.2019.09.05.03.34.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2019 03:34:42 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7498bf07-e3d6-65aa-7dee-6887c593eb68@redhat.com>
Date: Thu, 5 Sep 2019 12:34:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 10/42] tests/docker: add Buster to
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/19 10:29 PM, Alex Benn=C3=A9e wrote:
> We need to add additional packages to the base images to be able to
> build QEMU so lets avoid building with it.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index cf535cbd196..89881fb5f5d 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -6,7 +6,7 @@ DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>  DOCKER_DEPRECATED_IMAGES :=3D debian
>  # we don't run tests on intermediate images (used as base by another i=
mage)
> -DOCKER_PARTIAL_IMAGES :=3D debian debian8 debian9 debian8-mxe debian-p=
orts debian-sid debian-bootstrap
> +DOCKER_PARTIAL_IMAGES :=3D debian debian8 debian9 debian10 debian8-mxe=
 debian-ports debian-sid debian-bootstrap
>  DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(n=
otdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

