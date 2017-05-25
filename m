Received: from eggs.gnu.org ([2001:4830:134:3::10]:37622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDnCo-00040x-Pq
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDnCl-0002fD-SB
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:29:10 -0400
Date: Thu, 25 May 2017 15:28:58 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170525072858.GA8487@lemon.lan>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-18-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511144208.24075-18-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/18] block: introduce block_account_one_io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-block@nongnu.org

On Thu, 05/11 16:42, Paolo Bonzini wrote:
> -void block_acct_done(BlockAcctStats *stats, BlockAcctCookie *cookie)
> +static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie, bool failed)

This line is too long. Can be fixed when applying, though.

Fam
