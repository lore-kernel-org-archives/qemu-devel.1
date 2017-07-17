Received: from eggs.gnu.org ([2001:4830:134:3::10]:41570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXEfy-0006bb-0T
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXEfu-00018Y-Te
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:39:38 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:32862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXEfu-000188-Na
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:39:34 -0400
Received: by mail-qt0-x231.google.com with SMTP id n42so3016894qtn.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 15:39:34 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-8-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <462ff133-b2df-9df9-cced-02ed0f1f0206@twiddle.net>
Date: Mon, 17 Jul 2017 12:39:28 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-8-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/45] cpu-exec: rename have_tb_lock to
 acquired_tb_lock in tb_find
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
> Reusing the have_tb_lock name, which is also defined in translate-all.c,
> makes code reviewing unnecessarily harder.
> 
> Avoid potential confusion by renaming the local have_tb_lock variable
> to something else.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   accel/tcg/cpu-exec.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
