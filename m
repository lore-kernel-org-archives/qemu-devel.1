Received: from eggs.gnu.org ([2001:4830:134:3::10]:46753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFxQ-0001mP-DA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFxN-0001WB-6d
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:01:44 -0400
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:33887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFxN-0001Vx-2p
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:01:41 -0400
Received: by mail-qk0-x233.google.com with SMTP id t2so1283654qkc.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:01:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-24-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1a55ca19-d092-4b91-90d0-cf2a194f4b87@twiddle.net>
Date: Mon, 17 Jul 2017 14:01:35 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-24-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 23/45] translate-all: define and use
 DEBUG_TB_FLUSH_GATE
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
> This gets rid of some ifdef checks while ensuring that the debug code
> is compiled, which prevents bit rot.
> 
> Suggested-by: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   accel/tcg/translate-all.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
