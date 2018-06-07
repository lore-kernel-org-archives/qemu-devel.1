Received: from eggs.gnu.org ([2001:4830:134:3::10]:58917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQrOM-00068l-Rg
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQrOJ-00035U-PI
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:39:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34942 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQrOJ-00034c-KE
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:39:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97A4BC12AD
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 09:39:33 +0000 (UTC)
Date: Thu, 7 Jun 2018 11:39:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180607113931.3f5b726b@redhat.com>
In-Reply-To: <20180605122636.33654-5-dgilbert@redhat.com>
References: <20180605122636.33654-1-dgilbert@redhat.com>
	<20180605122636.33654-5-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Tue,  5 Jun 2018 13:26:34 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Allow a bunch of the info commands to be used in preconfig.
> Could probably add most of them.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hmp-commands-info.hx | 9 +++++++++
>  hmp-commands.hx      | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index ddfcd5adcc..00735e7d1c 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -19,6 +19,7 @@ ETEXI
>          .params     = "",
>          .help       = "show the version of QEMU",
>          .cmd        = hmp_info_version,
> +        .flags      = "p",
>      },
>  
>  STEXI
> @@ -33,6 +34,7 @@ ETEXI
>          .params     = "",
>          .help       = "show the network state",
>          .cmd        = hmp_info_network,
> +        .flags      = "p",
output seems to refer to frontend devices, so we probably should skip this one

>      },
>  
>  STEXI
> @@ -47,6 +49,7 @@ ETEXI
>          .params     = "",
>          .help       = "show the character devices",
>          .cmd        = hmp_info_chardev,
> +        .flags      = "p",
>      },
>  
>  STEXI
> @@ -62,6 +65,7 @@ ETEXI
>          .help       = "show info of one block device or all block devices "
>                        "(-n: show named nodes; -v: show details)",
>          .cmd        = hmp_info_block,
> +        .flags      = "p",
>      },
Devices (frontends) are processed after preconfig point,
so there isn't point in enabling this.
At least until we could instantiate devices at that time.

>  
>  STEXI
> @@ -151,6 +155,7 @@ ETEXI
>          .params     = "",
>          .help       = "show infos for each CPU",
>          .cmd        = hmp_info_cpus,
> +        .flags      = "p",
>      },
this command probably shouldn't be enabled, there can't be any CPUs at this point yet.

>  
>  STEXI
> @@ -165,6 +170,7 @@ ETEXI
>          .params     = "",
>          .help       = "show the command line history",
>          .cmd        = hmp_info_history,
> +        .flags      = "p",
>      },
>  
>  STEXI
> @@ -255,6 +261,7 @@ ETEXI
>          .help       = "show memory tree (-f: dump flat view for address spaces;"
>                        "-d: dump dispatch tree, valid with -f only)",
>          .cmd        = hmp_info_mtree,
> +        .flags      = "p",
>      },
probably we should skip this one as well

>  
>  STEXI
> @@ -399,6 +406,7 @@ ETEXI
>          .params     = "",
>          .help       = "show the current VM status (running|paused)",
>          .cmd        = hmp_info_status,
> +        .flags      = "p",
>      },
>  
>  STEXI
> @@ -829,6 +837,7 @@ ETEXI
>          .params     = "",
>          .help       = "Show information about hotpluggable CPUs",
>          .cmd        = hmp_hotpluggable_cpus,
> +        .flags      = "p",
>      },
>  
>  STEXI
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 8bf590ae4b..dc82ed526f 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1856,6 +1856,7 @@ ETEXI
>          .help       = "show various information about the system state",
>          .cmd        = hmp_info_help,
>          .sub_table  = info_cmds,
> +        .flags      = "p",
>      },
>  
>  STEXI

in addition to above we should be able to handle at preconfig time:

info memdev
info name
info numa
info qom-tree
info usbhost
info uuid
info iothreads
