Received: from eggs.gnu.org ([2001:4830:134:3::10]:37340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzpZZ-0003o2-Rz
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzpZV-0000uf-02
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:47:45 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fzpZU-0000Wu-BW
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:47:40 -0400
Received: by mail-pf1-x443.google.com with SMTP id j8-v6so12804919pff.6
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 13:47:30 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180911202823.21657-1-cota@braap.org>
	<20180911202823.21657-4-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <54b14c23-225f-8d83-38b2-40858a4808da@twiddle.net>
Date: Tue, 11 Sep 2018 13:47:27 -0700
MIME-Version: 1.0
In-Reply-To: <20180911202823.21657-4-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/13] target/i386: move cpu_T0 to
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
>  target/i386/translate.c | 1174 ++++++++++++++++++++-------------------
>  1 file changed, 594 insertions(+), 580 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
