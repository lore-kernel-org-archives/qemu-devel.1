Received: from eggs.gnu.org ([2001:4830:134:3::10]:43761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpdU8-0003cD-FL
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpdTt-0000NZ-Eb
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:52:00 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fpdTt-0000MO-5X
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:51:45 -0400
Received: by mail-oi0-x243.google.com with SMTP id k12-v6so35204837oiw.8
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 10:51:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ1tprBXs6PWP=SsjtPOPNxPJfvWsWFoHCAhovJEGn4=mf8_tw@mail.gmail.com>
References: <20180729143545.6978-1-samuel.thibault@ens-lyon.org>
	<20180729143545.6978-2-samuel.thibault@ens-lyon.org>
	<CAFEAcA8tX0_MNg99oorgOWarJa8Oy+gFFwoRys-fU7ZX3_Ufng@mail.gmail.com>
	<CAJ1tprAuf1mWtpw+4M3QFZyrDz22TMcnGS9xkhQn6Q9UQTrwiw@mail.gmail.com>
	<CAFEAcA_pj4tFE2tyrbRtvJnPoeRekDXtVJCzgSeFiiK=sxg4Aw@mail.gmail.com>
	<CAJ1tprAyHqgH1mHkeLu6qU1Fr8O-B5ebJ3Cfw8e_nHMYSYXfmQ@mail.gmail.com>
	<CAFEAcA8DdkVB6LG=wq10wJDBjZgScdC_6tavtMzEi-UgGXjEKw@mail.gmail.com>
	<CAJ1tprA11Q+kjkdmmpmJRiLbDveWR6qzKY3hz_FbRXAUPpXy6A@mail.gmail.com>
	<CAJ1tprBXs6PWP=SsjtPOPNxPJfvWsWFoHCAhovJEGn4=mf8_tw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 16:52:05 +0100
Message-ID: <CAFEAcA8qK_xGoGfrheganVLUepdGuiheq1UXRu5+iLW5tz=K1Q@mail.gmail.com>
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

On 12 August 2018 at 04:11, Andrew Oates <aoates@google.com> wrote:
> Ping --- would you like me to resubmit the patch using CONFIG_BSD?

Yes, that seems our best option. Could you please also include
a comment that summarises the behaviour of the other host OSes
and why we're using this ifdef?

thanks
-- PMM
