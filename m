Received: from eggs.gnu.org ([2001:4830:134:3::10]:34408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHY-0002LP-GD
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHU-0003Qk-Jl
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1enrHU-0003Pf-Bb
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:20 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JJd0uB136510
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:19 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g80r1k6kt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:19 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:39:18 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180211093607.27351-26-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-26-armbru@redhat.com>
Date: Mon, 19 Feb 2018 13:33:49 -0600
Message-Id: <151906882920.12376.9104203813206448298@sif>
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
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Quoting Markus Armbruster (2018-02-11 03:36:03)
> With modular code generation, putting stuff right into
> qapi-schema.json is a bad idea.  Update writing-qmp-commands.txt
> accordingly.
> =

> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  docs/devel/writing-qmp-commands.txt | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> =

> diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp=
-commands.txt
> index 4f5b24c0c4..776b3b41ca 100644
> --- a/docs/devel/writing-qmp-commands.txt
> +++ b/docs/devel/writing-qmp-commands.txt
> @@ -15,8 +15,8 @@ start with docs/interop/qmp-intro.txt.
>  Generally speaking, the following steps should be taken in order to writ=
e a
>  new QMP command.
> =

> -1. Write the command's and type(s) specification in the QAPI schema file
> -   (qapi-schema.json in the root source directory)
> +1. Define the command and any types it needs in the appropriate QAPI
> +   schema module.
> =

>  2. Write the QMP command itself, which is a regular C function. Preferab=
ly,
>     the command should be exported by some QEMU subsystem. But it can als=
o be
> @@ -88,8 +88,9 @@ command carries some meaningful action in QEMU but here=
 it will just print
>  Our command will be called "hello-world". It takes no arguments, nor doe=
s it
>  return any data.
> =

> -The first step is to add the following line to the bottom of the
> -qapi-schema.json file:
> +The first step is defining the command in the appropriate QAPI schema
> +module.  We pick module qapi/misc.json, and add the following line at
> +the bottom:
> =

>  { 'command': 'hello-world' }
> =

> @@ -245,7 +246,7 @@ This is very important. No QMP command will be accept=
ed in QEMU without proper
>  documentation.
> =

>  There are many examples of such documentation in the schema file already=
, but
> -here goes "hello-world"'s new entry for the qapi-schema.json file:
> +here goes "hello-world"'s new entry for qapi/misc.json:
> =

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
> =

>  Time to test the new command. Build qemu, run it as described in the "Te=
sting"
>  section and try this:
> -- =

> 2.13.6
>=20
