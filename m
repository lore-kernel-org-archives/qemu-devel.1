Received: from eggs.gnu.org ([2001:4830:134:3::10]:53299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gZx9q-0006yd-QU
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:10:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gZx9n-0005Hd-GF
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:10:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gZx9n-0005H0-8e
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:10:27 -0500
Date: Thu, 20 Dec 2018 10:10:18 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181220121018.GM19442@habkost.net>
References: <20181210190600.GK4669@habkost.net> <20181210194258.GD5482@zn.tnic>
	<20181210200843.GN4669@habkost.net>
	<20181211103839.GC921@redhat.com>
	<20181211115546.GQ4669@habkost.net>
	<e4d9a943-2de2-34a7-3f52-ee3d64ea889a@redhat.com>
	<20181211153017.GN921@redhat.com> <20181211161440.GG27375@zn.tnic>
	<20181212195235.GX7141@habkost.net> <20181212200803.GG6653@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212200803.GG6653@zn.tnic>
Subject: Re: [Qemu-devel] [PATCH -v2] target-i386: Reenable RDTSCP support
 on Opteron_G[345] CPU models CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Borislav Petkov <bp@alien8.de>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>, Andre Przywara <andre.przywara@arm.com>, kvm ML <kvm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On Wed, Dec 12, 2018 at 09:08:03PM +0100, Borislav Petkov wrote:
> On Wed, Dec 12, 2018 at 05:52:35PM -0200, Eduardo Habkost wrote:
> > Why did you remove this entry from PC_COMPAT_2_4?
> > 
> > We must keep compatibility with old behavior of Opteron_G2 on
> > pc-2.4, even if the old behavior was incorrect.
> 
> Ok, hunk reverted. v2 below.
> 
> Thx.
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> 
> The missing functionality was added ~3 years ago with the Linux commit
> 
>   46896c73c1a4 ("KVM: svm: add support for RDTSCP")
> 
> so reenable RDTSCP support on those CPU models.
> 
> Opteron_G2 - being family 15, model 6, doesn't have RDTSCP support
> (the real hardware doesn't have it. K8 got RDTSCP support with the NPT
> models, i.e., models >= 0x40).
> 
> Document the host's minimum required kernel version, while at it.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Queued, thanks.

-- 
Eduardo
