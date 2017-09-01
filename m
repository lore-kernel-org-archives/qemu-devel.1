Received: from eggs.gnu.org ([2001:4830:134:3::10]:57368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnv1C-00036y-CS
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 19:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnv1B-0007sV-Ep
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 19:06:30 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-13-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2d7182a4-f425-f330-8b8f-d13982af6531@redhat.com>
Date: Fri, 1 Sep 2017 19:06:14 -0400
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-13-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 12/29] libqos: Track QTestState with
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
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>, armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>



On 09/01/2017 02:03 PM, Eric Blake wrote:
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
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
