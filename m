Received: from eggs.gnu.org ([2001:4830:134:3::10]:53733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRSx3-0006qU-7J
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRSwz-0002ty-Vz
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:41:25 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dRSwz-0002tu-S9
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:41:21 -0400
Received: by mail-qt0-x243.google.com with SMTP id w12so19592420qta.2
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 17:41:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865462073.17063.17488435214703164893.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <09fdaae8-bc9f-8da2-4067-2fcf91107740@twiddle.net>
Date: Sat, 1 Jul 2017 17:41:17 -0700
MIME-Version: 1.0
In-Reply-To: <149865462073.17063.17488435214703164893.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 10/29] target/i386: [tcg] Refactor
 translate_insn
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

On 06/28/2017 05:57 AM, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova<vilanova@ac.upc.edu>
> ---
>   target/i386/translate.c |   72 +++++++++++++++++++++++++++++++----------------
>   1 file changed, 48 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
