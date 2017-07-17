Received: from eggs.gnu.org ([2001:4830:134:3::10]:43343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFpk-00061r-HM
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFph-0003iZ-DD
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:53:48 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFph-0003iC-8F
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:53:45 -0400
Received: by mail-qt0-x243.google.com with SMTP id j25so656799qtf.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:53:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-20-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2055c8f9-cd12-9602-e8b9-72598012aa68@twiddle.net>
Date: Mon, 17 Jul 2017 13:53:40 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-20-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 19/45] target/s390x: check CF_PARALLEL
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

On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> Thereby decoupling the resulting translated code from the current state
> of the system.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>   target/s390x/helper.h     |  3 +++
>   target/s390x/mem_helper.c | 50 +++++++++++++++++++++++++++++++++++++++--------
>   target/s390x/translate.c  | 20 +++++++++++++++----
>   3 files changed, 61 insertions(+), 12 deletions(-)


Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
