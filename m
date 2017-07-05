Received: from eggs.gnu.org ([2001:4830:134:3::10]:48766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSedo-0002ro-Fl
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSedn-0002Zc-J9
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:22:28 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-6-mreitz@redhat.com>
Date: Wed, 05 Jul 2017 09:22:18 +0200
In-Reply-To: <20170703122505.32017-6-mreitz@redhat.com> (Max Reitz's message
	of "Mon, 3 Jul 2017 14:25:05 +0200")
Message-ID: <87d19fe4b9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/5] tests: Add check-qobject for
 equality tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> Add a new test file (check-qobject.c) for unit tests that concern
> QObjects as a whole.
>
> Its only purpose for now is to test the qobject_is_equal() function.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

I'll review this one as soon as we made up our minds on what exactly
qnum_is_equal() should do.
