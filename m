Received: from eggs.gnu.org ([2001:4830:134:3::10]:57121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0nnJ-0004pt-MI
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0nnI-0000Dm-T2
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:29:09 -0400
Date: Wed, 19 Apr 2017 19:28:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170419112859.GC14508@lemon.lan>
References: <20170401155751.14322-1-mreitz@redhat.com>
	<20170401155751.14322-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170401155751.14322-5-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [RFC for-3.0 4/4] block/qcow2-rust: Register block
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

On Sat, 04/01 17:57, Max Reitz wrote:
> +/* This is just for the module loading system to detect this driver */
> +static BlockDriver _ __attribute__((used)) = {
> +    .format_name = "qcow2-rust",
> +};

You see why I didn't like that system in the first place.

Fam
