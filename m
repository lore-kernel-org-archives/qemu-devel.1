Received: from eggs.gnu.org ([2001:4830:134:3::10]:39992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXKEZ-0007cI-Im
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXKEV-00064H-MF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:35:43 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:36048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXKEV-00063X-FL
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:35:39 -0400
Received: by mail-pg0-x22f.google.com with SMTP id u5so5569770pgq.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:35:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-45-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6460761e-beb1-a293-a564-9f3719f25d75@twiddle.net>
Date: Mon, 17 Jul 2017 18:35:32 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-45-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 44/45] translate-all: do not allocate a
 guard page for code_gen_buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> TCG regions already have a guard page.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   accel/tcg/translate-all.c | 47 ++++++++++++-----------------------------------
>   1 file changed, 12 insertions(+), 35 deletions(-)

This should just be folded into the previous patch that creates TCG Regions.


r~
