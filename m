Received: from eggs.gnu.org ([2001:4830:134:3::10]:52520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRSl7-0004je-2H
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRSl3-0005XH-Vq
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:29:05 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dRSl3-0005XA-Re
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:29:01 -0400
Received: by mail-qk0-x244.google.com with SMTP id v143so7229193qkb.3
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 17:29:01 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865437871.17063.9119703949695421203.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c3b7fdbd-c246-8030-8057-a3a1eecbd8c8@twiddle.net>
Date: Sat, 1 Jul 2017 17:28:58 -0700
MIME-Version: 1.0
In-Reply-To: <149865437871.17063.9119703949695421203.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 09/29] target/i386: [tcg] Refactor
 breakpoint_check
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

On 06/28/2017 05:52 AM, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova<vilanova@ac.upc.edu>
> ---
>   target/i386/translate.c |   59 ++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 48 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
