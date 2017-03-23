Received: from eggs.gnu.org ([2001:4830:134:3::10]:55180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1crA3O-0007WH-MX
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1crA3K-0003RC-NQ
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:13:54 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1crA3K-0003R4-Hr
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:13:50 -0400
Received: by mail-pg0-x243.google.com with SMTP id 79so29683700pgf.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 14:13:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170323175851.14342-1-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a6e88463-0a8c-a8b0-ddbf-4aefeffc4812@twiddle.net>
Date: Fri, 24 Mar 2017 07:13:41 +1000
MIME-Version: 1.0
In-Reply-To: <20170323175851.14342-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/i386: Check the size of instruction
 being translated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>

On 03/24/2017 03:58 AM, Pranith Kumar wrote:
> Sending again since I messed by pbonzini's email.
>
> This fixes the bug: 'user-to-root privesc inside VM via bad translation
> caching' reported by Jann Horn here:
> https://bugs.chromium.org/p/project-zero/issues/detail?id=1122
>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  target/i386/translate.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
