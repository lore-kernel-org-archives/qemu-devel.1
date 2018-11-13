Received: from eggs.gnu.org ([2001:4830:134:3::10]:33577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gMVBl-0006GL-E3
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gMVBg-0006Wx-Bu
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:40:53 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181112104953.GB11580@linux.fritz.box>
	<f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
	<20181112160025.GE11580@linux.fritz.box>
	<b51dd4e4-e814-db42-86be-698c0d87f8ef@redhat.com>
Date: Tue, 13 Nov 2018 10:39:57 +0100
In-Reply-To: <b51dd4e4-e814-db42-86be-698c0d87f8ef@redhat.com> (Cleber Rosa's
	message of "Mon, 12 Nov 2018 12:36:33 -0500")
Message-ID: <875zx18geq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Acceptance tests for qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, Max Reitz <mreitz@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Drive-by comment...

Cleber Rosa <crosa@redhat.com> writes:

[...]
> My impression is that the "infrastructure for block tests" is not that
> different from the infrastructure needed by other tests, specially other
> QEMU tests.
[...]

Yes.  The actual reason for having a completely separate testing
infrastructure for block tests is that it predates testing
infrastructure for anything else.

Moving the tests to common infrastructure would be a sizable one-time
effort we can ill afford.  Maintaining multiple testing infrastructures
is an ongoing effort we can also ill afford.

Perhaps moving to common infrastructure is impractical.  I don't know.
What I do know is beware of temporal discounting.

[...]
