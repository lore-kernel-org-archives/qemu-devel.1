Received: from eggs.gnu.org ([209.51.188.92]:36151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gujIR-0003li-Fw
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gujIK-0001el-2p
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:37:11 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:34276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gujIB-0001Um-4m
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:37:04 -0500
Date: Fri, 15 Feb 2019 20:36:52 +0100
From: Sven Schnelle <svens@stackframe.org>
Message-ID: <20190215193651.GA19870@t470p.stackframe.org>
References: <20190214220453.15858-1-svens@stackframe.org>
	<65d59485-9973-4ed1-b08f-084ed4db7ef1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d59485-9973-4ed1-b08f-084ed4db7ef1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] lsi: implement basic SBCL functionality
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

On Fri, Feb 15, 2019 at 10:36:53AM +0100, Paolo Bonzini wrote:
> > HP-UX checks this register after sending data to the target. If there's no valid
> > information present, it assumes the client disconnected because the kernel sent
> > to much data. Implement at least some of the SBCL functionality that is possible
> > without having a real SCSI bus.
> > 
> > Signed-off-by: Sven Schnelle <svens@stackframe.org>
>  [..]
>
> This breaks live migration.  You need to bump the version number higher
> in vmstate_lsi_scsi and use "VMSTATE_UINT8_V(sbcl, LSIState, 1)" so that
> the field is only marshalled/unmarshalled for version 1 of the migration
> state.

Thanks, i wasn't aware of that. I'll send a revised v2.

Regards
Sven
