Received: from eggs.gnu.org ([2001:4830:134:3::10]:33581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDOTN-0002SE-2K
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDOT7-0003eg-FA
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:41:17 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:36628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDOT3-0003VY-ID
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:41:07 -0400
Received: by mail-pl1-x630.google.com with SMTP id y11-v6so15431060plt.3
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 23:41:05 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-7-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2c056a84-4555-17f2-f1a4-729a8be50f87@linaro.org>
Date: Thu, 18 Oct 2018 23:41:01 -0700
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-7-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 06/56] cpu: introduce
 process_queued_cpu_work_locked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 10/18/18 6:05 PM, Emilio G. Cota wrote:
> It will gain a user once we protect more of CPUState under cpu->lock.
> 
> This completes the conversion to cpu_mutex_lock/unlock in the file.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h |  9 +++++++++
>  cpus-common.c     | 17 +++++++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
