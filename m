Received: from eggs.gnu.org ([2001:4830:134:3::10]:53573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZf1Y-0005NL-5G
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZf1U-00061e-3g
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:11:56 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZf1T-00061X-V6
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:11:52 -0400
Received: by mail-qt0-x241.google.com with SMTP id d10so562028qtb.4
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 08:11:51 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500886370-14572-1-git-send-email-thuth@redhat.com>
	<1500886370-14572-4-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4c2db128-a700-177b-e7fd-29b020f30fd0@twiddle.net>
Date: Mon, 24 Jul 2017 08:11:48 -0700
MIME-Version: 1.0
In-Reply-To: <1500886370-14572-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/5] target/s390x: Rework
 program_interrupt() and related functions
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

On 07/24/2017 01:52 AM, Thomas Huth wrote:
> misc_helper.c won't be compiled with --disable-tcg anymore, but we
> still need the program_interrupt() function in that case. Move it
> to interrupt.c instead, and refactor it to re-use the code from
> trigger_pgm_exception() (for TCG) and enter_pgmcheck() (for KVM,
> which now got renamed to kvm_s390_program_interrupt() for
> clarity).
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   target/s390x/cpu.h         |  9 +++++----
>   target/s390x/helper.c      | 10 ----------
>   target/s390x/interrupt.c   | 39 +++++++++++++++++++++++++++++++++++++++
>   target/s390x/kvm.c         | 16 ++++++++--------
>   target/s390x/misc_helper.c | 26 --------------------------
>   5 files changed, 52 insertions(+), 48 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
