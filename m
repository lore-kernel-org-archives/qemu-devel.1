Received: from eggs.gnu.org ([2001:4830:134:3::10]:56930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHsE1-0007kW-5k
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHsDx-0007mp-Vr
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:39:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dHsDx-0007mF-Pc
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:39:13 -0400
Date: Mon, 5 Jun 2017 10:39:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170605133907.GN4294@thinpad.lan.raisama.net>
References: <CAFEAcA_pErWnoUh_-fxaBMZB1L=4jYxUXYfx9CA5uVnx0H2_pw@mail.gmail.com>
	<87f8f3e0-754d-7de5-4c2a-4b0930adb7fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87f8f3e0-754d-7de5-4c2a-4b0930adb7fe@redhat.com>
Subject: Re: [Qemu-devel] qdev properties vs qom object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Jun 05, 2017 at 03:32:56PM +0200, Paolo Bonzini wrote:
[...]
> > Which is the recommended one for new device code?
> > Do we have a transition plan for old code?
> > Where should I be looking for the documentation on this?
> 
> There is no transition plan, qdev properties are not going to go away
> soon unless someone actually makes a plan.
> 
> Now that there are QOM class properties, it would actually be feasible
> to make qdev_property_add_static define QOM properties on the class
> rather than the object.  In other words, instead of
> 
>     dc->props = virtio_serial_pci_properties;
> 
> you'd have something like:
> 
>     qdev_add_class_properties(klass, usb_tablet_properties);

I have an old branch that does that.  I don't remember if I
submitted it to qemu-devel.  I will try to rebase and (re)submit
it.

-- 
Eduardo
