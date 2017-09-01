Received: from eggs.gnu.org ([2001:4830:134:3::10]:32812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnvBO-0007xP-VS
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 19:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnvBN-00064Q-VZ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 19:17:02 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-29-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ff87af52-2137-072d-525e-4f293da89c16@redhat.com>
Date: Fri, 1 Sep 2017 19:16:47 -0400
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-29-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 28/29] libqtest: Remove qtest_start()
 and qtest_end() shortcuts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>, armbru@redhat.com, Alexander Graf <agraf@suse.de>, Keith Busch <keith.busch@intel.com>, "open list:sPAPR" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>



On 09/01/2017 02:03 PM, Eric Blake wrote:
> Remove the trivial wrappers qtest_start() and qtest_end(), to make
> it obvious in the rest of the testsuite where we are still relying on
> global_qtest.  Doing this makes it easier to see what remaining
> cleanups will be needed if we don't want an implicit dependency
> on global state.  Many tests can also take advantage of qtest_init()
> doing formatting of args, avoiding a temporary local variable.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

diffstat looks like a win overall, unless it's just a local minima ;)
