Received: from eggs.gnu.org ([2001:4830:134:3::10]:52768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f94Y5-0002Xc-Cd
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f94Xu-0002Qv-CE
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:04:09 -0400
Date: Thu, 19 Apr 2018 10:02:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180419100231.68536026@redhat.com>
In-Reply-To: <20180418145603.GN29865@localhost.localdomain>
References: <1524061685-83305-1-git-send-email-imammedo@redhat.com>
	<1524061685-83305-4-git-send-email-imammedo@redhat.com>
	<20180418145603.GN29865@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13 v2 3/5] pc: simplify
 MachineClass::get_hotplug_handler handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org, eric.auger@redhat.com

On Wed, 18 Apr 2018 11:56:03 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Apr 18, 2018 at 04:28:03PM +0200, Igor Mammedov wrote:
> > By default MachineClass::get_hotplug_handler is NULL and concrete board
> > should set it to it's own handler.
> > Considering there isn't any default handler, drop saving empty
> > MachineClass::get_hotplug_handler in child class and make PC code
> > consistent with spapr/s390x boards.
> > 
> > We can bring this back when actual usecase surfaces and do it
> > consistently across boards that use get_hotplug_handler().
> > 
> > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> 
> [...]
> > @@ -2344,7 +2341,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
> >      HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
> >      NMIClass *nc = NMI_CLASS(oc);
> >  
> > -    pcmc->get_hotplug_handler = mc->get_hotplug_handler;  
> 
> What about assert(!mc->get_hotplug_handler) just before
> overwriting it?
I'll make it patch on top of series to make sure that
every board that sets get_hotplug_handler will do it
consistently.
