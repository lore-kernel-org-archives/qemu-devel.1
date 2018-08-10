Received: from eggs.gnu.org ([2001:4830:134:3::10]:39524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fo03f-0000kH-FV
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fo03e-0005j0-K5
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:33:55 -0400
References: <20180809215307.18241-1-lbloch@janustech.com>
	<20180809215307.18241-6-lbloch@janustech.com>
	<e47135a1-2827-d969-1c33-da00846c9e61@redhat.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <37b1b971-e6be-2226-0a8f-0d336bbde8a7@janustech.com>
Date: Fri, 10 Aug 2018 08:33:29 +0300
MIME-Version: 1.0
In-Reply-To: <e47135a1-2827-d969-1c33-da00846c9e61@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 5/8] qcow2: Increase the default upper
 limit on the L2 cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -73,7 +73,7 @@
>> =C2=A0 /* Must be at least 4 to cover all cases of refcount table growth=
 */
>> =C2=A0 #define MIN_REFCOUNT_CACHE_SIZE 4 /* clusters */
>> -#define DEFAULT_L2_CACHE_MAX_SIZE 1048576=C2=A0 /* bytes */
>> +#define DEFAULT_L2_CACHE_MAX_SIZE 0x2000000U /* bytes */
>=20
> I'd spell this as '(64 * MiB)' with the help of "qemu/units.h".
>=20

You mean '(32 * MiB)', right? Good idea! Done.

Leonid.
