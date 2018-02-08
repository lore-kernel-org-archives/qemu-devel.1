Received: from eggs.gnu.org ([2001:4830:134:3::10]:37805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejqcX-0002ev-7a
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejqcW-0004h6-5E
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:08:29 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:45026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejqcV-0004gT-Vy
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:08:28 -0500
Received: by mail-oi0-x235.google.com with SMTP id b3so4145495oib.11
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 10:08:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqGr2e8vjQUUypkoyUc=QGQDNVkjydmOadfsSCzm78nkJQ@mail.gmail.com>
References: <20180207042438.15422-1-andrew.smirnov@gmail.com>
	<20180207042438.15422-10-andrew.smirnov@gmail.com>
	<CAFEAcA-=-+1A6toXM-ddP+iKBgHKh28Xq3VeGXfSLJ08xMRijA@mail.gmail.com>
	<20180208193033-mutt-send-email-mst@kernel.org>
	<CAHQ1cqGr2e8vjQUUypkoyUc=QGQDNVkjydmOadfsSCzm78nkJQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 18:08:06 +0000
Message-ID: <CAFEAcA8VQtdCTQRYF1xMnUoxZC=2q1DUdTyqMiu1mPjZx_Dsiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 09/14] pci: Use pci_config_size in
 pci_data_* accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 8 February 2018 at 17:43, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> My only justification for this change was suggestion from Marcel to
> use pci_data_* functions, instead of calling pci_host_config_*_common
> explicitly in designware.c introduced in next patch in the series. My
> v4 patches incorrectly limited config space size to 256, so such
> replacement didn't require this patch, but switching pci_data_* to use
> pci_config_size() seemed harmless enough. I am more than happy to got
> back to using pci_host_config_*_common in designware.c and dropping
> this patch.

OK. I'll keep patches 1-8, 11 and 13 in target-arm, and drop 9, 10,
12 and 14 for the moment.

thanks
-- PMM
