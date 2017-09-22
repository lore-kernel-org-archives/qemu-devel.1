Received: from eggs.gnu.org ([2001:4830:134:3::10]:52274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dvL6o-0000Ze-TH
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dvL6o-00084S-0Q
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:22:58 -0400
Date: Fri, 22 Sep 2017 11:22:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170922102251.GH9243@stefanha-x1.localdomain>
References: <1505997152-16980-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505997152-16980-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH] migration: disable auto-converge during
 bulk block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, famz@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, qemu-stable@nongnu.org

On Thu, Sep 21, 2017 at 02:32:32PM +0200, Peter Lieven wrote:
> auto-converge and block migration currently do not play well together.
> During block migration the auto-converge logic detects that ram
> migration makes no progress and thus throttles down the vm until
> it nearly stalls completely. Avoid this by disabling the throttling
> logic during the bulk phase of the block migration.

Please include the rationale in a comment here:

> -        if (migrate_auto_converge()) {
> +        if (migrate_auto_converge() && !blk_mig_bulk_active()) {

That way it's clear why auto-converge isn't enabled when block migration
is active.
