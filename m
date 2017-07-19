Received: from eggs.gnu.org ([2001:4830:134:3::10]:48752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXtQz-00076o-CC
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXtQw-0005ff-7y
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:10:53 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXtQw-0005f7-2a
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:10:50 -0400
Received: by mail-qt0-x243.google.com with SMTP id l55so1142632qtl.3
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 11:10:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500468850-15571-1-git-send-email-thuth@redhat.com>
	<1500468850-15571-5-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <bae06049-3332-5047-6469-90430025ad27@twiddle.net>
Date: Wed, 19 Jul 2017 08:10:42 -1000
MIME-Version: 1.0
In-Reply-To: <1500468850-15571-5-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] target/s390x: Move exception-related
 functions to a new excp_helper.c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 07/19/2017 02:54 AM, Thomas Huth wrote:
> These functions can not be compiled with --disable-tcg. But since we
> need the other functions from helper.c in the non-tcg build, we can also
> not simply remove helper.c from the non-tcg builds. Thus the problematic
> functions have to be moved into a separate new file instead that we
> can later omit in the non-tcg builds.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   target/s390x/Makefile.objs               |   2 +-
>   target/s390x/cpu.h                       |   8 +
>   target/s390x/{helper.c => excp_helper.c} | 307 +-------------------
>   target/s390x/helper.c                    | 472 +------------------------------
>   4 files changed, 15 insertions(+), 774 deletions(-)
>   copy target/s390x/{helper.c => excp_helper.c} (67%)

Wow, git diff really made a mess out of that one.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
