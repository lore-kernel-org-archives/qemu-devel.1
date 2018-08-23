Received: from eggs.gnu.org ([2001:4830:134:3::10]:42915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsksf-0003L6-EP
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsksa-0005rV-GW
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:22:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsksa-0005qj-7G
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:22:08 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <153496608036.29987.17320139395542439335.stgit@gimli.home> (Alex
	Williamson's message of "Wed, 22 Aug 2018 13:32:24 -0600")
References: <153496608036.29987.17320139395542439335.stgit@gimli.home>
Reply-To: quintela@redhat.com
Date: Thu, 23 Aug 2018 10:21:58 +0200
Message-ID: <87lg8xo5ll.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] postcopy: Synchronize usage of the balloon
 inhibitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, borntraeger@de.ibm.com, peter.maydell@linaro.org

Alex Williamson <alex.williamson@redhat.com> wrote:
> While the qemu_balloon_inhibit() interface appears rather general purpose,
> postcopy uses it in a last-caller-wins approach with no guarantee of balanced
> inhibits and de-inhibits.  Wrap postcopy's usage of the inhibitor to give it
> one vote overall, using the same last-caller-wins approach as previously
> implemented at the balloon level.
>
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Fixes: 01ccbec7bdf6 ("balloon: Allow multiple inhibit users")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

You can include it or I can include it on my next PULL.  But I "emptied"
my queue yesterday, so if you have anything to push, feel free to
include it.
