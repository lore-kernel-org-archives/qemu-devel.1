Received: from eggs.gnu.org ([2001:4830:134:3::10]:48266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ciHc5-0003xj-I0
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ciHc0-0005ns-Lk
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:29:01 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ciHc0-0005nd-Dr
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:28:56 -0500
Received: by mail-wr0-x244.google.com with SMTP id m5so3705697wrm.1
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 01:28:54 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1e54cf74-2ad1-7f26-27ba-fb662be92573@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c047f5b-eeb3-54ab-179e-8d981a81182a@redhat.com>
Date: Mon, 27 Feb 2017 10:28:51 +0100
MIME-Version: 1.0
In-Reply-To: <1e54cf74-2ad1-7f26-27ba-fb662be92573@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] exec: Respect as_tranlsate_internal length clamp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>



On 27/02/2017 06:53, Alexey Kardashevskiy wrote:
> There is a link to this one [1]:
> http://git.qemu-project.org/?p=qemu.git;a=commitdiff;h=c3c1bb99d1c11978d9ce94d1bdcf0705378c1459
> 
> Which was reverted with a sensible explanation [2]:
> http://git.qemu-project.org/?p=qemu.git;a=commitdiff;h=4025446f0ac6213335c22ec43f3c3d8362ce7286
> 
> However it is still in the tree as [3]:
> http://git.qemu-project.org/?p=qemu.git;a=commitdiff;h=23820dbfc79d1c9dce090b4c555994f2bb6a69b3
> 
> The only difference between [1] and [3] is a fixed typo in the subject,
> other than that they are identical.
> 
> Is not the explanation from [2] correct any more and [3] is a correct final
> fix? Or [3] should not be in the tree at all?

The explanation from [2] is correct, it caused "problems with boards
that declare memory regions shorter than the registers they contain" and
those were fixed.  Unfortunately I remember that the fixes were complex,
IIRC covering mostly ioport.c and Xen.  It might be fine for pSeries though.

Paolo
