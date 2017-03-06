Received: from eggs.gnu.org ([2001:4830:134:3::10]:48189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ckh3R-0004ZG-HN
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 20:03:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ckh3O-0006q6-FE
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 20:03:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ckh3O-0006po-A6
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 20:03:10 -0500
Date: Mon, 6 Mar 2017 09:03:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170306010303.GA31251@lemon.lan>
References: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
	<148858561902.285.12747236824169770569@0e2666bad730>
	<CAFEAcA-D37hty_DmU-VtudwnrEMeS=93HB5pe4HHL9GThRbQxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-D37hty_DmU-VtudwnrEMeS=93HB5pe4HHL9GThRbQxQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/6] disas: Fix various coverity
 nits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On Sat, 03/04 12:44, Peter Maydell wrote:
> On 4 March 2017 at 00:00,  <no-reply@patchew.org> wrote:
> > Hi,
> >
> > This series failed build test on s390x host. Please find the details below.
> 
> > === TEST BEGIN ===
> > Using CC: /home/fam/bin/cc
> > rm: cannot remove '/var/tmp/patchew-qemu-build/aarch64-softmmu': Directory not empty
> > === OUTPUT END ===
> 
> Fam, can we drop the s390x test from patchew until it gets fixed,
> please? Right now it's just spamming the list and means that
> actually interesting patchew emails are likely to get ignored...

OK, I've changed this test to off-list reply and I'll continue investigating.
Though I think that apart from this apparent tester hiccup and another one false
positive out of my manual intervention, other s390x reports are actual QEMU
issue.

Fam
