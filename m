Received: from eggs.gnu.org ([208.118.235.92]:37245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fvhVS-0004PW-6S
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fvhVO-0006pv-TT
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:22:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fvhVO-0006pf-O2
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:22:22 -0400
Date: Fri, 31 Aug 2018 13:22:19 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180831112219.ujfdn4uiya5p7ul4@kamzik.brq.redhat.com>
References: <1535630903-146863-1-git-send-email-imammedo@redhat.com>
	<38b3347b-8923-26e9-82a4-f69002262767@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b3347b-8923-26e9-82a4-f69002262767@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qga: ignore non present cpus when handling
 qmp_guest_get_vcpus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On Thu, Aug 30, 2018 at 05:51:13PM +0200, Laszlo Ersek wrote:
> Originally these guest agent commands (both getting and setting) were
> meant to be used in the absence of real VCPU hot[un]plug, as a fallback
> / place-holder.
> 
> If the latter (= real VCPU hot(un)plug) works, then these guest agent
> commands shouldn't be used at all.
> 
> Drew, do I remember correctly?

Yup. This guest agent functionality was merely a stopgap to support "cpu
hotplug", before real cpu hotplug could be supported.

> I wonder if, instead of this patch, we should rework
> qmp_guest_get_vcpus(), to silently skip processors for which this
> dirpath ENOENT condition arises (i.e., return a shorter list of
> GuestLogicalProcessor objects).

That sounds good to me.

Thanks,
drew
