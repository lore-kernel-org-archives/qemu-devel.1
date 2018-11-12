Received: from eggs.gnu.org ([2001:4830:134:3::10]:47507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM7dJ-0001IL-BE
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM7dD-0002HT-U4
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:31:44 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gM7dB-0001kZ-Va
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:31:39 -0500
Received: by mail-wm1-x342.google.com with SMTP id r11-v6so7507034wmb.2
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 00:31:27 -0800 (PST)
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-8-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6d9b9e68-6a55-90d4-7b41-662638d8a407@linaro.org>
Date: Mon, 12 Nov 2018 09:31:22 +0100
MIME-Version: 1.0
In-Reply-To: <20181111233622.8976-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 07/11] scripts/decodetree: Add
 add_func_check()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On 11/12/18 12:36 AM, Philippe Mathieu-Daudé wrote:
>          for n, f in self.fields.items():
>              output(ind, 'u.f_', arg, '.', n, ' = ', f.str_extract(), ';\n')
> +        for f, a in self.check_funcs:
> +            output(ind, 'check_', f, '(ctx, ', a, ');\n')
>          output(ind, 'return ', translate_prefix, '_', self.name,
>                 '(ctx, &u.f_', arg, ');\n')

I don't see the value in asserting the isa here.
If this were a conditional check, which might fall through to either another
pattern or to return false, maybe.


r~
