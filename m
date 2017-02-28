Received: from eggs.gnu.org ([2001:4830:134:3::10]:51120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cieCS-0006hb-7d
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cieCO-0002ke-IU
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:36:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cieCO-0002jL-6p
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:36:00 -0500
Date: Tue, 28 Feb 2017 09:35:53 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170228093553.GA2773@work-vm>
References: <20170214133331.28997-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170214133331.28997-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vmstate-static-checker: update white list
 with spapr_pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

* Laurent Vivier (lvivier@redhat.com) wrote:
> To fix migration between 2.7 and 2.8, some fields have
> been renamed and managed with the help of a PHB property
> (pre_2_8_migration):
> 
>     5c4537b spapr: Fix 2.7<->2.8 migration of PCI host bridge
> 
> So we need to add them to the white list:
> 
>     dma_liobn[0],
>     mem_win_addr, mem_win_size,
>     io_win_addr, io_win_size
> 
> become
> 
>     mig_liobn,
>     mig_mem_win_addr, mig_mem_win_size,
>     mig_io_win_addr, mig_io_win_size
> 
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Thomas Huth <thuth@redhat.com>
> CC: Greg Kurz <groug@kaod.org>
> CC: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Queued.

> ---
>  scripts/vmstate-static-checker.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-checker.py
> index 14a27e7..bcef7ee 100755
> --- a/scripts/vmstate-static-checker.py
> +++ b/scripts/vmstate-static-checker.py
> @@ -85,6 +85,11 @@ def check_fields_match(name, s_field, d_field):
>          'xio3130-express-upstream-port': ['br.dev', 'parent_obj.parent_obj',
>                                            'br.dev.exp.aer_log',
>                                            'parent_obj.parent_obj.exp.aer_log'],
> +        'spapr_pci': ['dma_liobn[0]', 'mig_liobn',
> +                      'mem_win_addr', 'mig_mem_win_addr',
> +                      'mem_win_size', 'mig_mem_win_size',
> +                      'io_win_addr', 'mig_io_win_addr',
> +                      'io_win_size', 'mig_io_win_size'],
>      }
>  
>      if not name in changed_names:
> -- 
> 2.9.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
