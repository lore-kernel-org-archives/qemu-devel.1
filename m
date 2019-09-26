Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E371C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B070621D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B070621D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWSR-0006iQ-IL
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDWJl-0005lZ-4z
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDWJh-0000IN-ID
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:08:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDWJd-0000CY-P3
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:08:27 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2DC60641C2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 16:08:21 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j3so1137829wrn.7
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sx5hJqMQQg2czYlHAJzjOIZHYucu3iDAFw2zgjDZzQM=;
 b=m7EX2bneshadXdrqtNXYHVvBY6b6H4jYV1uQUzfqMF8bbzzjZpPSiL7l4knTEDKZaJ
 mTLlB0zfKhZi2Y3unOBx5YaJrWxW1xT7N1jkzD0bmmNAZqB/mRMCirkWrf3ttGB5pJAC
 STzMcjfOt8PRE3T4jbYq0hG/JBf98nHsJ0gnXYNmGQe4PKb1t6vrOJ069DIRzLytKUYq
 PMVRb7ZC2iijaLE4+inp9J2EXETnTKeUVQgeaHsWHe98OPl+H3aCtP9OEO5u6u4k8qNO
 UkDkh+l/UpqNsFkRiilUHA2PCQCwkc6X3D+7z/eTVd9dRxSjeA4ygEP/imoD2SXHaX85
 3ejw==
X-Gm-Message-State: APjAAAVjK64kJPWuFKZvVcVpgpjl3k/PSJzXAP1UO1+lwGaB8rTGpXYh
 t+F3rZ91KuovqBBdE+4/v4c3va6HnnrLkP/r0GoNbbnk/RrkcFsjjHRB8MyREyVOh+Pck2sO6cF
 uZfBgReUG2A8MJTw=
X-Received: by 2002:a05:600c:2246:: with SMTP id
 a6mr3755826wmm.95.1569514099934; 
 Thu, 26 Sep 2019 09:08:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw69Q7837oljcWWt7PTbm47vIXPJFGM6jFj+60BgveH6OBGrAAY5kHx0x5VfXDXaeMkNq+q2g==
X-Received: by 2002:a05:600c:2246:: with SMTP id
 a6mr3755807wmm.95.1569514099706; 
 Thu, 26 Sep 2019 09:08:19 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id a71sm3928752wme.11.2019.09.26.09.08.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 09:08:19 -0700 (PDT)
Subject: Re: [PATCH v3 29/33] docker: remove 'deprecated' image definitions
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-30-alex.bennee@linaro.org>
 <95fcc08f-d2f1-edf7-0203-d867d297ac9f@redhat.com> <87ftkk9ch0.fsf@linaro.org>
 <a3afe1d8-b621-ba0c-58c3-d049d6eac665@redhat.com> <87a7ar9h8i.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9c1f380e-8dce-db8c-a229-0029fc509e48@redhat.com>
Date: Thu, 26 Sep 2019 18:08:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87a7ar9h8i.fsf@linaro.org>
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

On 9/26/19 6:04 PM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> Hi Alex,
>>
>> On 9/26/19 1:34 AM, Alex Benn=C3=A9e wrote:
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>> On 9/24/19 11:01 PM, Alex Benn=C3=A9e wrote:
>>>>> From: John Snow <jsnow@redhat.com>
>>>>>
>>>>> There isn't a debian.dockerfile anymore,
>>>>> so perform some ghost-busting.
>>>>
>>>> Won't we deprecate other images in the future?
>>>
>>> Sure but we can just drop them from dockerfiles. It's not like we
>>> allowed people to use them as we filtered them out.
>>
>> This patch isn't about removing a deprecated image, but about removing
>> the handy DOCKER_DEPRECATED_IMAGES variable used to start a deprecatio=
n
>> process.
>=20
> But it wasn't really doing anything. Because adding the image to
> DOCKER_DEPRECATED_IMAGES had the same effect as using
> DOCKER_PARTIAL_IMAGES. You couldn't invoke the test from make and it wa=
s
> dropped out from the dependencies for the do-X-on-all image rules. As i=
t
> was also hidden from the help you might as well just delete the thing
> all together.
>=20
>> Fam remembered once we should respect the QEMU deprecation policy even
>> with docker images, because there might be users relying on them, so w=
e
>> want to give them time to adapt. I can not find a thread on the list, =
so
>> we might have discussed that over IRC. The related commits are:
>>
>> $ git show bcaf457786c
>>
>>     docker: do not display deprecated images in 'make docker' help
>>
>>     the 'debian' base image is deprecated since 3e11974988d8
>>
>> $ git show 3e11974988d8
>>
>>     docker: warn users to use newer debian8/debian9 base image
>>
>>     to stay backward incompatible.
>>
>> I'd rather keep the DOCKER_DEPRECATED_IMAGES variable empty, maybe wit=
h
>> a comment describing why it exists. What do you think?
>=20
> I think deprecations are better handled by a noisy warning in the
> dockerfile than the silent suppression of their existence by the make
> system.

Yes, fair enough. Thanks for keeping explaining ;)

Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>> Message-Id: <20190923181140.7235-4-jsnow@redhat.com>
>>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>> ---
>>>>>  tests/docker/Makefile.include | 7 +++----
>>>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.=
include
>>>>> index 82d5a8a5393..fd6f470fbf8 100644
>>>>> --- a/tests/docker/Makefile.include
>>>>> +++ b/tests/docker/Makefile.include
>>>>> @@ -4,11 +4,10 @@
>>>>>
>>>>>  DOCKER_SUFFIX :=3D .docker
>>>>>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>>>>> -DOCKER_DEPRECATED_IMAGES :=3D debian
>>>>>  # we don't run tests on intermediate images (used as base by anoth=
er image)
>>>>> -DOCKER_PARTIAL_IMAGES :=3D debian debian9 debian10 debian-sid
>>>>> +DOCKER_PARTIAL_IMAGES :=3D debian9 debian10 debian-sid
>>>>>  DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-ports debian-bootstr=
ap
>>>>> -DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort=
 $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>>>>> +DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_=
FILES_DIR)/*.docker))))
>>>>>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>>>>>  # Use a global constant ccache directory to speed up repetitive bu=
ilds
>>>>>  DOCKER_CCACHE_DIR :=3D $$HOME/.cache/qemu-docker-ccache
>>>>> @@ -160,7 +159,7 @@ docker-image-debian-powerpc-user-cross: docker-=
binfmt-image-debian-powerpc-user
>>>>>  DOCKER_USER_IMAGES +=3D debian-powerpc-user
>>>>>
>>>>>  # Expand all the pre-requistes for each docker image and test comb=
ination
>>>>> -$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)=
 $(DOCKER_DEPRECATED_IMAGES)), \
>>>>> +$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)=
), \
>>>>>  	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
>>>>>  		$(eval .PHONY: docker-$t@$i) \
>>>>>  		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
>>>>>
>>>
>>>
>>> --
>>> Alex Benn=C3=A9e
>>>
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20

