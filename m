Received: from eggs.gnu.org ([2001:4830:134:3::10]:59779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdLeb-00076u-M7
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdLea-0005x9-UE
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:24:01 -0400
Date: Wed, 11 Jul 2018 17:23:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180711202351.GA31657@localhost.localdomain>
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<ca91bffe-2bcf-78a2-02cd-8ae7cc48074c@redhat.com>
	<20180711183031.GM914@localhost.localdomain>
	<ce0b8bf9-b0e6-fe02-c685-5a6c3140a3ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce0b8bf9-b0e6-fe02-c685-5a6c3140a3ae@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm283x: Fix crash with device_add
 bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Wed, Jul 11, 2018 at 10:16:42PM +0200, Paolo Bonzini wrote:
> On 11/07/2018 20:30, Eduardo Habkost wrote:
> >> The theoretical behavior should be:
> > It's not clear below where you expect
> >   qdev_set_parent_bus(..., sysbus_get_default())
> > to be called (if it should be called at all).
> > 
> > I don't know where it should be called, but I'm absolutely sure
> > instance_init is not the right place.
> 
> I think instance_init is fine to call qdev_set_parent_bus on contained
> devices.  Why do you say it's not?

Because object_unref(object_new(...)) is not supposed to affect
QEMU global state at all.

-- 
Eduardo
