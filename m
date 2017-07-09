Received: from eggs.gnu.org ([2001:4830:134:3::10]:49917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIJr-00087T-03
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 15:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIJn-0007pB-3u
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 15:56:39 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUIJm-0007oe-Sn
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 15:56:35 -0400
Received: by mail-pg0-x241.google.com with SMTP id u36so10256803pgn.3
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 12:56:33 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-2-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d8cbc193-e944-eebf-6918-b270ad6fb107@twiddle.net>
Date: Sun, 9 Jul 2017 09:56:22 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/22] vl: fix breakage of -tb-size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:49 PM, Emilio G. Cota wrote:
> Commit e7b161d573 ("vl: add tcg_enabled() for tcg related code") adds
> a check to exit the program when !tcg_enabled() while parsing the -tb-size
> flag.
> 
> It turns out that when the -tb-size flag is evaluated, tcg_enabled() can
> only return 0, since it is set (or not) much later by configure_accelerator().
> 
> Fix it by unconditionally exiting if the flag is passed to a QEMU binary
> built with !CONFIG_TCG.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   vl.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
