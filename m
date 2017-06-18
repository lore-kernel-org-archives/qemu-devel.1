Received: from eggs.gnu.org ([2001:4830:134:3::10]:60498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMi9M-0008Ng-45
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 17:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMi9J-0007Tb-0X
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 17:54:28 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:60794)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMi9I-0007Rm-KM
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 17:54:24 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924970.28532.9346819516051209538.stgit@frigg.lan>
	<20170615221911.GB26408@flamenco> <20170615232507.GA15332@flamenco>
	<87r2yhe5os.fsf@frigg.lan> <87a855b8n8.fsf@frigg.lan>
Date: Mon, 19 Jun 2017 00:54:05 +0300
In-Reply-To: <87a855b8n8.fsf@frigg.lan> (=?utf-8?Q?=22Llu=C3=ADs?=
	Vilanova"'s message of "Sun, 18 Jun 2017 18:47:07 +0300")
Message-ID: <87y3sp9d36.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 3/6] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Llu=C3=ADs Vilanova writes:

> Llu=C3=ADs Vilanova writes:
>> Emilio G Cota writes:
>>> On Thu, Jun 15, 2017 at 18:19:11 -0400, Emilio G. Cota wrote:
>>>> (snip)
>>>> > +/**
>>>> > + * DisasContextBase:
>>>> > + * @tb: Translation block for this disassembly.
>>>> > + * @pc_first: Address of first guest instruction in this TB.
>>>> > + * @pc_next: Address of next guest instruction in this TB (current =
during
>>>> > + *           disassembly).
>>>> > + * @num_insns: Number of translated instructions (including current=
).
>>>> > + * @singlestep_enabled: "Hardware" single stepping enabled.
>>>> > + *
>>>> > + * Architecture-agnostic disassembly context.
>>>> > + */
>>>> > +typedef struct DisasContextBase {
>>>> > +    TranslationBlock *tb;
>>>> > +    target_ulong pc_first;
>>>> > +    target_ulong pc_next;
>>>> > +    DisasJumpType jmp_type;
>>>> > +    unsigned int num_insns;
>>>> > +    bool singlestep_enabled;
>>>> > +} DisasContextBase;
>>>>=20
>>>> - @pc_next: I'd stick with @pc, it's shorter, it's everywhere already,=
 and
>>>> with the documentation it's very clear what it is for.
>>>> - @jmp_type: missing doc :-)

>>> Also, consider keeping the @is_jmp name instead of renaming it to
>>> @jmp_type. (@jmp would be shorter but it would be confusing though,
>>> e.g. cris has both dc->jmp and dc->is_jmp.)

>> I just figured that this series could also take the chance of trying to =
rename a
>> few common variables I'm changing to something more readable.

>> But if you feel very strongly about keeping the original names (and mini=
mizing
>> the diffs as you say later), I'll revert the name changes.

> Also, going through the changes to break them down into smaller pieces, I=
 saw
> that TranslationBlock (at least in i386) already has a "pc" member, so us=
ing
> "pc_next" in DisasContextBase makes it even clearer it's a different vari=
able.

> You comments still apply to "is_jmp" vs "jmp_type" though. Unless you or =
anybody
> else feels strongly against it, I'll keep "jmp_type", since I'm already c=
hanging
> all lines that reference "is_jmp" to use DisasContextBase (instead of
> DisasContext).

Aha, just checked your proposed patches more closely and it totally makes s=
ense
to keep "is_jmp" to simplify the diffs, so I'll go for that one.

Thanks!
Lluis
