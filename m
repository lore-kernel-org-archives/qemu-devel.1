Received: from eggs.gnu.org ([209.51.188.92]:47341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gjLxZ-0002DW-GN
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gjLxX-00052o-2S
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:28:39 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:32901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gjLxW-00051h-RI
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:28:38 -0500
Received: by mail-ot1-x334.google.com with SMTP id i20so2053428otl.0
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 02:28:38 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
In-Reply-To: <20190111161515.GG2738@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Jan 2019 10:28:26 +0000
Message-ID: <CAFEAcA8Ct-Htk73SO=LaSFONgYW-PcqXQ8s7xjYUd=Cv-NQnBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] test-filter-mirror hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 11 Jan 2019 at 16:15, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > Recently I've noticed that test-filter-mirror has been hanging
> > intermittently, typically when run on some other TCG architecture.
> > In the instance I've just looked at, this was with s390x guest on
> > x86-64 host, though I've also seen it on other host archs and
> > perhaps with other guests.
>
> Watch out to see if you really do see it for other guests;
> it carefully avoids using virtio-net to avoid vhost; but on s390x it
> uses virtio-net-ccw - could that hit the vhost it was trying to avoid?

I've seen several hangs in the last few days, all on s390x guests.
It is intermittent though, so sometimes s390x works fine.

thanks
-- PMM
