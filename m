Received: from eggs.gnu.org ([209.51.188.92]:42286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gldHW-00028q-Dm
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gldHV-0006p7-La
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:22:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gldHV-0006oU-Dq
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:22:41 -0500
Date: Mon, 21 Jan 2019 15:22:37 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190121172237.GO4136@habkost.net>
References: <20190121155051.5628-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121155051.5628-1-vkuznets@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] i386: Enable NPT and NRIPSAVE for AMD
 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Mon, Jan 21, 2019 at 04:50:51PM +0100, Vitaly Kuznetsov wrote:
> Modern AMD CPUs support NPT and NRIPSAVE features and KVM exposes these
> when present. NRIPSAVE apeared somewhere in Opteron_G3 lifetime (e.g.
> QuadCore AMD Opteron 2378 has is but QuadCore AMD Opteron HE 2344 doesn't),
> NPT was introduced a bit earlier.
> 
> Add the FEAT_SVM leaf to Opteron_G4/G5 and EPYC/EPYC-IBPB cpu models.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queued, thanks!

-- 
Eduardo
