Received: from eggs.gnu.org ([2001:4830:134:3::10]:42531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gReln-0003WS-3o
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRelj-0004TH-Qw
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:55:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gRelh-0004L7-Ta
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:55:19 -0500
References: <1542049690-12826-1-git-send-email-thuth@redhat.com>
	<1542049690-12826-4-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f712cb49-323e-0790-4eaa-3808bbde6196@redhat.com>
Date: Tue, 27 Nov 2018 08:55:02 -0600
MIME-Version: 1.0
In-Reply-To: <1542049690-12826-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 3/7] ahci-test: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ben Warren <ben@skyportsystems.com>

On 11/12/18 1:08 PM, Thomas Huth wrote:
> From: Eric Blake <eblake@redhat.com>
> 
> Managing parallel connections to two different monitors via
> the implicit global_qtest makes it hard to copy-and-paste code
> to tests that are not aware of the implicit state; the
> management of global_qtest is even harder to follow because
> it was masked behind set_context().
> 
> Instead, explicitly pass QTestState* around (generally, by
> reusing the member already present in ahci->parent QOSState),
> and call explicit qtest_* functions on all places that
> interact with a monitor.
> 
> We can assert that the conversion is correct by checking that
> global_qtest remains NULL throughout the test (a later patch
> that changes global_qtest to not be a public global variable
> will drop the assertions).
> 
> Bonus: there was one spots that was creating a needless temporary
> variable to execute the 'cont' command, rather than just directly
> passing the literal command through qtest_qmp().  Fixing that
> gets us one step closer to enabling -Wformat checking on
> constructed JSON.

This paragraph is now stale, and can be deleted, thanks to commit 62fff696d.

> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> [thuth: rebased patch to current master branch]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/ahci-test.c     | 81 +++++++++++++++++++++++++--------------------------
>   tests/libqos/libqos.c |  9 ------
>   tests/libqos/libqos.h |  1 -
>   3 files changed, 39 insertions(+), 52 deletions(-)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
