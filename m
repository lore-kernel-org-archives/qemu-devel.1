Received: from eggs.gnu.org ([2001:4830:134:3::10]:39082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRJql-0004sB-54
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:35:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRJqg-00066O-8j
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:35:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gRJqg-000644-3h
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:35:02 -0500
Date: Mon, 26 Nov 2018 14:34:55 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181126163455.GP18284@habkost.net>
References: <7280.1542702495@dschgrazlin2.units.it>
	<jpgd0qz3vg4.fsf@linux.bootlegged.copy>
	<20181121125008.GV4755@habkost.net>
	<jpg4lc4iiav.fsf_-_@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jpg4lc4iiav.fsf_-_@linux.bootlegged.copy>
Subject: Re: [Qemu-devel] [PATCH] kvm: Use KVM_GET_MSR_INDEX_LIST for
 MSR_IA32_ARCH_CAPABILITIES support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, balducci@units.it, qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>, David Alan Gilbert <dgilbert@redhat.com>, Cole Robinson <crobinso@redhat.com>

On Sun, Nov 25, 2018 at 11:17:28PM -0500, Bandan Das wrote:
> 
> When writing to guest's MSR_IA32_ARCH_CAPABILITIES, check whether it's
> supported in the guest using the KVM_GET_MSR_INDEX_LIST ioctl.
> 
> Fixes: d86f963694df27f11b3681ffd225c9362de1b634
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Tested-by: balducci@units.it
> Signed-off-by: Bandan Das <bsd@redhat.com>

Thanks!  Queued for 3.1.

-- 
Eduardo
