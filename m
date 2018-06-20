Received: from eggs.gnu.org ([2001:4830:134:3::10]:49492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fVfdw-0003LA-Nk
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fVfdv-0000cM-NH
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:07:36 -0400
References: <20180620152713.27309-1-vsementsov@virtuozzo.com>
	<f3fd65c1-fd8b-1a68-3437-9eb12d0ae25f@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <48cfe0a2-734b-0b4c-a309-77354690475e@redhat.com>
Date: Wed, 20 Jun 2018 12:07:29 -0400
MIME-Version: 1.0
In-Reply-To: <f3fd65c1-fd8b-1a68-3437-9eb12d0ae25f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qapi: drop x- from
 x-block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org



On 06/20/2018 11:28 AM, Vladimir Sementsov-Ogievskiy wrote:
> 20.06.2018 18:27, Vladimir Sementsov-Ogievskiy wrote:
>> Libvirt part is ready, let's drop x- prefix.
>=20
> libvirt patches will be sent soon I hope.
>=20

OK, can you ping this patch with a link to the series when it is posted?

Thank you,
--js

>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 qapi/block-core.json | 4 ++--
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 2 +-
>> =C2=A0 2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index cc3ede0630..dfaa050651 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -483,7 +483,7 @@
>> =C2=A0=C2=A0=C2=A0 'data': {'boundaries': ['uint64'], 'bins': ['uint64=
'] } }
>> =C2=A0 =C2=A0 ##
>> -# @x-block-latency-histogram-set:
>> +# @block-latency-histogram-set:
>> =C2=A0 #
>> =C2=A0 # Manage read, write and flush latency histograms for the devic=
e.
>> =C2=A0 #
>> @@ -547,7 +547,7 @@
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "arguments": { "device": "drive=
0" } }
>> =C2=A0 # <- { "return": {} }
>> =C2=A0 ##
>> -{ 'command': 'x-block-latency-histogram-set',
>> +{ 'command': 'block-latency-histogram-set',
>> =C2=A0=C2=A0=C2=A0 'data': {'device': 'str',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '*boundaries': ['uint64'],
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '*boundaries-read': ['uint64'],
>> diff --git a/blockdev.c b/blockdev.c
>> index 58d7570932..6d4ae77041 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -4299,7 +4299,7 @@ void qmp_x_blockdev_set_iothread(const char
>> *node_name, StrOrNull *iothread,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aio_context_release(old_context);
>> =C2=A0 }
>> =C2=A0 -void qmp_x_block_latency_histogram_set(
>> +void qmp_block_latency_histogram_set(
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *device,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool has_boundaries, uint64List *bounda=
ries,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool has_boundaries_read, uint64List *b=
oundaries_read,
>=20
>=20
