Received: from eggs.gnu.org ([2001:4830:134:3::10]:35779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTQTz-0002ro-W2
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTQTw-0001z2-P8
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:32 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:60702 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTQTw-0001vH-Bd
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:28 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865534644.17063.5754453204442221401.stgit@frigg.lan>
	<20170630011154.GM13979@flamenco>
Date: Fri, 07 Jul 2017 12:27:08 +0200
In-Reply-To: <20170630011154.GM13979@flamenco> (Emilio G. Cota's message of
	"Thu, 29 Jun 2017 21:11:54 -0400")
Message-ID: <877ezkfsoz.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 13/29] target/i386: [tcg] Port to
 generic translation framework
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

> On Wed, Jun 28, 2017 at 16:09:06 +0300, Llu=C3=ADs Vilanova wrote:
[...]
>> diff --git a/target/i386/translate.c b/target/i386/translate.c
>> index 3950fe95a4..295be26a95 100644
>> --- a/target/i386/translate.c
>> +++ b/target/i386/translate.c
> (snip)
>> @@ -8544,111 +8548,23 @@ static void i386_trblock_disas_log(const DisasC=
ontextBase *dcbase,
>>=20
>> }
>>=20
>> +static const TranslatorOps i386_trblock_ops =3D {
>> +    .init_disas_context =3D i386_trblock_init_disas_context,
>> +    .init_globals =3D i386_trblock_init_globals,
>> +    .tb_start =3D i386_trblock_tb_start,
>> +    .insn_start =3D i386_trblock_insn_start,
>> +    .breakpoint_check =3D i386_trblock_breakpoint_check,
>> +    .translate_insn =3D i386_trblock_translate_insn,
>> +    .tb_stop =3D i386_trblock_tb_stop,
>> +    .disas_log =3D i386_trblock_disas_log,
>> +};

> I like hard tabs here, which make things visually easier, e.g.:

>> +static const TranslatorOps i386_trblock_ops =3D {
>> +    .init_disas_context	=3D i386_trblock_init_disas_context,
>> +    .init_globals		=3D i386_trblock_init_globals,

> Don't know whether checkpatch likes it, but I do, and I see some
> examples in the code base.

According to the guidelines, not tabs should be used (and I'm assuming
checkpatch looks for that). The best I can do is to space-align these.


Thanks,
  Lluis
