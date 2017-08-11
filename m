Received: from eggs.gnu.org ([2001:4830:134:3::10]:44821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dg9qj-0008QV-KO
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dg9qe-0004GN-KR
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:19:37 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:35246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dg9qe-0004Fr-EL
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:19:32 -0400
Received: by mail-pg0-x234.google.com with SMTP id v189so15561159pgd.2
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 06:19:32 -0700 (PDT)
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aa4c0874-4b1e-4208-a55f-1f922db8d9a3@linaro.org>
Date: Fri, 11 Aug 2017 06:19:28 -0700
MIME-Version: 1.0
In-Reply-To: <20170811074652.31474-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 4/5] target/s390x: remove all
 CONFIG_KVM from cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

On 08/11/2017 12:46 AM, David Hildenbrand wrote:
> Let's move everything into internal.h
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h      | 62 -------------------------------------------------
>  target/s390x/internal.h | 52 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 62 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
