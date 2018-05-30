Received: from eggs.gnu.org ([2001:4830:134:3::10]:43137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO9rY-0001Ly-Fa
	for qemu-devel@nongnu.org; Wed, 30 May 2018 18:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO9rU-0007nR-K3
	for qemu-devel@nongnu.org; Wed, 30 May 2018 18:46:36 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fO9rU-0007n5-3Y
	for qemu-devel@nongnu.org; Wed, 30 May 2018 18:46:32 -0400
Received: by mail-pf0-x241.google.com with SMTP id w129-v6so9743935pfd.3
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 15:46:31 -0700 (PDT)
References: <1526945967-9687-1-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ff49bf54-3d5c-c2a4-95cd-3cb8c2efab51@linaro.org>
Date: Wed, 30 May 2018 15:46:27 -0700
MIME-Version: 1.0
In-Reply-To: <1526945967-9687-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/17] tcg: tb_lock removal redux v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 05/21/2018 04:39 PM, Emilio G. Cota wrote:
> v2: https://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg00656.html
> 
> Changes since v2:
> 
> - rebase onto master, fixing conflicts
> 
> - add R-b's
> 
> - add a missing page_lock to page_collection_lock
> 
> - add a couple of missing assert_page_locked assertions
> 
> - add page_lock_pair, as suggested by Alex and Richard
> 
> - use a per-thread GHashTable to keep track of locked pages
> 
> - get rid of page_collection assertions, and just export
>   assert_no_pages_locked() [Alex: I removed your R-b.]

Thanks.  Queued to tcg-next.


r~
