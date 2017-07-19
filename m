Received: from eggs.gnu.org ([2001:4830:134:3::10]:47916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXtMq-0005Fp-7F
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXtMp-0003gp-9E
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:06:36 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXtMp-0003gj-57
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:06:35 -0400
Received: by mail-qk0-x244.google.com with SMTP id u126so337062qka.0
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 11:06:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500468850-15571-1-git-send-email-thuth@redhat.com>
	<1500468850-15571-3-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cddd3b82-6cf3-1584-da8f-2ea4bac19eb5@twiddle.net>
Date: Wed, 19 Jul 2017 08:06:27 -1000
MIME-Version: 1.0
In-Reply-To: <1500468850-15571-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] target/s390x: Move
 s390_cpu_dump_state() to helper.c
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
> translate.c can not be compiled with --disable-tcg, but we need
> the s390_cpu_dump_state() in KVM-only builds, too. So let's move
> that function to helper.c instead, which will also be compiled
> when --disable-tcg has been specified.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   target/s390x/helper.c    | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
>   target/s390x/translate.c | 60 ------------------------------------------------
>   2 files changed, 60 insertions(+), 60 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
