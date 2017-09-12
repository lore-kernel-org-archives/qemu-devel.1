Received: from eggs.gnu.org ([2001:4830:134:3::10]:36550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1drZ7J-0002S3-31
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 20:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1drZ7I-0000Yt-CI
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 20:31:53 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-27-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5b23e7b5-b8f7-72c2-a7b7-73ba504abd06@redhat.com>
Date: Mon, 11 Sep 2017 20:31:36 -0400
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-27-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 26/38] libqtest: Merge qtest_end() into
 qtest_quit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, "open list:Floppy" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>, armbru@redhat.com, Alexander Graf <agraf@suse.de>, Keith Busch <keith.busch@intel.com>, "open list:sPAPR" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>



On 09/11/2017 01:20 PM, Eric Blake wrote:
> Rather than have two similar shutdown functions, where one requires
> the use of global_qtest in the header, it is better to have a single
> shutdown function that still takes care of cleaning up global_qtest
> if it is set.  All callers are updated.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.h               | 11 -----------
>  tests/libqtest.c               |  6 +++++-
[...]
>  tests/fdc-test.c               |  2 +-
[...]
>  tests/ide-test.c               |  2 +-

Reviewed-by: John Snow <jsnow@redhat.com>

The rest: "ACK." Change looks sane and I assume the rest of the patch is
fairly straightforward mechanical changes. Everything still compiles and
runs successfully.
