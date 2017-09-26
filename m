Received: from eggs.gnu.org ([2001:4830:134:3::10]:44770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel@loffgren.org>) id 1dwhO3-0003W4-24
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel@loffgren.org>) id 1dwhO2-0002av-5G
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:22:23 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Daniel Loffgren <daniel@loffgren.org>
In-Reply-To: <7726e35d-4869-e5aa-4151-f40bed148825@redhat.com>
Date: Mon, 25 Sep 2017 21:22:18 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <8DDD6AB1-B01F-4B6E-96E4-7AEE486CAFDD@loffgren.org>
References: <5DAE0523-80F8-4F68-93CB-0571C0C62B20@loffgren.org>
	<7726e35d-4869-e5aa-4151-f40bed148825@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] thunk.h uses TARGET_ABI_BITS without
 including abitypes.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

I am attempting to get ppc-darwin-user in a good working state again, =
and this broke one of the .c files that included it. I figured this =
change should be made regardless of my branch, and would help reduce the =
size of my branch for future rebasing.

> On Sep 25, 2017, at 9:37 AM, Thomas Huth <thuth@redhat.com> wrote:
>=20
>=20
> Did this cause any trouble? ... one of two sentences in the patch
> description would be nice, I think.
>=20
> Thomas
>=20
>=20
> On 25.09.2017 03:02, Daniel Loffgren wrote:
>>=20
>> Signed-off-by: Daniel Loffgren <daniel@loffgren.org>
>> ---
>> include/exec/user/thunk.h | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
>> index f19ef4b230..12b5449d8c 100644
>> --- a/include/exec/user/thunk.h
>> +++ b/include/exec/user/thunk.h
>> @@ -19,6 +19,7 @@
>> #ifndef THUNK_H
>> #define THUNK_H
>>=20
>> +#include "abitypes.h"
>> #include "cpu.h"
>>=20
>> /* types enums definitions */
>>=20
>=20
