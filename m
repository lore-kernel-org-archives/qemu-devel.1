Received: from eggs.gnu.org ([2001:4830:134:3::10]:55634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXOwz-0001YG-4N
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXOwy-0000Hc-5d
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:37:53 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXOwx-0000HE-Va
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:37:52 -0400
Received: by mail-wr0-x231.google.com with SMTP id y43so20562129wrd.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 02:37:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f66c4cb9-e024-d874-8e40-7c42eb489d23@redhat.com>
References: <20170717063521.GA7393@lemon>
	<b718f71c-5208-298a-4fb9-0c2fea3146ec@redhat.com>
	<20170717231721.GE2585@lemon>
	<f66c4cb9-e024-d874-8e40-7c42eb489d23@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 10:37:30 +0100
Message-ID: <CAFEAcA_dUAasSEPQdeWLBuihaPGQGUcfAz=eRW-s7cdfesNNag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 18 July 2017 at 10:11, Thomas Huth <thuth@redhat.com> wrote:
> Could the test be rewritten to provide a proper timeout handling
> instead? Tests should clearly fail after a while instead of hanging
> forever...
> Or maybe we could add some magic that the troublesome tests are not
> executed if a certain environment variable is set, so we could skip them
> in these automated setups here?

I think it's always going to be possible that some bug in
QEMU results in a test hanging -- so it must be down to
the test harness to deal with hanging tests. And then
once you have that functionality in the test harness it
doesn't matter quite so much whether an individual test
has its own timeout handling or not.

thanks
-- PMM
