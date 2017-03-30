Received: from eggs.gnu.org ([2001:4830:134:3::10]:43452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctblc-0001Cl-6M
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctblb-0005Kc-AK
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:13:40 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:34922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ctblb-0005JZ-2g
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:13:39 -0400
Received: by mail-lf0-x22c.google.com with SMTP id j90so29379410lfk.2
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 08:13:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149029914932.3910.14105127854664571409@loki>
References: <CAFEAcA8EgBp8=xjyfR+nuYw5KvdptNC++o39nAJiwu-SWWM+yw@mail.gmail.com>
	<149029914932.3910.14105127854664571409@loki>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Mar 2017 16:13:17 +0100
Message-ID: <CAFEAcA8Yhm-vaf+AYfNTZG5jR6tVv1mtt_tGCiRD+SVBZ5mFJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qga-test failure on Linux/sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 March 2017 at 19:59, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> Quoting Peter Maydell (2017-03-23 10:13:13)
>> Hi; I find that qga-test fails on Linux/sparc host:

> I think the code is assuming that it'll be the virtual block device
> itself that's mounted, rather than a partition within it. This is
> certainly a false assumption, so we shouldn't be making this a
> fatal error.
>
> It does make me wonder if we *should* be looking at the parent to
> get the slave/device information though, which in turn means we
> might want logic to traverse up the whole tree for nested cases.
> But the GuestDiskAddress field of GuestFilesystemInfo is documented
> as possibly being empty for certain disk types, so I think for now
> we can simply relax the error. Will send a patch for 2.9.

Did you find time to write a patch for this yet?
It would be nice to be able to add the sparc machine to the
build test set for 2.9.

thanks
-- PMM
