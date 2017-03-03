Received: from eggs.gnu.org ([2001:4830:134:3::10]:36070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cjnYD-0005tK-Rd
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cjnYC-0004Q6-V7
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:47:17 -0500
Date: Fri, 3 Mar 2017 14:47:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170303134710.GD14351@noname.redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-9-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488491046-2549-9-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/15] sheepdog: Use SocketAddress and
 socket_connect()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com

Am 02.03.2017 um 22:43 hat Markus Armbruster geschrieben:
> sd_parse_uri() builds a string from host and port parts for
> inet_connect().  inet_connect() parses it into host, port and options.
> Whether this gets exactly the same host, port and no options for all
> inputs is not obvious.
> 
> Cut out the string middleman and build a SocketAddress for
> socket_connect() instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
