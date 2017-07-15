Received: from eggs.gnu.org ([2001:4830:134:3::10]:55380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dWHwl-0000I9-W0
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 03:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dWHwi-0000F8-Sx
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 03:57:04 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
	<150002534291.22386.13499916738708680298.stgit@frigg.lan>
	<28a48f7c-930a-389b-b39d-64c43654cd04@twiddle.net>
Date: Sat, 15 Jul 2017 10:56:50 +0300
In-Reply-To: <28a48f7c-930a-389b-b39d-64c43654cd04@twiddle.net> (Richard
	Henderson's message of "Fri, 14 Jul 2017 07:33:46 -1000")
Message-ID: <87a846b0al.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v13 22/26] target/arm: [tcg] Port to tb_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Richard Henderson writes:

> On 07/13/2017 11:42 PM, Llu=C3=ADs Vilanova wrote:
>> -        dc->base.is_jmp =3D DISAS_SKIP;
>> +        dc->base.is_jmp =3D DISAS_NORETURN;

> Really should fold this back into the patch that introduced SKIP temporar=
ily.

Sorry, I don't understand what you mean.


Thanks,
  Lluis
