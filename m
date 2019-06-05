Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_MULTIPLE_AT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540ABC28CC6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 12:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303E4206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 12:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303E4206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40872 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYVNc-0006Jh-Dv
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 08:51:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Natalia.Fursova@ispras.ru>) id 1hYVM6-0005Wp-Br
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Natalia.Fursova@ispras.ru>) id 1hYV7P-0000HH-Mi
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:34:18 -0400
Received: from mail.ispras.ru ([83.149.199.45]:41096)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Natalia.Fursova@ispras.ru>) id 1hYV7P-0000AN-FM
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:34:15 -0400
Received: from NATALIAFURSOVA (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3BFD8540082;
	Wed,  5 Jun 2019 15:34:12 +0300 (MSK)
From: "Natalia Fursova" <Natalia.Fursova@ispras.ru>
To: "'Paolo Bonzini'" <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
	=?koi8-r?B?J/DB28En?= <Pavel.Dovgaluk@ispras.ru>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
	<1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
In-Reply-To: <1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
Date: Wed, 5 Jun 2019 15:34:12 +0300
Message-ID: <000e01d51b9a$fad452b0$f07cf810$@Fursova@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdUa5xM/z/IbN3AkRha6cV6nM500TAAs3alg
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: Re: [Qemu-devel] qgraph
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello, Paolo!

Thank you for your answer. I would like to clarify something about the =
qmp
commands.
For example, consider SCSI controller "lsi53c895a". For getting =
information
we use two commands: "device-list-properties" and "qom-list-properties".
Output consists of many properties, but there is no information about
provided buses by this device. Is there a qmp command which provides =
this
information?


Best regards,
Natalia

-----Original Message-----
From: Paolo Bonzini [mailto:pbonzini@redhat.com]=20
Sent: Tuesday, June 04, 2019 6:06 PM
To: Natalia Fursova; qemu-devel@nongnu.org; =F0=C1=DB=C1
Subject: Re: [Qemu-devel] qgraph

On 04/06/19 10:37, Natalia Fursova wrote:
> Hello, Paolo!
>=20
> We develop GUI for Qemu and want to implement graphical interface for
> configuring the device tree. To do this we need to detect list of the
> devices supported by any specific platform.
>=20
> Then we use this tree for command line generation.
>=20
> Existing qmp commands don't supply enough information to build the =
tree.
> They miss bus and interface data.

Hi!

Bus data is implicit in the parent class provided by QMP.  For example,
pci-device is the superclass of PCI devices, scsi-device is the
superclass of SCSI devices, etc.

qgraph is indeed similar, but it is only used by test cases, not by QEMU
itself.  The difference is that qgraph links together _drivers_ for the
devices, and so it is limited to those devices that have tests.  For
some ideas behind qgraph, see
https://wiki.qemu.org/Features/qtest_driver_framework.

Paolo

>=20
> =20
>=20
> There is something called 'qgraph' in Qemu. It looks similar to data
> structures in our GUI tool.
>=20
> =20
>=20
> Tell me please, do you have a plan on improving this interface? We =
found
the
> following hardcoded lines in the tests:
>=20
> qos_node_consumes("megasas", "pci-bus", &opts);
>=20
> qos_node_produces("megasas", "pci-device");
>=20
> =20
>=20
> And we wanted to extend QMP to query this kind of information.
>=20
> =20
>=20
> =20
>=20
> Best regards,=20
>=20
> Natalia
>=20
> =20
>=20



