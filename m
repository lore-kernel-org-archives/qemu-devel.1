Received: from eggs.gnu.org ([2001:4830:134:3::10]:55972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFRsa-0000jh-Rj
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 16:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFRsa-0002Ph-1c
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 16:39:24 -0500
References: <20171115090947.29883-1-kchamart@redhat.com>
	<0b29e074-6548-d42e-12ab-67419342773e@redhat.com>
	<20171115215433.fpihpl645mlholgo@eukaryote>
	<6ac3e1b3-d3b0-afe4-4d87-e8c421084d7f@redhat.com>
	<20171116091405.pleud7qrqzu5nzhb@eukaryote>
From: John Snow <jsnow@redhat.com>
Message-ID: <84a19949-f1ba-bf92-caf5-19b545564417@redhat.com>
Date: Thu, 16 Nov 2017 16:39:17 -0500
MIME-Version: 1.0
In-Reply-To: <20171116091405.pleud7qrqzu5nzhb@eukaryote>
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



On 11/16/2017 04:14 AM, Kashyap Chamarthy wrote:
> On Wed, Nov 15, 2017 at 04:56:13PM -0500, John Snow wrote:
>>
>>
>> On 11/15/2017 04:54 PM, Kashyap Chamarthy wrote:
>>> On Wed, Nov 15, 2017 at 02:15:57PM -0500, John Snow wrote:
>=20
> [...]
>=20
>>>> is it covered sufficiently in live-block-operations.rst ?
>>>
>>> I looked in there[2] too.  Short answer: no.  Long: In the "Live disk
>>> synchronization =E2=80=94 drive-mirror and blockdev-mirror" section, =
I simply
>>> seemed to declare:=20
>>>
>>>     "Issuing the command ``block-job-cancel`` after it emits the even=
t
>>>     ``BLOCK_JOB_CANCELLED``"
>>>
>>> As if that's the *only* event it emits, which is clearly not the case=
.
>>> So while at it, wonder if should I also update it
>>> ('live-block-operations.rst') too.
>>>
>>
>> It's an interesting gotcha that I wasn't really acutely aware of mysel=
f,
>> so having it in the doc format for API programmers who aren't
>> necessarily digging through our source sounds like a pleasant courtesy=
.
>=20
> Indeed, will do.  (Just for my own clarity, did you imply: don't update
> it in block-core.json?  FWIW, my first instinct is to check the QAPI
> documentation for such things, that's why I wrote there first :-))
>=20

No, definitely update both.

> Thanks for looking.
>=20
> [...]
>=20
