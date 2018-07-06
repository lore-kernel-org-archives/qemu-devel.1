Received: from eggs.gnu.org ([2001:4830:134:3::10]:39387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fbPol-0008Mj-IC
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fbPok-0002Oj-Mx
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:26:31 -0400
References: <20180705102604.4986-1-kwolf@redhat.com>
	<20180705102604.4986-10-kwolf@redhat.com>
	<baf76d34-88bf-5ac6-cce0-b63a15e0bbe5@redhat.com>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <404987c8-6979-18aa-ac3f-ed5ae6b08b72@tuxera.com>
Date: Fri, 6 Jul 2018 15:26:21 +0300
MIME-Version: 1.0
In-Reply-To: <baf76d34-88bf-5ac6-cce0-b63a15e0bbe5@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 09/12] block/blklogwrites: Add an option
 for appending to an old log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On 07/05/2018 07:06 PM, Eric Blake wrote:
> On 07/05/2018 05:26 AM, Kevin Wolf wrote:
>> From: Ari Sundholm <ari@tuxera.com>
>>
>> Suggested by Kevin Wolf. May be useful when testing multiple batches
>> of writes or doing long-term testing involving restarts of the VM.
>>
>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>> =C2=A0 qapi/block-core.json |=C2=A0=C2=A0 3 +-
>> =C2=A0 block/blklogwrites.c | 147=20
>> ++++++++++++++++++++++++++++++++++++++++++++++-----
>> =C2=A0 2 files changed, 135 insertions(+), 15 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index a9eab8cab8..d1753a2ae7 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3062,7 +3062,8 @@
>> =C2=A0 { 'struct': 'BlockdevOptionsBlklogwrites',
>> =C2=A0=C2=A0=C2=A0 'data': { 'file': 'BlockdevRef',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 'log': 'BlockdevRef',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*=
log-sector-size': 'uint32' } }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*=
log-sector-size': 'uint32',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*=
log-append': 'bool' } }
>=20
> Missing documentation (including the default value) of the new member.=20
> Since this is already pulled, please submit a followup patch.
>=20

I somehow missed your message. Sorry.

Thanks for spotting this. I just sent a patch to add the missing=20
documentation.

Thanks,
Ari Sundholm
ari@tuxera.com
