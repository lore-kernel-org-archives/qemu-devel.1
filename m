Received: from eggs.gnu.org ([2001:4830:134:3::10]:55716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZKC4-00018P-CV
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZKC1-00013b-Bz
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:57:24 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZKC1-00013D-68
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:57:21 -0400
Received: by mail-pf0-x244.google.com with SMTP id 1so602854pfi.3
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 09:57:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500648359-25931-1-git-send-email-thuth@redhat.com>
	<1500648359-25931-5-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4dfd4434-e404-2ad6-d49d-50907f2b12a0@twiddle.net>
Date: Sun, 23 Jul 2017 06:57:18 -1000
MIME-Version: 1.0
In-Reply-To: <1500648359-25931-5-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] target/s390x: Move
 exception-related functions to a new excp_helper.c file
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

On 07/21/2017 04:45 AM, Thomas Huth wrote:
> These functions can not be compiled with --disable-tcg. But since we
> need the other functions from helper.c in the non-tcg build, we can also
> not simply remove helper.c from the non-tcg builds. Thus the problematic
> functions have to be moved into a separate new file instead that we
> can later omit in the non-tcg builds.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   target/s390x/Makefile.objs |   2 +-
>   target/s390x/cpu.h         |   8 +
>   target/s390x/excp_helper.c | 515 +++++++++++++++++++++++++++++++++++++++++++++
>   target/s390x/helper.c      | 472 +----------------------------------------
>   4 files changed, 528 insertions(+), 469 deletions(-)
>   create mode 100644 target/s390x/excp_helper.c

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
