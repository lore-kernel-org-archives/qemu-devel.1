Received: from eggs.gnu.org ([2001:4830:134:3::10]:48072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIqlH-0003af-00
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIqlD-0007TF-Qs
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:17:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIqlD-0007TA-Kr
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:17:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170608031124.8031-1-maozy.fnst@cn.fujitsu.com>
Date: Thu, 08 Jun 2017 08:17:30 +0200
In-Reply-To: <20170608031124.8031-1-maozy.fnst@cn.fujitsu.com> (Mao Zhongyi's
	message of "Thu, 8 Jun 2017 11:11:24 +0800")
Message-ID: <874lvrknph.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] util/qemu-sockets: Drop unused helper
 socket_address_to_string()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

socket_address_to_string() was added in commit 7e84495 "Change
net/socket.c to use socket_*() functions".  The commit was reverted
(commit 6160183), but the revert left in the helper.  It was then redone
(commit 883e4f7), and reverted again (commit 6701e55).  No other users
have emerged.  If they ever do, the helper is one git-revert away.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
