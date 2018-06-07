Received: from eggs.gnu.org ([2001:4830:134:3::10]:36880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fR474-0002LA-16
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 19:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fR470-0000jz-2e
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 19:14:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fR46z-0000iw-Tq
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 19:14:33 -0400
Date: Fri, 8 Jun 2018 02:14:31 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180608021134-mutt-send-email-mst@kernel.org>
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<20180607223111.27792-3-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607223111.27792-3-ross.zwisler@linux.intel.com>
Subject: Re: [Qemu-devel] [qemu PATCH 3/5] hw/i386: Update SSDT table used
 by "make check"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On Thu, Jun 07, 2018 at 04:31:09PM -0600, Ross Zwisler wrote:
> This commit:
> 
> commit aa78a16d8645 ("hw/i386: Rename 2.13 machine types to 3.0")
> 
> updated the name used to create the q35 machine, which in turn changed the
> SSDT table which is generated when we run "make check":
> 
>   acpi-test: Warning! SSDT mismatch. Actual [asl:/tmp/asl-QZDWJZ.dsl,
>   aml:/tmp/aml-T8JYJZ], Expected [asl:/tmp/asl-DTWVJZ.dsl,
>   aml:tests/acpi-test-data/q35/SSDT.dimmpxm].
> 
> Here's the only difference, aside from the checksum:
> 
>   <     Name (MEMA, 0x07FFF000)
>   ---
>   >     Name (MEMA, 0x07FFE000)

Weird. How come the phys address changes just because of machine name?

> 
> Update the binary table that we compare against so it reflects this name
> change.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Fixes: commit aa78a16d8645 ("hw/i386: Rename 2.13 machine types to 3.0")
> ---
>  tests/acpi-test-data/q35/SSDT.dimmpxm | Bin 685 -> 685 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)
> 
> diff --git a/tests/acpi-test-data/q35/SSDT.dimmpxm b/tests/acpi-test-data/q35/SSDT.dimmpxm
> index 8ba0e67cb72daa81a65da4906d37a5e0f4af1fd4..2d5b721bcf9c398feb6d005761f898015042e8a4 100644
> GIT binary patch
> delta 23
> fcmZ3>x|WqIIM^j*EfWI+qr*n71x(Bz{<8xBPCEwk
> 
> delta 23
> fcmZ3>x|WqIIM^j*EfWI+W57nP1x(Bj{<8xBPMZev
> 
> -- 
> 2.14.4
