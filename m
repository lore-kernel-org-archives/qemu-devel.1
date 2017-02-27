Received: from eggs.gnu.org ([2001:4830:134:3::10]:45134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1ciJOE-0007pM-T9
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1ciJOA-0001gQ-1W
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:22:50 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:37938 helo=tegan.suse.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1ciJO9-0001gJ-Rg
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:22:45 -0500
From: Eric Bischoff <ebischoff@suse.com>
Date: Mon, 27 Feb 2017 12:22:18 +0100
Message-Id: <20170227112219.29313-1-ebischoff@suse.com>
Subject: [Qemu-devel] [PATCH v2] Adding support for LPD and LPDG instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: Michal Marek <mmarek@suse.cz>, QEmu developers <qemu-devel@nongnu.org>, Miroslav Benes <mbenes@suse.cz>

Second version of the patch, setting CC to zero.
I am not too satisfied, I had to create a cout_zero() helper, but
I could not find a better solution.
