Received: from eggs.gnu.org ([2001:4830:134:3::10]:57262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dEEMq-0008Sr-Ma
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dEEMm-0007ZJ-NU
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:29:20 -0400
Received: from mail-eopbgr20121.outbound.protection.outlook.com
	([40.107.2.121]:13728
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dEEMm-0007Z2-0m
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:29:16 -0400
Date: Fri, 26 May 2017 15:29:05 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170526122904.GB11269@rkaganb.sw.ru>
References: <1495801522-27628-1-git-send-email-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1495801522-27628-1-git-send-email-dplotnikov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2] kvmclock: update system_time_msr
 address forcibly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, den@virtuozzo.com

On Fri, May 26, 2017 at 03:25:22PM +0300, Denis Plotnikov wrote:
> Do an update of system_time_msr address every time before reading
> the value of tsc_timestamp from guest's kvmclock page.
> 
> There is no other code paths which ensure that qemu has an up-to-date
> value of system_time_msr. So, force this update on guest's tsc_timestamp
> reading.
> 
> This bug causes effect on those nested setups which turn off TPR access
> interception for L2 guests and that access being intercepted by L0 doesn't
> show up in L1.
> Linux bootstrap initiate kvmclock before APIC initializing causing TPR access.
> That's why on L1 guests, having TPR interception turned on for L2, the effect
> of the bug is not revealed.
> 
> This patch fixes this problem by making sure it knows the correct
> system_time_msr address every time it is needed.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  hw/i386/kvm/clock.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
