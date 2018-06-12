Received: from eggs.gnu.org ([2001:4830:134:3::10]:50090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSpvX-0002Tj-RQ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSpvT-0001uT-7o
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:30:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42834 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fSpvT-0001u7-3T
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:29:59 -0400
Date: Tue, 12 Jun 2018 23:29:54 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180612232909-mutt-send-email-mst@kernel.org>
References: <20180612184616.90838-1-mst@redhat.com>
	<152883108273.687.17942883548380621551@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152883108273.687.17942883548380621551@d39dc562802a>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] kvm: x86 CPU power management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, mtosatti@redhat.com, ehabkost@redhat.com, kvm@vger.kernel.org, rth@twiddle.net

On Tue, Jun 12, 2018 at 12:18:03PM -0700, no-reply@patchew.org wrote:
> Checking PATCH 1/2: kvm: support -realtime cpu-pm=on|off...
> WARNING: line over 80 characters
> #85: FILE: target/i386/kvm.c:1401:
> +            error_report("kvm: guest stopping CPU not supported: %s", strerror(-ret));
> 
> ERROR: do not initialise globals to 0 or NULL
> #100: FILE: vl.c:145:
> +bool enable_cpu_pm = false;
> 
> total: 1 errors, 1 warnings, 82 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

We seem to violate this left and right. Let's drop this?

-- 
MST
