Received: from eggs.gnu.org ([2001:4830:134:3::10]:42596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyoe2-00049l-Fq
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 21:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyodz-0007pT-7v
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 21:03:54 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58477)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyodz-0007pH-0L
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 21:03:51 -0400
Date: Wed, 21 Mar 2018 21:03:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180322010348.GA16453@flamenco>
References: <20180309132922.24211-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309132922.24211-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] Optionally use membarrier system call
 for RCU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Mar 09, 2018 at 14:29:18 +0100, Paolo Bonzini wrote:
> I didn't have time to check whether it improves performance (not
> too likely, since QEMU tends to have pretty long RCU critical
> sections), but it cannot hurt either. :)

Sorry it took me more than a week to go through this, I was busy
working on the FP patchset.

I see this set is already on master; nonetheless here are some
minor comments.

		E.
