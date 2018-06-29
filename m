Received: from eggs.gnu.org ([2001:4830:134:3::10]:44629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYnXp-00021L-PA
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYnXo-00065u-VN
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:10:13 -0400
Date: Fri, 29 Jun 2018 09:10:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180629071003.GA4555@localhost.localdomain>
References: <20180626174119.25778-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626174119.25778-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] block/crypto: Simplify
 block_crypto_{open, create}_opts_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com

Am 26.06.2018 um 19:41 hat Markus Armbruster geschrieben:
> block_crypto_open_opts_init() and block_crypto_create_opts_init()
> contain a virtual visit of QCryptoBlockOptions and
> QCryptoBlockCreateOptions less member "format", respectively.
> 
> Change their callers to put member "format" in the QDict, so they can
> use the generated visitors for these types instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks, applied to the block branch.

Kevin
