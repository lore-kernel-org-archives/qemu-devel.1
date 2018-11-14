Received: from eggs.gnu.org ([2001:4830:134:3::10]:49575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gMwsJ-0006rc-4k
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:14:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gMwsH-0000xD-DT
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:14:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1gMwsH-0000uD-64
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:14:37 -0500
Date: Wed, 14 Nov 2018 15:14:27 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181114151427.GJ27120@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<871s7nstle.fsf@dusky.pond.sub.org>
	<e935a267-a5ae-4dd4-a1a7-064c084671ab@redhat.com>
	<874lcjra28.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874lcjra28.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 00/41] RFC: slirp: make it again a
 standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, renzo@cs.unibo.it, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, stefanha@redhat.com, samuel.thibault@ens-lyon.org

On Wed, Nov 14, 2018 at 03:46:39PM +0100, Markus Armbruster wrote:
> The issue I have with SLIRP isn't that it solves a useless problem (au
> contraire!), it's that it's a useless solution.  Okay, that's an unfair
> exaggeration, it's not useless, I just wouldn't trust it in production,
> unless it has improved significantly since I last looked at it.

It's used by virt-builder, virt-customize, virt-v2v, etc., in some
cases in production.  Of course those uses are not completely general
purpose (it'll be things like running very specific, known =E2=80=98yum i=
nstall=E2=80=99
commands from the guest), and we test it quite a bit.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
