Received: from eggs.gnu.org ([2001:4830:134:3::10]:56163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dgURD-0007BV-Lr
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dgURC-0007ii-KJ
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:18:39 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dgURC-0007iJ-D7
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:18:38 -0400
Received: by mail-wm0-x235.google.com with SMTP id t201so8280377wmt.1
	for <qemu-devel@nongnu.org>; Sat, 12 Aug 2017 04:18:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170812110410.rosk6yhkj22w346s@var.youpi.perso.aquilenet.fr>
References: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
	<20170811215845.n667iobglz5cef3z@var.youpi.perso.aquilenet.fr>
	<CAFEAcA_XrnDxZLhX5FGFBh+Mh-_80z3Z6b+0LkmQuoWzrWK0tA@mail.gmail.com>
	<20170812110410.rosk6yhkj22w346s@var.youpi.perso.aquilenet.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 12 Aug 2017 12:18:16 +0100
Message-ID: <CAFEAcA-N5pAM+3PXvjaJ-LMPFswAtmkAXA6yn151CCtfn+=JQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] SLIRP warning messages displayed while compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Programmingkid <programmingkidx@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 12 August 2017 at 12:04, Samuel Thibault <samuel.thibault@gnu.org> wrote=
:
> Peter Maydell, on sam. 12 ao=C3=BBt 2017 11:53:20 +0100, wrote:
>> The utility of the warning is that it means you get told
>> about stuff that might break on other architectures.
>
> Sure, I understand that. But here all fields are aligned on their size
> inside the packed structure. So there can't be alignment issues, and the
> compiler should be able to determine that.

Alignment is architecture-dependent, and the compiler
can't know the alignment requirements for every
architecture. There's no rule in C that says that
uint16_t only needs 2 byte alignment and not 4 on
some hosts.

(Also I just noticed 'struct ip6' uses bitfields:
that's badly non-portable if it's trying to
match an on-the-wire layout.)

thanks
-- PMM
