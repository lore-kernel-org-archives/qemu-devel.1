Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980BDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A96720780
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A96720780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDe7-00066y-Og
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreas.konopik@efs-auto.de>)
 id 1jqDVt-0003L2-Qt
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:29:17 -0400
Received: from mailin3.audi.de ([143.164.102.17]:53675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreas.konopik@efs-auto.de>)
 id 1jqDVr-0000eZ-ES
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:29:17 -0400
From: "Konopik, Andreas (EFS-GH2)" <andreas.konopik@efs-auto.de>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, David Brenken
 <david.brenken@efs-auto.org>
Subject: Re: [PATCH v3 1/1] tricore: added triboard with tc27x_soc
Thread-Topic: [PATCH v3 1/1] tricore: added triboard with tc27x_soc
Thread-Index: AdZOx+ecudLgwbd+Qa2lYFrQh/1gHQ==
Date: Tue, 30 Jun 2020 10:28:57 +0000
Message-ID: <4006678c6d834f4fb126314e83f99f5c@efs-auto.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.241.65.249]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Received-SPF: none client-ip=143.164.102.17;
 envelope-from=andreas.konopik@efs-auto.de; helo=mailin3.audi.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 06:29:10
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Hofstetter, Georg \(EFS-GH2\)" <Georg.Hofstetter@efs-auto.de>, "Brenken,
 David \(EFS-GH5\)" <david.brenken@efs-auto.de>, "Rasche,
 Robert \(EFS-GH2\)" <robert.rasche@efs-auto.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Biermanski, Lars
 \(EFS-GH3\)" <lars.biermanski@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bastian,

> On Mon, Jun 22, 2020 at 03:19:34PM +0200, David Brenken wrote:
> > From: Andreas Konopik <andreas.konopik@efs-auto.de>
> > +const MemmapEntry tc27x_soc_memmap[] =3D {
> > +    [TC27XD_DSPR2]     =3D { 0x50000000,   0x1E000 },
> > +    [TC27XD_DCACHE2]   =3D { 0x5001E000,    0x2000 },
> > +    [TC27XD_DTAG2]     =3D { 0x500C0000,     0xC00 },
>=20
> The size changed from 0xa00 to 0xc00 from v2. The manual states that it h=
as no
> size. I guess you inferred the size from the address range. How does real=
 hw
> behave if you access DTAG2?

DTAG size of 0xa00 was a mistake, 0xc00 is correct. Even though the manual =
does not assign sizes, DTAG and PTAG can be mapped for memory testing purpo=
ses.
Therefore memory accesses to DTAG/PTAG are possible (see Footnote 3 & 4 [1,=
 Page 3-10]).

Real hardware has to be configured via MTU before accessing DTAG/PTAG. Beca=
use QEMU tricore has no MTU, we wanted to be less restrictive by mapping DT=
AG/PTAG into memory.

> Why not use KiB/MiB sizes as before? I created a patch for that. Can you =
check
> that I didn't skrew up the sizes?

Thank you, the patch looks good to me.
How do you want to proceed? Should we send you a Patch v4?

> The remainder looks good to me.

Great!

Kind regards,

Andreas

[1] https://hitex.co.uk/fileadmin/uk-files/downloads/ShieldBuddy/tc27xD_um_=
v2.2.pdf

