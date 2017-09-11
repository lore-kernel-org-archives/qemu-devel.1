Received: from eggs.gnu.org ([2001:4830:134:3::10]:56072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1drYX1-0007Ij-OL
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 19:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1drYX0-0000VD-Um
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 19:54:23 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-17-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <46e51e9e-aa23-5f0f-cdfb-c25dafdfe23d@redhat.com>
Date: Mon, 11 Sep 2017 19:54:15 -0400
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-17-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 16/38] libqos: Use explicit QTestState
 for ahci operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, armbru@redhat.com, "open list:IDE" <qemu-block@nongnu.org>



On 09/11/2017 01:20 PM, Eric Blake wrote:
> Drop one more client of global_qtest by teaching all ahci test
> functionality to pass in an explicit QTestState.  The state was
> already available, so no callers had to be adjusted.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

I should admit that this makes my urge to write a wrapper/macro increase
just a little bit, but ... admitting you have a problem is the first
step to recovery.

Reviewed-by: John Snow <jsnow@redhat.com>
