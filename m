Received: from eggs.gnu.org ([2001:4830:134:3::10]:41139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzpkR-0005JB-CL
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzpkQ-0007mB-E2
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:58:59 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fzpkQ-0007gl-2N
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:58:58 -0400
Received: by mail-pf1-x443.google.com with SMTP id p12-v6so12831034pfh.2
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 13:58:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180911202823.21657-1-cota@braap.org>
	<20180911202823.21657-13-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e6119e61-088c-c578-1078-d3b4c155edea@twiddle.net>
Date: Tue, 11 Sep 2018 13:58:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180911202823.21657-13-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/13] target/i386: move x86_64_hregs to
 DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 09/11/2018 01:28 PM, Emilio G. Cota wrote:
> And convert it to a bool to use an existing hole
> in the struct.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/i386/translate.c | 307 ++++++++++++++++++++--------------------
>  1 file changed, 154 insertions(+), 153 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
