Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11ACC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5232067B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5232067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJMF-0001Lm-Px
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 15:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAJLW-0000pP-5w
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAJLU-0003F3-26
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:41:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33044)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAJLT-0003Er-RH
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:41:04 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E26A046288
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 19:41:02 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id n3so1661867wmf.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 12:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1FH52gwocCl6vZOyLvdD50rWyIvzE1V4K1qSPgaS3q8=;
 b=B4lDJ1mIxQDyWgjVdm7gqwFbQcm3AuvZ/Jf/YCBsIkAI1AKGzkwXLLcxGYvuqm7cFJ
 4DXQT76+hq23ZHJ1T0czlYc51Tavx0nAVWDp1HeIdkw/z5k5AJt/4LP7971mToNN9vvP
 4gY5rApoZROyXGCkEc0JC7AfjNy/PjJ69VBuJjPc+HyM9UCItgdLfJdtM4yef31L4Bh3
 Lc5tHQrMDX7kbzS7/kapv9t/mMJG7bs80NbAS30dSsLULVq8OwnZXvOMsmMxBPF/dIFK
 eAK3777dhtmXtjLl0Q4X5kUcqKrPW3tLgRbqlpc55C0oTG5AqorfA7HlCGg4lnNNP01V
 Jsjw==
X-Gm-Message-State: APjAAAUCovjQZxyCBhbmGk04ty9LmWIT5aPktAAPzkoIItG8j8EPt1N1
 KxxE2kE7hPDfXLAet9GAYKGyqa1EFEnKiJ3o8cHNx2Vqkqfi9jU8PsvY5EXe60K2RZQ0Hc1rjyi
 kER25FFDcEVes8fI=
X-Received: by 2002:a1c:1d4:: with SMTP id 203mr4774873wmb.104.1568749261700; 
 Tue, 17 Sep 2019 12:41:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxtEs4J204e6w4+jaUUumvPJAkfqtql0ACR3FK5R9WnxEwJuBjeSsDMj2WS2abOwYOspoC4iQ==
X-Received: by 2002:a1c:1d4:: with SMTP id 203mr4774868wmb.104.1568749261527; 
 Tue, 17 Sep 2019 12:41:01 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id g185sm6845769wme.10.2019.09.17.12.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 12:41:00 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190917185537.25417-1-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <744592ce-03e3-8495-1a56-a66c0d3b1be6@redhat.com>
Date: Tue, 17 Sep 2019 21:40:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190917185537.25417-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests/docker: fix typo for debian9-mxe
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

On 9/17/19 8:55 PM, John Snow wrote:
> We spelled it debian-9-mxe, but the image is debian9-mxe.

Oops I missed that, good catch.

Fixes: 44d5a8bf5d2
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 50a400b573..7eac1516f6 100644
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
> +DEBIAN_PARTIAL_IMAGES +=3D debian8-mxe debian9-mxe debian-ports debian=
-bootstrap
>  DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(n=
otdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
>=20

