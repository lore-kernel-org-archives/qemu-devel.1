Received: from eggs.gnu.org ([2001:4830:134:3::10]:40929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb4OZ-0006sO-SR
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb4OZ-0001oO-85
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:01:47 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:37960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb4OZ-0001nf-1n
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:01:47 -0500
Received: by mail-ot0-x229.google.com with SMTP id v5so221389oth.5
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 05:01:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516008655-31732-1-git-send-email-thuth@redhat.com>
References: <1516008655-31732-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 13:01:25 +0000
Message-ID: <CAFEAcA8X+p=oWWBTquGjceZJVEfcD8eWDxdZnRe=jVaL7t+LEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] Clean up the ppc default configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>

On 15 January 2018 at 09:30, Thomas Huth <thuth@redhat.com> wrote:
> (off-topic question: Do we still need a separate ppcemb-softmmu nowadays?
> It seemed to be useful 10 years ago when everybody was doing KVM on
> embedded PPC, but these days seem to be pretty much over now, so IMHO
> just using ppc-softmmu for embedded should be enough nowadays? We could
> save quite some compilation- and "make check"-time if we could finally get
> rid of ppcemb-softmmu again...)

There are some specific differences guarded by TARGET_PPCEMB, like
the way it has a different TARGET_PAGE_BITS value, and some code
in target/ppc/kvm.c related to telling KVM about interrupts. You
would need to make those all be runtime decisions I assume.

thanks
-- PMM
