Received: from eggs.gnu.org ([2001:4830:134:3::10]:40393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPpWe-0001DO-H4
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPpWb-0008Ee-Bu
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:23:24 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:35722 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPpWa-0008DG-VM
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:23:21 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<6ce1f317-6502-d4e0-e67a-d4795e87aed2@redhat.com>
Date: Tue, 27 Jun 2017 15:23:10 +0300
In-Reply-To: <6ce1f317-6502-d4e0-e67a-d4795e87aed2@redhat.com> (Eric Blake's
	message of "Mon, 26 Jun 2017 22:00:37 -0500")
Message-ID: <87podpipqp.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v9 00/26] translate: [tcg] Generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Eric Blake writes:

> On 06/25/2017 03:43 AM, Llu=C3=ADs Vilanova wrote:
>> This series proposes a generic (target-agnostic) instruction translation
>> framework.
>>=20
>> It basically provides a generic main loop for instruction disassembly, w=
hich
>> calls target-specific functions when necessary. This generalization makes
>> inserting new code in the main loop easier, and helps in keeping all tar=
gets in
>> synch as to the contents of it.
>>=20
>> This series also paves the way towards adding events to trace guest code
>> execution (BBLs and instructions).
>>=20
>> I've ported i386/x86-64 and arm/aarch64 as an example to see how it fits=
 in the
>> current organization, but will port the rest when this series gets merge=
d.
>>=20
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>>=20
>> Changes in v9
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Further increase inter-mail sleep time during sending.
>>=20
>>=20
>> Changes in v8
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Increase inter-mail sleep time during sending (list keeps refusing som=
e emails
>> due to an excessive send rate).

> It's more likely that your rejection message was from your SMTP
> connection than from the list (I've had to deal with my ISP's SMTP
> server prohibiting me from sending more than 10 patches in a minute;
> while using my company's SMTP server did not have that rate-limiting
> restriction).

> But yes, it would be neat if 'git send-email' had a knob to easily tweak
> things to avoid flooding beyond a picky SMTP server's rate limits.

Yup, it's my SMTP, not the list. Since I'm using "stg mail --git" (uses git
send-email underneath), I can set up an inter-mail wait time.


Cheers,
  Lluis
