Received: from eggs.gnu.org ([2001:4830:134:3::10]:38996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fzN82-0004AO-Ef
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 10:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fzN2f-00041M-Vv
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 10:19:54 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180910081649.GA4901@dhcp-200-186.str.redhat.com>
Date: Mon, 10 Sep 2018 10:19:46 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B577F71-321C-4A6E-A75B-C7EEB8472C6E@gmail.com>
References: <20180908030136.844-1-programmingkidx@gmail.com>
	<CAFEAcA-W-J30u=AaJ6U8eAD6HppWW37h6pW95kVOd8rXE6mpEA@mail.gmail.com>
	<6386A97A-3BAB-43D2-B3BF-D6B72FC3D068@gmail.com>
	<20180910081649.GA4901@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img.c: add help for each command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


> On Sep 10, 2018, at 4:16 AM, Kevin Wolf <kwolf@redhat.com> wrote:
>=20
> Am 08.09.2018 um 05:16 hat Programmingkid geschrieben:
>>=20
>>> On Sep 7, 2018, at 11:13 PM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>>>=20
>>> On 8 September 2018 at 04:01, John Arbuckle =
<programmingkidx@gmail.com> wrote:
>>>=20
>>>> +    /* print the help for this command */
>>>> +    if (strcmp("--help", argv[optind + 1]) =3D=3D 0) {
>>>> +        if (strcmp("amend", cmdname) =3D=3D 0) {
>>>> +            help_amend();
>>>> +        } else if (strcmp("bench", cmdname) =3D=3D 0) {
>>>> +            help_bench();
>>>> +        } else if (strcmp("check", cmdname) =3D=3D 0) {
>>>> +            help_check();
>>>> +        } else if (strcmp("commit", cmdname) =3D=3D 0) {
>>>> +            help_commit();
>>>> +        } else if (strcmp("compare", cmdname) =3D=3D 0) {
>>>> +            help_compare();
>>>> +        } else if (strcmp("convert", cmdname) =3D=3D 0) {
>>>> +            help_convert();
>>>> +        } else if (strcmp("create", cmdname) =3D=3D 0) {
>>>> +            help_create();
>>>> +        } else if (strcmp("dd", cmdname) =3D=3D 0) {
>>>> +            help_dd();
>>>> +        } else if (strcmp("info", cmdname) =3D=3D 0) {
>>>> +            help_info();
>>>> +        } else if (strcmp("map", cmdname) =3D=3D 0) {
>>>> +            help_map();
>>>> +        } else if (strcmp("measure", cmdname) =3D=3D 0) {
>>>> +            help_measure();
>>>> +        } else if (strcmp("snapshot", cmdname) =3D=3D 0) {
>>>> +            help_snapshot();
>>>> +        } else if (strcmp("rebase", cmdname) =3D=3D 0) {
>>>> +            help_rebase();
>>>> +        } else if (strcmp("resize", cmdname) =3D=3D 0) {
>>>> +            help_resize();
>>>=20
>>> Any time you find yourself writing very repetitive code like
>>> this, it's a good idea to ask yourself "is there a way to make
>>> this data-driven?".
>>>=20
>>> thanks
>>> -- PMM
>>=20
>> Did you want me to loop thru an array of strings instead?
>=20
> There is already an array of all subcommands, img_cmds. You should
> probably add another field there for the help text.

Even though I would prefer to leave the img_cmds array alone, I do
see the advantages of your suggestion. All the code that checks which
command is being used could go. I will ad a help_text field to this
array.

> Also, your line wrapping (even mid-word!) is awful. I'm not sure we
> really have to fill 80 characters in the output and can't simply keep
> the lines a bit shorter so that 80 characters in the source are =
enough.

Yeah it does look very unreadable like that.

> But if we do want to use the full 80 characters in the output, I'd
> rather break the limit from the coding style and use longer lines in =
the
> source coe than doing what you did.

Using lines longer than 80 would make the patch a lot easier to read. I =
will do this.

Thank you.=
