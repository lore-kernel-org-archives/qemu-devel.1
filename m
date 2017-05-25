Received: from eggs.gnu.org ([2001:4830:134:3::10]:49727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDgIl-0003Zy-AJ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDgIk-0006tf-6I
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:06:51 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDgIk-0006sv-2E
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:06:50 -0400
Received: by mail-qt0-x242.google.com with SMTP id a46so28348190qte.0
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 17:06:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170519091642.25309-1-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <dc999fde-d142-600f-632f-98726c651c8f@twiddle.net>
Date: Wed, 24 May 2017 17:06:45 -0700
MIME-Version: 1.0
In-Reply-To: <20170519091642.25309-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: use multiple CPU AddressSpaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: anthony.xu@intel.com

On 05/19/2017 02:16 AM, Paolo Bonzini wrote:
> This speeds up SMM switches.  Later on it may remove the need to take
> the BQL, and it may also allow to reuse code between TCG and KVM.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/cpu.c        | 15 +++++++++-----
>   target/i386/cpu.h        | 11 +++++++++-
>   target/i386/helper.c     | 54 ++++++++++++++++++++++++------------------------
>   target/i386/machine.c    |  4 ----
>   target/i386/smm_helper.c | 18 ----------------
>   5 files changed, 47 insertions(+), 55 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
