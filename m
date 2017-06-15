Received: from eggs.gnu.org ([2001:4830:134:3::10]:59530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLcKv-00049N-BC
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLcKr-0002dZ-B0
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:29:53 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:33849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLcKr-0002dJ-6L
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:29:49 -0400
Received: by mail-qt0-x229.google.com with SMTP id c10so38351661qtd.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 14:29:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-4-rth@twiddle.net>
	<20170615211920.c7y2xaixy6tm2fan@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <bc5ee3d0-2e00-6b54-8f42-d36f5cde516b@twiddle.net>
Date: Thu, 15 Jun 2017 14:29:45 -0700
MIME-Version: 1.0
In-Reply-To: <20170615211920.c7y2xaixy6tm2fan@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/5] target/mips: Exit after enabling
 interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, cota@braap.org, pbonzini@redhat.com, Yongbok Kim <yongbok.kim@imgtec.com>

On 06/15/2017 02:19 PM, Aurelien Jarno wrote:
> While the above looks correct, it's not complete. It only fixes the
> microMIPS EI instruction. The MIPS one also has to be fixed.
> 
> For what I understood, anything that can change the result of
> cpu_mips_hw_interrupts_enabled has to stop the translation. In that case
> I checked that ERET/ERETNC and MTC0/DMTC0 to the Status register are
> already correct, that said it might be a good idea to update the
> comments to mention it.
> 
> I can work on a better patch, but I doubt I'll have time before the
> week-end.

Ok, I'll drop this one for now.  It's not urgent.


r~
