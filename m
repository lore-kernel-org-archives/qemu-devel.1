Received: from eggs.gnu.org ([2001:4830:134:3::10]:35421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1elzNk-0005g5-Oa
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1elzNj-00008G-Qa
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:54:04 -0500
References: <18b3a8c6-4f5c-3623-a781-5beb94375331@virtuozzo.com>
	<2ad975a6-7624-cb63-ce1e-2dadf9b1c40e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <22cccbd8-659d-d794-5458-3fa13c3325d3@virtuozzo.com>
Date: Wed, 14 Feb 2018 18:28:42 +0300
MIME-Version: 1.0
In-Reply-To: <2ad975a6-7624-cb63-ce1e-2dadf9b1c40e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] BLOCK_STATUS extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Wouter Verhelst <w@uter.be>, nbd list <nbd@other.debian.org>, Alex Bligh <alex@alex.org.uk>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

14.02.2018 17:56, Eric Blake wrote:
> [using the updated nbd list email]
>
> On 02/14/2018 08:35 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> Just note: looks like we allow zero-sized metadata context name. Is=20
>> it ok?
>>
>> =C2=A0=C2=A0*
>>
>> =C2=A0=C2=A0=C2=A0 |NBD_REP_META_CONTEXT| (4)
>>
>> =C2=A0=C2=A0=C2=A0 A description of a metadata context. Data:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o 32 bits, NBD metadata context ID.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o String, name of the metadata context. T=
his is not required to be
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a human-readable string, but =
it MUST be valid UTF-8 data.
>
> No; elsewhere we state:
>
>>
>> Metadata contexts are identified by their names. The name MUST=20
>> consist of a namespace, followed by a colon, followed by a leaf-name.=20
>> The namespace must consist entirely of printable non-whitespace UTF-8=20
>> characters other than colons, and be non-empty. The entire name=20
>> (namespace, colon, and leaf-name) MUST follow the restrictions for=20
>> strings as laid out earlier in this document.
>>
>> Namespaces MUST be consist of one of the following:
>>
>> =C2=A0=C2=A0=C2=A0 base, for metadata contexts defined by this document;
>> =C2=A0=C2=A0=C2=A0 nbd-server, for metadata contexts defined by the impl=
ementation=20
>> that accompanies this document (none currently);
>> =C2=A0=C2=A0=C2=A0 x-*, where * can be replaced by an arbitrary string n=
ot=20
>> containing colons, for local experiments. This SHOULD NOT be used by=20
>> metadata contexts that are expected to be widely used.
>> =C2=A0=C2=A0=C2=A0 A third-party namespace from the list below.
>>
>
> So a name must be at least 2 bytes (for a one-byte namespace, if=20
> someone ever registers one - and supposing that namespace has=20
> zero-byte leaf names), but will more commonly be even longer.
>

Ok, thank you.

--=20
Best regards,
Vladimir
