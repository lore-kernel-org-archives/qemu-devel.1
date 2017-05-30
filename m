Received: from eggs.gnu.org ([2001:4830:134:3::10]:39757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnJ3-0006nC-7u
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnIz-0003xX-As
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:59:53 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFnIz-0003xP-7P
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:59:49 -0400
Received: by mail-qt0-x244.google.com with SMTP id l39so13693509qtb.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 12:59:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-4-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <561ef414-c293-f106-c65b-7f1051cbb202@twiddle.net>
Date: Tue, 30 May 2017 12:59:44 -0700
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-4-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/29] target/s390x: implement
 local-TLB-clearing in IPTE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/29/2017 12:24 PM, Aurelien Jarno wrote:
> And at the same time make IPTE SMP aware.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/helper.h     |  2 +-
>   target/s390x/mem_helper.c | 19 ++++++++++++-------
>   target/s390x/translate.c  |  6 +++++-
>   3 files changed, 18 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
