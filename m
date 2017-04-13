Received: from eggs.gnu.org ([2001:4830:134:3::10]:45820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cyli4-0001RT-Bo
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cyli0-00076M-9F
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:51:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cyli0-00074q-3a
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:51:16 -0400
Date: Thu, 13 Apr 2017 17:51:10 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170413205110.GB4376@thinpad.lan.raisama.net>
References: <20170405190024.27581-1-dgilbert@redhat.com>
	<20170405190024.27581-4-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170405190024.27581-4-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] migration/i386: Remove support for
 pre-0.12 formats
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

On Wed, Apr 05, 2017 at 08:00:24PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Remove support for versions of the CPU state prior to 11
> which is the version used in qemu 0.12 - you'd be pretty
> lucky if you got a migration stream to work from anything
> that old anyway.  This doesn't affect the machine type
> definition in any way.
> 
> My main reason for doing this is the hack for sysenter_esp/eip
> that uses .get/.put's in state versions less than 7 (that's
> prior to somewhere before 0.10).
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Nice!

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
