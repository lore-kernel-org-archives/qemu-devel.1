Received: from eggs.gnu.org ([2001:4830:134:3::10]:37378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fToAa-0000TQ-Qa
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fToAa-0006Gq-7H
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:49:36 -0400
Date: Fri, 15 Jun 2018 14:49:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180615124931.GD5187@localhost.localdomain>
References: <20180614095544.31549-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614095544.31549-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] block: Remove deprecated -drive
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

Am 14.06.2018 um 11:55 hat Kevin Wolf geschrieben:
> We deprecated a bunch of -drive options in 2.10, so let's remove them
> for 3.0.
> 
> v2:
> - Simplified hd-geo-test code after removing test cases [Markus]
> - Split patch 3 and 4 so that the deprecation warning code can be easily
>   restored if we ever need it again [Markus]

Thanks for the review, applied to the block branch.

Kevin
