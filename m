Received: from eggs.gnu.org ([2001:4830:134:3::10]:40858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f5qOY-0003f9-L6
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f5qOT-0003FO-KJ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:20:58 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:40310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f5qOT-0003Eo-E1
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:20:53 -0400
Received: by mail-wm0-f50.google.com with SMTP id x4so22279491wmh.5
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 03:20:53 -0700 (PDT)
References: <20180410101319.2519-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47f8e1b0-4e9c-9f73-cc22-c6ac0fe06cd4@redhat.com>
Date: Tue, 10 Apr 2018 12:20:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180410101319.2519-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12] icount: fix
 cpu_restore_state_from_tb for non-tb-exit cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: bonzini@redhat.com, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

On 10/04/2018 12:13, Richard Henderson wrote:
> In most cases new parameter is true (icount should be recalculated).
> But there are two cases in i386 and openrisc when the CPU state is only
> queried without the need to break the TB.  This patch fixes both of
> these cases.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> Message-Id: <20180409091320.12504.35329.stgit@pasha-VirtualBox>
> [rth: Make can_do_io setting unconditional; move from cpu_exec;
> make cpu_loop_exit_{noexc,restore} call cpu_loop_exit.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Looks good, thanks!

Paolo
