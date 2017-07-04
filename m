Received: from eggs.gnu.org ([2001:4830:134:3::10]:53471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSIMO-0002e1-5Q
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSIMN-00072A-Er
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:35:00 -0400
Date: Tue, 4 Jul 2017 15:34:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170704073448.GF10298@lemon.lan>
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170703221456.30817-6-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/15] qcow2: Switch is_zero_sectors()
 to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr

On Mon, 07/03 17:14, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Convert another internal
> function (no semantic change), and rename it to is_zero() in the
> process.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
