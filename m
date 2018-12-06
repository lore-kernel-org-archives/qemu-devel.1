Received: from eggs.gnu.org ([2001:4830:134:3::10]:33257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gUw9h-00035T-61
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gUw9b-0004mQ-4o
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:05:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gUw9X-0004DF-6b
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:05:29 -0500
Date: Thu, 6 Dec 2018 09:04:39 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181206090439.3c5c3223@x1.home>
In-Reply-To: <83c490a2-7565-b95c-563f-fb73476e874f@redhat.com>
References: <154393964026.28192.13536237934563059985.stgit@gimli.home>
	<154394077749.28192.1229512133780284321.stgit@gimli.home>
	<83c490a2-7565-b95c-563f-fb73476e874f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-4.0 PATCH v3 3/9] qapi: Define PCIe link
 speed and width properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, Geoffrey McRae <geoff@hostfission.com>, Markus Armbruster <armbru@redhat.com>

On Wed, 5 Dec 2018 13:42:25 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> > --- a/qapi/common.json
> > +++ b/qapi/common.json
> > @@ -127,6 +127,48 @@
> >  { 'enum': 'OffAutoPCIBAR',
> >    'data': [ 'off', 'auto', 'bar0', 'bar1', 'bar2', 'bar3', 'bar4', 'bar5' ] }
> >  
> > +##
> > +# @PCIELinkSpeed:
> > +#
> > +# An enumeration of PCIe link speeds in units of GT/s
> > +#
> > +# @2_5: 2.5GT/s
> > +#
> > +# @5: 5.0GT/s
> > +#
> > +# @8: 8.0GT/s
> > +#
> > +# @16: 16.0GT/s
> > +#
> > +# Since: 3.2  
> 4.0 here and below

Fixed in the next spin.  Thanks,

Alex

> > +##
> > +{ 'enum': 'PCIELinkSpeed',
> > +  'data': [ '2_5', '5', '8', '16' ] }
> > +
> > +##
> > +# @PCIELinkWidth:
> > +#
> > +# An enumeration of PCIe link width
> > +#
> > +# @1: x1
> > +#
> > +# @2: x2
> > +#
> > +# @4: x4
> > +#
> > +# @8: x8
> > +#
> > +# @12: x12
> > +#
> > +# @16: x16
> > +#
> > +# @32: x32
> > +#
> > +# Since: 3.2
> > +##
> > +{ 'enum': 'PCIELinkWidth',
> > +  'data': [ '1', '2', '4', '8', '12', '16', '32' ] }
> > +
> >  ##
> >  # @SysEmuTarget:
> >  #
> > 
> >   
