Received: from eggs.gnu.org ([2001:4830:134:3::10]:59915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpvfv-0006Mq-79
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpvfl-0001fM-Jq
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:12:51 -0400
Date: Thu, 7 Sep 2017 14:12:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170907121220.GE4461@dhcp-200-186.str.redhat.com>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
	<20170825132332.6734-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825132332.6734-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v3 2/7] block: add options parameter to
 bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 25.08.2017 um 15:23 hat Manos Pitsidianakis geschrieben:
> Allow passing a QDict *options parameter to bdrv_new_open_driver() so
> that it can be used if a driver needs it upon creation. The previous
> behaviour (empty bs->options and bs->explicit_options) remains when
> options is NULL.
> 
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
