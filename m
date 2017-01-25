Received: from eggs.gnu.org ([2001:4830:134:3::10]:41820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWMfI-0004Zl-7F
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWMfF-00075E-31
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:27:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cWMfE-000752-TJ
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:27:01 -0500
Date: Wed, 25 Jan 2017 20:26:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170125122655.GE9699@lemon.Home>
References: <CABn57gE5rBetw0Di1a0S7M3LJOs5BWLi940a1wS+gBtVZ0z39g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABn57gE5rBetw0Di1a0S7M3LJOs5BWLi940a1wS+gBtVZ0z39g@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu-img rebase working very slowly over NFS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Elaye Karstadt <elayeek@gmail.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com

On Wed, 01/25 08:35, Elaye Karstadt wrote:
> Two suggested solutions:
> 1. Before reading the old_backing and new_backing, one could call
> bdrv_is_allocated_above to check if a sector needs to be read (if a sector
> is not allocated in any file after new_backing, it can be assumed that it
> was not changed and need not be merged in the rebase?)

The rebase code is written such that it works even when moving an image from one
backing chain to another: reading and comparing data is simple and reliable for
that. But indeed your cases can be improved, just keep in mind any optimizations
for the specific "same chain" cases need to preserve the above property.

Fam
