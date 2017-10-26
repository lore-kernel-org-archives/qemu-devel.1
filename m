Received: from eggs.gnu.org ([2001:4830:134:3::10]:50303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7nLI-0003fT-Pi
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 14:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7nLE-0004vV-U9
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 14:57:24 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:49648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7nLE-0004uv-OI
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 14:57:20 -0400
Received: by mail-qt0-x243.google.com with SMTP id k31so5622283qta.6
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 11:57:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171026135814.20773-1-richard.henderson@linaro.org>
	<20171026173758.GA2334@flamenco>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <163ef388-2b1f-21f3-5434-286eb8f3078d@amsat.org>
Date: Thu, 26 Oct 2017 15:57:11 -0300
MIME-Version: 1.0
In-Reply-To: <20171026173758.GA2334@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Avoid setting tcg_initialize if
 !CONFIG_TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, ehabkost@redhat.com

On 10/26/2017 02:37 PM, Emilio G. Cota wrote:
> AFAIK the only target that is so far supposed to work with
> --disable-tcg is i386. The configure script however lets you try to
> build without TCG if the host has an alternative accelerator (e.g. KVM),
> but that build is likely to fail. [ just confirmed this with aarch64 ]

What about s390x?

  LINK    s390x-softmmu/qemu-system-s390x
exec.o: In function `tlb_reset_dirty_range_all':
exec.c:1118: undefined reference to `tlb_reset_dirty'
exec.o: In function `tcg_commit':
exec.c:2765: undefined reference to `cpu_reloading_memory_map'
cpus.o: In function `tcg_cpu_exec':
cpus.c:1270: undefined reference to `cpu_exec'
cpus.o: In function `qemu_tcg_rr_cpu_thread_fn':
cpus.c:1310: undefined reference to `tcg_register_thread'
cpus.c:1375: undefined reference to `cpu_exec_step_atomic'
cpus.o: In function `qemu_tcg_cpu_thread_fn':
cpus.c:1458: undefined reference to `tcg_register_thread'
cpus.c:1492: undefined reference to `cpu_exec_step_atomic'
cpus.o: In function `qemu_tcg_init_vcpu':
cpus.c:1679: undefined reference to `tcg_region_init'
cpus.c:1689: undefined reference to `parallel_cpus'
target/s390x/cpu.o: In function `s390_cpu_class_init':
target/s390x/cpu.c:500: undefined reference to `s390x_translate_init'
collect2: error: ld returned 1 exit status
