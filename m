Received: from eggs.gnu.org ([2001:4830:134:3::10]:60251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erhgN-0006JC-Nv
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erhgM-0002Bm-St
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:12:55 -0500
Date: Fri, 2 Mar 2018 11:12:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180302111251.7fe22e84.cohuck@redhat.com>
In-Reply-To: <1519944838-12430-12-git-send-email-cota@braap.org>
References: <1519944838-12430-1-git-send-email-cota@braap.org>
	<1519944838-12430-12-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv1 11/14] target/s390x: convert to
 DisasContextBase
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

On Thu,  1 Mar 2018 17:53:55 -0500
"Emilio G. Cota" <cota@braap.org> wrote:

> Notes:
> 
> - Did not convert {num,max}_insns and is_jmp, since the corresponding
>   code will go away in the next patch.
> 
> - Avoided a checkpatch error in use_exit_tb.
> 
> - As suggested by David, (1) Drop ctx.pc and use
>   ctx.base.pc_next instead, and (2) Rename ctx.next_pc to
>   ctx.pc_tmp and add a comment about it.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/s390x/translate.c | 146 ++++++++++++++++++++++++-----------------------
>  1 file changed, 75 insertions(+), 71 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
