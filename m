Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518A2C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 06:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE792080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 06:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZaY896fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE792080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBCVr-0002uv-Ux
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 02:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iBCTz-0000vi-Bs
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 02:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iBCJt-0004vB-Hp
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 02:23:06 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iBCJs-0004uO-V7
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 02:23:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id i1so5481176wro.4
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 23:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iawjsINkvq/vgQvQ5tf7a7F6hE+44gxnpEzi3QeXFHw=;
 b=ZaY896fcxRG38im9GFRBWfzhoFSdeC9w06wMSVMoQ0VLDMHY2nJAWcP6nbf5J3FskS
 35Ejit8WiLvM8+R4TEFm3Csy7nCAztrozndOgx0tJ+z4Uga2Bp92xdIimDxQCrB1F0u6
 S9LnEwO9Xw7Ir5zxaPKuXNynOo8rjHn053F5kk7/2ruWaVN7Kp94vgM8IHdxa2ov9HlC
 De2SF0wNG2lurUBsXE8fDzRvsOWNb3KvzbcJWeok8w8bIWxjdrgh/Iffj2Z8nPsQLZ8y
 ajHCm6S1QBzh1Y/UgTr6xE9XM3StHvSFrG80GVTA4bJVv2jAVilk2kD8fzu4QqhVii1c
 fDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iawjsINkvq/vgQvQ5tf7a7F6hE+44gxnpEzi3QeXFHw=;
 b=rexqIVsgL/Ym5J1wPotEAttkCrWbD3c3vOBfBml1qYFm4xR3ryTpbWBZ7CC//E1mqi
 RTC422kazn4rmkQ5dwbN6XkeR9Vugm3JLUutlBrDucmF/OrUJfzNbt7Al0/blusDCdM+
 zaGH5+v0Dg/teQYxxRLOdG8L8wYDLtMB1G5Vm8LbODMtp8OziFUvkI5D+C0FXeDfv8tU
 i7qw5eW954OdTsuTZl5bvXkubq9oxVcQQ5ub34C9J5+/UsVQXUpYrcrSoU4s1AD759jO
 9ofa3Vjz7PkYLDuojV1Q6cFPXMQq+eIliifoe0Sfx0UqsOhr3UcrEdGFeuML/Ho+7H5W
 KwAA==
X-Gm-Message-State: APjAAAVA7/24pl4zDVdesJaiiIvCd/0ngH3OsV4KiyaH1E195eAzT3vv
 ShUruHE7Or52MuvgCN0bjkT/qA==
X-Google-Smtp-Source: APXvYqz2Kpo23RlRYpiWUd7B0eUD6D9FkvlSHXQ4icLKPrl3/j4x7C4V8FqxNYE0B9WxGgMeDcNRZg==
X-Received: by 2002:adf:f547:: with SMTP id j7mr10779523wrp.119.1568960583405; 
 Thu, 19 Sep 2019 23:23:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y3sm11293831wmg.2.2019.09.19.23.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 23:23:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A639E1FF87;
 Fri, 20 Sep 2019 07:23:01 +0100 (BST)
References: <20190910084349.28817-1-alex.bennee@linaro.org>
 <20190910084349.28817-32-alex.bennee@linaro.org>
 <984feb48-31a9-2fc0-e1e7-e9d7a78b706f@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PULL 31/45] tests/docker: add more images to PARTIAL_IMAGES
 when not on x86_64
In-reply-to: <984feb48-31a9-2fc0-e1e7-e9d7a78b706f@redhat.com>
Date: Fri, 20 Sep 2019 07:23:01 +0100
Message-ID: <87k1a3zdtm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Alex,
>
> On 9/10/19 10:43 AM, Alex Benn=C3=A9e wrote:
>> This prevents us trying to do builds which we can't complete.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.inclu=
de
>> index 7df8dbe1a17..50a400b573a 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -106,6 +106,15 @@ docker-image-debian-s390x-cross: docker-image-debia=
n9
>>  docker-image-debian-win32-cross: docker-image-debian9-mxe
>>  docker-image-debian-win64-cross: docker-image-debian9-mxe
>>
>> +# For non-x86 hosts not all cross-compilers have been packaged
>> +ifneq ($(ARCH),x86_64)
>> +DOCKER_PARTIAL_IMAGES +=3D debian-mips-cross debian-mipsel-cross debian=
-mips64el-cross
>> +DOCKER_PARTIAL_IMAGES +=3D debian-ppc64el-cross
>> +DOCKER_PARTIAL_IMAGES +=3D debian-s390x-cross
>> +DOCKER_PARTIAL_IMAGES +=3D debian-win32-cross debian-win64-cross
>> +DOCKER_PARTIAL_IMAGES +=3D fedora travis
>> +endif
>> +
>>  docker-image-debian-alpha-cross: docker-image-debian10
>>  docker-image-debian-arm64-cross: docker-image-debian10
>>  docker-image-debian-hppa-cross: docker-image-debian10
>>
>
> I wanted to run the Travis tests locally (per
> docs/devel/testing.rst:364) but I got:
>
> $ make docker-travis@travis
>   LD      docker-travis@travis.mo
> cc: fatal error: no input files
> compilation terminated.
> make: *** [rules.mak:118: docker-travis@travis.mo] Error 1
>
> Bisected to this patch:
>
> e5389e44147e4c8d652006ed086c48f74684726a is the first bad commit
> commit e5389e44147e4c8d652006ed086c48f74684726a
> Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Date:   Thu Aug 15 19:40:48 2019 +0000
>
>     tests/docker: add more images to PARTIAL_IMAGES when not on x86_64
>
>     This prevents us trying to do builds which we can't complete.
>
> Removing 'travis' from this list we get it working again.

Have you run configure? I had to work around this in shippable:

    # usually host ARCH is set by configure
    - echo "ARCH=3D$(uname -m)" > config-host.mak

I guess more logic could be put in if the ARCH is empty

>
> Regards,
>
> Phil.


--
Alex Benn=C3=A9e

