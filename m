Received: from eggs.gnu.org ([2001:4830:134:3::10]:60971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTNto-0007XL-2S
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTNtk-0005vV-WA
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:42:00 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:49360)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTNtk-0005uW-JO
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:41:56 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865365245.17063.7830070270971603805.stgit@frigg.lan>
	<20170629235133.GE13979@flamenco>
Date: Fri, 07 Jul 2017 09:41:30 +0200
In-Reply-To: <20170629235133.GE13979@flamenco> (Emilio G. Cota's message of
	"Thu, 29 Jun 2017 19:51:33 -0400")
Message-ID: <87mv8gg0d1.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 06/29] target/i386: [tcg] Refactor
 init_disas_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Emilio G Cota writes:

> On Wed, Jun 28, 2017 at 15:40:52 +0300, Llu=C3=ADs Vilanova wrote:
[,,,]
>> @@ -8425,7 +8415,7 @@ void gen_intermediate_code(CPUState *cpu, Translat=
ionBlock *tb)
>>      dc-> code64 =3D (flags >> HF_CS64_SHIFT) & 1;
>> #endif
>>      dc-> flags =3D flags;
>> -    dc->jmp_opt =3D !(dc->tf || cpu->singlestep_enabled ||
>> +    dc->jmp_opt =3D !(dc->tf || dc->base.singlestep_enabled ||

> Why this change and not leaving cpu->singlestep_enabled?

The single-stepping info is initialized by the generic code into dc->base, =
and
so I wanted to keep a bit more code consistency by unifying its use (on pla=
ces I
touched). In fact, using dc->base ensures translation will be consistent ev=
en if
in the future cpu->singlestep_enabled is allowed to change.


Cheers,
  Lluis
