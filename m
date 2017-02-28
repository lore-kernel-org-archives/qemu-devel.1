Received: from eggs.gnu.org ([2001:4830:134:3::10]:48843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cinHe-0003DH-Eo
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:18:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cinHd-0002ov-3G
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:18:02 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cinHc-0002nq-SZ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:18:01 -0500
Received: by mail-wm0-x22c.google.com with SMTP id v186so93395850wmd.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 11:18:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228191226.GI2778@thinpad.lan.raisama.net>
References: <20170227162501.29280-1-ehabkost@redhat.com>
	<CAFEAcA8b_tdQAP6YVDRaZKzHLed5xKbfABtJUV0U43HpkTiBdg@mail.gmail.com>
	<20170227194134.GH2778@thinpad.lan.raisama.net>
	<20170227205753.60b8a225@bahia.lan>
	<20170228191226.GI2778@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 19:17:39 +0000
Message-ID: <CAFEAcA8iZG8yB=4an9O2Mroej8bWNHBcANxsJkCOVbKHcxaGRg@mail.gmail.com>
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
Cc: Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 28 February 2017 at 19:12, Eduardo Habkost <ehabkost@redhat.com> wrote:
> I saw a failure on x86-pull-request that seemed to be because of
> vhost-user-test[1]. However, after restarting the job, it
> passed[2].

I'm currently processing a patch which (hopefully) fixes
vhost-user-test's intermittent failures:
http://patchwork.ozlabs.org/patch/732747/

thanks
-- PMM
