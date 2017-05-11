Received: from eggs.gnu.org ([2001:4830:134:3::10]:34076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8rUx-0006Ts-O2
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8rUu-00006V-Lf
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:03:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8rUu-00004q-H2
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:03:28 -0400
Date: Thu, 11 May 2017 14:03:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170511170321.GF11869@thinpad.lan.raisama.net>
References: <20170405190024.27581-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170405190024.27581-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3 for 2.10] migration/i386 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, quintela@redhat.com

On Wed, Apr 05, 2017 at 08:00:21PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   This removes some qemu_get_ and qemu_put_ use from i386/machine.c
> and cleans out some very old code.
>   It breaks migration compatibility from prior to 0.12
> for i386 and prior to ~0.14 for non-softfloat - it doesn't alter the
> machine type, it just removes some old stream features.
> 
> (Has anyone got a good test of FP migration to make sure
> I've not broken the FP/mmx/etc cases?)
> 
> Dave

Queued, thanks.

-- 
Eduardo
