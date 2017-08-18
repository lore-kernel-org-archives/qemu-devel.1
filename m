Received: from eggs.gnu.org ([2001:4830:134:3::10]:38401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dikaT-0007BL-IV
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dikaS-0005Wn-UB
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:57:33 -0400
Date: Fri, 18 Aug 2017 13:57:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170818165716.GB3108@localhost.localdomain>
References: <20170814215748.5158-1-ehabkost@redhat.com>
	<20170814215748.5158-9-ehabkost@redhat.com>
	<7327f3f6-16fb-e9c6-4f2a-eed6144f2282@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7327f3f6-16fb-e9c6-4f2a-eed6144f2282@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 08/13] ide: enumerate_slots implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>, qemu-block@nongnu.org

On Wed, Aug 16, 2017 at 05:46:18PM -0400, John Snow wrote:
> 
> 
> On 08/14/2017 05:57 PM, Eduardo Habkost wrote:
> > Example output when using "-machine q35":
> > 
> >   {
> >     "available": true,
> >     "count": 1,
> >     "device-types": [
> >       "ide-device"
> >     ],
> >     "hotpluggable": false,
> >     "opts": [
> >       { "option": "unit", "values": 0 },
> >       { "option": "bus", "values": "ide.2" }
> >     ],
> >     "opts-complete": true
> >   }
> >   {
> >     "available": false,
> >     "count": 1,
> >     "device": "/machine/unattached/device[19]",
> >     "device-types": [
> >       "ide-device"
> >     ],
> >     "hotpluggable": false,
> >     "opts": [
> >       { "option": "unit", "values": 1 },
> >       { "option": "bus", "values": "ide.2" } ],
> >     "opts-complete": true
> >   }
> >   {
> >     "available": true,
> >     "count": 10,
> >     "device-types": [
> >       "ide-device"
> >     ],
> >     "hotpluggable": false,
> >     "opts": [
> >       { "option": "unit", "values": [ [ 0, 1 ] ] },
> 
> Hm, these unit values aren't really correct -- we do not support
> primary/secondary semantics for IDE buses on the AHCI device. I guess
> they technically exist, but you cannot use them for anything.
> 
> Should I do something to "disable" or otherwise hide the unusable
> secondary unit slots for AHCI devices?

If the device is already rejecting -device ...,unit=1, then the
bug is in my implementation of enumerate_devices.  Maybe it
should just look at IDEBus::max_units to find that out?

-- 
Eduardo
