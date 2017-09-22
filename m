Received: from eggs.gnu.org ([2001:4830:134:3::10]:39691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dvP8c-0000NK-1Q
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dvP8Y-0001eJ-8L
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:41:06 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:36449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dvP8Y-0001e9-1v
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:41:02 -0400
Received: by mail-io0-x242.google.com with SMTP id n69so1810670ioi.3
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 07:41:01 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1506014941-31076-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cf9011ad-1810-12ed-830d-deb5858f19df@twiddle.net>
Date: Fri, 22 Sep 2017 09:40:52 -0500
MIME-Version: 1.0
In-Reply-To: <1506014941-31076-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] docs/devel/loads-stores.rst: Document
 our various load and store APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

On 09/21/2017 12:29 PM, Peter Maydell wrote:
> QEMU has a wide selection of different functions for doing
> loads and stores; provide some overview documentation of
> what they do and how to pick which one to use.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2: filled in most of the gaps thanks to the
> comments on v1.
> 
> I have left some TODO markers in where they represent
> fixes we should ideally make to the API. Since this
> is for-developers internals documentation I think it's
> OK to leave those in.
> 
> I found I was referring back to my v1 patch and the replies
> to it quite a bit recently, so I think it would be nice to
> get it into the tree.
> 
> The major question I have left is about the license text
> to apply to this...
> ---
>  docs/devel/loads-stores.rst | 400 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 400 insertions(+)
>  create mode 100644 docs/devel/loads-stores.rst

Eric found some typos; I see nothing substantively wrong in the text.

Looks good, thanks!


r~
