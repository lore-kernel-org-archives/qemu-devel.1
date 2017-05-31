Received: from eggs.gnu.org ([2001:4830:134:3::10]:42777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dG0E2-00063J-A8
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dG0Dz-0003EI-Mr
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:47:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dG0Dz-0003E2-F5
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:47:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0C20C056791
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 09:47:29 +0000 (UTC)
Date: Wed, 31 May 2017 10:47:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170531094719.GE2141@work-vm>
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-11-git-send-email-vyasevic@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495649128-10529-11-git-send-email-vyasevic@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/12] hmp: Add hmp_announce_self
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladislav Yasevich <vyasevic@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com

* Vladislav Yasevich (vyasevic@redhat.com) wrote:
> Add an HMP command to trigger self annocements.
> 
> Signend-off-by: Vladislav Yasevich <vyasevic@redhat.com>
       ^^

> ---
>  hmp-commands.hx | 14 ++++++++++++++
>  hmp.c           |  5 +++++
>  hmp.h           |  1 +
>  3 files changed, 20 insertions(+)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index c8dd816..0efe479 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -939,6 +939,20 @@ Set the parameter @var{parameter} for GARP/RARP announcements.
>  ETEXI
>  
>      {
> +        .name       = "qemu_announce_self",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "Trigger GARP/RARP announcements",
> +        .cmd        = hmp_announce_self,
> +    },
> +
> +STEXI
> +@item qemu_announce_self
> +@findex qemu_announce_self
> +Trigger GARP/RARP announcements.

Yes, you could probably just call that 'announce_self';
if I understand then this version doesn't take any parameters
(unlike the qmp version) you just rely on the preset-configs.
That's OK if that mechanism stays the same.

Dave

> +ETEXI
> +
> +    {
>          .name       = "migrate",
>          .args_type  = "detach:-d,blk:-b,inc:-i,uri:s",
>          .params     = "[-d] [-b] [-i] uri",
> diff --git a/hmp.c b/hmp.c
> index 7d41783..f3c1f02 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1509,6 +1509,11 @@ void hmp_announce_set_parameter(Monitor *mon, const QDict *qdict)
>      }
>  }
>  
> +void hmp_announce_self(Monitor *mon, const QDict *qdict)
> +{
> +    qmp_announce_self(false, NULL, NULL);
> +}
> +
>  void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
>  {
>      qmp_migrate_cancel(NULL);
> diff --git a/hmp.h b/hmp.h
> index adf017c..fcb4be4 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -147,5 +147,6 @@ void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
>  void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
>  void hmp_info_announce_parameters(Monitor *mon, const QDict *qdict);
> +void hmp_announce_self(Monitor *mon, const QDict *qdict);
>  
>  #endif
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
