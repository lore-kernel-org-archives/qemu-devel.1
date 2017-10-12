Received: from eggs.gnu.org ([2001:4830:134:3::10]:53088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2gO4-000843-BH
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2gNy-0002WJ-SR
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:31:08 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:52135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e2gNy-0002Vw-LJ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:31:02 -0400
Received: by mail-pf0-x22e.google.com with SMTP id n14so5576409pfh.8
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 09:31:02 -0700 (PDT)
References: <20171012143548.18581-1-pbonzini@redhat.com>
	<20171012143548.18581-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9bc851d4-1064-c26c-e6f8-09d2655255eb@linaro.org>
Date: Thu, 12 Oct 2017 09:30:58 -0700
MIME-Version: 1.0
In-Reply-To: <20171012143548.18581-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] target/i386: introduce x86_ld*_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 10/12/2017 07:35 AM, Paolo Bonzini wrote:
> These take care of advancing s->pc, and will provide a unified point
> where to check for the 15-byte instruction length limit.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/translate.c | 228 ++++++++++++++++++++++++++----------------------
>  1 file changed, 125 insertions(+), 103 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
