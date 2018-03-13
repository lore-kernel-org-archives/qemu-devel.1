Received: from eggs.gnu.org ([2001:4830:134:3::10]:58474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evlGW-0000Xz-Hj
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evlGS-00006x-NE
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:51:00 -0400
Date: Tue, 13 Mar 2018 15:50:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180313145044.GC4642@localhost.localdomain>
References: <20180313142003.12124-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313142003.12124-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] block: Fix permission during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 13.03.2018 um 15:20 hat Fam Zheng geschrieben:
> v3: Fix test case. [Max]
> 
> v2: Use update_flags_from_options. [Kevin]
> 
> We write open the whole backing chain during reopen. It is not necessary and
> will cause image locking problems if the backing image is shared.

Thanks, applied to the block branch.

Kevin
