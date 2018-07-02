Received: from eggs.gnu.org ([2001:4830:134:3::10]:38140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZwRb-0001e9-HR
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZwRa-0002cz-PR
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:52:31 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:42833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZwRa-0002co-C3
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:52:30 -0400
Received: by mail-oi0-x241.google.com with SMTP id n84-v6so15514085oib.9
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 03:52:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a9f99868-6ac8-9116-0d78-28aa12f81aff@amsat.org>
References: <20180627111936.31019-1-kraxel@redhat.com>
	<980ced5f-cf5d-6a2b-067e-522276f9c5bd@amsat.org>
	<a9f99868-6ac8-9116-0d78-28aa12f81aff@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 11:52:09 +0100
Message-ID: <CAFEAcA_fauypJ4dOgW7mxXULc_7G+S-N9o3tQCc=VN032-wT2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] audio/hda: drop atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Max Reitz <mreitz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Martin Schrodt <martin@schrodt.org>

On 29 June 2018 at 18:49, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> On 06/27/2018 01:15 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 06/27/2018 08:19 AM, Gerd Hoffmann wrote:
>>> Doesn't build on 32bit clang.  And because we run under qemu mutex
>>> anyway they are not needed.
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Applying this patch as build fix on master would fix the mips/mipsel
> host builds (also clang -m32 reported by Max). But there's no hurry.

Thanks; applied to master as a build fix.

-- PMM
