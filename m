Received: from eggs.gnu.org ([2001:4830:134:3::10]:47945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZTrc-0001ov-LJ
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZTrZ-00008Z-Hr
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:16:56 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:38204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZTrZ-00008H-BB
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:16:53 -0400
Received: by mail-pf0-x243.google.com with SMTP id c23so9397313pfe.5
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 20:16:53 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170721125609.11117-1-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4a89b217-6d7b-af98-ceb8-379605e161e5@twiddle.net>
Date: Sun, 23 Jul 2017 20:16:49 -0700
MIME-Version: 1.0
In-Reply-To: <20170721125609.11117-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/6] target/s390x: tcg improvments + MSA
 functions
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

On 07/21/2017 05:56 AM, David Hildenbrand wrote:
> 1. smaller pgm irq instruction length fixes

I think maybe we should add insn length data to the unwind data, so that we can 
have env->int_pgm_ilen set to the right value whenever cpu_restore_state is called.


r~
