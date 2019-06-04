Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_MULTIPLE_AT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133CAC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B3E24AE2
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B3E24AE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48680 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY4xr-0001Wf-5m
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 04:38:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Natalia.Fursova@ispras.ru>) id 1hY4x4-0001De-Rk
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Natalia.Fursova@ispras.ru>) id 1hY4x2-0002BD-ST
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:37:50 -0400
Received: from mail.ispras.ru ([83.149.199.45]:40918)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Natalia.Fursova@ispras.ru>) id 1hY4x0-00026u-Qi
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:37:47 -0400
Received: from NATALIAFURSOVA (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5299F54006B;
	Tue,  4 Jun 2019 11:37:40 +0300 (MSK)
From: "Natalia Fursova" <Natalia.Fursova@ispras.ru>
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>,
	=?koi8-r?B?8MHbwQ==?= <Pavel.Dovgaluk@ispras.ru>
References: 
In-Reply-To: 
Date: Tue, 4 Jun 2019 11:37:37 +0300
Message-ID: <000301d51ab0$c3f1aee0$4bd50ca0$@Fursova@ispras.ru>
MIME-Version: 1.0
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdUWFZgjwxE4OQxbTXG9Tx3j6WX9aQEmxUUw
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
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

ping

=20

=20

Best regards,=20

Natalia

=20

From: =EE=C1=D4=C1=CC=D8=D1 =E6=D5=D2=D3=CF=D7=C1 =
[mailto:Natalia.Fursova@ispras.ru]=20
Sent: Wednesday, May 29, 2019 2:57 PM
To: 'qemu-devel@nongnu.org'; 'pbonzini@redhat.com'; =F0=C1=DB=C1
(Pavel.Dovgaluk@ispras.ru)
Subject: qgraph

=20

Hello, Paolo!

=20

We develop GUI for Qemu and want to implement graphical interface for
configuring the device tree. To do this we need to detect list of the
devices supported by any specific platform.

Then we use this tree for command line generation.

=20

Existing qmp commands don't supply enough information to build the tree.
They miss bus and interface data.

=20

There is something called 'qgraph' in Qemu. It looks similar to data
structures in our GUI tool.

=20

Tell me please, do you have a plan on improving this interface? We found =
the
following hardcoded lines in the tests:

qos_node_consumes("megasas", "pci-bus", &opts);

qos_node_produces("megasas", "pci-device");

=20

And we wanted to extend QMP to query this kind of information.

=20

=20

Best regards,=20

Natalia

=20

