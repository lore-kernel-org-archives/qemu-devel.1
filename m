Received: from eggs.gnu.org ([2001:4830:134:3::10]:47965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRRzG-0003Cg-Sq
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 19:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRRzD-0002Lm-QL
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 19:39:38 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dRRzD-0002LX-Lx
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 19:39:35 -0400
Received: by mail-qk0-x242.google.com with SMTP id v143so7148603qkb.3
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 16:39:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865341027.17063.1860120579163763533.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6df1b0ab-9445-79f3-f487-640a0a4dd7dd@twiddle.net>
Date: Sat, 1 Jul 2017 16:39:32 -0700
MIME-Version: 1.0
In-Reply-To: <149865341027.17063.1860120579163763533.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 05/29] target/i386: [tcg] Port to
 DisasContextBase
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

On 06/28/2017 05:36 AM, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova<vilanova@ac.upc.edu>
> ---
>   target/i386/translate.c |  142 +++++++++++++++++++++++------------------------
>   1 file changed, 70 insertions(+), 72 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
