Received: from eggs.gnu.org ([2001:4830:134:3::10]:39528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7nLM-0000VD-HK
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7nLL-00057r-9h
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:02:00 -0400
References: <20181002233314.30159-1-jsnow@redhat.com>
	<79b55f31-00a9-273f-e004-6c097a2f1542@virtuozzo.com>
	<ee24dc7f-7685-aaae-3315-60d66284bb23@redhat.com>
	<a0d3a14f-610f-c326-004b-336f49c98f39@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48fef418-d99d-b4d2-d007-062f1275ad8a@redhat.com>
Date: Wed, 3 Oct 2018 15:01:41 -0500
MIME-Version: 1.0
In-Reply-To: <a0d3a14f-610f-c326-004b-336f49c98f39@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] bitmap: Update count after a merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 10/3/18 2:57 PM, John Snow wrote:

>>>  =C2=A0 =C2=A0- I always forget to update this field.. We definitely =
should add some
>>> generic check on it somewhere, at least in tests.
>>
>> My suggestion (in another thread) was to enhance
>> x-debug-block-dirty-bitmap-sha256 to include 'count' alongside the
>> checksum, to make it easier to write such tests.
>>
>=20
> I suppose this is in preference to query-block? It would make it easier=
.

Well, query-block remains the canonical way for users to access the=20
count, while x-debug-block-dirty-bitmap-sha256 is for debugging only=20
(basically, for our unit tests, as no one outside of qemu will get much=20
use out of it).  But yes, writing a test that uses bitmaps on an=20
unconnected BDS is easier than a test that has to use a named device,=20
since query-block won't list nodes that aren't connected to a named=20
device, and requires a lot more parsing to get at the actual bitmap=20
information in comparison to the debug command directly telling you=20
about a single bitmap.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
