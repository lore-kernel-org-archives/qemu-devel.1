Received: from eggs.gnu.org ([2001:4830:134:3::10]:42623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dS2Ke-0007h4-3K
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dS2Ka-0004lj-VU
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:28:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dS2Ka-0004kn-Ou
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:28:04 -0400
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
	<1499076743-15477-7-git-send-email-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9eed0ab9-f388-7daa-2e2a-4f891c973e0a@redhat.com>
Date: Mon, 3 Jul 2017 16:28:00 +0200
MIME-Version: 1.0
In-Reply-To: <1499076743-15477-7-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/15] kvmvapic: remove tcg related code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, rth@twiddle.net, thuth@redhat.com
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com, a.rigo@virtualopensystems.com



On 03/07/2017 12:12, Yang Zhong wrote:
> Since Paolo's below patch has fixed A20 issue
> commit bbfa326fc8028e275eddf8c9965c2a1b59405b2e
> target/i386: enable A20 automatically in system management mod

How is this patch related to kvmvapic?  It fixes a bug with vapic
disabled, but it's not a reason to disable kvmvapic.

Paolo

> The tcg code in kvmvapic.c is NOT useful, those code need remove.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  hw/i386/kvmvapic.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
