Received: from eggs.gnu.org ([2001:4830:134:3::10]:49038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Cuu-0007hE-9x
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Cut-0007sA-Ht
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:18:40 -0400
Date: Thu, 20 Apr 2017 22:18:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170420141827.GN24486@lemon.lan>
References: <1492614962-20946-1-git-send-email-kwolf@redhat.com>
	<1492614962-20946-4-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492614962-20946-4-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qemu-iotests: Test postcopy
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, lvivier@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com

On Wed, 04/19 17:16, Kevin Wolf wrote:
> +_supported_fmt generic

This doesn't work for formats that install migration blockers, so maybe
s/generic/raw qcow2/ instead?

Fam
