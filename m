Received: from eggs.gnu.org ([2001:4830:134:3::10]:39836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPYEb-0002ko-G1
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:23:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPYEX-0002mp-Qe
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:23:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPYEX-0002ma-IE
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:23:17 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9701D90227
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 17:23:17 +0000 (UTC)
Date: Fri, 6 Jan 2017 17:23:11 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170106172311.GW31112@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<148372216116.199.16599655470675110536@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148372216116.199.16599655470675110536@790289a7ca88>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/47] Switch all subdirs over to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

On Fri, Jan 06, 2017 at 09:02:42AM -0800, no-reply@patchew.org wrote:
> Hi,
>=20
> Your series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it

[snip]

> /tmp/qemu-test/src/hw/char/pl011.c: In function =E2=80=98pl011_update=E2=
=80=99:
> /tmp/qemu-test/src/hw/char/pl011.c:62: warning: implicit declaration of=
 function =E2=80=98trace_pl011_irq_state=E2=80=99
> /tmp/qemu-test/src/hw/char/pl011.c:62: warning: nested extern declarati=
on of =E2=80=98trace_pl011_irq_state=E2=80=99
> /tmp/qemu-test/src/hw/char/pl011.c: In function =E2=80=98pl011_read=E2=80=
=99:
> /tmp/qemu-test/src/hw/char/pl011.c:87: warning: implicit declaration of=
 function =E2=80=98trace_pl011_read_fifo=E2=80=99
> /tmp/qemu-test/src/hw/char/pl011.c:87: warning: nested extern declarati=
on of =E2=80=98trace_pl011_read_fifo=E2=80=99
> /tmp/qemu-test/src/hw/char/pl011.c:139: warning: implicit declaration o=
f function =E2=80=98trace_pl011_read=E2=80=99
> /tmp/qemu-test/src/hw/char/pl011.c:139: warning: nested extern declarat=
ion of =E2=80=98trace_pl011_read=E2=80=99
> /tmp/qemu-test/src/hw/char/pl011.c: In function =E2=80=98pl011_write=E2=
=80=99:
> /tmp/qemu-test/src/hw/char/pl011.c:163: warning: implicit declaration o=
f function =E2=80=98trace_pl011_write=E2=80=99
> /tmp/qemu-test/src/hw/char/pl011.c:163: warning: nested extern declarat=
ion of =E2=80=98trace_pl011_write=E2=80=99
> /tmp/qemu-test/src/hw/char/pl011.c: In function =E2=80=98pl011_can_rece=
ive=E2=80=99:
> /tmp/qemu-test/src/hw/char/pl011.c:237: warning: implicit declaration o=
f function =E2=80=98trace_pl011_can_receive=E2=80=99
> /tmp/qemu-test/src/hw/char/pl011.c:237: warning: nested extern declarat=
ion of =E2=80=98trace_pl011_can_receive=E2=80=99
> /tmp/qemu-test/src/hw/char/pl011.c: In function =E2=80=98pl011_put_fifo=
=E2=80=99:
> /tmp/qemu-test/src/hw/char/pl011.c:252: warning: implicit declaration o=
f function =E2=80=98trace_pl011_put_fifo=E2=80=99
> /tmp/qemu-test/src/hw/char/pl011.c:252: warning: nested extern declarat=
ion of =E2=80=98trace_pl011_put_fifo=E2=80=99
> /tmp/qemu-test/src/hw/char/pl011.c:254: warning: implicit declaration o=
f function =E2=80=98trace_pl011_put_fifo_full=E2=80=99
> /tmp/qemu-test/src/hw/char/pl011.c:254: warning: nested extern declarat=
ion of =E2=80=98trace_pl011_put_fifo_full=E2=80=99

Sigh, include search path ordering is different when doing in-tree vs
out of tree builds.

When in-tree, the headers in the hw/char sub-dir are found *before*
the top level source dir.

When out of tree, the headers hw/char *build* dir are found *after*
the top level source dir.

Will have to investigate how we can fix the include ordering.

This is also a sign that travis.yml should do at least one of its
builds  with srcdir !=3D build dir

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
