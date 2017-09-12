Received: from eggs.gnu.org ([2001:4830:134:3::10]:41212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drhCQ-0001Oy-Tk
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drhCM-00064c-Vt
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:09:42 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-17-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f7c5969c-38a6-89ec-6577-48b5067b68be@redhat.com>
Date: Tue, 12 Sep 2017 11:09:25 +0200
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
Cc: armbru@redhat.com, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

On 11.09.2017 19:20, Eric Blake wrote:
> Drop one more client of global_qtest by teaching all ahci test
> functionality to pass in an explicit QTestState.  The state was
> already available, so no callers had to be adjusted.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
