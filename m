Received: from eggs.gnu.org ([2001:4830:134:3::10]:34194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gSLL0-000628-Bz
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gSLKw-0003bk-Aq
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:22:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gSLKw-0003af-4r
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:22:30 -0500
Date: Thu, 29 Nov 2018 12:22:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181129122218.GD2333@work-vm>
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-10-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126200435.23408-10-minyard@acm.org>
Subject: Re: [Qemu-devel] [PATCH v3 09/16] migration: Add a
 VMSTATE_BOOL_TEST() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

* minyard@acm.org (minyard@acm.org) wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> This will be needed by coming I2C changes.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/vmstate.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 2b501d0466..0861e18138 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -850,6 +850,9 @@ extern const VMStateInfo vmstate_info_qtailq;
>  #define VMSTATE_INT32_POSITIVE_LE(_f, _s)                             \
>      VMSTATE_SINGLE(_f, _s, 0, vmstate_info_int32_le, int32_t)
>  
> +#define VMSTATE_BOOL_TEST(_f, _s, _t)                               \
> +    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_bool, bool)
> +
>  #define VMSTATE_INT8_TEST(_f, _s, _t)                               \
>      VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_int8, int8_t)
>  
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
