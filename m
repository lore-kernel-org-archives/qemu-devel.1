Received: from eggs.gnu.org ([2001:4830:134:3::10]:36138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drgyc-0002Hg-0a
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drgyb-0005KP-83
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:55:26 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-14-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <409e4c1f-80f3-5548-c829-8f49edc3d4e7@redhat.com>
Date: Tue, 12 Sep 2017 10:55:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-14-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 13/38] libqos: Use explicit QTestState
 for fw_cfg operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:IDE" <qemu-block@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>

On 11.09.2017 19:19, Eric Blake wrote:
> Drop one more client of global_qtest by teaching all fw_cfg test
> functionality (invoked through alloc-pc) to pass in an explicit
> QTestState, adjusting all callers.  In particular, fw_cfg-test
> had to reorder things to create the test state prior to creating
> the fw_cfg (and drop a pointless strdup in the meantime), but that
> test now no longer depends on global_qtest.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
