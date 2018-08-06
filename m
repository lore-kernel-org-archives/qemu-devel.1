Received: from eggs.gnu.org ([2001:4830:134:3::10]:35676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fmZXF-0001BE-6I
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 03:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fmZXC-000353-53
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 03:02:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fmZXB-00034x-U7
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 03:02:30 -0400
References: <20180806065344.7103-1-armbru@redhat.com>
	<20180806065344.7103-5-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <88dfc191-7e79-2a0e-e093-2e0474d83e7c@redhat.com>
Date: Mon, 6 Aug 2018 09:02:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180806065344.7103-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 04/23] libqtest: Remove
 qtest_qmp_discard_response() & friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org, eblake@redhat.com

On 08/06/2018 08:53 AM, Markus Armbruster wrote:
> qtest_qmp_discard_response(...) is shorthand for
> qobject_unref(qtest_qmp(...), except it's not actually shorter.
> Moreover, the presence of these functions encourage sloppy testing.
> Remove them from libqtest.  Add them as macros to the tests that use
> them, with a TODO comment asking for cleanup.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/ahci-test.c              |  3 +++
>  tests/boot-order-test.c        |  5 ++++-
>  tests/drive_del-test.c         |  3 +++
>  tests/fdc-test.c               |  4 ++++
>  tests/ide-test.c               |  5 ++++-
>  tests/libqtest.c               | 27 +--------------------------
>  tests/libqtest.h               | 27 ---------------------------
>  tests/migration-test.c         |  3 +++
>  tests/test-filter-mirror.c     |  4 ++++
>  tests/test-filter-redirector.c |  4 ++++
>  tests/virtio-blk-test.c        |  4 ++++
>  11 files changed, 34 insertions(+), 55 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
