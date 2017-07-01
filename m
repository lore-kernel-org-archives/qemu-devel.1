Received: from eggs.gnu.org ([2001:4830:134:3::10]:48867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRSAE-0005Mv-A2
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 19:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRSAB-00083B-9K
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 19:50:58 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dRSAB-00082z-49
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 19:50:55 -0400
Received: by mail-oi0-x241.google.com with SMTP id f134so8803194oig.0
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 16:50:54 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865365245.17063.7830070270971603805.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8ccbce76-c7bf-8ac5-d135-b107af81be50@twiddle.net>
Date: Sat, 1 Jul 2017 16:50:51 -0700
MIME-Version: 1.0
In-Reply-To: <149865365245.17063.7830070270971603805.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 06/29] target/i386: [tcg] Refactor
 init_disas_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/28/2017 05:40 AM, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova<vilanova@ac.upc.edu>
> ---
>   target/i386/translate.c |   43 ++++++++++++++++++++++++-------------------
>   1 file changed, 24 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
