Received: from eggs.gnu.org ([2001:4830:134:3::10]:50240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1elHYX-0005LS-CQ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1elHYT-0006yd-O7
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:06:17 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:39164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1elHYT-0006xk-H3
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:06:13 -0500
Received: by mail-io0-x243.google.com with SMTP id b198so18024192iof.6
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 09:06:13 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180212154903.8859-1-dgilbert@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2c8c252d-0430-9adf-15d4-fc4082984251@twiddle.net>
Date: Mon, 12 Feb 2018 09:06:08 -0800
MIME-Version: 1.0
In-Reply-To: <20180212154903.8859-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390/stattrib: Make SaveVMHandlers data
 static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, agraf@suse.de, david@redhat.com

On 02/12/2018 07:49 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> There's no need for this to be dynamic, make it static.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/s390x/s390-stattrib.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index a1d2135a60..adf07ef312 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -365,22 +365,22 @@ static inline void s390_stattrib_set_migration_enabled(Object *obj, bool value,
>      s->migration_enabled = value;
>  }
>  
> +static SaveVMHandlers savevm_s390_stattrib_handlers = {
> +    .save_setup = cmma_save_setup,
> +    .save_live_iterate = cmma_save_iterate,
> +    .save_live_complete_precopy = cmma_save_complete,
> +    .save_live_pending = cmma_save_pending,
> +    .save_cleanup = cmma_save_cleanup,
> +    .load_state = cmma_load,
> +    .is_active = cmma_active,
> +};

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Bonus points for the follow-on to make this const.  I realize that
register_savevm_live is not currently prepared for this, so pushing the
qualifier down will take some doing.


r~
