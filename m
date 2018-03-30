Received: from eggs.gnu.org ([2001:4830:134:3::10]:42699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1ztW-00005X-Lp
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 15:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1ztR-0004Et-Pz
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 15:41:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1ztR-0004DA-Jh
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 15:40:57 -0400
Date: Fri, 30 Mar 2018 16:40:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180330194053.GD5046@localhost.localdomain>
References: <20180330170209.20627-1-rkagan@virtuozzo.com>
	<20180330170209.20627-3-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330170209.20627-3-rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 2/2] i386/hyperv: error out if
 features requested but unsupported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

On Fri, Mar 30, 2018 at 08:02:09PM +0300, Roman Kagan wrote:
> In order to guarantee compatibility on migration, QEMU should have
> complete control over the features it announces to the guest via CPUID.
> 
> However, for a number of Hyper-V-related cpu properties, if the
> corresponding feature is not supported by the underlying KVM, the
> propery is silently ignored and the feature is not announced to the
> guest.
> 
> Refuse to start with an error instead.
> 
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
