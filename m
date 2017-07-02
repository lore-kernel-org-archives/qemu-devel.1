Received: from eggs.gnu.org ([2001:4830:134:3::10]:54293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRT3F-0008Fx-64
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRT3C-0005Qx-5k
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:47:49 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dRT3B-0005Qi-Vt
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:47:46 -0400
Received: by mail-qk0-x244.google.com with SMTP id 91so20033557qkq.1
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 17:47:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865486266.17063.7032445527012069283.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <657e84d5-4913-9a54-9295-2a99b94d9ca2@twiddle.net>
Date: Sat, 1 Jul 2017 17:47:41 -0700
MIME-Version: 1.0
In-Reply-To: <149865486266.17063.7032445527012069283.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 11/29] target/i386: [tcg] Refactor
 tb_stop
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

On 06/28/2017 06:01 AM, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova<vilanova@ac.upc.edu>
> ---
>   target/i386/translate.c |   26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
