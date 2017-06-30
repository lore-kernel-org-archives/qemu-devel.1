Received: from eggs.gnu.org ([2001:4830:134:3::10]:46271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQrFZ-0005Pt-SY
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 04:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQrFV-0000Bn-Rz
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 04:26:01 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:36681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dQrFV-0000Az-L3
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 04:25:57 -0400
Received: by mail-qt0-x232.google.com with SMTP id i2so93261591qta.3
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 01:25:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4e66d79b-6455-58f6-83ce-0ada25d1cec4@twiddle.net>
Date: Fri, 30 Jun 2017 01:25:54 -0700
MIME-Version: 1.0
In-Reply-To: <1498768109-4092-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/7] tcg: parallel code generation (Work in
 Progress)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 06/29/2017 01:28 PM, Emilio G. Cota wrote:
> - Patches 2-3 remove *tbs[] to use a binary search tree instead.
>    This removes the assumption in tb_find_pc that *tbs[] are ordered
>    by tc_ptr, thereby allowing us to generate code regardless of
>    its location on the host (as we do after patch 6).

Have you considered a scheme by which the front end translation and tcg 
optimization are done outside the lock, but final code generation is done 
inside the lock?

It would put at least half of the translation time in the parallel space 
without requiring changes to code_buffer allocation.


r~
