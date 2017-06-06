Received: from eggs.gnu.org ([2001:4830:134:3::10]:53628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIHs7-0005hF-AL
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIHs6-0000TW-Nt
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:02:23 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:34164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIHs6-0000TQ-Id
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:02:22 -0400
Received: by mail-qt0-x22e.google.com with SMTP id c10so82594185qtd.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 10:02:22 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1496702979-26132-1-git-send-email-cota@braap.org>
	<1496702979-26132-4-git-send-email-cota@braap.org>
	<015d442b-a44e-0ebc-470c-e3289b109ca6@twiddle.net>
	<20170606162508.GB6109@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e03d566d-25c4-5052-68ba-2a07b64bbfdd@twiddle.net>
Date: Tue, 6 Jun 2017 10:02:17 -0700
MIME-Version: 1.0
In-Reply-To: <20170606162508.GB6109@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tcg: allocate TB structs before the
 corresponding translated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>

On 06/06/2017 09:25 AM, Emilio G. Cota wrote:
> For this particular case we can get away without padding the structs if
> we're OK with having the end of a TB struct immediately followed
> by its translated code, instead of having that code on the following
> cache line.

Uh, no, if you can manually pad before the struct, you can manually pad after 
the struct too.


r~
