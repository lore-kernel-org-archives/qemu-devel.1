Received: from eggs.gnu.org ([2001:4830:134:3::10]:35227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZKCq-0001Sw-S7
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZKCp-0006NB-BV
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:25:56 -0500
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:34353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZKCp-0006Mz-61
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:25:55 -0500
Received: by mail-vk0-x22a.google.com with SMTP id r136so14297106vke.1
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 08:25:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9zEaATTwGLNCB=X_mhqjapC-0jxPpv8OjDt=zqaFBnjA@mail.gmail.com>
References: <1485893872-26524-1-git-send-email-mst@redhat.com>
	<CAFEAcA9zEaATTwGLNCB=X_mhqjapC-0jxPpv8OjDt=zqaFBnjA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Feb 2017 16:25:34 +0000
Message-ID: <CAFEAcA_SCHQ06uON3pEgpt2ku4HO2C-fUTHr7TZAVmZ1PEq09Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v5 00/22] virtio, vhost, pci: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>

On 2 February 2017 at 13:56, Peter Maydell <peter.maydell@linaro.org> wrote=
:
> On 31 January 2017 at 20:18, Michael S. Tsirkin <mst@redhat.com> wrote:
>> virtio, vhost, pci: fixes, features
>>
>> generic pci root port support
>> disable shpc by default
>> safer version of ARRAY_SIZE and QEMU_BUILD_BUG_ON
>> fixes and cleanups all over the place
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

> Applied, thanks.

...travis builds now fail for the --enable-tcg-interpreter config:
https://travis-ci.org/qemu/qemu/jobs/197648661

In file included from /home/travis/build/qemu/qemu/tcg/tcg.c:255:0:
/home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c: In function =E2=80=
=98tcg_out_op=E2=80=99:
/home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c:569:117: error:
negative width in bit-field =E2=80=98<anonymous>=E2=80=99
/home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c:569:255: error:
negative width in bit-field =E2=80=98<anonymous>=E2=80=99
In file included from /home/travis/build/qemu/qemu/tcg/tcg.c:255:0:
/home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c:578:115: error:
negative width in bit-field =E2=80=98<anonymous>=E2=80=99
/home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c:578:255: error:
negative width in bit-field =E2=80=98<anonymous>=E2=80=99

These look to be because we were trying to use ARRAY_SIZE()
on a non-array, which was previously undetected. The use is
only in an assert() so fairly harmless.

Would somebody who cares about TCI like to provide a fix?

thanks
-- PMM
