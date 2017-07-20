Received: from eggs.gnu.org ([2001:4830:134:3::10]:52874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY6FK-0002SM-2M
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY6FG-000569-Uc
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:51:42 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:37559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dY6FG-00054l-Pz
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:51:38 -0400
Received: by mail-qk0-x22a.google.com with SMTP id y126so10545584qke.4
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 00:51:38 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-41-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8e3deffa-1e36-4d1a-2f2d-30d8f07f7093@twiddle.net>
Date: Wed, 19 Jul 2017 21:51:32 -1000
MIME-Version: 1.0
In-Reply-To: <1500520169-23367-41-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 40/43] translate-all: use
 qemu_protect_rwx/none helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/19/2017 05:09 PM, Emilio G. Cota wrote:
> The helpers require the address and size to be page-aligned, so
> do that before calling them.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   accel/tcg/translate-all.c | 61 ++++++++++-------------------------------------
>   1 file changed, 13 insertions(+), 48 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
