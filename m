Received: from eggs.gnu.org ([2001:4830:134:3::10]:58081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1drYeF-0000sp-5v
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 20:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1drYeE-0004xD-CP
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 20:01:51 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-18-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <487f96ab-d6d9-efd0-436f-cb67e7dfbe77@redhat.com>
Date: Mon, 11 Sep 2017 20:01:38 -0400
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-18-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 17/38] libqos: Use explicit QTestState
 for remaining libqos operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, "open list:IDE" <qemu-block@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Jason Wang <jasowang@redhat.com>, armbru@redhat.com, Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>



On 09/11/2017 01:20 PM, Eric Blake wrote:
> Drop one more client of global_qtest by teaching all remaining
> libqos stragglers to pass in an explicit QTestState.  Change the
> setting of global_qtest from being implicit in libqos' call to
> qtest_start() to instead be explicit in all clients that are
> still relying on global_qtest.
> 
> Note that qmp_execute() can be greatly simplified in the process,
> and that we also get rid of interpolation of a JSON string into a
> temporary variable when qtest_qmp() can do it more reliably.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: John Snow <jsnow@redhat.com>
