Received: from eggs.gnu.org ([209.51.188.92]:36745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJza1-00088I-Vs
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJzLf-00013l-Fl
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:49:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hJzLf-00013M-AJ
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:48:59 -0400
Date: Fri, 26 Apr 2019 13:48:57 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190426114857.jrso2nox5tdgtp5k@sirius.home.kraxel.org>
References: <4ec13220-0c12-3b87-6a79-49a42a38db01@suse.com>
	<20190426083830.kj7currufo637loa@sirius.home.kraxel.org>
	<ef5b2ec7-f796-becd-f488-bb17538e93bb@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ef5b2ec7-f796-becd-f488-bb17538e93bb@suse.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] About pt-br keyboard layout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>
Cc: qemu-devel@nongnu.org

> > So -k must match the *hosts* keyboard layout.
> So, that means, If I launch qemu with -k pt-br on a host, I need to ens=
ure
> the keyboard layout
> must be pt-br as well onthathypervisorhost,Then when I connected to thi=
s vnc
> server(qemu)
> throughvncviewer on mylaptop(us keyboard layout), I type shift + 6, I c=
an
> get=A8(diaeresis)
> character, am I right?

No.  I've simplified a bit, assuming both vncviewer and qemu run on the
host machine.  -k $layout must match the keyboard layout of the machine
running vncviewer.  So, in your case it should be us (the laptops
layout).

cheers,
  Gerd
