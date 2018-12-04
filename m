Received: from eggs.gnu.org ([2001:4830:134:3::10]:45637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUFaQ-0003D2-RA
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUFQS-0007Nm-HN
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:28:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gUFQQ-0007Mh-KG
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:28:02 -0500
Date: Tue, 4 Dec 2018 16:27:48 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181204182748.GE18284@habkost.net>
References: <154385426086.17724.4390242199797858265.stgit@gimli.home>
	<154385451622.17724.12272989665681200621.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154385451622.17724.12272989665681200621.stgit@gimli.home>
Subject: Re: [Qemu-devel] [for-4.0 PATCH v2 8/9] q35/440fx/arm/spapr: Add
 QEMU 4.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Mon, Dec 03, 2018 at 09:28:36AM -0700, Alex Williamson wrote:
> Including all machine types that might have a pcie-root-port.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
[...]
> +static void virt_3_1_instance_init(Object *obj)
> +{
> +    virt_4_0_instance_init(obj);
> +}
[...]
> +/*
> + * pseries-4.0
> + */
> +static void spapr_machine_4_0_instance_options(MachineState *machine)
> +{
> +}

Not something specific about patch, but:

Why exactly virt and pseries machines need separate instance
initialization functions?

I'd like to eventually make all machine-type-version-specific
behavior instrospectable, so it needs to be available at
class_init time.

-- 
Eduardo
