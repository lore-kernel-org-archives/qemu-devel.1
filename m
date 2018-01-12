Received: from eggs.gnu.org ([2001:4830:134:3::10]:51425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZz1a-0001G6-Vv
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZz1V-0000zL-1A
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:05:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZz1U-0000yN-RF
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:05:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 776B95586C
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 13:05:27 +0000 (UTC)
Date: Fri, 12 Jan 2018 14:04:16 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180112130416.rsdydqy4popkugrm@sirius.home.kraxel.org>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-38-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180111213250.16511-38-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 37/51] qapi: add conditions to VNC
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

> diff --git a/ui/vnc.h b/ui/vnc.h
> index 694cf32ca9..5572bfdc9e 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -291,7 +291,9 @@ struct VncState
>      bool encode_ws;
>      bool websocket;
>  
> +#ifdef CONFIG_VNC
>      VncClientInfo *info;
> +#endif

Is this header files used even on !vnc builds?

> diff --git a/hmp.c b/hmp.c
> index 2d72f94193..0612ddc621 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -613,6 +613,7 @@ void hmp_info_blockstats(Monitor *mon, const QDict *qdict)
>      qapi_free_BlockStatsList(stats_list);
>  }
>  
> +#ifdef CONFIG_VNC
>  /* Helper for hmp_info_vnc_clients, _servers */
>  static void hmp_info_VncBasicInfo(Monitor *mon, VncBasicInfo *info,
>                                    const char *name)
> @@ -700,6 +701,7 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict)
>      qapi_free_VncInfo2List(info2l);
>  
>  }
> +#endif

Move to ui/vnc.c, so we don't need #ifdef here?

cheers,
  Gerd
