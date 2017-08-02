Received: from eggs.gnu.org ([2001:4830:134:3::10]:42015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dcv8H-0003h6-Ts
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dcv8C-0004iu-Vq
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:00:21 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dcv8C-0004hP-P2
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:00:16 -0400
Received: by mail-pf0-x242.google.com with SMTP id j68so5476012pfc.2
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 08:00:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <cover.7fbcecb0d0061824a32985f26b9c1b7f816203b0.1501667615.git-series.james.hogan@imgtec.com>
	<753c3960fd4ad5ca5c8ccea15d2c7f6fb95dc25d.1501667615.git-series.james.hogan@imgtec.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9860940e-126d-d9bf-dead-ea61b773fde8@twiddle.net>
Date: Wed, 2 Aug 2017 08:00:10 -0700
MIME-Version: 1.0
In-Reply-To: <753c3960fd4ad5ca5c8ccea15d2c7f6fb95dc25d.1501667615.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/3] target/mips: Use BS_EXCP
 where interrupts are expected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hogan <james.hogan@imgtec.com>, qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

On 08/02/2017 02:59 AM, James Hogan wrote:
> Commit e350d8ca3ac7 ("target/mips: optimize indirect branches") made
> indirect branches able to directly find the next TB and jump straight to
> it without breaking out of translated code and going around the main
> execution loop. This breaks the assumption in target/mips/translate.c
> that BS_STOP is sufficient to cause pending interrupts to be handled,
> since interrupts are only checked in the main loop.
> 
> Fix a few of these assumptions by using gen_save_pc to update the saved
> PC and using BS_EXCP instead of BS_STOP:

I don't like the name, BS_EXCP, because this isn't an exception.

But, since one of the first things we'll do in 2.11 is land LLuis' generic 
translation framework, and rename all of these exit conditions, this is ok.  It 
certainly is the minimal change for 2.10, and this does work.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
