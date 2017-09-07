Received: from eggs.gnu.org ([2001:4830:134:3::10]:45618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpySp-0005C1-JJ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpySh-0003lW-VT
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:11:31 -0400
Date: Thu, 7 Sep 2017 17:11:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170907151101.GI4461@dhcp-200-186.str.redhat.com>
References: <20170804143658.23020-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170804143658.23020-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img: Clarify about relative
 backing file options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 04.08.2017 um 16:36 hat Fam Zheng geschrieben:
> It's not too surprising when a user specifies the backing file relative
> to the current working directory instead of the top layer image. This
> causes error when they differ. Though the error message has enough
> information to infer the fact about the misunderstanding, it is better
> if we document this explicitly, so that users don't have to learn from
> mistakes.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
