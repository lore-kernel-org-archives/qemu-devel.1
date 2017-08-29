Received: from eggs.gnu.org ([2001:4830:134:3::10]:39503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmkWt-00066k-KW
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmkWs-0001Nj-Mz
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:42:23 -0400
MIME-Version: 1.0
In-Reply-To: <20170829165058.8229-1-kchamart@redhat.com>
References: <20170829165058.8229-1-kchamart@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 29 Aug 2017 18:42:20 +0100
Message-ID: <CAJSP0QUSXyb8MNVf6Tq8hLgb2wVWLX6GVAPgG-mmrGCxAEOcXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] qemu-iotests: Extend
 non-shared storage migration test (194)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu block <qemu-block@nongnu.org>, Dave Gilbert <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Aug 29, 2017 at 5:50 PM, Kashyap Chamarthy <kchamart@redhat.com> wrote:
> This is the follow-up patch that was discussed[*] as part of feedback to
> qemu-iotest 194.
>
> Changes in this patch:
>
>   - Supply 'job-id' parameter to `drive-mirror` invocation.
>
>   - Once migration completes, issue QMP `block-job-cancel` command on
>     the source QEMU to gracefully complete `drive-mirror` operation.
>
>   - Once the BLOCK_JOB_COMPLETED event is emitted, stop the NBD server
>     on the destination QEMU.
>
>   - Check for both the events: MIGRATION and BLOCK_JOB_COMPLETED.
>
> With the above, the test will also be (almost) in sync with the
> procedure outlined in the document 'live-block-operations.rst'[+]
> (section: "QMP invocation for live storage migration with
> ``drive-mirror`` + NBD").
>
> [*] https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg04820.html
>     -- qemu-iotests: add 194 non-shared storage migration test
> [+] https://git.qemu.org/gitweb.cgi?p=qemu.git;a=blob;f=docs/interop/live-block-operations.rst
>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
> Changes in v3:
>  - Wait for migration to complete before issuing `block-job-cancel`
>    (StefanH)
>  - Wait for the event BLOCK_JOB_COMPLETED on the source before stopping
>    the NBD server on the destination (StefanH)
>
> Changes in v2:
>  - Check for both the events: MIGRATION and BLOCK_JOB_COMPLETED (EricB)
> ---
>  tests/qemu-iotests/194     | 23 +++++++++++++++++------
>  tests/qemu-iotests/194.out | 11 ++++++++---
>  2 files changed, 25 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
