Received: from eggs.gnu.org ([2001:4830:134:3::10]:59424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQ6Nk-0005Po-DK
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQ6Ng-0005Th-F9
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:27:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54266 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fQ6Ng-0005TM-9g
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:27:48 -0400
Date: Tue, 5 Jun 2018 09:27:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, ehabkost@redhat.com

  Hi,

> >   Add to that shortcuts like -cdrom
> > stop working,
> 
> Maybe is fixable.

Already fixed for ages.

> I see marking Q35 as the default machine a first step.

Maybe the better option is to go the arm route:  Just don't define a
default, so users have to specify pc or q35.  That will make them notice
there is a world beside 'pc', and we also avoid breaking things
silently.

In case no machine type is given qemu can print some hints together with
the error message.

cheers,
  Gerd
