Received: from eggs.gnu.org ([2001:4830:134:3::10]:46612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gMHSf-0003L8-Jq
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 14:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gMHST-0004zd-Q0
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 14:01:21 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gMHST-0004yr-7v
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 14:01:13 -0500
Received: by mail-wr1-x442.google.com with SMTP id b13so10549525wrx.6
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 11:01:13 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-6-f4bug@amsat.org>
	<20181112170351.GU12503@habkost.net>
	<CAAdtpL4234FKt685azMs_iWYNGzvhp8Mo6dJsah_Sq=JWJUaJA@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <86da62fc-351f-d039-49ea-9f62d073d476@twiddle.net>
Date: Mon, 12 Nov 2018 20:01:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAAdtpL4234FKt685azMs_iWYNGzvhp8Mo6dJsah_Sq=JWJUaJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 05/11] decodetree: Force Python to
 print unsigned values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, peer.adelt@hni.uni-paderborn.de, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>

On 11/12/18 7:52 PM, Philippe Mathieu-Daudé wrote:
> So the fix is rather:
> 
> -- >8 --
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> @@ -916,7 +916,7 @@ class Tree:
> 
> def build_tree(pats, outerbits, outermask):
>      # Find the intersection of all remaining fixedmask.
> -    innermask = ~outermask
> +    innermask = ~outermask & insnmask
>      for i in pats:
>          innermask &= i.fixedmask
>  ---

Ah!  I like it.


r~
