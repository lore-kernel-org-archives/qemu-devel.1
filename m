Received: from eggs.gnu.org ([2001:4830:134:3::10]:34148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcBjr-0007ZV-1Z
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcBjq-0005Gk-3q
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:32:07 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcBjp-0005GS-TY
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:32:06 -0400
Received: by mail-wm0-x231.google.com with SMTP id t201so51190196wmt.0
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 07:32:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170731142308.GB3206@lemon.lan>
References: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
	<CAKmqyKPZ3+ohCvpzbw=MyLpgB5cFKQosBJNsaWcoT=yWp1c9Mw@mail.gmail.com>
	<cf854184-8bc0-4a9c-b97f-8274abf538bc@amsat.org>
	<20170729135042.GA1139@pks-xps>
	<CAFEAcA_gG=pukiHmhW5kMDu0sUxRL8Yp5H5=XA0gKbTSVuNBpQ@mail.gmail.com>
	<192810b2-02a2-fbbc-fc1e-7e9d3d80d7fa@gmx.com>
	<CAFEAcA9dvAnkKhKq03VccO1MLgg-4g20Mt2=85TZ1jF9XxHPRw@mail.gmail.com>
	<20170731142308.GB3206@lemon.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2017 15:31:44 +0100
Message-ID: <CAFEAcA-96Be8PCs=zOD-w1LJ7Eed=HBvpqZrB+2AK8UdXutiaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Fam Zheng <famz@redhat.com>
Cc: Kamil Rytarowski <n54@gmx.com>, Kamil Rytarowski <kamil@netbsd.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Patrick Steinhardt <ps@pks.im>, Alistair Francis <alistair23@gmail.com>

On 31 July 2017 at 15:23, Fam Zheng <famz@redhat.com> wrote:
> No objection to adding more BSDs to patchew as long as I can find a few more
> gigabytes RAM to run the VM (BTW I'm also thinking about converting long running
> VMs to boot/shutdown on demand, to support more types of guests). But still want
> to ask this: how likely it is for a patch to compile on one BSD flavor but fail
> on the other?

I dunno about any particular patch, but when I came to trying
to get the BSDs into my test machine set I found that the
three different OSes were all failing for different reasons.
The bulk of "BSD fails" probably fail on all 3 though, so
you could probably get away with only testing 1 in patchew
and letting my tests catch the rest.

thanks
-- PMM
