Received: from eggs.gnu.org ([2001:4830:134:3::10]:60972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5qKM-0006Ko-Th
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5qKI-0006ib-Uo
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:12:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d5qKI-0006iD-Od
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:12:02 -0400
References: <20170502061649.6668.93083.stgit@PASHA-ISP>
	<20170502143706.GL22502@stefanha-x1.localdomain>
	<96fe9706-4846-488e-9e72-a37949f87444@ispras.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2cf2894e-5b88-b19d-a30b-374dcadc8aa2@redhat.com>
Date: Wed, 3 May 2017 11:11:52 +0200
MIME-Version: 1.0
In-Reply-To: <96fe9706-4846-488e-9e72-a37949f87444@ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] maintainers: add maintainer for replay*
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com



On 03/05/2017 07:07, Pavel Dovgalyuk wrote:
> Indeed. I missed these ones.

Please also add myself as reviewer (R:).

get_maintainers.pl doesn't support reviewers yet, but I'll backport it
from Linux today.

Paolo

> =E2=81=A3=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE =D1=
=81 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C=D1=8E BlueMail =E2=80=8B
>=20
> =D0=9D=D0=B0 2 =D0=9C=D0=B0=D0=B9 2017 =D0=B3., 17:37, =D0=B2 17:37, St=
efan Hajnoczi <stefanha@gmail.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BB:=D0=BF>On Tue, May 02, 2017 at 09:16:49AM +0300, Pavel Dovgalyuk wrot=
e:
>>> Updating MAINTAINERS to set Pavel Dovgalyuk as record/replay
>> maintainer.
>>>
>>> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>>> ---
>>>  MAINTAINERS |    9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index a1d2b3a4d3..8be1c74ac5 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1546,6 +1546,15 @@ F: net/colo*
>>>  F: net/filter-rewriter.c
>>>  F: net/filter-mirror.c
>>> =20
>>> +Record/replay
>>> +M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>>> +W: http://wiki.qemu.org/Features/record-replay
>>> +S: Supported
>>> +F: replay/*
>>> +F: block/blkreplay.c
>>> +F: net/filter-replay.c
>>> +F: include/sysemu/replay.h
>>
>> + F: docs/replay.txt
>> + F: stubs/replay.c
>>
>> Are these missing?
