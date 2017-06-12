Received: from eggs.gnu.org ([2001:4830:134:3::10]:40935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKLjM-0003tL-Qw
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKLjH-0003oW-UW
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:33:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dKLjH-0003oQ-PZ
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:33:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD7A3C04B943
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 09:33:46 +0000 (UTC)
Date: Mon, 12 Jun 2017 17:33:39 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170612093339.GH12928@pxdev.xzpeter.org>
References: <20170601212921.30241-1-quintela@redhat.com>
	<20170601212921.30241-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170601212921.30241-5-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/11] migration: Move
 dump_vmsate_json_to_file() to misc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Thu, Jun 01, 2017 at 11:29:14PM +0200, Juan Quintela wrote:
> It was not from vmstate.c to start with.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  include/migration/misc.h    | 4 ++++
>  include/migration/vmstate.h | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 60486d4..026b561 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -36,4 +36,8 @@ int64_t self_announce_delay(int round)
>      return 50 + (SELF_ANNOUNCE_ROUNDS - round - 1) * 100;
>  }
>  
> +/* migration/savevm.c */
> +
> +void dump_vmstate_json_to_file(FILE *out_fp);
> +
>  #endif
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 6de554d..ad243d4 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1004,8 +1004,6 @@ void vmstate_register_ram(struct MemoryRegion *memory, DeviceState *dev);
>  void vmstate_unregister_ram(struct MemoryRegion *memory, DeviceState *dev);
>  void vmstate_register_ram_global(struct MemoryRegion *memory);
>  
> -void dump_vmstate_json_to_file(FILE *out_fp);
> -
>  bool vmstate_check_only_migratable(const VMStateDescription *vmsd);
>  
>  #endif
> -- 
> 2.9.4
> 

-- 
Peter Xu
