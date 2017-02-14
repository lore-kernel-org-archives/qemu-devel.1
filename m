Received: from eggs.gnu.org ([2001:4830:134:3::10]:32988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cddlh-0003hg-AM
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cddle-0002B9-7K
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:07:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cddle-0002A3-15
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:07:42 -0500
References: <20170214133331.28997-1-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4f19d5a8-4791-6a32-94c3-813602845fb4@redhat.com>
Date: Tue, 14 Feb 2017 15:07:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170214133331.28997-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 14.02.2017 14:33, Laurent Vivier wrote:
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
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
