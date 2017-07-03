Received: from eggs.gnu.org ([2001:4830:134:3::10]:40838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS73O-0000h1-B5
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS73L-0001qn-8c
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:30:38 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS73L-0001qA-3m
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:30:35 -0400
Received: by mail-qk0-x241.google.com with SMTP id 16so25163524qkg.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 12:30:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-2-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a62894ea-d6a4-0fce-ce75-37a2181ae371@twiddle.net>
Date: Mon, 3 Jul 2017 12:30:29 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/22] configure: factor out list of
 supported Xen/KVM/HAX targets
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
> This will be useful when the functions are called, early in the configure
> process, to filter out targets that do not support hardware acceleration.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   configure | 90 ++++++++++++++++++++++++++++++++++++++-------------------------
>   1 file changed, 55 insertions(+), 35 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
