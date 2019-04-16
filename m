Received: from eggs.gnu.org ([209.51.188.92]:44387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGSQE-0006Zi-5Z
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGSQ9-0002Pb-8u
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:03:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hGSQ6-0002Mo-LD
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:02:58 -0400
Date: Tue, 16 Apr 2019 15:02:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190416180251.GI32317@habkost.net>
References: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
Subject: Re: [Qemu-devel] [PATCH v3] i386: Add new Hygon 'Dhyana' CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pu Wen <puwen@hygon.cn>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, marcel.apfelbaum@gmail.com

On Tue, Apr 16, 2019 at 08:06:13PM +0800, Pu Wen wrote:
> Add a new base CPU model called 'Dhyana' to model processors from Hygon
> Dhyana(family 18h), which derived from AMD EPYC(family 17h).
> 
> The following features bits have been removed compare to AMD EPYC:
> aes, pclmulqdq, sha_ni
> 
> The Hygon Dhyana support to KVM in Linux is already accepted upstream[1].
> So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
> CPU model.
> 
> Reference:
> [1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2fc9adf87
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>

Queued for 4.1, thanks!

-- 
Eduardo
