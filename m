Received: from eggs.gnu.org ([2001:4830:134:3::10]:42433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpDdT-0005qY-8k
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpDdL-00079w-LY
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:11:23 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-30-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3e70c2c4-3266-6cc7-3682-2cf3c2c61d42@redhat.com>
Date: Tue, 5 Sep 2017 15:10:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-30-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 29/29] libqtest: Rename qtest_init() to
 qtest_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:Floppy" <qemu-block@nongnu.org>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>, armbru@redhat.com, Alexander Graf <agraf@suse.de>, Keith Busch <keith.busch@intel.com>, "open list:sPAPR" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 01.09.2017 20:03, Eric Blake wrote:
> We already have another qtest_init() in the tree, for the
> top-level qtest.c device; having two functions with different
> signatures is confusing.  Rename the libqtest version to
> qtest_start() to eliminate the duplication.

This is too much code churn for my taste, and I also do not like the
idea of naming the function qtest_start() - since this was a function
with different semantics before your patch 28/29, so this will cause
confusion for all the people who are used to the old qtest_start()
function or who want to backport patches that have done after this
change to a code level before this change.

If you are really bugged by the qtest_init() name clash, I think it's
way easier if you rename the qtest_init() in the qtest.c file instead.

 Thomas
