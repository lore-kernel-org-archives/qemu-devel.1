Received: from eggs.gnu.org ([2001:4830:134:3::10]:60581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3HHS-0007Q2-0y
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3HHO-00085A-Sm
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:22:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d3HHO-00084i-Mf
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:22:26 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1558ac56-8c05-0940-f19c-d3783c708ab3@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue,
	25 Apr 2017 22:41:48 -0300")
References: <20170425223739.6703-1-quintela@redhat.com>
	<20170425223739.6703-6-quintela@redhat.com>
	<1558ac56-8c05-0940-f19c-d3783c708ab3@amsat.org>
Reply-To: quintela@redhat.com
Date: Wed, 26 Apr 2017 09:22:21 +0200
Message-ID: <8760hrmy4y.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/26] audio: Remove UINT8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> Hi Juan,
>
> On 04/25/2017 07:37 PM, Juan Quintela wrote:
>> uint8_t has existed since ..... all this century?
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  hw/audio/fmopl.c |  8 ++++----
>>  hw/audio/fmopl.h | 39 ++++++++++++++++++++-------------------
>>  2 files changed, 24 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
>> index 282662a..3d14b45 100644
>> --- a/hw/audio/fmopl.c
>> +++ b/hw/audio/fmopl.c
>> @@ -789,8 +789,8 @@ static void OPLWriteReg(FM_OPL *OPL, int r, int v)
>>  			}
>>  			else
>>  			{	/* set IRQ mask ,timer enable*/
>> -				UINT8 st1 =3D v&1;
>> -				UINT8 st2 =3D (v>>1)&1;
>> +				uint8_t st1 =3D v&1;
>> +				uint8_t st2 =3D (v>>1)&1;
>
> Welcome to stdint! but since you're changing this code please make it
> more readable (at least spaces) so checkpatch don't reject your serie:
>
> ERROR: spaces required around that '&'

checkpatch reject because there are no spaces and there are tabs all
around.  I think that the only sane solution is to run indent on the
whole file, or maintain the "old" format.

Gerd, any prefferences?

Later, Juan.
