Received: from eggs.gnu.org ([2001:4830:134:3::10]:41063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdmEU-0007xE-GL
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdmET-0006UW-Hh
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:10:02 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487086676-24339-1-git-send-email-armbru@redhat.com>
Date: Wed, 15 Feb 2017 00:09:52 +0100
In-Reply-To: <1487086676-24339-1-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Tue, 14 Feb 2017 16:37:54 +0100")
Message-ID: <87k28s5pz3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v2 0/2] block: Crude initial
 implementation of -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com

Markus Armbruster <armbru@redhat.com> writes:

> This is based on "[PATCH 00/24] QemuOpts util/cutils: Fix and clean up
> number conversions".
>
> v2: Support KEY=VALUE,... syntax as well.

Forgot to mention: the thing collapses when KEY has a type other than
string.  There's one reason this is marked RFC...
