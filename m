Received: from eggs.gnu.org ([2001:4830:134:3::10]:44662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cor9z-0004H3-5D
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cor9u-0004S0-7D
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:39:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cor9u-0004Ql-1z
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:39:06 -0400
Date: Fri, 17 Mar 2017 13:38:58 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170317123858.sqhisecxdigfsjs2@kamzik.brq.redhat.com>
References: <1489748902-21765-1-git-send-email-peter.maydell@linaro.org>
	<20170317114953.GF8050@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317114953.GF8050@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Warn about deprecated hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, patches@linaro.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On Fri, Mar 17, 2017 at 11:49:53AM +0000, Daniel P. Berrange wrote:
> On Fri, Mar 17, 2017 at 11:08:22AM +0000, Peter Maydell wrote:
> > This list is definitely too all-encompassing, and we should
> > move at least some of the BSDs into "not-deprecated".
> > I'm posting the patch for the moment for code review on the
> > logic and as a placeholder.
> 
> FreeBSD is the one where I most frequently see developers engaging across
> the overall virt tools stack (QEMU/libvirt/virt-manager/OpenStack).
> GNU/kFreeBSD has come up a few times in libvirt, and I don't recall seeing
> anyone mentioning the remaining BSDs - though perhaps thats because the
> FreeBSD port fixes are enough to also make other BSDs work.

OpenBSD just came up this week regarding kvm-unit-tests. Someone is
attempting to test vmd, the openbsd hypervisor, using the openbsd port
of qemu and kvm-unit-tests.

(just pointing that out, not making a deprecate/don't-deprecate statement)

Thanks,
drew
