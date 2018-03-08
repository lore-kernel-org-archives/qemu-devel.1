Received: from eggs.gnu.org ([2001:4830:134:3::10]:47429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etyoI-0001m4-Se
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etyoF-0005qM-6F
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:54:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etyoF-0005p6-05
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:54:27 -0500
Date: Thu, 8 Mar 2018 16:54:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180308165413.GH4718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-11-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308124901.83533-11-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH v12 10/28] include: add psp-sev.h header
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 08, 2018 at 06:48:43AM -0600, Brijesh Singh wrote:
> The header file provide the ioctl command and structure to communicate
> with /dev/sev device.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  linux-headers/linux/psp-sev.h | 142 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 linux-headers/linux/psp-sev.h
> 
> diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.h
> new file mode 100644
> index 000000000000..33e247471ae0
> --- /dev/null
> +++ b/linux-headers/linux/psp-sev.h
> @@ -0,0 +1,142 @@
> +/*
> + * Userspace interface for AMD Secure Encrypted Virtualization (SEV)
> + * platform management commands.
> + *
> + * Copyright (C) 2016-2017 Advanced Micro Devices, Inc.
> + *
> + * Author: Brijesh Singh <brijesh.singh@amd.com>
> + *
> + * SEV spec 0.14 is available at:
> + * http://support.amd.com/TechDocs/55766_SEV-KM%20API_Specification.pdf
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

Most of the files you've added are GPLv2-or-later. Is this one intentionally
GPLv2-only instead ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
