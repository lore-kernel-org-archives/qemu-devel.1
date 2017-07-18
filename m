Received: from eggs.gnu.org ([2001:4830:134:3::10]:38003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXK2H-0003So-GG
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXK2E-00066y-Qj
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:23:01 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXK2E-00066e-KQ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:22:58 -0400
Received: by mail-pf0-x242.google.com with SMTP id o88so1228962pfk.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:22:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-40-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <08072997-a0d1-bf82-0903-002a8907091b@twiddle.net>
Date: Mon, 17 Jul 2017 18:22:52 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-40-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 39/45] osdep: move
 qemu_real_host_page_size/mask to osdep
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
> These only depend on the host and therefore belong in the common
> osdep, not in a target-dependent object.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   include/exec/cpu-all.h | 2 --
>   include/qemu/osdep.h   | 8 ++++++++
>   exec.c                 | 5 +----
>   util/osdep.c           | 9 +++++++++
>   4 files changed, 18 insertions(+), 6 deletions(-)

I do wonder if a new file in util/ with a constructor to init would be cleaner.

But, ok I guess,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
