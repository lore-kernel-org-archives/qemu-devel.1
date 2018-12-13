Received: from eggs.gnu.org ([2001:4830:134:3::10]:48249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXRc2-00007f-00
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXRc0-00083y-Tv
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:05:13 -0500
References: <20181212220410.569069-1-eblake@redhat.com>
	<7936c6ef-7576-6004-5999-6af23cd88db9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <391c955c-b347-5b65-7d78-d0287e2a787c@redhat.com>
Date: Thu, 13 Dec 2018 08:04:53 -0600
MIME-Version: 1.0
In-Reply-To: <7936c6ef-7576-6004-5999-6af23cd88db9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] qemu-io: Prefer stderr for error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 12/13/18 6:21 AM, Wainer dos Santos Moschetta wrote:
>=20
> On 12/12/2018 08:04 PM, Eric Blake wrote:
>> When a qemu-io command fails, it's best if the failure message
>> goes to stderr rather than stdout.
>>
>> Reported-by: Richard W.M. Jones <rjones@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> RFC because at least iotest 60 (found by -qcow2 -g quick) breaks due
>> to reordering of output lines, and I'd rather know if we like this
>> idea before bothering to revisit all affected iotests (including
>> discovering if other slower ones have similar problems).

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!QEMU_IS_AL=
IGNED(count, BDRV_SECTOR_SIZE)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
intf("%"PRId64" is not a sector-aligned value for=20
>> 'count'\n",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fp=
rintf(stderr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%"PRId64" is not a sector-=
aligned value for=20
>> 'count'\n",
>=20
> Adding one space before and after PRId64 as in '"%" PRId64 " is not=20
> (...)"' increases readability IMHO.

Pre-existing, but I don't mind fixing it while touching in the area.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
