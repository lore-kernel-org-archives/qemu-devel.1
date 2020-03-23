Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831C1C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FE52072D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FE52072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGMsQ-000634-Hr
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jGMrq-0005Sa-7z
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jGMro-0004DM-UI
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:11:46 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:55980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jGMrm-0004C3-2p; Mon, 23 Mar 2020 09:11:42 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A8AEB746381;
 Mon, 23 Mar 2020 14:11:38 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 847C97461AE; Mon, 23 Mar 2020 14:11:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8245B745953;
 Mon, 23 Mar 2020 14:11:38 +0100 (CET)
Date: Mon, 23 Mar 2020 14:11:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: Coverity CID 1421984
In-Reply-To: <88618db3-cb48-12bd-6152-b642b25a0287@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2003231359420.14974@zero.eik.bme.hu>
References: <d9b7d8d8-1640-7d69-cd16-66e6d9cef3d1@redhat.com>
 <88618db3-cb48-12bd-6152-b642b25a0287@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-389342008-1584969098=:14974"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-389342008-1584969098=:14974
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Mar 2020, Philippe Mathieu-Daud=C3=A9 wrote:
> Cc'ing qemu-ppc since this is restricted to the aCube Sam460ex board.
> On 3/23/20 12:46 PM, Max Reitz wrote:
>> Hi,
>>=20
>> I was triaging new Coverity block layer reports today, and one that
>> seemed like a real bug was CID 1421984:
>>=20
>> It complains about a memleak in sii3112_pci_realize() in
>> hw/ide/sii3112.c, specifically about @irq being leaked (it=E2=80=99s a=
llocated
>> by qemu_allocate_irqs(), but never put anywhere or freed).
>>=20
>> I=E2=80=99m not really well-versed in anything under hw/ide, so I was =
wondering
>> whether you agree it=E2=80=99s a bug and whether you know the correct =
way to fix
>> it.  (I assume it=E2=80=99s just a g_free(irqs), but maybe there=E2=80=
=99s a more
>> specific way that=E2=80=99s applicable here.)
>
> What does other devices is hold a reference in the DeviceState=20
> (SiI3112PCIState) to make static analyzers happy.

Other IDE devices such as ahci and cmd646 seem to free it at the end of=20
the init function after calling ide_init2 with it. However it's not clear=
=20
to me how all this is supposed to work. Ahci does for example:

qemu_irq *irqs =3D qemu_allocate_irqs(ahci_irq_set, s, s->ports);
for (i =3D 0; i < s->ports; i++) {
     ide_init2(&ad->port, irqs[i]);
}
g_free(irqs);

So it allocates an array of s->ports irqs then only frees a single=20
element? Also aren't these needed after ide_init2 to actually raise the=20
irq or are these end up copied to the irq field of the BMDMAState sonehow=
?=20
Where will that be freed?

> Ideally we should free such memory in the DeviceUnrealize handler, but =
we in=20
> the reality we only care for hotunpluggable devices.
> PCI devices usually are. There is a trick however, you can mark overwri=
te the=20
> DeviceClass::hotpluggable field in sii3112_pci_class_init:
>
>  dc->hotpluggable =3D false;

If the above is correct then simply adding g_free(irq) after the loop at=20
end of sii3112_pci_realize should be enough but I can't tell if that's=20
correct. Setting hotpluggable to false does not seem to be a good fix.

Regards,
BALATON Zoltan
--3866299591-389342008-1584969098=:14974--

