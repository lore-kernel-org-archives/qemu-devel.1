Received: from eggs.gnu.org ([2001:4830:134:3::10]:47027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY5oZ-0007Js-KQ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY5oV-00044c-1e
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:24:03 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:33808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dY5oU-00043v-SH
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:23:58 -0400
Received: by mail-qt0-x234.google.com with SMTP id 32so15583654qtv.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 00:23:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-17-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <db7c6c01-a5d6-d53c-8651-69f0dfafc469@twiddle.net>
Date: Wed, 19 Jul 2017 21:23:52 -1000
MIME-Version: 1.0
In-Reply-To: <1500520169-23367-17-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 16/43] target/m68k: check CF_PARALLEL
 instead of parallel_cpus
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
> Thereby decoupling the resulting translated code from the current state
> of the system.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   target/m68k/helper.h    |  1 +
>   target/m68k/op_helper.c | 33 ++++++++++++++++++++-------------
>   target/m68k/translate.c | 12 ++++++++++--
>   3 files changed, 31 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
