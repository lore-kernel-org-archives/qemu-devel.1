Received: from eggs.gnu.org ([2001:4830:134:3::10]:37955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eF5fP-00024B-98
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eF5fO-0001fu-4j
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:56:19 -0500
References: <20171115090947.29883-1-kchamart@redhat.com>
	<0b29e074-6548-d42e-12ab-67419342773e@redhat.com>
	<20171115215433.fpihpl645mlholgo@eukaryote>
From: John Snow <jsnow@redhat.com>
Message-ID: <6ac3e1b3-d3b0-afe4-4d87-e8c421084d7f@redhat.com>
Date: Wed, 15 Nov 2017 16:56:13 -0500
MIME-Version: 1.0
In-Reply-To: <20171115215433.fpihpl645mlholgo@eukaryote>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qapi: block-core: Clarify
 events emitted by 'block-job-cancel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com



On 11/15/2017 04:54 PM, Kashyap Chamarthy wrote:
> On Wed, Nov 15, 2017 at 02:15:57PM -0500, John Snow wrote:
>>
>>
>> On 11/15/2017 04:09 AM, Kashyap Chamarthy wrote:
>>> When you cancel an in-progress live block operation with QMP
>>> `block-job-cancel`, it emits the event: BLOCK_JOB_CANCELLED.  However=
,
>>> when `block-job-cancel` is issued after `drive-mirror` has indicated =
(by
>>> emitting the event BLOCK_JOB_READY) that the source and destination
>>> remain synchronized:
>=20
> [...]
>=20
>>> But this is expected behaviour, where the _COMPLETED event indicates
>>> that synchronization has successfully ended (and the destination has =
a
>>> point-in-time copy, which is at the time of cancel).
>>>
>>> So add a small note to this effect.  (Thanks: Max Reitz for reminding
>>> me of this on IRC.)
>>>
>>
>> I suppose this difference probably isn't covered in what was the
>> bitmaps.md doc file (we don't bother covering mirror there, only
>> backup);=20
>=20
> Your supposition is correct: Looking at the now-renamed
> 'bitmaps.rst'[1], it isn't covered there.
>=20

Makes sense, I don't think we need to correct this, and

>> is it covered sufficiently in live-block-operations.rst ?
>=20
> I looked in there[2] too.  Short answer: no.  Long: In the "Live disk
> synchronization =E2=80=94 drive-mirror and blockdev-mirror" section, I =
simply
> seemed to declare:=20
>=20
>     "Issuing the command ``block-job-cancel`` after it emits the event
>     ``BLOCK_JOB_CANCELLED``"
>=20
> As if that's the *only* event it emits, which is clearly not the case.
> So while at it, wonder if should I also update it
> ('live-block-operations.rst') too.
>=20

It's an interesting gotcha that I wasn't really acutely aware of myself,
so having it in the doc format for API programmers who aren't
necessarily digging through our source sounds like a pleasant courtesy.

> [1] https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/interop/bitmap=
s.rst
> [2] https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/interop/live-b=
lock-operations.rst#l513=20
>=20

Thanks Kashyap :)
