Received: from eggs.gnu.org ([2001:4830:134:3::10]:45596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1elJI8-0006sC-Kc
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1elJI3-0000Dx-Uy
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:57:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1elJI3-0000Bx-P0
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:57:23 -0500
Date: Mon, 12 Feb 2018 16:57:13 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180212185713.GS13981@localhost.localdomain>
References: <20180212153715.87555-1-brijesh.singh@amd.com>
	<20180212153715.87555-11-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212153715.87555-11-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH v8 10/28] sev/i386: add command to
 initialize the memory encryption context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>

On Mon, Feb 12, 2018 at 09:36:57AM -0600, Brijesh Singh wrote:
[...]
> +#define SEV_FW_MAX_ERROR      0x17
> +
> +static const char *const sev_fw_errlist[] = {

This requires anybody reading the code to manually count the
number of items on the array to be sure fw_error_to_str() is
safe.

What about:
  #define SEV_FW_MAX_ERROR ARRAY_SIZE(sev_fw_errlist)


> +    "",
> +    "Platform state is invalid",
> +    "Guest state is invalid",
> +    "Platform configuration is invalid",
> +    "Buffer too small",
> +    "Platform is already owned",
> +    "Certificate is invalid",
> +    "Policy is not allowed",
> +    "Guest is not active",
> +    "Invalid address",
> +    "Bad signature",
> +    "Bad measurement",
> +    "Asid is already owned",
> +    "Invalid ASID",
> +    "WBINVD is required",
> +    "DF_FLUSH is required",
> +    "Guest handle is invalid",
> +    "Invalid command",
> +    "Guest is active",
> +    "Hardware error",
> +    "Hardware unsafe",
> +    "Feature not supported",
> +    "Invalid parameter"
> +};
[...]
> +fw_error_to_str(int code)
> +{
> +    if (code >= SEV_FW_MAX_ERROR) {
> +        return "unknown error";
> +    }
> +
> +    return sev_fw_errlist[code];
> +}
> +

-- 
Eduardo
