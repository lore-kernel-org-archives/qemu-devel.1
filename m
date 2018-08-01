Received: from eggs.gnu.org ([2001:4830:134:3::10]:48410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fko5d-00048E-Gh
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 06:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fko5c-0007al-Ls
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 06:10:45 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:34212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fko5c-0007aZ-Fl
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 06:10:44 -0400
Received: by mail-oi0-x231.google.com with SMTP id 13-v6so33562046ois.1
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 03:10:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ1tprAyHqgH1mHkeLu6qU1Fr8O-B5ebJ3Cfw8e_nHMYSYXfmQ@mail.gmail.com>
References: <20180729143545.6978-1-samuel.thibault@ens-lyon.org>
	<20180729143545.6978-2-samuel.thibault@ens-lyon.org>
	<CAFEAcA8tX0_MNg99oorgOWarJa8Oy+gFFwoRys-fU7ZX3_Ufng@mail.gmail.com>
	<CAJ1tprAuf1mWtpw+4M3QFZyrDz22TMcnGS9xkhQn6Q9UQTrwiw@mail.gmail.com>
	<CAFEAcA_pj4tFE2tyrbRtvJnPoeRekDXtVJCzgSeFiiK=sxg4Aw@mail.gmail.com>
	<CAJ1tprAyHqgH1mHkeLu6qU1Fr8O-B5ebJ3Cfw8e_nHMYSYXfmQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Aug 2018 11:10:23 +0100
Message-ID: <CAFEAcA8DdkVB6LG=wq10wJDBjZgScdC_6tavtMzEi-UgGXjEKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 1/1] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Oates <aoates@google.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, "J. Kiszka" <jan.kiszka@siemens.com>

On 1 August 2018 at 00:25, Andrew Oates <aoates@google.com> wrote:
> Both CONFIG_BSD and not-CONFIG_LINUX work on macOS.  I unfortunately don't
> have access to any other BSDs to test them, though.

Is there an easy way to test it? The QEMU makefiles have some
runes for setting up a BSD VM...

thanks
-- PMM
