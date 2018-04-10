Received: from eggs.gnu.org ([2001:4830:134:3::10]:51459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5pEF-0007Fz-Df
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5pE9-0003gN-K3
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:06:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f5pE9-0003f0-EQ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:06:09 -0400
Date: Tue, 10 Apr 2018 10:05:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180410090550.GE5155@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180407000117.25640-1-lersek@redhat.com>
	<bf5fc85b-0695-3bd0-117d-759d5dbd4546@redhat.com>
	<6bfdae78-909f-e7ad-b0f0-25f76dfd81f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6bfdae78-909f-e7ad-b0f0-25f76dfd81f7@redhat.com>
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Mon, Apr 09, 2018 at 06:34:41PM +0200, Laszlo Ersek wrote:
> On 04/09/18 09:26, Thomas Huth wrote:
> >  Hi Laszlo,
> > 
> > On 07.04.2018 02:01, Laszlo Ersek wrote:
> >> Add a schema that describes the properties of virtual machine firmware.
> >>
> >> Each firmware executable installed on a host system should come with a
> >> JSON file that conforms to this schema, and informs the management
> >> applications about the firmware's properties.
> >>
> >> In addition, a configuration directory with symlinks to the JSON files
> >> should exist, with the symlinks carefully named to reflect a priority
> >> order. Management applications can then search this directory in priority
> >> order for the first firmware executable that satisfies their search
> >> criteria. The found JSON file provides the management layer with domain
> >> configuration bits that are required to run the firmware binary.
> > [...]
> >> +##
> >> +# @FirmwareDevice:
> >> +#
> >> +# Defines the device types that a firmware file can be mapped into.
> >> +#
> >> +# @memory: The firmware file is to be mapped into memory.
> >> +#
> >> +# @kernel: The firmware file is to be loaded like a Linux kernel. This is
> >> +#          similar to @memory but may imply additional processing that is
> >> +#          specific to the target architecture.
> >> +#
> >> +# @flash: The firmware file is to be mapped into a pflash chip.
> >> +#
> >> +# Since: 2.13
> >> +##
> >> +{ 'enum' : 'FirmwareDevice',
> >> +  'data' : [ 'memory', 'kernel', 'flash' ] }
> > 
> > This is not fully clear to me... what is this exactly good for? Is this
> > a way to say how the firmware should be loaded, i.e. via "-bios",
> > "-kernel" or "-pflash" parameter? If so, the term "memory" is quite
> > misleading since files that are loaded via -bios can also end up in an
> > emulated ROM chip.
> 
> I threw in "-kernel" because, although it also (usually?) means
> "memory", I expected people would want it separate.

What platform / scenario actually uses -kernel to load firmware. If you
have loaded firmware using -kernel, how do you then load the actual
kernel ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
