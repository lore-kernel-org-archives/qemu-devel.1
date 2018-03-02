Received: from eggs.gnu.org ([2001:4830:134:3::10]:60376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erhhC-0006m4-RR
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erhh9-0002Pa-Cy
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:13:46 -0500
Date: Fri, 2 Mar 2018 11:13:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180302111339.2f1f2ba6.cohuck@redhat.com>
In-Reply-To: <1519944838-12430-13-git-send-email-cota@braap.org>
References: <1519944838-12430-1-git-send-email-cota@braap.org>
	<1519944838-12430-13-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv1 12/14] target/s390x: convert to
 TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org

On Thu,  1 Mar 2018 17:53:56 -0500
"Emilio G. Cota" <cota@braap.org> wrote:

> Note: I looked into dropping dc->do_debug. However, I don't see
> an easy way to do it given that TOO_MANY is also valid
> when we just translate more than max_insns. Thus, the check
> for do_debug in "case DISAS_PC_CC_UPDATED" would still need
> additional state to know whether or not we came from
> breakpoint_check.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/s390x/translate.c | 162 +++++++++++++++++++++++------------------------
>  1 file changed, 80 insertions(+), 82 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
