Received: from eggs.gnu.org ([2001:4830:134:3::10]:54253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYwVs-0007zz-Ig
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYwVo-0004my-Ef
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:12:32 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:41535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYwVo-0004mC-9P
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:12:28 -0500
Received: by mail-ot0-x22b.google.com with SMTP id 5so3775419oth.8
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 08:12:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6d20557d-5722-706f-ca4f-489ab85358c0@redhat.com>
References: <1513183941-24300-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA8NbL7ROZs99hWhpAF2Rdi2qEiWLNo3hr_9W7gmgXyw4A@mail.gmail.com>
	<6d20557d-5722-706f-ca4f-489ab85358c0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 16:12:06 +0000
Message-ID: <CAFEAcA-Nn4VmSnxT7Of8Nh+p5QgF9cMzkqZ-VBCC=2zRgk-Xdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/2] GICv2 & GICv3: RAZ/WI
 reserved addresses rather than aborting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "patches@linaro.org" <patches@linaro.org>, Drew Jones <drjones@redhat.com>, Auger Eric <eric.auger@redhat.com>, Wei Huang <wei@redhat.com>

On 9 January 2018 at 15:58, Laszlo Ersek <lersek@redhat.com> wrote:
> Sorry, no clue about any of this -- where should I read up?

I cc'd you mostly as a heads-up since the QEMU bug is UEFI affecting,
not because I wanted to make you read the GIC specs :-)

> Ard did ask a question though:
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg500055.html

Sounds plausible (my UEFI binary I hit this with is pretty ancient)
but I don't know for certain. It's one of those things that seems
like it's a bug in UEFI (perhaps now fixed) but which is also
definitely a bug in QEMU, and if it is a UEFI bug it's pretty
harmless.

thanks
-- PMM
