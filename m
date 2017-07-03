Received: from eggs.gnu.org ([2001:4830:134:3::10]:42132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS75k-0001dL-56
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS75h-0003KV-3c
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:33:04 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS75g-0003KJ-Uw
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:33:01 -0400
Received: by mail-qt0-x241.google.com with SMTP id w12so24621745qta.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 12:33:00 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-3-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <87069083-6c37-6ef7-d69b-c689ab4a4d21@twiddle.net>
Date: Mon, 3 Jul 2017 12:32:55 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-3-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/22] configure: early test for supported
 targets
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
> Check for unsupported targets in target_list, and print an
> error early in the configuration process.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   configure | 65 ++++++++++++++++++++++++++++++++++++++++++---------------------
>   1 file changed, 43 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
