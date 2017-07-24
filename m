Received: from eggs.gnu.org ([2001:4830:134:3::10]:40867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZcGn-0005cM-Uo
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZcGk-0007Of-Qf
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:15:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dZcGk-0007NP-KI
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:15:26 -0400
Date: Mon, 24 Jul 2017 14:15:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170724121523.GG4630@noname.str.redhat.com>
References: <1500449614-16811-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500449614-16811-1-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] error: Revert unwanted change of warning
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>

Am 19.07.2017 um 09:33 hat Markus Armbruster geschrieben:
> Commit 97f4030 changed warning messages from
> 
>     timestamp-if-enabled progname ":" location "warning: " message
> 
> to
> 
>     "warning: " timestamp-if-enabled progname ":" location message
> 
> This regressed qemu-iotests 051.  Put "warning: " right back where it
> was, along with "info: ".
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Cc: Alistair Francis <alistair.francis@xilinx.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
