Received: from eggs.gnu.org ([2001:4830:134:3::10]:55251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gLntN-0000Td-DK
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 06:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gLntH-0002jG-3O
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 06:27:00 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gLntF-0002cB-P8
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 06:26:54 -0500
Received: by mail-wr1-x443.google.com with SMTP id j26-v6so6317523wre.1
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 03:26:52 -0800 (PST)
References: <20181110211313.6922-1-f4bug@amsat.org>
	<20181110211313.6922-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d003a490-57fb-4c27-f99b-51a2b1084f9c@linaro.org>
Date: Sun, 11 Nov 2018 12:26:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181110211313.6922-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] decodetree: Add multiple include guard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 11/10/18 10:13 PM, Philippe Mathieu-Daudé wrote:
> It is necessary when splitting an ISA, or when using multiple ISAs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  scripts/decodetree.py | 5 +++++
>  1 file changed, 5 insertions(+)

I guess I have no problems with this, but can you explain
when these headers get included more than once?


r~
