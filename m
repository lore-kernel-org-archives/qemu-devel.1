Received: from eggs.gnu.org ([2001:4830:134:3::10]:38795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eCiUQ-0003z5-SG
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eCiUL-0001Th-W6
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:47:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1eCiUL-0001TS-Q9
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:47:05 -0500
Date: Thu, 9 Nov 2017 08:47:03 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171109084702.GD2787@redhat.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
	<10f1bca388976b18119fd4fc28d6fdcf7106f7d3.1510181732.git.alistair.francis@xilinx.com>
	<20c00ee8-6d77-e8bd-aa77-6db5db789900@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20c00ee8-6d77-e8bd-aa77-6db5db789900@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 40/45] hw/watchdog: Replace
 fprintf(stderr, "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com

On Wed, Nov 08, 2017 at 08:43:45PM -0300, Philippe Mathieu-Daud=E9 wrote:
> > @@ -126,7 +125,7 @@ void watchdog_perform_action(void)
> > =20
> >      case WATCHDOG_ACTION_DEBUG:
> >          qapi_event_send_watchdog(WATCHDOG_ACTION_DEBUG, &error_abort=
);
> > -        fprintf(stderr, "watchdog: timer fired\n");
> > +        error_report("watchdog: timer fired");
>=20
> I don't think this is an error and would rather use info_report() here.
>=20
> Richard what do you think?

Yes, this is not an error.  It's an informational message.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
