Received: from eggs.gnu.org ([2001:4830:134:3::10]:33537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAEQ8-0003Ez-II
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAEQ7-0007sQ-Jz
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:16:28 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:45334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAEQ7-0007rj-FP
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:16:27 -0400
Received: by mail-io0-x241.google.com with SMTP id i38so13466699iod.2
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 05:16:27 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <1e17a8cf-e81e-91ba-5656-e8e2dfa3baea@twiddle.net>
References: <201711021923504024201@zte.com.cn>
	<1e17a8cf-e81e-91ba-5656-e8e2dfa3baea@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Thu, 2 Nov 2017 09:16:26 -0300
Message-ID: <CAAdtpL7f7BW4Ta357GT_3nMhFSjrh0eFZpn+OvC8XOrw710dXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg/mips: make some functions inline.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>
Cc: Jiang Biao <jiang.biao2@zte.com.cn>, zhong.weidong@zte.com.cn, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Thu, Nov 2, 2017 at 8:43 AM, Richard Henderson <rth@twiddle.net> wrote:
> On 11/02/2017 12:23 PM, jiang.biao2@zte.com.cn wrote:
>> No, :) Just found some of these functions are inline and others are not when reading
>> the code, the style looks inconsistent.
>
> My preference would be to remove them all.

If more people agree to this we should add an entry in HACKING coding
guidelines (not sure about checkpatch).
