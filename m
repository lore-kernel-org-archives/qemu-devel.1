Received: from eggs.gnu.org ([2001:4830:134:3::10]:48194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kZe-0001yi-3X
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kZd-000868-6p
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:08:02 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:39030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5kZc-00085G-Uv
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:08:01 -0400
Received: by mail-pf0-x242.google.com with SMTP id c78so7160746pfj.6
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 21:08:00 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-12-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8a83af62-d376-c26c-8ce9-510f0039d010@linaro.org>
Date: Tue, 10 Apr 2018 14:07:53 +1000
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-12-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/17] target/s390x: convert to
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org

On 04/07/2018 04:19 AM, Emilio G. Cota wrote:
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
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reviewed-by:  David Hildenbrand <david@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/s390x/translate.c | 148 ++++++++++++++++++++++++-----------------------
>  1 file changed, 76 insertions(+), 72 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
