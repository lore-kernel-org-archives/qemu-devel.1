Received: from eggs.gnu.org ([2001:4830:134:3::10]:53275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecb5v-00082L-GG
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecb5q-0005p5-Jj
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:08:51 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-14-vsementsov@virtuozzo.com>
	<20171228063330.GL9192@lemon>
	<e7950241-1eee-a415-3e28-9468f1020d1b@virtuozzo.com>
	<17c25946-8cce-21e8-d70f-856fb1924b8c@redhat.com>
	<753ed688-ea9f-4070-b98f-ddbd35f49a32@virtuozzo.com>
Message-ID: <b2f0c083-d5b3-774b-e931-c7bbe6dc1eac@virtuozzo.com>
Date: Fri, 19 Jan 2018 21:08:39 +0300
MIME-Version: 1.0
In-Reply-To: <753ed688-ea9f-4070-b98f-ddbd35f49a32@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v9 13/13] iotests: add dirty bitmap
 postcopy test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com

18.01.2018 12:57, Vladimir Sementsov-Ogievskiy wrote:
> 17.01.2018 21:30, John Snow wrote:
>>
>> On 12/28/2017 06:49 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Thank you for reviewing my code!
>>>
>> Time for the re-spin? There's pretty good pressure to get this into 2.12
>> and say the non-nbd workflow model is feature complete.
>
> Yes, you are right. Hope to do it today or tomorrow.
>

I've rebased, applied comments from review, and even one some new fixes,=20
but now I understand that it is too early for re-spin.

Now this series depends on
1. [PATCH v2 0/3] fix bitmaps migration through shared storage
 =C2=A0 - we need to decide, how to fix it. May be, we just do not need=20
bitmaps in inactive state, and should not load them in do_qcow2_open in=20
this case
 =C2=A0 [I can ignore it, just dropping one test case from new iotest, and=
=20
fix it later, but..
2. [PATCH v2 0/6] qmp dirty bitmap API
 =C2=A0- here autoload is dropped, and migration should be rebased on it.

so, I'll re-spin migration after these two questions are resolved.

--=20
Best regards,
Vladimir
