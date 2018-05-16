Received: from eggs.gnu.org ([2001:4830:134:3::10]:35657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJ4OD-0003mZ-GK
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJ4OC-0003fn-LC
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:55:17 -0400
References: <20180512012537.22478-1-jsnow@redhat.com>
	<20180512012537.22478-10-jsnow@redhat.com>
	<70d0df96-1d41-4687-4b55-fcfdb42adb0c@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8380a71e-3f5e-1915-9112-037cebd23fc1@redhat.com>
Date: Wed, 16 May 2018 17:55:09 -0400
MIME-Version: 1.0
In-Reply-To: <70d0df96-1d41-4687-4b55-fcfdb42adb0c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 09/12] qapi/block-core: add
 BitmapMapping and BitmapEntry structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 05/16/2018 05:37 PM, Eric Blake wrote:
>> +##
>> +# @BitmapMapping:
>> +#
>> +# List of described regions correlated to a named bitmap.
>> +#
>> +# @name: The name of the bitmap whose range is described here
>> +#
>> +# @entries: A list of zero or more @BitmapEntry elements representing
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the ran=
ge(s) described by the bitmap.
>=20
> Is it also worth documenting that the list will be in ascending order,
> with no overlaps (no two entries covering the same offset); and in fact
> with a gap between all entries (as otherwise those two consecutive
> entries could have been consolidated to one)?
>=20

Hm. I didn't necessarily want to guarantee the order, but being more
specific about the output will assist legibility of the spec.

I'll amend the documentation and make some stronger guarantees.

>> +#
>> +# Since: 2.13
>> +#
>> +##
>> +{ 'struct': 'BitmapMapping',
>> +=C2=A0 'data': { 'name': 'str',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'e=
ntries': [ 'BitmapEntry' ] } }
>> +
>> =C2=A0 ##
>> =C2=A0 # @BlockdevCacheInfo:
>> =C2=A0 #=20
