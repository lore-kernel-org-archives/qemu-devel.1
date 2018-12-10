Received: from eggs.gnu.org ([2001:4830:134:3::10]:59274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWMwG-00065R-J1
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWMwC-0002MP-8u
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:53:40 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWMwC-0002Ld-1a
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:53:36 -0500
Received: by mail-ot1-x342.google.com with SMTP id e12so10623634otl.5
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 06:53:35 -0800 (PST)
References: <20181206175541.29508-1-richard.henderson@linaro.org>
	<20181206175541.29508-2-richard.henderson@linaro.org>
	<CAFEAcA9HSrGX2PR8DieF6Fa8x2fHk1xnnismNvcMpaSQ4U9dMA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ee87a667-c203-922d-fb28-726e70e74eda@linaro.org>
Date: Mon, 10 Dec 2018 08:53:31 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9HSrGX2PR8DieF6Fa8x2fHk1xnnismNvcMpaSQ4U9dMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] target/arm: Introduce
 arm_hcr_el2_eff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12/10/18 8:22 AM, Peter Maydell wrote:
> This section that clears VI/VF/VSE is new, and I'm not sure it's right.
> The spec says that the virtual IRQ interrupt is enabled only if {TGE,IMO}
> is {0,1}, but the meaning of the bit is "pending", and an interrupt
> can be pending without being enabled. Ditto VF, VSE.

Fair enough.  I can re-send with this section removed.


r~
