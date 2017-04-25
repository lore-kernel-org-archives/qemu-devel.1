Received: from eggs.gnu.org ([2001:4830:134:3::10]:57239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yDS-0001oV-RI
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yDS-0001gE-0T
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:01:06 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
	<1493106839-10438-3-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <50bc6227-c967-5309-0fbd-96f71ea36979@twiddle.net>
Date: Tue, 25 Apr 2017 13:00:56 +0200
MIME-Version: 1.0
In-Reply-To: <1493106839-10438-3-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/13] exec-all: inline tb_from_jmp_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On 04/25/2017 09:53 AM, Emilio G. Cota wrote:
> The inline improves performance, as shown in upcoming commits' logs.
> 
> This commit is kept separate to ease review, since the inclusion
> of tb-hash.h might be controversial. The problem here, which was
> introduced before this commit, is that tb_hash_func() depends on
> page_addr_t: this defeats the original purpose of tb-hash.h,
> which was to be self-contained and CPU-agnostic.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   cpu-exec.c              | 19 -------------------
>   include/exec/exec-all.h | 24 +++++++++++++++++++++++-
>   2 files changed, 23 insertions(+), 20 deletions(-)

Is there a reason we should just inline this code directly into 
HELPER(lookup_tb_ptr)?  I think that would save a bit of churn, and I can't 
think of any other reason we'd want to use this function.


r~
