Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81569C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 09:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5186520675
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 09:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5186520675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGKDH-0006us-FV
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 05:17:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hGKAA-0004R7-OU
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hGKA9-0004VW-5i
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:13:58 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:46437
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hGKA8-0004Tt-PF
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:13:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id D2E96818D7;
	Tue, 16 Apr 2019 11:13:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
	by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k3gLcQR1mZs1; Tue, 16 Apr 2019 11:13:54 +0200 (CEST)
Received: from localhost.localdomain
	(apoitiers-155-1-191-106.w109-220.abo.wanadoo.fr [109.220.154.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.eu.adacore.com (Postfix) with ESMTPSA id 061D8815A8;
	Tue, 16 Apr 2019 11:13:48 +0200 (CEST)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87d0mwatbu.fsf@dusky.pond.sub.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <6ac64f2d-58d5-695b-8111-8b68cb3916c1@adacore.com>
Date: Tue, 16 Apr 2019 11:13:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87d0mwatbu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 194.98.77.210
Subject: Re: [Qemu-devel] Maintainers,
 please tell us how to boot your machines!
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paul Burton <pburton@wavecomp.com>, Chris Wulff <crwulff@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
	Jia Liu <proljc@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
	Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
	Magnus Damm <magnus.damm@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Alistair Francis <alistair@alistair23.me>,
	Fabien Chouteau <chouteau@adacore.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Paul Durrant <paul.durrant@citrix.com>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Richard Henderson <rth@twiddle.net>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Cornelia Huck <cohuck@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Michael Walle <michael@walle.cc>,
	Thomas Huth <huth@tuxfamily.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416091346.bIMfk1XQasEzaWPkqXa8GmWvGLs3bXBzU4P2CtfcS7s@z>


Le 3/12/19 =C3=A0 6:36 PM, Markus Armbruster a =C3=A9crit=C2=A0:
> Dear board code maintainers,

Hi Markus,

>=20
> This is a (rather late) follow-up to the last QEMU summit.  Minutes[*]:
>=20

[...]

>=20
>      =3D hw/sparc/leon3.c =3D
>      Fabien Chouteau <chouteau@adacore.com> (maintainer:Leon3)
>      Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> (maintainer:SPARC=
)
>      Artyom Tarasenko <atar4qemu@gmail.com> (maintainer:SPARC)

We are still using with this board. I'll try to create a working linux im=
age for
it and get back to you.

Cheers,
Fred

