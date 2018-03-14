Received: from eggs.gnu.org ([2001:4830:134:3::10]:57553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ew63I-0003uD-Ag
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 09:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ew63F-00065J-9l
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 09:02:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ew63F-00065A-3r
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 09:02:41 -0400
Date: Wed, 14 Mar 2018 10:02:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180314130238.GE3417@localhost.localdomain>
References: <1520969191-18162-1-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520969191-18162-1-git-send-email-luwei.kang@intel.com>
Subject: Re: [Qemu-devel] [PATCH] i386: Disable Intel PT if packets IP
 payloads have LIP values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luwei Kang <luwei.kang@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On Wed, Mar 14, 2018 at 03:26:31AM +0800, Luwei Kang wrote:
> Intel processor trace should be disabled when
> CPUID.(EAX=14H,ECX=0H).ECX.[bit31] is set.
> Generated packets which contain IP payloads will have LIP
> values when this bit is set, or IP payloads will have RIP
> values.
> Currently, The information of CPUID 14H is constant to make
> live migration safty and this bit is always 0 in guest even
> if host support LIP values.
> Guest sees the bit is 0 will expect IP payloads with RIP
> values, but the host CPU will generate IP payloads with
> LIP values if this bit is set in HW.
> To make sure the value of IP payloads correctly, Intel PT
> should be disabled when bit[31] is set.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>

Queued, thanks.

-- 
Eduardo
