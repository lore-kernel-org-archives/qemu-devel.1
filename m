Received: from eggs.gnu.org ([2001:4830:134:3::10]:39594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cHwFF-0003B3-Rc
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 12:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cHwFA-0004rg-Qi
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 12:24:33 -0500
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:37334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cHwFA-0004pO-KG
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 12:24:28 -0500
Received: from player760.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id F2C45570E5
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 18:24:17 +0100 (CET)
References: <1480441323-31417-1-git-send-email-clg@kaod.org>
	<CAFEAcA9SVh-pUS+mnPWBYgWR9is49ysh9O_y35K-x2iyDwhfNg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f7bba440-f985-3fc4-cc93-f12dac768426@kaod.org>
Date: Fri, 16 Dec 2016 18:24:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9SVh-pUS+mnPWBYgWR9is49ysh9O_y35K-x2iyDwhfNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] FTGMAC100 model for the Aspeed SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Dmitry Fleytman <dmitry@daynix.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 12/16/2016 05:48 PM, Peter Maydell wrote:
> On 29 November 2016 at 17:41, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>> The Aspeed SoCs AST2400 and AST2500 have two FTGMAC100 ethernet
>> controllers. This serie proposes a model for this device and a way to
>> customize the bit definitions which are slightly different from the
>> Faraday definitions.
>>
>> The last patch adds a fake NC-SI (Network Controller Sideband
>> Interface) backend to pretend a NIC is being managed.
>=20
> Could you explain in a bit more detail why the patchset is
> marked "RFC" and what parts you want comments on?  (An RFC
> patchset that doesn't say this kind of thing in the cover letter
> is dangerously close to being a "please ignore me" request :-))

This is true. I didn't take the time to do so ...

Well, first, this is not an area I am familiar with, so this=20
might look more like a draft for experts and the review should=20
take that into account :)=20

Also, I am not entirely satisfied with how the model looks for=20
the first descriptor to transmit. May be I am trying to fit=20
too well the driver.

And, the NC-SI is just a fake one to exercise the linux driver=20
(we did find bugs with it) but I am wondering how far we should=20
push the model. It's a rather complex interface.

Thanks,

C.=20
