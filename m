Received: from eggs.gnu.org ([2001:4830:134:3::10]:50504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTZlz-0004Yn-Cq
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTZlv-0006Hn-GV
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:50:27 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cTZlv-0006Gw-Cn
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:50:23 -0500
Received: by mail-qt0-x241.google.com with SMTP id f4so23945761qte.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 11:50:21 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-7-git-send-email-batuzovk@ispras.ru>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0b6d48ae-f5da-5209-14f7-80bcd5895fff@twiddle.net>
Date: Tue, 17 Jan 2017 11:50:17 -0800
MIME-Version: 1.0
In-Reply-To: <1484644078-21312-7-git-send-email-batuzovk@ispras.ru>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/18] tcg: allow globals to overlap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>

On 01/17/2017 01:07 AM, Kirill Batuzov wrote:
> Sometimes the target architecture may allow some parts of a register to be
> accessed as a different register. If both of these registers are
> implemented as globals in QEMU, then their content will overlap and the
> change to one global will also change the value of the other. To handle
> such situation properly, some fixes are needed in the register allocator
> and liveness analysis.

You need to handle the overlap during optimization as well.  Otherwise you'll 
propagate values that you shouldn't.


r~
