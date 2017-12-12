Received: from eggs.gnu.org ([2001:4830:134:3::10]:38966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOncR-0007JN-8f
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 11:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOncO-00040d-3A
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 11:41:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eOncN-0003z6-So
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 11:41:20 -0500
Date: Tue, 12 Dec 2017 16:41:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171212164114.GF2409@work-vm>
References: <1511273358-21789-1-git-send-email-s1seetee@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1511273358-21789-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1] hmp: 'info snapshots' not showing the id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, lma@suse.com
Cc: qemu-devel@nongnu.org, mreitz@redhat.com

* Seeteena Thoufeek (s1seetee@linux.vnet.ibm.com) wrote:
> (qemu) info snapshots
> List of snapshots present on all disks:
> ID        TAG                 VM SIZE                DATE       VM CLOCK
> --         1                      314M 2017-11-15 15:22:18   00:02:25.695
> --         2                      319M 2017-11-15 15:23:03   00:02:45.970
> --         3                      319M 2017-11-15 15:23:37   00:02:56.328
> 
> ID field is showing -- with no information.
> 
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>

Hi Seeteena,
  Your change doesn't seem to be consistent with the comment above it.
I don't know the detailed history of snapshots, but that comment and the
pstrcpy comes from Lin Ma's commit 3a1ee711 which seems to be saying the
ID can't be trusted.

Dave

> ---
>  hmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 35a7041..1921b3b 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1454,7 +1454,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
>              /* The ID is not guaranteed to be the same on all images, so
>               * overwrite it.
>               */
> -            pstrcpy(sn->id_str, sizeof(sn->id_str), "--");
> +            pstrcpy(sn->id_str, sizeof(sn->id_str), sn->id_str);
>              bdrv_snapshot_dump((fprintf_function)monitor_printf, mon, sn);
>              monitor_printf(mon, "\n");
>          }
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
