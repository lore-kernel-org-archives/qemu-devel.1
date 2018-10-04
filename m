Received: from eggs.gnu.org ([2001:4830:134:3::10]:50947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86Ws-00014F-KX
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86Wp-0000Tb-WE
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:31:10 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-7-crosa@redhat.com>
	<4f0850d2-3baa-7acc-d34b-98f074f1a2f8@vivier.eu>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <50e4aeaa-7f4f-03b3-05ae-2a29deac9662@redhat.com>
Date: Thu, 4 Oct 2018 12:31:04 -0400
MIME-Version: 1.0
In-Reply-To: <4f0850d2-3baa-7acc-d34b-98f074f1a2f8@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/10] thunk.c: clean up commented out
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>



On 10/4/18 12:24 PM, Laurent Vivier wrote:
> Le 04/10/2018 =C3=A0 18:18, Cleber Rosa a =C3=A9crit=C2=A0:
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  thunk.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/thunk.c b/thunk.c
>> index d5d8645cd4..e351ae53af 100644
>> --- a/thunk.c
>> +++ b/thunk.c
>> @@ -21,8 +21,6 @@
>>  #include "qemu.h"
>>  #include "exec/user/thunk.h"
>> =20
>> -//#define DEBUG
>> -
>=20
> Generally we use that to enable easily existing debug traces.
>=20

Oh, I wasn't aware that was intentional (I clearly lack some background
here).

> In this case, if you remove the "#define" I think you should also
> replace the "#ifdef DEBUG"s by some trace_XXXX() functions.
>=20

Is that desirable? I don't want to disrupt the status quo just because
it looked odd to me.

Thanks!
- Cleber.

> Thanks,
> Laurent
>=20
