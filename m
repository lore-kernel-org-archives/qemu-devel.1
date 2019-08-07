Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A85C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AB721BF6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AB721BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvLGC-0004W0-V0
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 08:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46337)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hvLFn-0003xv-MD
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hvLFm-0007uf-Fv
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:41:19 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.234]:21551)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hvLFe-0007ic-D8; Wed, 07 Aug 2019 08:41:10 -0400
Received: from tpw09926dag18g.domain1.systemhost.net (10.9.212.34) by
 RDW083A012ED68.bt.com (10.187.98.38) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 7 Aug 2019 13:40:45 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18g.domain1.systemhost.net (10.9.212.34) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 7 Aug 2019 13:41:06 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Wed, 7 Aug 2019
 13:41:06 +0100
From: <tony.nguyen@bt.com>
To: <philmd@redhat.com>, <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v6 00/26] Invert Endian bit in SPARCv9 MMU
 TTE
Thread-Index: AQHVTPljpfwTk/sMkk++4xOSHxskc6bvbaGAgAAxHHw=
Date: Wed, 7 Aug 2019 12:41:06 +0000
Message-ID: <1565181666201.26324@bt.com>
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>,
 <2397186a-a28e-85dd-131c-900e777a60ad@redhat.com>
In-Reply-To: <2397186a-a28e-85dd-131c-900e777a60ad@redhat.com>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.44]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.234
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 00/26] Invert Endian bit in SPARCv9 MMU
 TTE
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, sagark@eecs.berkeley.edu, mst@redhat.com,
 green@moxielogic.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 keith.busch@intel.com, jcmvbkbc@gmail.com, frederic.konrad@adacore.com,
 pbonzini@redhat.com, kraxel@redhat.com, edgar.iglesias@gmail.com,
 mreitz@redhat.com, pburton@wavecomp.com, marex@denx.de, robh@kernel.org,
 hare@suse.com, gxt@mprc.pku.edu.cn, berto@igalia.com, proljc@gmail.com,
 qemu-block@nongnu.org, arikalo@wavecomp.com, jslaby@suse.cz, deller@gmx.de,
 david@redhat.com, magnus.damm@gmail.com, yuval.shaia@oracle.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, hpoussin@reactos.org,
 joel@jms.id.au, anthony.perard@citrix.com, marcandre.lureau@redhat.com,
 david@gibson.dropbear.id.au, jasowang@redhat.com, atar4qemu@gmail.com,
 antonynpavlov@gmail.com, jiri@resnulli.us, ehabkost@redhat.com,
 minyard@acm.org, jcd@tribudubois.net, sw@weilnetz.de, alistair@alistair23.me,
 chouteau@adacore.com, b.galvani@gmail.com, eric.auger@redhat.com,
 alex.williamson@redhat.com, sstabellini@kernel.org, jan.kiszka@web.de,
 clg@kaod.org, stefanha@redhat.com, imammedo@redhat.com,
 xen-devel@lists.xenproject.org, shorne@gmail.com, andrew.smirnov@gmail.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, xiaoguangrong.eric@gmail.com, qemu-riscv@nongnu.org,
 andrew@aj.id.au, lersek@redhat.com, crwulff@gmail.com, laurent@vivier.eu,
 Andrew.Baumann@microsoft.com, sundeep.lkml@gmail.com, i.mitsyanko@gmail.com,
 michael@walle.cc, paul.durrant@citrix.com, qemu-ppc@nongnu.org,
 huth@tuxfamily.org, amarkovic@wavecomp.com, kbastian@mail.uni-paderborn.de,
 cohuck@redhat.com, peter.chubb@nicta.com.au, aurelien@aurel32.net,
 stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/19 8:37 PM, Philippe Mathieu-Daud=E9 wrote:

> I'm confused I think I already reviewed various patches of your previous
?> series but don't see my Reviewed-by tags.?


Apologies Philippe! I am the confused one here =3D/


Will append.


Thank you very much for the reviews and qemu-devel newbie tips so far. I ha=
ve felt very welcome.


Tony
