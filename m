Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E737C388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 16:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B2B206E9
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 16:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B2B206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYtUD-00073M-Fh
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 12:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kYtTV-0006LN-3V
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 12:11:29 -0400
Received: from 1.mo52.mail-out.ovh.net ([178.32.96.117]:37795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kYtTS-0004Im-G4
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 12:11:28 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.114])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 3887620097F;
 Sat, 31 Oct 2020 17:11:13 +0100 (CET)
Received: from kaod.org (37.59.142.106) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Sat, 31 Oct
 2020 17:11:13 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0060d788c9d-cfac-474f-a40c-d2f4674bb917,
 2F54911E0F6A4FE01AC36C20AF5A9A51754373E7) smtp.auth=groug@kaod.org
Date: Sat, 31 Oct 2020 17:11:07 +0100
From: Greg Kurz <groug@kaod.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v10] spapr: Implement Open Firmware client interface
Message-ID: <20201031171107.4a75a9db@bahia.lan>
In-Reply-To: <0beb2a31-4910-36bc-18ee-699c42b63cb3@ozlabs.ru>
References: <20201013021911.28701-1-aik@ozlabs.ru>
 <0beb2a31-4910-36bc-18ee-699c42b63cb3@ozlabs.ru>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 777b2a78-d375-4211-911b-9432b3e3dbf2
X-Ovh-Tracer-Id: 10133380637889042851
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrleejgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveelhfdtudffhfeiveehhfelgeellefgteffteekudegheejfffghefhfeeuudffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuh
Received-SPF: pass client-ip=178.32.96.117; envelope-from=groug@kaod.org;
 helo=1.mo52.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 12:11:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 31 Oct 2020 16:53:24 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> Has anyone at least tried this, or everybody is busy  KVMforuming? :)
>=20

Yeah virtualKVMforuming :)

I had tried when you posted this v10 but I didn't get far at the time,
because the kernel I was passing didn't want to boot and then I got
distracted by more urgent work... so I just gave a try on my laptop=20
(fedora32 with gcc-10.2.1-6.fc32.x86_64) and:

[36/945] Compiling C object libqemu-ppc64-softmmu.fa.p/hw_ppc_spapr_of_clie=
nt.c.o
FAILED: libqemu-ppc64-softmmu.fa.p/hw_ppc_spapr_of_client.c.o=20
cc -Ilibqemu-ppc64-softmmu.fa.p -I. -I../.. -Itarget/ppc -I../../target/ppc=
 -Itrace -Iqapi -Iui -Iui/shader -I/usr/include/capstone -I/usr/include/pix=
man-1 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -fdiagnostics-c=
olor=3Dauto -pipe -Wall -Winvalid-pch -Werror -std=3Dgnu99 -O2 -g -U_FORTIF=
Y_SOURCE -D_FORTIFY_SOURCE=3D2 -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BIT=
S=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wundef -W=
write-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv=
 -Wold-style-declaration -Wold-style-definition -Wtype-limits -Wformat-secu=
rity -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-ex=
terns -Wendif-labels -Wexpansion-to-defined -Wno-missing-include-dirs -Wno-=
shift-negative-value -Wno-psabi -fstack-protector-strong -isystem /home/gre=
g/Work/qemu/qemu-ppc/linux-headers -isystem linux-headers -iquote /home/gre=
g/Work/qemu/qemu-ppc/tcg/i386 -iquote . -iquote /home/greg/Work/qemu/qemu-p=
pc -iquote /home/greg/Work/qemu/qemu-ppc/accel/tcg -iquote /home/greg/Work/=
qemu/qemu-ppc/include -iquote /home/greg/Work/qemu/qemu-ppc/disas/libvixl -=
pthread -fPIC -isystem../../linux-headers -isystemlinux-headers -DNEED_CPU_=
H '-DCONFIG_TARGET=3D"ppc64-softmmu-config-target.h"' '-DCONFIG_DEVICES=3D"=
ppc64-softmmu-config-devices.h"' -MD -MQ libqemu-ppc64-softmmu.fa.p/hw_ppc_=
spapr_of_client.c.o -MF libqemu-ppc64-softmmu.fa.p/hw_ppc_spapr_of_client.c=
.o.d -o libqemu-ppc64-softmmu.fa.p/hw_ppc_spapr_of_client.c.o -c ../../hw/p=
pc/spapr_of_client.c
../../hw/ppc/spapr_of_client.c: In function =E2=80=98prop_format=E2=80=99:
../../hw/ppc/spapr_of_client.c:131:29: error: comparison is always false du=
e to limited range of data type [-Werror=3Dtype-limits]
  131 |         if (*c < 0x20 || *c >=3D 0x80) {
      |                             ^~

Fixed by:

-    const char *c;
+    const unsigned char *c;

../../hw/ppc/spapr_of_client.c: In function =E2=80=98spapr_h_of_client=E2=
=80=99:
../../hw/ppc/spapr_of_client.c:793:35: error: taking address of packed memb=
er of =E2=80=98struct prom_args=E2=80=99 may result in an unaligned pointer=
 value [-Werror=3Daddress-of-packed-member]
  793 |                                   &pargs.args[nargs + 1]);
      |                                   ^~~~~~~~~~~~~~~~~~~~~~
../../hw/ppc/spapr_of_client.c:800:38: error: taking address of packed memb=
er of =E2=80=98struct prom_args=E2=80=99 may result in an unaligned pointer=
 value [-Werror=3Daddress-of-packed-member]
  800 |                                      &pargs.args[nargs + 1]);
      |                                      ^~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Fixed by dropping QEMU_PACKED and ensuring we don't have unwanted padding:

-} QEMU_PACKED;
+};
+
+QEMU_BUILD_BUG_ON(sizeof(struct prom_args) !=3D 13 * 4);

I'll resume my experiments later :)

Cheers,

--
Greg

