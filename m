Received: from eggs.gnu.org ([2001:4830:134:3::10]:33415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1cm3s4-0002bT-IU
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1cm3s1-0002xO-Ey
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:37:08 -0500
Received: from mail.genode-labs.com ([88.198.56.169]:47952)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1cm3s1-0002wz-7N
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:37:05 -0500
References: <7005a482-2372-0aaf-eb8b-60cd0a16b002@genode-labs.com>
	<c088c706-392f-e978-8edd-9db85a265681@redhat.com>
From: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Message-ID: <51941cb9-ac7a-bbe2-0185-b8c0ad587b51@genode-labs.com>
Date: Thu, 9 Mar 2017 20:36:57 +0100
MIME-Version: 1.0
In-Reply-To: <c088c706-392f-e978-8edd-9db85a265681@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH=C2=B1_SVM_I/O_permission_bitmap_?=
 =?utf-8?q?for_user-level_=28ring-3=29_code_ignored?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, ehabkost@redhat.com

On 09.03.2017 13:42, Paolo Bonzini wrote:
> On 05/03/2017 19:21, Alexander Boettcher wrote:
>> the SVM I/O permission bitmap for user-level (ring-3) VM code running =
in
>> SVM seems to be ignored and causes a GP-fault. (Actual the IO permissi=
on
>> was granted by the kernel via the TSS I/O port permission bitmap).
>>
>> After some debugging the GP code originates from target/i386/translate=
.c
>> gen_check_io() within the if(s->pe && (s->cpl > s->iopl || s->vm86))
>> condition. However, the actual SVM IO permission bitmap is checked aft=
er
>> that condition, which succeeds and would permit the access.


> The code as is
> written now matches the AMD manual: "Exceptions related to virtual x86
> mode, IOPL, or the TSS-bitmap are checked before the SVM intercept
> check. All other exceptions are checked after the SVM intercept check".

I see. I will re-check, maybe we're doing things wrong in the VMM.

Thanks.
--=20
Alexander Boettcher
Genode Labs

http://www.genode-labs.com - http://www.genode.org

Genode Labs GmbH - Amtsgericht Dresden - HRB 28424 - Sitz Dresden
Gesch=C3=A4ftsf=C3=BChrer: Dr.-Ing. Norman Feske, Christian Helmuth
