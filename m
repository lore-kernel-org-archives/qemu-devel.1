Received: from eggs.gnu.org ([2001:4830:134:3::10]:40123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzphN-0002Ob-JY
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzphK-0005vr-Cr
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:55:49 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fzphK-0005po-4y
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:55:46 -0400
Received: by mail-pf1-x444.google.com with SMTP id k19-v6so12834470pfi.1
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 13:55:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180911202823.21657-1-cota@braap.org>
	<20180911202823.21657-10-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6c3a940b-24df-6e73-fcd5-5a5290d05b5c@twiddle.net>
Date: Tue, 11 Sep 2018 13:55:33 -0700
MIME-Version: 1.0
In-Reply-To: <20180911202823.21657-10-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 09/13] target/i386: move cpu_tmp2_i32 to
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
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/i386/translate.c | 347 ++++++++++++++++++++--------------------
>  1 file changed, 174 insertions(+), 173 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
