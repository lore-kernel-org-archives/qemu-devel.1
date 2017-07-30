Received: from eggs.gnu.org ([2001:4830:134:3::10]:41038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dbssa-0003wj-13
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 14:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dbssY-0005ZS-T0
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 14:23:52 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:37165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dbssY-0005Z9-Lr
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 14:23:50 -0400
Received: by mail-wr0-x232.google.com with SMTP id 33so114840430wrz.4
	for <qemu-devel@nongnu.org>; Sun, 30 Jul 2017 11:23:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <192810b2-02a2-fbbc-fc1e-7e9d3d80d7fa@gmx.com>
References: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
	<CAKmqyKPZ3+ohCvpzbw=MyLpgB5cFKQosBJNsaWcoT=yWp1c9Mw@mail.gmail.com>
	<cf854184-8bc0-4a9c-b97f-8274abf538bc@amsat.org>
	<20170729135042.GA1139@pks-xps>
	<CAFEAcA_gG=pukiHmhW5kMDu0sUxRL8Yp5H5=XA0gKbTSVuNBpQ@mail.gmail.com>
	<192810b2-02a2-fbbc-fc1e-7e9d3d80d7fa@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 30 Jul 2017 19:23:26 +0100
Message-ID: <CAFEAcA9dvAnkKhKq03VccO1MLgg-4g20Mt2=85TZ1jF9XxHPRw@mail.gmail.com>
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
To: Kamil Rytarowski <n54@gmx.com>
Cc: Patrick Steinhardt <ps@pks.im>, Alistair Francis <alistair23@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 30 July 2017 at 17:51, Kamil Rytarowski <n54@gmx.com> wrote:
> On 29.07.2017 21:34, Peter Maydell wrote:
>> On 29 July 2017 at 14:50, Patrick Steinhardt <ps@pks.im> wrote:
>>> On Fri, Jul 28, 2017 at 02:20:49PM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
>>>> This is likely to break on BSD, but now than patchew has a NetBSD job
>>>> you can trigger a build RESENDing this patch.
>>
>
> I just checked patchew, and there is FreeBSD job. How far are we from
> adding more BSDs?

I now test OpenBSD and NetBSD as well in my pre-merge
test setup. Patchew could add them as well if desired.
(vm setup instructions at http://wiki.qemu.org/Hosts/BSD)

(I haven't bothered to send a patch marking OpenBSD
as 'supported' since we've had zero contact from
anybody in the OpenBSD community AFAIK.)

thanks
-- PMM
