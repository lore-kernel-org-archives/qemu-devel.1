Received: from eggs.gnu.org ([2001:4830:134:3::10]:39030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPh5i-0004Jk-4c
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPh5f-0006OL-0o
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:23:02 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPh5e-0006OB-RU
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:22:58 -0400
Received: by mail-qk0-x244.google.com with SMTP id r62so2496556qkf.3
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 20:22:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838119390.6497.17430428991952287717.stgit@frigg.lan>
	<87fuenxdh2.fsf@linaro.org> <878tke9al6.fsf@frigg.lan>
	<CAFEAcA99y-RL4KtXHmuotsXSRuthWNsmVC-f8WZV2Zc2LJtfUg@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <edfd8638-6c23-871d-8cbd-10fea7670a06@twiddle.net>
Date: Mon, 26 Jun 2017 20:22:53 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99y-RL4KtXHmuotsXSRuthWNsmVC-f8WZV2Zc2LJtfUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 04/26] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 06/26/2017 11:21 AM, Peter Maydell wrote:
> x86 definitely gets this totally wrong. I would be unsurprised
> to find that other variable-length-insn targets do too.

For x86, doing this optimally is difficult.  We *could* fix it simply by 
single-stepping when executing within the last 15 bytes of the page.


r~
