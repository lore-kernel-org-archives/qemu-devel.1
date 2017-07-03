Received: from eggs.gnu.org ([2001:4830:134:3::10]:43838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7AC-0003cT-II
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7A7-0005uz-NP
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:37:40 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7A7-0005uF-IG
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:37:35 -0400
Received: by mail-qt0-x243.google.com with SMTP id v31so24666141qtb.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 12:37:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-4-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e5f16b6d-843f-6c8c-cc7d-68fa9ca33069@twiddle.net>
Date: Mon, 3 Jul 2017 12:37:29 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-4-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/22] configure: add --disable-tcg
 configure option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com, Anthony Liguori <aliguori@us.ibm.com>

On 07/03/2017 09:34 AM, Paolo Bonzini wrote:
> This lets you build without TCG (hardware accelerationor qtest only).  When
> this flag is passed to configure, it will automatically filter out the target
> list to only those that support KVM or Xen or HAX.
> 
> Signed-off-by: Anthony Liguori<aliguori@us.ibm.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   configure | 26 +++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
