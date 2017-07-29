Received: from eggs.gnu.org ([2001:4830:134:3::10]:41536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dbXVh-0003Vj-24
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 15:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dbXVg-0003yr-4O
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 15:34:49 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dbXVf-0003yG-SL
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 15:34:48 -0400
Received: by mail-wr0-x231.google.com with SMTP id 12so165777191wrb.1
	for <qemu-devel@nongnu.org>; Sat, 29 Jul 2017 12:34:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170729135042.GA1139@pks-xps>
References: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
	<CAKmqyKPZ3+ohCvpzbw=MyLpgB5cFKQosBJNsaWcoT=yWp1c9Mw@mail.gmail.com>
	<cf854184-8bc0-4a9c-b97f-8274abf538bc@amsat.org>
	<20170729135042.GA1139@pks-xps>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 29 Jul 2017 20:34:26 +0100
Message-ID: <CAFEAcA_gG=pukiHmhW5kMDu0sUxRL8Yp5H5=XA0gKbTSVuNBpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] 9pfs: include <linux/limits.h> for
 XATTR_SIZE_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair23@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 29 July 2017 at 14:50, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Jul 28, 2017 at 02:20:49PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> This is likely to break on BSD, but now than patchew has a NetBSD job
>> you can trigger a build RESENDing this patch.

> Thanks for the feedback! Is this really relevant in this context,
> though? Both 9p-local.c and 9p-handle.c already include linux
> headers, especially <linux/fs.h> is included without any ifdef
> around. As such, I simply assumed that this code is being built
> on Linux systems, only.

Yes; hw/Makefile.objs only includes the 9pfs directory
if CONFIG_VIRTFS is defined, and configure only sets that
on Linux hosts which have libpcap and libattr available.

thanks
-- PMM
