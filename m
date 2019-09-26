Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA9DC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 04:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D4421A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 04:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D4421A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDLPv-0004ao-BN
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 00:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDLOi-0003f5-Rx
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 00:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDLOe-0004qW-5A
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 00:28:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDLOd-0004hj-Sw
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 00:28:52 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7AE4385540
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 04:28:49 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id a15so399398wrq.4
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 21:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1HPQRovOuKSXa3IR8ZD5Yr5u8+EL+lCv5qn59Gav9GE=;
 b=FP2LyjipVdyrBbv0wAgp0CsAtAZVSkzFqhaaI5YxzoMHwLLPWVW8z9898QfD30/CvF
 5/pP31F25oH/sbg3MH8yYlnrrgfdEG4Lub0tdcDGe/RF5QXuw6ecYc0/KSswWGtD7h8S
 hWRWK1LHdgPZROSGoUx6NraK1vAqaIY4TKNddf+lS4ew4dPg3Z+ZZeNoi5qpi/4YNg/j
 Wr+5y9brfIdDp4FyOhexjqoA5AjrtgvWRmVUUippr6h2dd/rKuf3APBMg7CtdxT5uBit
 /vPOxF0Gjkzq+4D9yD5aZiW2RJ1pQ3FtuugBkeOS6fjin/g6+H03bSikPrC9DQ1NZuzE
 dLaA==
X-Gm-Message-State: APjAAAXwnp6jmEDPUdeKTxDz/8GF3wAwBKqezAMZiARjc85Pr5LOsHk0
 jO5SFk29tEWsKIrBvWXeb+ca2QoyrRgCYVdjUfUaP9t5RRmwqBixxvpXKRv59J4YxK35LJVRapv
 I0hGO8xArlYWhaW8=
X-Received: by 2002:a5d:5692:: with SMTP id f18mr1266487wrv.68.1569472128257; 
 Wed, 25 Sep 2019 21:28:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzr8H5BLD75uzL75K39iXkev1X4jNYN78U6W2YAD1PS/zaJ6DhGiES1pohb4tz8luvmFSk3mQ==
X-Received: by 2002:a5d:5692:: with SMTP id f18mr1266477wrv.68.1569472128045; 
 Wed, 25 Sep 2019 21:28:48 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id n1sm2744292wrg.67.2019.09.25.21.28.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 21:28:47 -0700 (PDT)
Subject: Re: [PATCH v3 29/33] docker: remove 'deprecated' image definitions
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-30-alex.bennee@linaro.org>
 <95fcc08f-d2f1-edf7-0203-d867d297ac9f@redhat.com> <87ftkk9ch0.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a3afe1d8-b621-ba0c-58c3-d049d6eac665@redhat.com>
Date: Thu, 26 Sep 2019 06:28:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87ftkk9ch0.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, jsnow@redhat.com, qemu-devel@nongnu.org,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 9/26/19 1:34 AM, Alex Benn=C3=A9e wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>> On 9/24/19 11:01 PM, Alex Benn=C3=A9e wrote:
>>> From: John Snow <jsnow@redhat.com>
>>>
>>> There isn't a debian.dockerfile anymore,
>>> so perform some ghost-busting.
>>
>> Won't we deprecate other images in the future?
>=20
> Sure but we can just drop them from dockerfiles. It's not like we
> allowed people to use them as we filtered them out.

This patch isn't about removing a deprecated image, but about removing
the handy DOCKER_DEPRECATED_IMAGES variable used to start a deprecation
process.

Fam remembered once we should respect the QEMU deprecation policy even
with docker images, because there might be users relying on them, so we
want to give them time to adapt. I can not find a thread on the list, so
we might have discussed that over IRC. The related commits are:

$ git show bcaf457786c

    docker: do not display deprecated images in 'make docker' help

    the 'debian' base image is deprecated since 3e11974988d8

$ git show 3e11974988d8

    docker: warn users to use newer debian8/debian9 base image

    to stay backward incompatible.

I'd rather keep the DOCKER_DEPRECATED_IMAGES variable empty, maybe with
a comment describing why it exists. What do you think?

Thanks,

Phil.

>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> Message-Id: <20190923181140.7235-4-jsnow@redhat.com>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>  tests/docker/Makefile.include | 7 +++----
>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.in=
clude
>>> index 82d5a8a5393..fd6f470fbf8 100644
>>> --- a/tests/docker/Makefile.include
>>> +++ b/tests/docker/Makefile.include
>>> @@ -4,11 +4,10 @@
>>>
>>>  DOCKER_SUFFIX :=3D .docker
>>>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>>> -DOCKER_DEPRECATED_IMAGES :=3D debian
>>>  # we don't run tests on intermediate images (used as base by another=
 image)
>>> -DOCKER_PARTIAL_IMAGES :=3D debian debian9 debian10 debian-sid
>>> +DOCKER_PARTIAL_IMAGES :=3D debian9 debian10 debian-sid
>>>  DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-ports debian-bootstrap
>>> -DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $=
(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>>> +DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FI=
LES_DIR)/*.docker))))
>>>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>>>  # Use a global constant ccache directory to speed up repetitive buil=
ds
>>>  DOCKER_CCACHE_DIR :=3D $$HOME/.cache/qemu-docker-ccache
>>> @@ -160,7 +159,7 @@ docker-image-debian-powerpc-user-cross: docker-bi=
nfmt-image-debian-powerpc-user
>>>  DOCKER_USER_IMAGES +=3D debian-powerpc-user
>>>
>>>  # Expand all the pre-requistes for each docker image and test combin=
ation
>>> -$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $=
(DOCKER_DEPRECATED_IMAGES)), \
>>> +$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)),=
 \
>>>  	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
>>>  		$(eval .PHONY: docker-$t@$i) \
>>>  		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
>>>
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20

