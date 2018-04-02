Received: from eggs.gnu.org ([2001:4830:134:3::10]:33188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f2p5H-0007Hh-Bu
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 22:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f2p5D-0006hE-4w
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 22:20:35 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:54098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f2p5C-0006fW-Ji
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 22:20:31 -0400
Received: by mail-wm0-f48.google.com with SMTP id p9so22850343wmc.3
	for <qemu-devel@nongnu.org>; Sun, 01 Apr 2018 19:20:29 -0700 (PDT)
References: <000001d3c9cf$19f0a190$4dd1e4b0$@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <29f1952e-325f-0a60-041c-fc651ae33fbb@redhat.com>
Date: Mon, 2 Apr 2018 04:20:24 +0200
MIME-Version: 1.0
In-Reply-To: <000001d3c9cf$19f0a190$4dd1e4b0$@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Debugging on HAXM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandro Sanchez Bach <alexaltea123@gmail.com>, qemu-devel@nongnu.org
Cc: 'Anthony Liguori' <aliguori@us.ibm.com>, 'Glauber Costa' <gcosta@redhat.com>, Yu Ning <yu.ning@linux.intel.com>

On 01/04/2018 17:35, Alexandro Sanchez Bach wrote:
> 
> I've noticed that `gdb_breakpoint_insert` only considers KVM so far. My
> question is: Has anyone planned adding debugging support to HAXM? Or is
> anyone actively working on QEMU's HAXM frontend at all? If not, I would like
> to work on it myself. Are there any guidelines or things I should take into
> consideration to work on this accelerator (pinging Anthony and Glauber)?

The main person working on HAXM is Yu Ning.  Anthony and Glauber are
only listed because they are the authors of the KVM support (and HAXM
support in turn is based on KVM).

> Would it be more reasonable to add debugging support to HAXM [1] directly
> instead of trying to use the existing APIs from QEMU to achieve the same
> thing  (I was thinking in patching memory, e.g. with `hlt` instructions, to
> trigger VM exits)?

That would probably be less "hackish", but harder too.  It would also
let you support singlestep and hardware breakpoints---they are often
better than software breakpoints for debugging if you can live with the
limit of four breakpoints.

Yu Ning, what do you think?

Paolo
