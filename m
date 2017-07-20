Received: from eggs.gnu.org ([2001:4830:134:3::10]:47320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY5qK-0000WL-Sl
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY5qG-0005gS-AO
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:25:52 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dY5qG-0005gE-5h
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:25:48 -0400
Received: by mail-qt0-x242.google.com with SMTP id n43so2349545qtc.4
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 00:25:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-18-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fa757582-7c8a-6418-d317-25c014083128@twiddle.net>
Date: Wed, 19 Jul 2017 21:25:41 -1000
MIME-Version: 1.0
In-Reply-To: <1500520169-23367-18-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 17/43] target/s390x: check CF_PARALLEL
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
>   target/s390x/helper.h     |  4 +++
>   target/s390x/mem_helper.c | 80 +++++++++++++++++++++++++++++++++++++----------
>   target/s390x/translate.c  | 26 ++++++++++++---
>   3 files changed, 88 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
