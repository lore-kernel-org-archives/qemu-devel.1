Received: from eggs.gnu.org ([2001:4830:134:3::10]:52251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1clKiQ-0000qX-6V
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 14:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1clKiN-0006Qp-0E
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 14:24:10 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1clKiM-0006Qi-RL
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 14:24:06 -0500
Received: by mail-qk0-x241.google.com with SMTP id o135so3804002qke.2
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 11:24:06 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<20170307155054.5833-10-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5667f2bf-5314-94da-3451-87596434fd0e@twiddle.net>
Date: Wed, 8 Mar 2017 06:23:58 +1100
MIME-Version: 1.0
In-Reply-To: <20170307155054.5833-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 09/11] target-i386: defer VMEXIT to
 do_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Eduardo Habkost <ehabkost@redhat.com>

On 03/08/2017 02:50 AM, Alex Bennée wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>
> Paths through the softmmu code during code generation now need to be audited
> to check for double locking of tb_lock.  In particular, VMEXIT can take tb_lock
> through cpu_vmexit -> cpu_x86_update_cr4 -> tlb_flush.
>
> To avoid this, split VMEXIT delivery in two parts, similar to what is done with
> exceptions.  cpu_vmexit only records the VMEXIT exit code and information, and
> cc->do_interrupt can then deliver it when it is safe to take the lock.
>
> Reported-by: Alexander Boettcher <alexander.boettcher@genode-labs.com>
> Suggested-by: Richard Henderson <rth@twiddle.net>
> Tested-by: Alexander Boettcher <alexander.boettcher@genode-labs.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/i386/cpu.h        |  2 ++
>  target/i386/seg_helper.c | 20 +++++++++++---------
>  target/i386/svm_helper.c | 22 +++++++++++++---------
>  3 files changed, 26 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
