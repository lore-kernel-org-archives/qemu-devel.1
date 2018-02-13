Received: from eggs.gnu.org ([2001:4830:134:3::10]:60831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eld0O-00030C-8A
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eld0L-0002yv-Ll
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:00:28 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eld0L-0002yU-7e
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:00:25 -0500
Received: by mail-qk0-f195.google.com with SMTP id 15so23006953qkl.3
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 08:00:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-26-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-26-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Tue, 13 Feb 2018 17:00:23 +0100
Message-ID: <CAMxuvayQ29r30T+foMCCrTDTUSayhRV07r1Ek6ECcj11oy4bow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 25/29] docs/devel/writing-qmp-commands:
 Update for modular QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>

On Sun, Feb 11, 2018 at 10:36 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> With modular code generation, putting stuff right into
> qapi-schema.json is a bad idea.  Update writing-qmp-commands.txt
> accordingly.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  docs/devel/writing-qmp-commands.txt | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp=
-commands.txt
> index 4f5b24c0c4..776b3b41ca 100644
> --- a/docs/devel/writing-qmp-commands.txt
> +++ b/docs/devel/writing-qmp-commands.txt
> @@ -15,8 +15,8 @@ start with docs/interop/qmp-intro.txt.
>  Generally speaking, the following steps should be taken in order to writ=
e a
>  new QMP command.
>
> -1. Write the command's and type(s) specification in the QAPI schema file
> -   (qapi-schema.json in the root source directory)
> +1. Define the command and any types it needs in the appropriate QAPI
> +   schema module.
>
>  2. Write the QMP command itself, which is a regular C function. Preferab=
ly,
>     the command should be exported by some QEMU subsystem. But it can als=
o be
> @@ -88,8 +88,9 @@ command carries some meaningful action in QEMU but here=
 it will just print
>  Our command will be called "hello-world". It takes no arguments, nor doe=
s it
>  return any data.
>
> -The first step is to add the following line to the bottom of the
> -qapi-schema.json file:
> +The first step is defining the command in the appropriate QAPI schema
> +module.  We pick module qapi/misc.json, and add the following line at
> +the bottom:
>
>  { 'command': 'hello-world' }
>
> @@ -245,7 +246,7 @@ This is very important. No QMP command will be accept=
ed in QEMU without proper
>  documentation.
>
>  There are many examples of such documentation in the schema file already=
, but
> -here goes "hello-world"'s new entry for the qapi-schema.json file:
> +here goes "hello-world"'s new entry for qapi/misc.json:
>
>  ##
>  # @hello-world
> @@ -425,8 +426,7 @@ There are a number of things to be noticed:
>     allocated by the implementation. This is so because the QAPI also gen=
erates
>     a function to free its types and it cannot distinguish between dynami=
cally
>     or statically allocated strings
> -6. You have to include the "qmp-commands.h" header file in qemu-timer.c,
> -   otherwise qemu won't build
> +6. You have to include "qapi/qmp-commands-misc.h" in qemu-timer.c
>
>  Time to test the new command. Build qemu, run it as described in the "Te=
sting"
>  section and try this:
> --
> 2.13.6
>
