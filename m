Received: from eggs.gnu.org ([209.51.188.92]:45832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0hrr-0008Au-Tj
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0hrr-0001Rj-D1
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:18:31 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1551457277-884-1-git-send-email-thuth@redhat.com>
Date: Mon, 04 Mar 2019 08:18:25 +0100
In-Reply-To: <1551457277-884-1-git-send-email-thuth@redhat.com> (Thomas Huth's
	message of "Fri, 1 Mar 2019 17:21:17 +0100")
Message-ID: <87r2bncdku.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] tests: Do not use "\n" in g_test_message()
 strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> g_test_message() takes care of the newline on its own, so we
> should not use \n in the strings here.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Without "[PATCH] tests: Remove (mostly) useless architecture checks",
the patch misses four instances of '\n', so:

Based-on: <1551456970-463-1-git-send-email-thuth@redhat.com>
