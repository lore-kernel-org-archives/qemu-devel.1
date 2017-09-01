Received: from eggs.gnu.org ([2001:4830:134:3::10]:57473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnv1W-0003IG-0H
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 19:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnv1V-00080B-1l
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 19:06:49 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-15-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6d3a0a60-ba74-9e6f-0099-a811fc4115e5@redhat.com>
Date: Fri, 1 Sep 2017 19:06:40 -0400
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-15-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 14/29] libqos: Use explicit QTestState
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
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>, armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>



On 09/01/2017 02:03 PM, Eric Blake wrote:
> Drop one more client of global_qtest by teaching all fw_cfg test
> functionality (invoked through alloc-pc) to pass in an explicit
> QTestState, adjusting all callers.  In particular, fw_cfg-test
> had to reorder things to create the test state prior to creating
> the fw_cfg.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
