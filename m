Received: from eggs.gnu.org ([2001:4830:134:3::10]:51083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjTPo-0000r3-3a
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjTPn-0003xb-2v
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:17:16 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjTPm-0003wd-Tr
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:17:15 -0500
Received: by mail-wr0-x22a.google.com with SMTP id l37so56048407wrc.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 08:17:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170302160734.GB11509@thinpad.lan.raisama.net>
References: <20170227162501.29280-1-ehabkost@redhat.com>
	<CAFEAcA8b_tdQAP6YVDRaZKzHLed5xKbfABtJUV0U43HpkTiBdg@mail.gmail.com>
	<20170227194134.GH2778@thinpad.lan.raisama.net>
	<20170227205753.60b8a225@bahia.lan>
	<20170228191226.GI2778@thinpad.lan.raisama.net>
	<CAFEAcA8iZG8yB=4an9O2Mroej8bWNHBcANxsJkCOVbKHcxaGRg@mail.gmail.com>
	<20170302153913.GQ2778@thinpad.lan.raisama.net>
	<9dd3053b-1faf-e7a2-1cd7-aea934f5dc3c@redhat.com>
	<20170302160734.GB11509@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 16:16:53 +0000
Message-ID: <CAFEAcA_rB9biK2sic1NCtMkk-w=5Zis+SjtB22+Jw4e4zzUc6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] travis-ci 'make check' timeouts (was Re: [PULL
 00/11] x86 queue, 2017-02-27)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 2 March 2017 at 16:07, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Earlier this week I saw the wait_for_fds assertion (mentioned at
> the thread above) on a travis-ci job again, and I was suspecting
> it was the same vhost_set_mem_table() + TCG error seen at the
> thread above.
>
> Unfortunately travis-ci overwrote the previous logs when I
> restarted the job, and now I can't confirm if it was really the
> same vhost_set_mem_table() error. I guess we'll have to simply
> wait and see if it fails again.

Here's a fresh new travis job failing like that:
https://travis-ci.org/qemu/qemu/builds/207005044
(specifically https://travis-ci.org/qemu/qemu/jobs/207005050)

thanks
-- PMM
