Received: from eggs.gnu.org ([2001:4830:134:3::10]:38845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpAhy-0000yL-TE
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpAhp-0001fA-3q
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:03:50 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-14-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d00055a9-5c4a-f639-6197-bd754416458b@redhat.com>
Date: Tue, 5 Sep 2017 12:03:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-14-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 13/29] libqos: Use explicit QTestState
 for pci operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Alexander Graf <agraf@suse.de>, "open list:sPAPR" <qemu-ppc@nongnu.org>, armbru@redhat.com, David Gibson <david@gibson.dropbear.id.au>

On 01.09.2017 20:03, Eric Blake wrote:
> Now that the QPCIBus tracks QTestState, use that state instead
> of an implicit reliance on global_qtest.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqos/pci-pc.c    | 47 ++++++++++++++++++++++++-----------------------
>  tests/libqos/pci-spapr.c | 20 ++++++++++----------
>  2 files changed, 34 insertions(+), 33 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
