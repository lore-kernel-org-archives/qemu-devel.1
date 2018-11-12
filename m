Received: from eggs.gnu.org ([2001:4830:134:3::10]:44816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpa@zytor.com>) id 1gM5qI-0007Iv-Q1
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:37:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpa@zytor.com>) id 1gM5qD-0003FZ-PM
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:37:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45753 helo=mail.zytor.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpa@zytor.com>) id 1gM5qD-00039e-96
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:36:57 -0500
References: <1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
	<CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
	<c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
	<20181109072015.GA86700@gmail.com>
	<38905d35-29af-b522-1629-b13e98a47a42@intel.com>
	<d30b404d-624e-0497-879a-2d5df2eb9f31@suse.com>
	<b7b608dc-1743-5e1f-3b88-94d784c4cab2@intel.com>
	<d9c293bd-b43f-999c-55f1-3b90a6020065@zytor.com>
	<20181112045624.GA28219@gmail.com>
	<fcf1d6b5-e64f-3aea-f794-99237e1988cf@zytor.com>
	<20181112061940.GA61749@gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <766e1f84-b8c0-db95-45d3-e624c8d61519@zytor.com>
Date: Sun, 11 Nov 2018 22:36:27 -0800
MIME-Version: 1.0
In-Reply-To: <20181112061940.GA61749@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ingo Molnar <mingo@kernel.org>
Cc: Li Zhijian <zhijianx.li@intel.com>, Juergen Gross <jgross@suse.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, QEMU Developers <qemu-devel@nongnu.org>, Philip Li <philip.li@intel.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kees Cook <keescook@chromium.org>

On 11/11/18 10:19 PM, Ingo Molnar wrote:
> 
> I might be a bit dense early in the morning, but could you elaborate? 
> What do you mean by mapping all data areas?
> 

Heh. I need to pack for LPC and get some sleep before my flight lest I'll be
denser than depleted uranium; I'll write an explanation tomorrow.

	-hpa
