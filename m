Received: from eggs.gnu.org ([2001:4830:134:3::10]:52240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhYew-0001rV-0A
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhYev-0000sy-2j
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:01:14 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:38557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhYeu-0000sW-TF
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:01:13 -0400
Received: by mail-wr0-x22d.google.com with SMTP id m57so1628785wrm.5
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 03:01:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170814204450.24118-1-farman@linux.vnet.ibm.com>
References: <20170814204450.24118-1-farman@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Aug 2017 11:00:51 +0100
Message-ID: <CAFEAcA8=_1exzxHEOvmFV1r_oxaGi7beeCVzy=bvVx8tQTNU8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/1] Fix "make clean" for s390
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On 14 August 2017 at 21:44, Eric Farman <farman@linux.vnet.ibm.com> wrote:
> How often does one really do a "make clean" ?  Rather infrequently,
> as I only stumbled on this today.

FWIW, one of my standard pre-merge build tests does a
"make clean" and then a make (mostly as a check that we
do build from clean as well as incrementally). Not sure
why it didn't catch this...

thanks
-- PMM
