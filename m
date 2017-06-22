Received: from eggs.gnu.org ([2001:4830:134:3::10]:39629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dO4VO-0003Qc-Gj
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dO4VL-0001OF-Ey
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:58:50 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dO4VL-0001O3-7i
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:58:47 -0400
Received: by mail-pg0-x242.google.com with SMTP id u62so2977961pgb.0
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 08:58:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170622094151.28633-1-david@redhat.com>
	<20170622094151.28633-2-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <dc5d3acf-6098-da2e-9b8a-e0226fb5e490@twiddle.net>
Date: Thu, 22 Jun 2017 08:58:42 -0700
MIME-Version: 1.0
In-Reply-To: <20170622094151.28633-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] target/s390x: Indicate and check
 for local tlb clearing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com

On 06/22/2017 02:41 AM, David Hildenbrand wrote:
> Let's allow to enable it for the qemu cpu model and correctly emulate
> it.
> 
> Signed-off-by: David Hildenbrand<david@redhat.com>
> ---
>   target/s390x/cpu_models.c | 1 +
>   target/s390x/mem_helper.c | 2 --
>   target/s390x/translate.c  | 6 +++++-
>   3 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
