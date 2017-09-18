Received: from eggs.gnu.org ([2001:4830:134:3::10]:56847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtsRS-0001tf-SG
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtsRS-0001TX-4i
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:34:14 -0400
Date: Mon, 18 Sep 2017 10:34:04 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170918093403.GB31063@stefanha-x1.localdomain>
References: <20170918052524.4045-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918052524.4045-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu.py: Fix syntax error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, apahim@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, armbru@redhat.com, crosa@redhat.com, qemu-devel@nongnu.org

On Mon, Sep 18, 2017 at 07:25:24AM +0200, Kevin Wolf wrote:
> Python requires parentheses around multiline expression. This fixes the
> breakage of all Python-based qemu-iotests cases that was introduced in
> commit dab91d9aa0.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
> 
> Eduardo, I think I'm going to include this patch in a block layer pull
> request today, just to stop the CI spam I'm getting, so the CC is just
> FYI.
> 
>  scripts/qemu.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
