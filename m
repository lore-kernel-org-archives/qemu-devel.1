Received: from eggs.gnu.org ([2001:4830:134:3::10]:60005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVDMO-0001ZD-6S
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVDML-00081U-1l
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:51:04 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:50479)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVDMK-000804-KV
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:51:00 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149942859571.8972.4761014660099212028.stgit@frigg.lan>
	<65f59b75-08c3-3872-6906-20060b5b4a28@twiddle.net>
	<87eftnhqpw.fsf@frigg.lan>
	<235bbfe6-6eb7-e61d-17e2-4ef6458e6488@twiddle.net>
Date: Wed, 12 Jul 2017 11:50:48 +0300
In-Reply-To: <235bbfe6-6eb7-e61d-17e2-4ef6458e6488@twiddle.net> (Richard
	Henderson's message of "Tue, 11 Jul 2017 07:21:42 -1000")
Message-ID: <878tjughsn.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 04/27] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Richard Henderson writes:

> On 07/11/2017 06:40 AM, Llu=C3=ADs Vilanova wrote:
>> Since other hooks can set db->is_jmp and return values (breakpoint_check=
), I'll
>> stick with db->is_jmp instead. Then tb_start can return max_insns, and g=
eneric
>> code can refine it with checks like single-stepping.

> No, you misunderstand.  For SH4 I need to override single-stepping, icoun=
t, and
> anything else that produces a TB smaller than the atomic region.

I see, ok.

Cheers,
  Lluis
