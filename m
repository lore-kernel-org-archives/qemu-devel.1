Received: from eggs.gnu.org ([2001:4830:134:3::10]:37401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e3m4m-0001nU-Mz
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e3m4l-0002kv-UH
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:47:44 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:45980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e3m4l-0002kO-Nb
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:47:43 -0400
Received: by mail-wm0-x22a.google.com with SMTP id q124so29503618wmb.0
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 09:47:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87tvz08jc3.fsf@frigg.lan>
References: <87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
	<87o9pywt8k.fsf@frigg.lan> <87shf5zlty.fsf@frigg.lan>
	<20170929175943.GA25038@flamenco>
	<87vak1w53a.fsf@frigg.lan> <20170930180941.GA22048@flamenco>
	<8760bu333n.fsf@frigg.lan> <20171005005043.GA20425@flamenco>
	<87vajsl3h7.fsf@frigg.lan> <20171006175929.GA28281@flamenco>
	<87tvz08jc3.fsf@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 15 Oct 2017 17:47:21 +0100
Message-ID: <CAFEAcA8drKvtqmLNKx4oQs+zGUNBgnh3g9Q1X=TbPzoqT2iC2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 15 October 2017 at 17:30, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wrot=
e:
> Thinking about it, shouldn't this always be the same given QEMU's TLB/pag=
e table
> consistency assurances?

What TLB/page table consistency assurances? For ARM at least
we will only update (ie flush) the TLB when the guest next
executes a relevant TLB maintenance instruction. So a
misbehaving guest can set things up so the page table
is completely different from what's in QEMU's TLB if it
wants. This all falls in the realms of architecturally
unpredictable behaviour for the guest -- whether you
want the instrumentation to be confused as well is a
different question...

thanks
-- PMM
