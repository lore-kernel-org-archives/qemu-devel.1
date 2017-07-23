Received: from eggs.gnu.org ([2001:4830:134:3::10]:55125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dZ64O-0002AW-ST
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 21:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dZ64L-0002Hd-Ro
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 21:52:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dZ64L-0002HN-LQ
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 21:52:29 -0400
Date: Sun, 23 Jul 2017 04:52:22 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170723044845-mutt-send-email-mst@kernel.org>
References: <201707221349209626503@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201707221349209626503@zte.com.cn>
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTog562U5aSNOiBSZTogIFtQQVRD?=
 =?utf-8?q?H=5D_vhost=3A_fix_a_migration_failedbecause_ofvhost_region_merg?=
 =?utf-8?q?e?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peng.hao2@zte.com.cn
Cc: imammedo@redhat.com, dgilbert@redhat.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, wang.yechao255@zte.com.cn, qemu-devel@nongnu.org

On Sat, Jul 22, 2017 at 01:49:20PM +0800, peng.hao2@zte.com.cn wrote:
> some regions can not merge when just part of devices have realized.
> 
> when all devices are realized on destination, these regions  can be merged
>  again 
> 
>  and the used slots can satisfy the vhost slot limit as on source.
> 
> in the restore stage the vm is not in running state, so don't compute if more
> than 
> 
> vhost slot limit when vm is not running. when a last device is realized,
> 
> all regions are merged to the slot number as on source. then the state of vm 
> 
> changes to running.
> 
>  it satisfies the vhost slot limit on source, so it should satify on
> destination.

OK but the VM not running check is too hacky. E.g. it won't
trigger with memory hotplug if someone stops VM before
doing hotplug.

Looks like you want to check machine_init_done or something
like this.

-- 
MST
