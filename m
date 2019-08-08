Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC16C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 13:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E120321880
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 13:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E120321880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=unipi.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hviJp-0005qd-Uz
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 09:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55575)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <giuseppe.lettieri@unipi.it>) id 1hvcq8-0003SB-4d
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 03:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <giuseppe.lettieri@unipi.it>) id 1hvcq7-0001Xi-15
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 03:28:00 -0400
Received: from smtp2.unipi.it ([131.114.21.21]:54688 helo=smtp.unipi.it)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <giuseppe.lettieri@unipi.it>) id 1hvcq6-0001X9-NT
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 03:27:58 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.unipi.it (Postfix) with ESMTP id BFDBF408D0;
 Thu,  8 Aug 2019 09:27:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at unipi.it
Received: from [10.216.1.207] (prova.iet.unipi.it [131.114.58.86])
 (Authenticated User)
 by smtp.unipi.it (Postfix) with ESMTPSA id 0987440851;
 Thu,  8 Aug 2019 09:27:53 +0200 (CEST)
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
 <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
From: Giuseppe Lettieri <giuseppe.lettieri@unipi.it>
Message-ID: <695325d7-a0c3-73c1-97ab-f62fb345c622@unipi.it>
Date: Thu, 8 Aug 2019 09:27:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 131.114.21.21
X-Mailman-Approved-At: Thu, 08 Aug 2019 09:18:34 -0400
Subject: Re: [Qemu-devel] Is network backend netmap worth keeping?
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Vincenzo Maffione <v.maffione@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dear Markus,

the netmap project is alive and well, if a bit understuffed. We have=20
moved to github:

https://github.com/luigirizzo/netmap

We have users from FreeBSD, where it is part of the official kernel, and=20
Linux, both from Academia and industry.

But you asked about the netmap backend in QEMU, in particular. When it=20
was merged, the decision was made to disable it by default because it=20
was not supported upstream in Linux. As Jason Wang says, this support is=20
even more unlikely now than it was then.

The fact the the backend has to be explicitly enabled and built from the=20
sources has obviously cut down the number of potential users. However,=20
we still think it is useful and we have pending updates for it. If it's=20
causing problems in the workflow, I am willing to help as much as I can.

Cheers,
Giuseppe

Il 08/08/19 06:48, Markus Armbruster ha scritto:
> Please excuse the attention-grabbing subject.
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> On 8/7/19 10:16 PM, Markus Armbruster wrote:
> [...]
>>> Can you tell me offhand what I have to install so configure enables
>>> CONFIG_NETMAP?
>>
>> The steps are listed in tests/docker/dockerfiles/debian-amd64.docker,
>> but you can get to this point running:
>>
>>    $ make docker-image-debian-amd64 V=3D1 DEBUG=3D1
>>
>> This will build the docker image with netmap (so you don't have to mes=
s
>> with your workstation setup), then build QEMU within the image.
>=20
> So, to make use of QEMU's netmap backend (CONFIG_NETMAP), you have to
> build and install netmap software from sources.  Which pretty much
> ensures nobody uses it.  It was added in commit 58952137b0b (Nov 2013).
> The commit message points to <http://info.iet.unipi.it/~luigi/netmap/>,
> which gives me "connection timed out" right now.
>=20
> On the other hand, it's covered in MAINTAINERS, and has seen
> non-janitorial activity as late as Dec 2018 (commit c693fc748a).
>=20
> Luigi, Giuseppe, Vincenzo, what's the status of the netmap project?
>=20
> Why is the QEMU netmap backend worth keeping?
>=20
> Who is using the netmap backend?
>=20
> How do they obtain a netmap-enabled QEMU?  Compile it from sources
> themselves?
>=20
> Would it make sense to have netmap packaged in common Linux distros?
>=20


--=20
Dr. Ing. Giuseppe Lettieri
Dipartimento di Ingegneria della Informazione
Universita' di Pisa
Largo Lucio Lazzarino 1, 56122 Pisa - Italy
Ph. : (+39) 050-2217.649 (direct) .599 (switch)
Fax : (+39) 050-2217.600
e-mail: g.lettieri@iet.unipi.it

