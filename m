Received: from eggs.gnu.org ([2001:4830:134:3::10]:54237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1crQ8e-0003IW-R6
	for Qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1crQ8d-00054f-Na
	for Qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:24:24 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1crQ8d-00054S-Cc
	for Qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:24:23 -0400
Received: by mail-lf0-x243.google.com with SMTP id v2so464856lfi.2
	for <Qemu-devel@nongnu.org>; Fri, 24 Mar 2017 07:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAOvx4-1MYO14+hkP8ZZg6Y4v_GFU8HtzYSeRo692zbsZN8D79A@mail.gmail.com>
In-Reply-To: <CAOvx4-1MYO14+hkP8ZZg6Y4v_GFU8HtzYSeRo692zbsZN8D79A@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 24 Mar 2017 14:24:09 +0000
Message-ID: <CAJ+F1CL8O80ORsKU8tf49XeSb+0Dz+b8d+MtsRMKmYGa22KLNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] guest-exec of qemu-guest-agent fails on Windows
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Armin Ranjbar <zoup@zoup.org>, Qemu-devel@nongnu.org
Cc: Behrooz <everplays@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Fri, Mar 24, 2017 at 2:38 PM Armin Ranjbar <zoup@zoup.org> wrote:

> Hi everyone,
>
> We are trying to use guest-exec[0] command of qemu-guest-agent. However,
> discovered that whatever command we try to run, it ends up with the
> following error on the host side:
>
> > error: Guest agent is not responding: Guest agent not available for now
>

I don't have this error, perhaps you could try running the ga under gdb and
see where it hangs?


>
> An example of what we run on the host side:
>
> > virsh qemu-agent-command --domain armin_1 '{ "execute": "guest-exec",
> "arguments": { "path": "C:/Windows/System32/ipconfig.exe",
> "capture-output": false } }'
>
> Because Windows was complaining about `gspawn-win64-helper-console.exe`
>

Where does it complain?


> whenever we ran a command on host, we tried to run it directly from cli a=
nd
> it failed on the following assertion:
>
> > g_assert (argc >=3D ARG_COUNT); // [1]
>
> This picture[2] might be a bit more useful as it includes the output of
> `qemu-ga` in verbose mode.
>

Any idea how we can solve it and/or what we are doing wrong?
>
>
I am pretty sure you can't call spawn-helper like this in command line.

the warning about child setup function is harmless

Which version qemu-ga are you testing?


> Thanks in advance.
>
> [0]
>
> https://github.com/qemu/qemu/blob/fbddc2e5608eb655493253d080598375db61a74=
8/qga/qapi-schema.json#L1024
> [1]
>
> https://github.com/GNOME/glib/blob/8edcf67b0221efa3c2ada67c44eff29939b170=
4d/glib/gspawn-win32-helper.c#L208
> [2] https://ibin.co/3GTVo4WXfR7a.png
>
> ---
> Armin ranjbar
>
--=20
Marc-Andr=C3=A9 Lureau
