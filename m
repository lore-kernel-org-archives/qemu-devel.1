Received: from eggs.gnu.org ([2001:4830:134:3::10]:34852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faJap-0002T7-NC
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faJao-00052E-Pk
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:35:35 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:46288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faJao-00051o-Da
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:35:34 -0400
Received: by mail-oi0-x22c.google.com with SMTP id y207-v6so3051024oie.13
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 04:35:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703113229.GD3812@localhost.localdomain>
References: <20180622125502.GF4366@localhost.localdomain>
	<ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
	<20180622142513.GH4366@localhost.localdomain>
	<20180622143146.GQ23296@redhat.com>
	<20180625095322.GC18580@redhat.com>
	<20180625114106.GJ5024@localhost.localdomain>
	<20180625114528.GL16514@angien.pipo.sk>
	<20180702080411.GA4299@localhost.localdomain>
	<60f6bf3c-6cad-c86f-01d7-8c376a6ccfe0@de.ibm.com>
	<20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 12:35:13 +0100
Message-ID: <CAFEAcA8uo72D79rRjP7sTz-C1-vxahFKMk3gxWs_cJqVBYXpAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Krempa <pkrempa@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 3 July 2018 at 12:32, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 03.07.2018 um 13:22 hat Daniel P. Berrang=C3=A9 geschrieben:
>> Just posted latest version here:
>>
>>   https://www.redhat.com/archives/libvir-list/2018-July/msg00130.html
>>
>> It will be in the next release on ~ Aug 1st
>
> It would have been a lot nicer to have it the July release because this
> means that we'll have the released libvirt broken during almost the
> whole rc phase of QEMU 3.0, but the release is planned for Aug 8th the
> earliest, so I guess we're still okay. People using QEMU from git will
> just need libvirt from git as well.

I'm still not clear what we gain from having a QEMU that's dropped
a feature that is still used by everything except leading-edge
not-yet-released versions of libvirt. Is there a strong reason we
can't just revert the deletion of the deprecated feature for a QEMU
release or two?

thanks
-- PMM
