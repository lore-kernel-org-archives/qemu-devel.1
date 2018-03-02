Received: from eggs.gnu.org ([2001:4830:134:3::10]:60121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erhfq-0005yM-LI
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:12:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erhfp-00021T-P0
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:12:22 -0500
Date: Fri, 2 Mar 2018 11:12:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180302111201.35ec8e8e.cohuck@redhat.com>
In-Reply-To: <1519944838-12430-11-git-send-email-cota@braap.org>
References: <1519944838-12430-1-git-send-email-cota@braap.org>
	<1519944838-12430-11-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv1 10/14] target/s390x: convert to
 DisasJumpType
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

On Thu,  1 Mar 2018 17:53:54 -0500
"Emilio G. Cota" <cota@braap.org> wrote:

> The only non-trivial modification is the use of DISAS_TOO_MANY
> in the same way is used by the generic translation loop.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/s390x/translate.c | 1267 +++++++++++++++++++++++-----------------------
>  1 file changed, 632 insertions(+), 635 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
