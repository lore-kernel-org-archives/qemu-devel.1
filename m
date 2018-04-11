Received: from eggs.gnu.org ([2001:4830:134:3::10]:36018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f6HrW-0001Le-D5
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f6HrS-0003Yj-D7
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:40:42 -0400
Date: Wed, 11 Apr 2018 17:40:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180411174032.6582481b.cohuck@redhat.com>
In-Reply-To: <1523377186-32578-10-git-send-email-cota@braap.org>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
	<1523377186-32578-10-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/10] target/s390x: avoid integer overflow
 in next_page PC check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org

On Tue, 10 Apr 2018 12:19:45 -0400
"Emilio G. Cota" <cota@braap.org> wrote:

> If the PC is in the last page of the address space, next_page_start
> overflows to 0. Fix it.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/s390x/translate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
