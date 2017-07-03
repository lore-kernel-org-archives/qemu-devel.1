Received: from eggs.gnu.org ([2001:4830:134:3::10]:33200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7r0-00068s-5b
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7qv-0005hq-3L
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:21:54 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:34674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7qu-0005hW-UM
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:21:49 -0400
Received: by mail-qk0-x235.google.com with SMTP id d78so153857942qkb.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:21:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-23-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <00c56c99-de57-5987-9ebf-5ae59ea03d8b@twiddle.net>
Date: Mon, 3 Jul 2017 13:21:43 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-23-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/22] configure: warn on untested
 --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

On 07/03/2017 09:34 AM, Paolo Bonzini wrote:
> --disable-tcg will almost certainly fail to compile on non-x86 platforms,
> so issue a warning.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   configure | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
