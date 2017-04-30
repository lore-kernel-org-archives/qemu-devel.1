Received: from eggs.gnu.org ([2001:4830:134:3::10]:44689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d4lvU-0006oE-2j
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 06:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d4lvP-0007YF-4q
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 06:18:00 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:32906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d4lvO-0007YB-UF
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 06:17:55 -0400
Received: by mail-wm0-x241.google.com with SMTP id y10so18971029wmh.0
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 03:17:54 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
References: <20170427120006.20564-1-rth@twiddle.net>
	<1493407045-24172-1-git-send-email-cota@braap.org>
	<1493407045-24172-3-git-send-email-cota@braap.org>
	<e0573fdf-b717-8e0a-5675-664b87b1dce3@twiddle.net>
Message-ID: <aa07bb47-a3c5-1245-7787-8f155bb94bce@twiddle.net>
Date: Sun, 30 Apr 2017 12:17:51 +0200
MIME-Version: 1.0
In-Reply-To: <e0573fdf-b717-8e0a-5675-664b87b1dce3@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 + 2/2] target/aarch64: optimize indirect
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

On 04/30/2017 11:47 AM, Richard Henderson wrote:
> These aarch64 patches fail for me like so:
> 
> $ ../bld/aarch64-softmmu/qemu-system-aarch64 -M virt -cpu cortex-a57 \
>      -m 1024 -nographic -kernel ./aarch64-linux-3.15rc2-buildroot.img \
>      -append console=ttyAMA0
> qemu-system-aarch64: /home/rth/work/qemu/qemu/cpu-exec.c:599: cpu_loop_exec_tb: 
> Assertion `use_icount' failed.

Bah.  Nevermind, this is my fault.


r~
