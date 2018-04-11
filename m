Received: from eggs.gnu.org ([2001:4830:134:3::10]:38831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f63K8-0007W1-RD
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 20:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f63K7-0001lD-Oy
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 20:09:16 -0400
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:46228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f63K7-0001ko-J2
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 20:09:15 -0400
Received: by mail-pl0-x230.google.com with SMTP id 59-v6so36800plc.13
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 17:09:15 -0700 (PDT)
References: <1523377186-32578-1-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e863cce3-d06e-f225-eb25-212729c5f05f@linaro.org>
Date: Wed, 11 Apr 2018 10:08:58 +1000
MIME-Version: 1.0
In-Reply-To: <1523377186-32578-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/10] Avoid integer overflow in
 next_page_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On 04/11/2018 02:19 AM, Emilio G. Cota wrote:
> Richard pointed out in another thread that when computing
> next_page_start we can break checks for the last page in the
> address space due to integer overflow. This affects several targets;
> the appended fixes them.
> 
> You can fetch the patches from:
>   https://github.com/cota/qemu/tree/next_page_overflow

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
