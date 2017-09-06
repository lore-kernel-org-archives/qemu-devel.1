Received: from eggs.gnu.org ([2001:4830:134:3::10]:40216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dpbek-0005nB-HZ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dpbeg-0000mD-08
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:50:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dpbef-0000lp-QB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:50:13 -0400
Date: Wed, 6 Sep 2017 11:49:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170906144958.GA7570@localhost.localdomain>
References: <20170906142658.58298-1-marcel@redhat.com>
	<20170906142658.58298-3-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906142658.58298-3-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/pcie: disable IO port fwd by
 default for pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On Wed, Sep 06, 2017 at 05:26:58PM +0300, Marcel Apfelbaum wrote:
> For most cases the devices attached to PCIe Root Ports
> do not need IO ports range, add an 'enable-io-fwd' property
> making it false by default, but keeping it true for older machines.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
[...]
> @@ -78,6 +111,7 @@ static const VMStateDescription vmstate_rp_dev = {
>  
>  static Property gen_rp_props[] = {
>      DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort, migrate_msix, true),
> +    DEFINE_PROP_BOOL("enable-io-fwd", GenPCIERootPort, enable_io_fwd, false),

There's no "x-" prefix, so I guess we really need to let the user
or management software to set enable-io-fwd=on explicitly on some
cases?

-- 
Eduardo
