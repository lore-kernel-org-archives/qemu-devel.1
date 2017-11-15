Received: from eggs.gnu.org ([2001:4830:134:3::10]:57189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eEtR8-0008Nq-W1
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 03:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eEtR8-00039t-4z
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 03:52:47 -0500
Date: Wed, 15 Nov 2017 09:52:33 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171115085233.jceusmntibwoolli@eukaryote>
References: <20171114191605.22349-1-kchamart@redhat.com>
	<151068761850.402.4003752939306427653@bafd83ae6430>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151068761850.402.4003752939306427653@bafd83ae6430>
Subject: Re: [Qemu-devel] [PATCH] qapi: block-core: Clarify events emitted
 by 'block-job-cancel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com

On Tue, Nov 14, 2017 at 11:26:59AM -0800, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.

[...]

> In file included from /tmp/qemu-test/src/qapi-schema.json:85:
> In file included from /tmp/qemu-test/src/qapi/block.json:7:
> /tmp/qemu-test/src/qapi/block-core.json:2081:1: '@device:' can't follow 'Note' section

Hmm, I don't know the syntax enough to see why the 'Note' section is not
allowed.  But it's not strictly needed at all.  So I'll just do:

    s/Note:/It is worth noting/

> make: *** [qapi-visit.h] Error 1
> make: *** Deleting file `qapi-visit.h'
> make: *** Waiting for unfinished jobs....

[...]

-- 
/kashyap
