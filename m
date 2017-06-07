Received: from eggs.gnu.org ([2001:4830:134:3::10]:34779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOvG-00051i-Hc
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOvD-0002qE-E9
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:34:06 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOvD-0002q9-9y
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:34:03 -0400
Received: by mail-qt0-x244.google.com with SMTP id o21so22866090qtb.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:34:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170604202034.16615-1-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a28be157-6dab-fda9-6180-21c8269ec720@twiddle.net>
Date: Tue, 6 Jun 2017 17:33:59 -0700
MIME-Version: 1.0
In-Reply-To: <20170604202034.16615-1-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/3] target/s390x: implement loads/store
 quadword
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

On 06/04/2017 01:20 PM, Aurelien Jarno wrote:
> This patchset implements the LOAD PAIR FROM QUADWORD and STORE PAIR TO
> QUADWORD instructions. The corresponding patches have been in my previous
> patchset and the pull request from Richard, but they failed to build on a
> host without atomic128 support.
> 
> This new version fixes that. It has to be applied over the pull request
> as it makes uses of the check_alignment function.
> 
> Finally the latest patch fixes a lack of alignement check in CDSG,
> discovered as I used it as an example about how to properly handle hosts
> without atomic128 support.
> 
> Aurelien Jarno (3):
>    target/s390x: implement LOAD PAIR FROM QUADWORD
>    target/s390x: implement STORE PAIR TO QUADWORD
>    target/s390x: check alignment in CDSG in the !CONFIG_ATOMIC128 case
> 
>   target/s390x/helper.h      |  2 ++
>   target/s390x/insn-data.def |  4 ++++
>   target/s390x/mem_helper.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>   target/s390x/translate.c   | 13 ++++++++++++
>   4 files changed, 72 insertions(+)
> 

Thanks.  Incorporated into my v2 pull.


r~
