Received: from eggs.gnu.org ([2001:4830:134:3::10]:40440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmN4r-0006JX-FT
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmN4n-0002rW-GB
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:07:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cmN4n-0002rD-9v
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:07:33 -0500
References: <1489158897-9206-1-git-send-email-yang.zhong@intel.com>
	<867e2a13-b48e-cb85-1eb9-38694e28c172@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A0F66A@ORSMSX112.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a5f6ed2f-2580-beaa-a5d2-42857588844c@redhat.com>
Date: Fri, 10 Mar 2017 17:07:30 +0100
MIME-Version: 1.0
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A0F66A@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] reduce qemu's heap Rss size from
 12252kB to 2752KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>, "Zhong, Yang" <yang.zhong@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Peng, Chao P" <chao.p.peng@intel.com>



On 10/03/2017 17:05, Xu, Anthony wrote:
> Ideally, freeing QOM object should not require a global lock. 
> If you see any other QOM requiring a global lock, please let us know, we are willing to fix it.

All of them.  When unplugging a device, the device object will be freed
from an RCU callback.

Paolo
