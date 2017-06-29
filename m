Received: from eggs.gnu.org ([2001:4830:134:3::10]:50826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQZZ4-00029i-MM
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQZZ1-0004AD-Jv
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:32:58 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dQZZ1-00049Y-Do
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:32:55 -0400
Received: by mail-wm0-f50.google.com with SMTP id z75so18927562wmc.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 06:32:54 -0700 (PDT)
References: <cover.1498607452.git.alistair.francis@xilinx.com>
	<6955f1684346baf57b619ca407cd71363027307a.1498607452.git.alistair.francis@xilinx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb27d632-fae4-23da-48cc-e0c94b9bc584@redhat.com>
Date: Thu, 29 Jun 2017 15:32:51 +0200
MIME-Version: 1.0
In-Reply-To: <6955f1684346baf57b619ca407cd71363027307a.1498607452.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 2/4] util/oslib-win32: Remove invalid check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com
Cc: edgar.iglesias@xilinx.com, alistair23@gmail.com, qemu-block@nongnu.org

On 28/06/2017 01:57, Alistair Francis wrote:
> There is no way nhandles can be zero in this section so that part of the
> if statement will always be false. Let's just remove it to make the code
> easier to read.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
> 
>  util/oslib-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 80e4668935..7ec0f8e083 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -414,7 +414,7 @@ static int poll_rest(gboolean poll_msgs, HANDLE *handles, gint nhandles,
>          /* If we have a timeout, or no handles to poll, be satisfied
>           * with just noticing we have messages waiting.
>           */
> -        if (timeout != 0 || nhandles == 0) {
> +        if (timeout != 0) {
>              return 1;
>          }
>  
> 

Hmm, I think it's possible, poll_msgs is true here.

Paolo
