Received: from eggs.gnu.org ([2001:4830:134:3::10]:42630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d85ut-0000N3-Hc
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d85up-00037U-2l
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:15:07 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d85uo-00037G-Um
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:15:03 -0400
Received: by mail-qk0-x244.google.com with SMTP id k74so268333qke.2
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 07:15:02 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170509082800.10756-1-aurelien@aurel32.net>
	<20170509082800.10756-3-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b0f73425-7721-4b5e-7862-d753f3ee6bfa@twiddle.net>
Date: Tue, 9 May 2017 07:14:59 -0700
MIME-Version: 1.0
In-Reply-To: <20170509082800.10756-3-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] target/s390x: fix SIGNAL PROCESSOR
 return value
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

On 05/09/2017 01:27 AM, Aurelien Jarno wrote:
> The SIGNAL PROCESSOR helper returns its value through the CC register.
> set_cc_static should be called just after the helper.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/translate.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
