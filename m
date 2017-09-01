Received: from eggs.gnu.org ([2001:4830:134:3::10]:33357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnvCN-00008c-C2
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 19:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnvCI-0006v0-MG
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 19:18:03 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-30-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7704d989-2671-bb5e-1a1d-936512897702@redhat.com>
Date: Fri, 1 Sep 2017 19:17:44 -0400
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
Cc: Thomas Huth <thuth@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>, armbru@redhat.com, Alexander Graf <agraf@suse.de>, Keith Busch <keith.busch@intel.com>, "open list:sPAPR" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>



On 09/01/2017 02:03 PM, Eric Blake wrote:
> We already have another qtest_init() in the tree, for the
> top-level qtest.c device; having two functions with different
> signatures is confusing.  Rename the libqtest version to
> qtest_start() to eliminate the duplication.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Why not.

Reviewed-by: John Snow <jsnow@redhat.com>
