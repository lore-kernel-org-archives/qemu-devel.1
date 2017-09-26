Received: from eggs.gnu.org ([2001:4830:134:3::10]:44737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel@loffgren.org>) id 1dwhNz-0003VB-NQ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel@loffgren.org>) id 1dwhNw-0002Y5-CM
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:22:19 -0400
From: Daniel Loffgren <daniel@loffgren.org>
Message-Id: <415B68ED-AFB4-4673-8B66-90F74C4B64E1@loffgren.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Mon, 25 Sep 2017 21:22:08 -0700
In-Reply-To: <759768e1-9acb-c14b-7136-743cba166ef0@redhat.com>
References: <5DAE0523-80F8-4F68-93CB-0571C0C62B20@loffgren.org>
	<759768e1-9acb-c14b-7136-743cba166ef0@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


> On Sep 25, 2017, at 9:10 AM, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 09/24/2017 08:02 PM, Daniel Loffgren wrote:
>>=20
>> Signed-off-by: Daniel Loffgren <daniel@loffgren.org =
<mailto:daniel@loffgren.org>>
>> ---
>> include/exec/user/thunk.h | 1 +
>> 1 file changed, 1 insertion(+)
>=20
> meta-comment: your patch is titled 2/2, but was sent as its own
> top-level thread (it is missing In-Reply-To: and References: headers).
> When sending 2 patches as a series, it is important to include a 0/2
> cover letter, and to properly thread things so that both 1/2 and 2/2 =
are
> in-reply-to the 0/2 cover letter.  'git send-email' is probably the
> easiest way to get this to work.  More patch submission hints at:
>=20
> https://wiki.qemu.org/Contribute/SubmitAPatch =
<https://wiki.qemu.org/Contribute/SubmitAPatch>

Oops, sorry about that! I used 'git format-patch' to get this email from =
a set of two commits, and sent each as-is. This commit can totally stand =
alone.

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
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org <http://qemu.org/> | libvirt.org =
<http://libvirt.org/>
