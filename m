Received: from eggs.gnu.org ([2001:4830:134:3::10]:45328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel@fooishbar.org>) id 1f4O2j-0005PM-2Q
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel@fooishbar.org>) id 1f4O2i-0005IK-B6
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:52:25 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <daniel@fooishbar.org>)
	id 1f4O2i-0005Hs-16
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:52:24 -0400
Received: by mail-wr0-x243.google.com with SMTP id u46so1025682wrc.11
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 02:52:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
References: <20180313154826.20436-1-kraxel@redhat.com>
	<20180313161035.GL4788@phenom.ffwll.local>
	<20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 6 Apr 2018 10:52:21 +0100
Message-ID: <CAPj87rPKtuQ4SZePYDUesWY9VSSGR=1p-LO=yByY_6Q8=BfoyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RfC PATCH] Add udmabuf misc device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>

Hi Gerd,

On 14 March 2018 at 08:03, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> Either mlock account (because it's mlocked defacto), and get_user_pages
>> won't do that for you.
>>
>> Or you write the full-blown userptr implementation, including mmu_notifi=
er
>> support (see i915 or amdgpu), but that also requires Christian K=C3=B6ni=
gs
>> latest ->invalidate_mapping RFC for dma-buf (since atm exporting userptr
>> buffers is a no-go).
>
> I guess I'll look at mlock accounting for starters then.  Easier for
> now, and leaves the door open to switch to userptr later as this should
> be transparent to userspace.

Out of interest, do you have usecases for full userptr support? Maybe
another way would be to allow creation of dmabufs from memfds.

Cheers,
Daniel
