Received: from eggs.gnu.org ([2001:4830:134:3::10]:39165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOn55-0000mm-PP
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOn55-0008AV-61
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:11:27 -0500
References: <20181116155325.22428-7-berrange@redhat.com>
	<20181118022403.2211483-1-eblake@redhat.com>
	<20181119104030.GK19532@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3f7cb55e-c3cc-bd0f-38d9-372ab8571911@redhat.com>
Date: Mon, 19 Nov 2018 11:11:23 -0600
MIME-Version: 1.0
In-Reply-To: <20181119104030.GK19532@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/6] iotests: Also test I/O over NBD TLS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

On 11/19/18 4:40 AM, Daniel P. Berrang=C3=A9 wrote:
> On Sat, Nov 17, 2018 at 08:24:03PM -0600, Eric Blake wrote:
>> Enhance test 233 to also perform I/O beyond the initial handshake.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> Depends on my tweak to 2/6 to suppress an EIO error message
>> on a failed read after NBD_CMD_DISC.
>>
>>   tests/qemu-iotests/233     | 12 +++++++++++-
>>   tests/qemu-iotests/233.out | 10 ++++++++++
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Yay - after dropping patch 2/6 (both your work, and the code I was=20
questioning whether to squash in), and instead using your patch for=20
making qio return 0 on connection abort after shutdown, this test still=20
passes without any extra lines from the server.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
