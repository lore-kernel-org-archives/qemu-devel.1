Received: from eggs.gnu.org ([2001:4830:134:3::10]:45332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6I3E-0004FJ-0y
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6I3A-0005jZ-SA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:48:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6I3A-0005j8-Li
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:48:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9475BC04BD2F
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 14:48:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
	<20170504125432.21653-5-marcandre.lureau@redhat.com>
Date: Thu, 04 May 2017 16:48:07 +0200
In-Reply-To: <20170504125432.21653-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 4 May 2017 16:54:32 +0400")
Message-ID: <87h910adaw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] qmp-shell: improve help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Describe the arguments & fix the tool name.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> index db24c87cdd..fce1ab6c49 100755
> --- a/scripts/qmp/qmp-shell
> +++ b/scripts/qmp/qmp-shell
> @@ -375,7 +375,11 @@ def die(msg):
>  def fail_cmdline(option=3DNone):
>      if option:
>          sys.stderr.write('ERROR: bad command-line option \'%s\'\n' % opt=
ion)
> -    sys.stderr.write('qemu-shell [ -v ] [ -p ] [ -H ] [ -N ] < UNIX sock=
et path> | < TCP address:port >\n')
> +    sys.stderr.write('qmp-shell [ -v ] [ -p ] [ -H ] [ -N ] < UNIX socke=
t path> | < TCP address:port >\n')
> +    sys.stderr.write('    -v     Verbose (echo command sent and received=
)\n')
> +    sys.stderr.write('    -p     Pretty-print JSON\n')
> +    sys.stderr.write('    -H     Use HMP interface\n')
> +    sys.stderr.write('    -N     Skip negotiate (for qemu-ga)\n')
>      sys.exit(1)
>=20=20
>  def main():

Given Python modules like argparse, doing option parsing by hand is
basically stupid.  I'll take this patch anyway, because it improves help
without making the program appreciably stupider.
