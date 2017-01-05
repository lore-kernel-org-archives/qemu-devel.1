Received: from eggs.gnu.org ([2001:4830:134:3::10]:58866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cP9x1-0002iC-Gx
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cP9wy-0004Jx-5O
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:27:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cP9wx-0004Jl-Uv
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:27:32 -0500
References: <1483628868-10496-1-git-send-email-nutarojj@ornl.gov>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0f3d6652-e633-c02e-7234-0d5b885d31ea@redhat.com>
Date: Thu, 5 Jan 2017 16:27:29 +0100
MIME-Version: 1.0
In-Reply-To: <1483628868-10496-1-git-send-email-nutarojj@ornl.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] qqq: module for synchronizing with a
 simulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "James J. Nutaro" <nutarojj@ornl.gov>, qemu-devel@nongnu.org



On 05/01/2017 16:07, James J. Nutaro wrote:
> This patch adds an interface for pacing the execution of QEMU to match an external
> simulation clock. Its aim is to permit QEMU to be used as a module within a
> larger simulation system.
> 
> Signed-off-by: James J. Nutaro <nutarojj@ornl.gov>

What's the difference between v5 and v6?

> +(2) Fork QEMU with the appropriate command line arguments.
> +    The -qqq part of the argument will look something like
> +
> +       -qqq sock=socks[1]

No need for -qqq, just make it "-icount extclock=FD".

Paolo
