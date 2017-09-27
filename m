Received: from eggs.gnu.org ([2001:4830:134:3::10]:49285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dx8FV-0006kw-F5
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dx8FR-0006af-IJ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:03:21 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1506421996-12513-1-git-send-email-pl@kamp.de> (Peter Lieven's
	message of "Tue, 26 Sep 2017 12:33:16 +0200")
References: <1506421996-12513-1-git-send-email-pl@kamp.de>
Reply-To: quintela@redhat.com
Date: Wed, 27 Sep 2017 11:03:13 +0200
Message-ID: <87k20kbjji.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V3] migration: disable auto-converge during
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
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, qemu-stable@nongnu.org

Peter Lieven <pl@kamp.de> wrote:
> auto-converge and block migration currently do not play well together.
> During block migration the auto-converge logic detects that ram
> migration makes no progress and thus throttles down the vm until
> it nearly stalls completely. Avoid this by disabling the throttling
> logic during the bulk phase of the block migration.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>
