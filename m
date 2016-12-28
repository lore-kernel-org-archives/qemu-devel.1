Received: from eggs.gnu.org ([2001:4830:134:3::10]:43895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMH0X-0006pN-V8
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMH0U-0004i2-Sw
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:23:17 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:60135 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMH0U-0004ht-Fw
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:23:14 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148293406236.28901.9490775858242540392.stgit@fimbulvetr.bsc.es>
	<148293408387.28901.10687132341063477318.stgit@fimbulvetr.bsc.es>
	<5187c1b7-1c34-1cc1-1e22-9d1f957d6e82@twiddle.net>
Date: Wed, 28 Dec 2016 17:23:10 +0100
In-Reply-To: <5187c1b7-1c34-1cc1-1e22-9d1f957d6e82@twiddle.net> (Richard
	Henderson's message of "Wed, 28 Dec 2016 08:08:33 -0800")
Message-ID: <87tw9onhu9.fsf@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 4/7] exec: [tcg] Use different TBs
 according to the vCPU's dynamic tracing state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Richard Henderson writes:

> On 12/28/2016 06:08 AM, Llu=C3=ADs Vilanova wrote:
>> @@ -83,6 +85,13 @@ uint32_t tb_hash_func5(uint64_t a0, uint64_t b0, uint=
32_t e)
>> h32 +=3D e * PRIME32_3;
>> h32  =3D rol32(h32, 17) * PRIME32_4;
>>=20
>> +    if (sizeof(TRACE_QHT_VCPU_DSTATE_TYPE) =3D=3D sizeof(uint32_t)) {
>> +        h32 +=3D f * PRIME32_3;
>> +        h32  =3D rol32(h32, 17) * PRIME32_4;
>> +    } else {
>> +        abort();
>> +    }
>> +

> QEMU_BUILD_BUG_ON.

Right, thanks.

Lluis
