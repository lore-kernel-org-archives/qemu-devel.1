Received: from eggs.gnu.org ([208.118.235.92]:59143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1echDW-000752-1w
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 19:41:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1echC8-00072G-B3
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 19:41:06 -0500
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-14-vsementsov@virtuozzo.com>
	<20171228063330.GL9192@lemon>
	<e7950241-1eee-a415-3e28-9468f1020d1b@virtuozzo.com>
	<17c25946-8cce-21e8-d70f-856fb1924b8c@redhat.com>
	<753ed688-ea9f-4070-b98f-ddbd35f49a32@virtuozzo.com>
	<b2f0c083-d5b3-774b-e931-c7bbe6dc1eac@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <94f7d424-0a97-6360-1551-3c7df9f7b203@redhat.com>
Date: Fri, 19 Jan 2018 19:37:46 -0500
MIME-Version: 1.0
In-Reply-To: <b2f0c083-d5b3-774b-e931-c7bbe6dc1eac@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com



On 01/19/2018 01:08 PM, Vladimir Sementsov-Ogievskiy wrote:
> 18.01.2018 12:57, Vladimir Sementsov-Ogievskiy wrote:
>> 17.01.2018 21:30, John Snow wrote:
>>>
>>> On 12/28/2017 06:49 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Thank you for reviewing my code!
>>>>
>>> Time for the re-spin? There's pretty good pressure to get this into 2=
.12
>>> and say the non-nbd workflow model is feature complete.
>>
>> Yes, you are right. Hope to do it today or tomorrow.
>>
>=20
> I've rebased, applied comments from review, and even one some new fixes=
,
> but now I understand that it is too early for re-spin.
>=20
> Now this series depends on
> 1. [PATCH v2 0/3] fix bitmaps migration through shared storage
> =C2=A0 - we need to decide, how to fix it. May be, we just do not need
> bitmaps in inactive state, and should not load them in do_qcow2_open in
> this case
> =C2=A0 [I can ignore it, just dropping one test case from new iotest, a=
nd fix
> it later, but..

I'll look at this next.

> 2. [PATCH v2 0/6] qmp dirty bitmap API
> =C2=A0- here autoload is dropped, and migration should be rebased on it=
.
>=20

For (2) I really want to see a test case showing the utility for enable,
disable and merge to be added to the API, *or* add an x- prefix to them
for now.

I want to see some use-case tests that demonstrate how they are to be
safely used, basically. You might want to expand test 124 for this.

I'm not sure we need this entire series for migration, but I don't want
to make you re-order absolutely everything. Can we merge patch one by
itself for the purposes of the migration patchset?

> so, I'll re-spin migration after these two questions are resolved.
>=20

Thanks for your patience, as always. Please send me pings every day on
whatever you have to in order to get migration in to 2.12 -- I'm going
to try to stay focused too, but I've got the attention span of a
goldfish. If I miss something, please speak up.

--js
