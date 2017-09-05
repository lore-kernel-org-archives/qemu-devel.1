Received: from eggs.gnu.org ([2001:4830:134:3::10]:40279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp7uD-0003Kk-Sj
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp7u9-0001lg-BI
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:04:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dp7u9-0001lN-5V
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:04:13 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-23-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a1f65bd1-6307-63bd-6404-7f3fbb49c81d@redhat.com>
Date: Tue, 5 Sep 2017 09:04:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-23-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 22/29] tests/boot-sector: Drop
 dependence on global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, armbru@redhat.com, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 01.09.2017 20:03, Eric Blake wrote:
> As a general rule, we prefer avoiding implicit global state
> because it makes code harder to safely copy and paste without
> thinking about the global state.  Adjust the helper code to
> use explicit state instead, and update all callers.
> 
> Fix some trailing whitespace while touching the file.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/boot-sector.h      | 6 ++++--
>  tests/bios-tables-test.c | 2 +-
>  tests/boot-sector.c      | 8 ++++----
>  tests/pxe-test.c         | 2 +-
>  tests/vmgenid-test.c     | 2 +-
>  5 files changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
