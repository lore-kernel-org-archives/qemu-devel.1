Received: from eggs.gnu.org ([2001:4830:134:3::10]:36458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dbCNk-00074a-00
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 17:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dbCNj-0000TS-4m
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 17:01:12 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dbCNi-0000Sv-Uq
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 17:01:11 -0400
Received: by mail-wm0-x232.google.com with SMTP id t201so5647521wmt.0
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 14:01:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a965a76e-3a63-e69c-18f1-dbfdc569cafd@amsat.org>
References: <20170728131151.4802-1-olaf@aepfle.de>
	<a965a76e-3a63-e69c-18f1-dbfdc569cafd@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2017 22:00:49 +0100
Message-ID: <CAFEAcA_+ELUt-aeeQv6yUXqFXcBb1RbXmvhPMBzW+meahD+pig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] xen-disk: use g_new0 to fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Olaf Hering <olaf@aepfle.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, "open list:Block layer core" <qemu-block@nongnu.org>

On 28 July 2017 at 21:49, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Hi Olaf,
>
> On 07/28/2017 10:11 AM, Olaf Hering wrote:
>>
>> g_malloc0_n is available since glib-2.24. To allow build with older glib
>> versions use the generic g_new0, which is already used in many other
>> places in the code.
>
>
> Can you provide information about which distrib/release/version/[packages=
?]
> you used? So we might add the same setup in QEMU continuous integration
> system.

I do have a build system with our oldest supported glib
version (it's my OSX box), and I have a feeling one of the
patchew centos configs does this too, but I guess neither
of them have the Xen headers to enable the Xen code,
which is why this one slipped through.

thanks
-- PMM
