Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_MULTIPLE_AT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EA5C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20102082E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20102082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43052 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haH0P-0002pT-3p
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50143)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Natalia.Fursova@ispras.ru>) id 1haGzv-0002FT-51
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Natalia.Fursova@ispras.ru>) id 1haGzt-0002oN-8T
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:53:51 -0400
Received: from mail.ispras.ru ([83.149.199.45]:35742)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <Natalia.Fursova@ispras.ru>) id 1haGzo-0002fP-3m
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:53:47 -0400
Received: from NATALIAFURSOVA (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id DE90254006B;
 Mon, 10 Jun 2019 12:53:36 +0300 (MSK)
From: "Natalia Fursova" <Natalia.Fursova@ispras.ru>
To: "'Natalia Fursova'" <Natalia.Fursova@ispras.ru>,
 "'Paolo Bonzini'" <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
 =?koi8-r?B?J/DB28En?= <Pavel.Dovgaluk@ispras.ru>, <afaerber@suse.de>,
 <armbru@redhat.com>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
 <1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
 <5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>
 <ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com> 
In-Reply-To: 
Date: Mon, 10 Jun 2019 12:53:34 +0300
Message-ID: <003b01d51f72$5e6f4160$1b4dc420$@Fursova@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdUbn5dVomEoJ1bbQxiyw0FvHJZsTgAClymwAPHgNOA=
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: Re: [Qemu-devel] qgraph
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi there!
Read please our correspondence and answer on last question (Will it ok =
for
QOM conception?)
Also forwarding to QOM and QMP maintainers. Can you make comments on =
this
discussion?


Best regards,
Natalia

-----Original Message-----
From: Natalia Fursova [mailto:Natalia.Fursova@ispras.ru]=20
Sent: Wednesday, June 05, 2019 5:23 PM
To: 'Paolo Bonzini'; 'qemu-devel@nongnu.org'; '=F0=C1=DB=C1'
Subject: RE: [Qemu-devel] qgraph

I see.
We need this opportunity and want to implement it. Will it ok for QOM
conception?



Best regards,
Natalia

-----Original Message-----
From: Paolo Bonzini [mailto:pbonzini@redhat.com]=20
Sent: Wednesday, June 05, 2019 4:07 PM
To: Natalia Fursova; qemu-devel@nongnu.org; '=F0=C1=DB=C1'
Subject: Re: [Qemu-devel] qgraph

On 05/06/19 14:34, Natalia Fursova wrote:
>=20
> Thank you for your answer. I would like to clarify something about the =
qmp
> commands.
> For example, consider SCSI controller "lsi53c895a". For getting
information
> we use two commands: "device-list-properties" and =
"qom-list-properties".
> Output consists of many properties, but there is no information about
> provided buses by this device. Is there a qmp command which provides =
this
> information?

Unfortunately there is no information in QMP about buses that are
provided.   qom-list-types gives the buses that are requested.

Paolo


