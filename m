Received: from eggs.gnu.org ([2001:4830:134:3::10]:48203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQspI-0001td-VB
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:39:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQspD-00088J-EH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:39:17 -0500
References: <20171218100404.4427-1-david@gibson.dropbear.id.au>
	<20171218100404.4427-5-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <104d1207-1d34-a3a6-3913-d9ca20f09e19@redhat.com>
Date: Mon, 18 Dec 2017 11:39:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171218100404.4427-5-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 4/4] tests/pxe-test: Add some extra tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, mst@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 18.12.2017 11:04, David Gibson wrote:
> Previously virtio-net was only tested for ppc64 in "slow" mode.  That
> doesn't make much sense since virtio-net is used much more often in
> practice than the spapr-vlan device which was tested always.  So, move
> virtio-net to always be tested on ppc64.

Assuming that the "Use tcg_gen_lookup_and_goto_ptr" patch and Paolo's
"optimize cmp translation" will give us enough speed-up in TCG mode:

Reviewed-by: Thomas Huth <thuth@redhat.com>
