Received: from eggs.gnu.org ([2001:4830:134:3::10]:48315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFyx-0002mb-7k
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFys-0002Zd-Jy
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:03:19 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFys-0002ZF-Fj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:03:14 -0400
Received: by mail-qk0-x242.google.com with SMTP id d136so626575qkg.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:03:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-27-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c2a18f7c-23f3-5e1e-1fe2-6d6ba59b04fd@twiddle.net>
Date: Mon, 17 Jul 2017 14:03:09 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-27-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 26/45] translate-all: define and use
 DEBUG_TB_CHECK_GATE
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
> This prevents bit rot by ensuring the debug code is compiled when
> building a user-mode target.
> 
> Unfortunately the helpers are user-mode-only so we cannot fully
> get rid of the ifdef checks. Add a comment to explain this.
> 
> Suggested-by: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   accel/tcg/translate-all.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
