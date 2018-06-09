Received: from eggs.gnu.org ([2001:4830:134:3::10]:39398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRcCp-0007B2-VM
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 07:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRcCp-0003Lq-4z
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 07:38:51 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:36549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fRcCp-0003LI-0y
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 07:38:51 -0400
Received: by mail-oi0-x229.google.com with SMTP id 14-v6so14110069oie.3
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 04:38:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <68fe6a1f-e2fd-679c-d705-82173c832c3f@amsat.org>
References: <20180601162620.32362-1-mst@redhat.com>
	<CAFEAcA_weoW3XS2dppdc=jwpCSSAaiTxaQDxsBBKdjjA4aY_Rg@mail.gmail.com>
	<fe4cdf31-4e5c-c3c8-936b-91a45eaa77ad@amsat.org>
	<68fe6a1f-e2fd-679c-d705-82173c832c3f@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Jun 2018 12:38:29 +0100
Message-ID: <CAFEAcA9afwrT8wVC4n=weMsKof74m2z9Yw4W2=uufGp9rQze+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/31] acpi, vhost, misc: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 8 June 2018 at 19:47, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> On 06/08/2018 02:52 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> So 'rm ${srcdir}/qemu-version.h ${srcdir}/qemu-options.def' fixed my
>> problems.
>>
>> Should we add a check for this kind of mistakes when running out-of-tree
>> builds? I'll try something.

We do have a rune in the makefile that checks for whether you
have a stale in-tree build and you do an out-of-tree build,
and we also should refuse to do an in-tree build without
generating any extra files. Unfortunately we didn't always
have the rules for the latter correct, so in the past it
was possible to generate stray generated files, which then
lurk around until they cause a problem months later.

thanks
-- PMM
