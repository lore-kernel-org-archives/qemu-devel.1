Received: from eggs.gnu.org ([2001:4830:134:3::10]:56431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKMnh-0002D7-O7
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKMne-0007dx-Hr
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:42:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dKMne-0007dl-CT
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:42:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 151C880461
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 10:42:21 +0000 (UTC)
References: <20170601212921.30241-1-quintela@redhat.com>
	<20170601212921.30241-5-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <7d970715-b44e-02a9-c310-60c6d2d75498@redhat.com>
Date: Mon, 12 Jun 2017 12:42:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170601212921.30241-5-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 01/06/2017 23:29, Juan Quintela wrote:
> It was not from vmstate.c to start with.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

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
> 
