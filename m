Received: from eggs.gnu.org ([2001:4830:134:3::10]:43523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjNRe-0007Hq-05
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjNRa-00039n-Sx
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:54:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cjNRa-00039S-Mi
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:54:42 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
	<1488435591-17882-6-git-send-email-mst@redhat.com>
	<87a894m72h.fsf@dusky.pond.sub.org>
	<15694a65-6ac4-9387-1cc2-89d5bb8660b9@redhat.com>
	<1987f7ea-6d16-c5c4-2ddb-cec3e18bd9f8@redhat.com>
Date: Thu, 02 Mar 2017 10:54:38 +0100
In-Reply-To: <1987f7ea-6d16-c5c4-2ddb-cec3e18bd9f8@redhat.com> (Laszlo Ersek's
	message of "Thu, 2 Mar 2017 09:37:57 +0100")
Message-ID: <877f48gg0x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 05/15] qmp/hmp: add query-vm-generation-id
 and 'info vm-generation-id' commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Ben Warren <ben@skyportsystems.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Laszlo Ersek <lersek@redhat.com> writes:

> On 03/02/17 09:25, Laszlo Ersek wrote:
>
> Regarding your other email ("New QMP command without a test -> automatic
> NAK"), Ben did write a small test suite for this feature:
>
> [Qemu-devel] [PATCH v8 7/8] tests: Add unit tests for the VM Generation
>                             ID feature
>
> and it contains a test called "/vmgenid/vmgenid/query-monitor".
>
> That patch is not part of the pull request because the functional tests
> in the same suite only pass if you have an updated SeaBIOS blob in the
> tree as well. While the SeaBIOS patches have been committed, the update
> for the blob bundled with QEMU is still in progress. Thus the patch with
> the tests is being delayed.

Posting the testing part that depends on in-progress work only as RFC
sounds like a perfectly acceptable case of the "not practical" exception
mentioned "New QMP command without a test -> automatic NAK".

> So, it wasn't negligence, we simply missed this failure case because we
> were so focused on the long-awaited functionality. We didn't miss other
> failure cases that were a bit closer to the functionality.
>
> BTW, now that I look at said "/vmgenid/vmgenid/query-monitor" test case,
> it also doesn't seem to catch this error -- the monitor command is
> apparently not called without the device present.

I expect you to try to cover all QMP command error cases with automated
tests.  I don't expect you to always succeed.  We're all human :)

>                                                   So yeah, review
> focused specifically on QMP / QAPI bits is always welcome.

It's a struggle, to be honest.  Bits of QMP and QAPI are often buried
deep in patches dealing with other stuff.  QMP can usually be separated
into its own patch, but QAPI is just infrastructure, it *wants* to be
used.
