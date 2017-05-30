Received: from eggs.gnu.org ([2001:4830:134:3::10]:55851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFje1-0004KS-Ow
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFje0-0007QJ-Qu
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:05:17 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFje0-0007PX-Kf
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:05:16 -0400
Received: by mail-wm0-x234.google.com with SMTP id e127so104919611wmg.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:05:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494697399-352-5-git-send-email-eric.auger@redhat.com>
References: <1494697399-352-1-git-send-email-eric.auger@redhat.com>
	<1494697399-352-5-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 17:04:52 +0100
Message-ID: <CAFEAcA-GCKfxEpy9p=k7NzoY2zez-KVXNMuAx-ruW5t27ZMgQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v4 4/5] hw/arm/virt: Add 2.10 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, prem.mallappa@gmail.com, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>

On 13 May 2017 at 18:43, Eric Auger <eric.auger@redhat.com> wrote:
> The new machine type allows smmuv3 instantiation. A new option
> is introduced to turn the feature on/off (off by default).

Should we go for default-on, or would that break guests?
For other things added to the virt board I think the
approach we've taken has been:
 * if this is just an extra device, simply provide it in the
   new virt-n.nn machine by default
 * if this is something that changes how the machine behaves
   even for code that doesn't care about that feature (eg
   EL2, EL3, since they change what mode you start in on boot)
   then default it to off
 * if the feature only works with TCG and not KVM then
   maybe default it to off

thanks
-- PMM
