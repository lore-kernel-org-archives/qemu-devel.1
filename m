Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2112EC49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 08:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E8D217F5
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 08:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E8D217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBb2E-0001DT-2J
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 04:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBb12-0000MW-BC
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBb10-0002J3-LV
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:45:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBb0y-0002Hh-IJ
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:45:12 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23150B62C
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 08:45:11 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id h6so3250999wrh.6
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 01:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VKdlpsyzLA9jF8cipmcnjWTyuUglx6h0PL51wUXhhBo=;
 b=gULW/F9NMqyXYEBRKBupU4d4uAX98RtI0lF5+Pjq7mksNMKvvnezXe5SXxw96WKnAI
 fvu9YGJEo0JkX5Scl+hFCxKH68zkKhdfvWOLO7i/LzFjMhbLTHau891yUvKRQW2SoO+w
 Yob57qmXH/gajKbsHAvOj2z0mFPenY+62Ov0ArxN/C3MLsTZsIAKVo9DNiXqljvkCQTz
 wBfr//L7bq6wEQJ2bmMvde9zxlHAFWujQm6Jtw2YprgaGdxTxq0b8uU3/+0GpZSVqTB0
 KS7OZEVBsc0rA8sruHwHbWaq0GX2IB1GtovsHBiE/v3j+z1AX/yRngS1jflFS3ayZXga
 tumA==
X-Gm-Message-State: APjAAAVpBITzfAHYf4SBfgOHQEbud/peVgOA6dnn+Au+dJzYzWxS8Z+F
 Ax9gLgLCs4cfNA2RnojvlnWOAbQmgOuatzcjSoMy3QpnC3H8rwo7R5A3IqngObutFPOslTMvv14
 X1AO9YHmWUvo5mXo=
X-Received: by 2002:a05:6000:11cb:: with SMTP id
 i11mr13403307wrx.171.1569055509841; 
 Sat, 21 Sep 2019 01:45:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwHXOXqa3aWURPisP9OPmOpCEV7JXDVuNhZnml4q3qXgFc0V8QY/DH0lWtPD44YIGsJgSfyjg==
X-Received: by 2002:a05:6000:11cb:: with SMTP id
 i11mr13403302wrx.171.1569055509670; 
 Sat, 21 Sep 2019 01:45:09 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id z142sm7925059wmc.24.2019.09.21.01.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2019 01:45:09 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] docker: remove debian8-mxe definitions
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190920221255.30412-1-jsnow@redhat.com>
 <20190920221255.30412-4-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6abcc7df-5911-64e6-8524-8b3093d024ca@redhat.com>
Date: Sat, 21 Sep 2019 10:45:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190920221255.30412-4-jsnow@redhat.com>
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

On 9/21/19 12:12 AM, John Snow wrote:
> We don't have a debian8-mxe dockerfile anymore.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

> Message-id: 20190920001413.22567-3-jsnow@redhat.com
  ^ remove?

Fixes: 67bd36beda1ae
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 0d75260e46..0a7fc8bc79 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -6,7 +6,7 @@ DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>  # we don't run tests on intermediate images (used as base by another i=
mage)
>  DOCKER_PARTIAL_IMAGES :=3D debian8 debian9 debian10 debian-sid
> -DOCKER_PARTIAL_IMAGES +=3D debian8-mxe debian9-mxe debian-ports debian=
-bootstrap
> +DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-ports debian-bootstrap
>  DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILE=
S_DIR)/*.docker))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
>=20

