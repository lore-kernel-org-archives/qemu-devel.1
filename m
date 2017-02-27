Received: from eggs.gnu.org ([2001:4830:134:3::10]:49546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciRAz-0003Yb-I1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciRAv-0003Tv-M4
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ciRAv-0003To-GD
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:37 -0500
Date: Mon, 27 Feb 2017 16:41:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170227194134.GH2778@thinpad.lan.raisama.net>
References: <20170227162501.29280-1-ehabkost@redhat.com>
	<CAFEAcA8b_tdQAP6YVDRaZKzHLed5xKbfABtJUV0U43HpkTiBdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8b_tdQAP6YVDRaZKzHLed5xKbfABtJUV0U43HpkTiBdg@mail.gmail.com>
Subject: [Qemu-devel] travis-ci 'make check' timeouts (was Re: [PULL 00/11]
 x86 queue, 2017-02-27)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Feb 27, 2017 at 07:16:03PM +0000, Peter Maydell wrote:
[...]
> This seemed to hang in 'make check' on x86. I didn't have time to
> investigate, so I'll have another go with it later.

I have been seeing lots of travis-ci failures recently because of
'make check' taking too long. The jobs seem to timeout while
running tests/test-aio-multithread.

I see similar failures on recent qemu.git master jobs, too:
https://travis-ci.org/qemu/qemu/builds

Are they similar to the hang you have seen?

-- 
Eduardo
