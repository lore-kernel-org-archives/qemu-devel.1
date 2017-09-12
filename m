Received: from eggs.gnu.org ([2001:4830:134:3::10]:48401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drhWb-0000Rc-3l
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drhWa-0008RS-B2
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:30:33 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-27-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <677602b8-99a2-4117-c0ee-72a752d588f8@redhat.com>
Date: Tue, 12 Sep 2017 11:30:10 +0200
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
Cc: armbru@redhat.com, pbonzini@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, Keith Busch <keith.busch@intel.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>

On 11.09.2017 19:20, Eric Blake wrote:
> Rather than have two similar shutdown functions, where one requires
> the use of global_qtest in the header, it is better to have a single
> shutdown function that still takes care of cleaning up global_qtest
> if it is set.  All callers are updated.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
