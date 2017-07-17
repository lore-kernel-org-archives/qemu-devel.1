Received: from eggs.gnu.org ([2001:4830:134:3::10]:40093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFjH-0002hy-3d
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFjD-0007Tw-7I
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:47:07 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:33991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFjD-0007TV-3V
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:47:03 -0400
Received: by mail-qt0-x234.google.com with SMTP id 32so3854103qtv.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:47:02 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-16-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9562b451-29bf-2cd1-b9f7-67c1bc093cc1@twiddle.net>
Date: Mon, 17 Jul 2017 13:46:58 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-16-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/45] target/arm: check CF_PARALLEL
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

On 07/16/2017 10:03 AM, Emilio G. Cota wrote:
> Thereby decoupling the resulting translated code from the current state
> of the system.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   target/arm/helper-a64.h    |  4 ++++
>   target/arm/helper-a64.c    | 38 ++++++++++++++++++++++++++++++++------
>   target/arm/op_helper.c     |  7 -------
>   target/arm/translate-a64.c | 31 +++++++++++++++++++++++++------
>   target/arm/translate.c     |  9 +++++++--
>   5 files changed, 68 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
