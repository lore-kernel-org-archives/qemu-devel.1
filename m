Received: from eggs.gnu.org ([2001:4830:134:3::10]:50219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kcP-0003ce-JG
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kcO-0001S2-K3
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:10:53 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:42109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5kcO-0001RA-EA
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:10:52 -0400
Received: by mail-pl0-x243.google.com with SMTP id t20-v6so3727999ply.9
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 21:10:52 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-13-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4ab468cc-87ae-86e6-0c89-a6e1459c1b1f@linaro.org>
Date: Tue, 10 Apr 2018 14:10:45 +1000
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-13-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/17] target/s390x: convert to
 TranslatorOps
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
> Note: I looked into dropping dc->do_debug. However, I don't see
> an easy way to do it given that TOO_MANY is also valid
> when we just translate more than max_insns. Thus, the check
> for do_debug in "case DISAS_PC_CC_UPDATED" would still need
> additional state to know whether or not we came from
> breakpoint_check.
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Tested-by:   David Hildenbrand <david@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/s390x/translate.c | 162 +++++++++++++++++++++++------------------------
>  1 file changed, 80 insertions(+), 82 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
