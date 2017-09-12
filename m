Received: from eggs.gnu.org ([2001:4830:134:3::10]:37244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drfGo-0001sB-Pu
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drfGi-0003pj-W0
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:06:06 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-9-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0f14c31c-a1f2-7bed-e9fb-e8b7149b3867@redhat.com>
Date: Tue, 12 Sep 2017 09:05:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-9-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 08/38] libqos: Track QTestState with
 QPCIBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>

On 11.09.2017 19:19, Eric Blake wrote:
> When initializing a QPCIBus, track which QTestState the bus is
> associated with (so that a later patch can then explicitly use
> that test state for all communication on the bus, rather than
> blindly relying on global_qtest).  Update the initialization
> functions to take another parameter, and update all callers to
> pass in state (for now, most callers get away with passing the
> current global_qtest as the current state, although this required
> fixing the order of initialization to ensure qtest_start() is
> called before qpci_init*() in rtl8139-test, and provided an
> opportunity to pass in the allocator in e1000e-test).
> 
> Touch up some allocations to use g_new0() rather than g_malloc()
> while in the area, and simplify some code (all implementations
> of QOSOps provide a .init_allocator() that never fails).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
