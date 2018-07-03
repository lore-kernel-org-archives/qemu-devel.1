Received: from eggs.gnu.org ([2001:4830:134:3::10]:47808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1faKa2-0005xc-Hh
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1faKZz-0001C4-MD
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:38:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41674
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1faKZz-0001Bh-HF
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:38:47 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63CTQ20051490
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 08:38:47 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k08vvhba6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:38:46 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 3 Jul 2018 13:38:42 +0100
References: <20180622125502.GF4366@localhost.localdomain>
	<ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
	<20180622142513.GH4366@localhost.localdomain>
	<20180622143146.GQ23296@redhat.com> <20180625095322.GC18580@redhat.com>
	<20180625114106.GJ5024@localhost.localdomain>
	<20180625114528.GL16514@angien.pipo.sk>
	<20180702080411.GA4299@localhost.localdomain>
	<60f6bf3c-6cad-c86f-01d7-8c376a6ccfe0@de.ibm.com>
	<20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
	<CAFEAcA8uo72D79rRjP7sTz-C1-vxahFKMk3gxWs_cJqVBYXpAQ@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 3 Jul 2018 14:38:39 +0200
In-Reply-To: <CAFEAcA8uo72D79rRjP7sTz-C1-vxahFKMk3gxWs_cJqVBYXpAQ@mail.gmail.com>
Content-Language: en-US
Message-Id: <d8b2efe4-0317-93e9-8c7d-41a0be2c1ff2@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
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
To: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>



On 07/03/2018 01:35 PM, Peter Maydell wrote:
> On 3 July 2018 at 12:32, Kevin Wolf <kwolf@redhat.com> wrote:
>> Am 03.07.2018 um 13:22 hat Daniel P. Berrang=C3=A9 geschrieben:
>>> Just posted latest version here:
>>>
>>>   https://www.redhat.com/archives/libvir-list/2018-July/msg00130.html
>>>
>>> It will be in the next release on ~ Aug 1st
>>
>> It would have been a lot nicer to have it the July release because this
>> means that we'll have the released libvirt broken during almost the
>> whole rc phase of QEMU 3.0, but the release is planned for Aug 8th the
>> earliest, so I guess we're still okay. People using QEMU from git will
>> just need libvirt from git as well.
>=20
> I'm still not clear what we gain from having a QEMU that's dropped
> a feature that is still used by everything except leading-edge
> not-yet-released versions of libvirt. Is there a strong reason we
> can't just revert the deletion of the deprecated feature for a QEMU
> release or two?

+1
