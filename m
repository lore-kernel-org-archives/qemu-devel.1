Received: from eggs.gnu.org ([2001:4830:134:3::10]:40241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFjV-0002qz-LE
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFjU-0007fJ-SX
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:47:21 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:35982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFjU-0007ex-OL
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:47:20 -0400
Received: by mail-qk0-x22a.google.com with SMTP id d136so3946242qkg.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:47:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-17-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <92ddfa33-899a-b0bd-5862-00df600cbe2c@twiddle.net>
Date: Mon, 17 Jul 2017 13:47:15 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-17-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 16/45] target/hppa: check CF_PARALLEL
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
>   target/hppa/helper.h    |  2 ++
>   target/hppa/op_helper.c | 32 ++++++++++++++++++++++++++++----
>   target/hppa/translate.c | 12 ++++++++++--
>   3 files changed, 40 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
