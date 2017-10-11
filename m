Received: from eggs.gnu.org ([2001:4830:134:3::10]:50771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2GkQ-0004fr-Tn
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2GkL-0003JV-Ez
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:08:30 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:53819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2GkL-0003Iv-8L
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:08:25 -0400
Received: by mail-wm0-x22f.google.com with SMTP id q132so4649976wmd.2
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 06:08:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171010080201.GB4177@dhcp-200-186.str.redhat.com>
References: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
	<62e835a4-ba5d-e620-47d2-180932a33426@redhat.com>
	<20171006135425.GF26575@redhat.com>
	<CAEfK_444_fPwjnj1M8w8XNFFwiMJW-pdN7R1Tdu+FfvB38ZBtw@mail.gmail.com>
	<20171006140137.GH26575@redhat.com>
	<CAEfK_455Hr1afv-H6=9QMQErDGZJtOBgFMk2F8QJshYTLgOa1Q@mail.gmail.com>
	<e46a6b2d-83e2-d558-028c-94ad41af8fa2@redhat.com>
	<CAEfK_44_43d5_KaGUf-FH7bHxre5BP1wCQu96p38bhskUqU+Ug@mail.gmail.com>
	<87h8v7lcan.fsf@dusky.pond.sub.org>
	<20171010080201.GB4177@dhcp-200-186.str.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Oct 2017 14:08:03 +0100
Message-ID: <CAFEAcA-jb=4eTgD836+darXBLBuDA70pcypON2Bbj3b0SpNTaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Patch to add helpful tracing output for driver
 authors in NVMe emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Doug Gale <doug16k@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>

On 10 October 2017 at 09:02, Kevin Wolf <kwolf@redhat.com> wrote:
> Assertions are for checking that assumptions in qemu code hold true.
> Here it's about bad guest code, and you can't let qemu abort for that.
>
> Tracing is the right tool to detect bad guest code, and I think it makes
> sense to mark conditions that shouldn't happen with a correctly
> operating guest driver. I'm not sure if an exclamation mark is the best
> syntax for this, because I wouldn't have intuitively understood what
> it's supposed to tell me.

We have qemu_log_mask(LOG_GUEST_ERROR, ...) for logging guest errors,
so I think we should use that.

thanks
-- PMM
