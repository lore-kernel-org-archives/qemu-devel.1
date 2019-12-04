Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CB1C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF8C205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rjy8eA8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF8C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icVHK-0005k2-JN
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1icVFS-00045c-OD
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:03:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1icVFM-0001Vn-85
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:03:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21278
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1icVFM-0001VX-1O
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575468195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Qp6nn6yT0MWya+4eXZFhviYS4Qf3qDbKv6VGLB/dDDQ=;
 b=Rjy8eA8TtOSwdl3EO8Ltijw4Ml2pppJWzXcxJZY5uRXVtnlbJYzVgBKXBymYlqbx/iwywR
 ubx97PFguj3atjYzeYg4vk8S716r0yrpfKdJRYcQ/7JgHNtyLTJFEPA0d3T3GnHwJMRWzs
 dknvmMnXFHoWZR9Z2DgYNxIRHymbxz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-6T_lAQb3NHuum0W9LeIB_A-1; Wed, 04 Dec 2019 09:03:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAD1E107ACC4;
 Wed,  4 Dec 2019 14:03:12 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-39.ams2.redhat.com [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B50B869184;
 Wed,  4 Dec 2019 14:03:07 +0000 (UTC)
Subject: Re: [PATCH 0/6] Enable Travis builds on arm64, ppc64le and s390x
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191119170822.45649-1-thuth@redhat.com>
 <87wobr7bkz.fsf@linaro.org> <878so4gsh1.fsf@linaro.org>
 <eb3ff72d-647b-ce46-d0de-9fb8556dfacc@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <67da9041-9550-e03b-437e-d68a45c52f43@redhat.com>
Date: Wed, 4 Dec 2019 15:03:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <eb3ff72d-647b-ce46-d0de-9fb8556dfacc@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 6T_lAQb3NHuum0W9LeIB_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/11/2019 09.50, Thomas Huth wrote:
> On 25/11/2019 11.28, Alex Benn=C3=A9e wrote:
>>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> Travis recently added build hosts for arm64, ppc64le and s390x, so
>>>> this is a welcome addition to our Travis testing matrix.
>>>>
>>>> Unfortunately, the builds are running in quite restricted LXD
>>>> containers
>>>> there, for example it is not possible to create huge files there (even
>>>> if they are just sparse), and certain system calls are blocked. So we
>>>> have to change some tests first to stop them failing in such
>>>> environments.
>>> <snip>
>>>> =C2=A0=C2=A0 iotests: Skip test 060 if it is not possible to create la=
rge files
>>>> =C2=A0=C2=A0 iotests: Skip test 079 if it is not possible to create la=
rge files
>>>
>>> It seems like 161 is also failing:
>>>
>>> =C2=A0=C2=A0 https://travis-ci.org/stsquad/qemu/jobs/615672478
>>
>> And sometimes 249
>=20
> These must be intermittent problems ... I've seen 161 failing once at
> the very beginning of my tests, but then never again, so I assumed that
> it was a quirk with the test system that got fixed later. Seems like
> that was a wrong assumption. I've never seen 249 failing so far... I'll
> try to do some more tests when I've got some spare time...

It's not intermittent, it's a problem with "dist: bionic". It seems to
work fine with "dist: xenial", as far as I can tell. So I think we
should simply stick with "dist: xenial" for the ppc64le builder unless
someone has a ppc64le bionic system at hand for debugging.

 Thomas


