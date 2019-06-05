Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_MULTIPLE_AT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC0AC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4920A206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4920A206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYWp4-0002jI-Bs
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 10:23:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Natalia.Fursova@ispras.ru>) id 1hYWoG-0002Ru-Uz
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Natalia.Fursova@ispras.ru>) id 1hYWoG-0003cn-4A
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:22:36 -0400
Received: from mail.ispras.ru ([83.149.199.45]:59112)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Natalia.Fursova@ispras.ru>) id 1hYWoF-0003PC-Ra
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:22:36 -0400
Received: from NATALIAFURSOVA (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id 61FF654008B;
	Wed,  5 Jun 2019 17:22:30 +0300 (MSK)
From: "Natalia Fursova" <Natalia.Fursova@ispras.ru>
To: "'Paolo Bonzini'" <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
	=?koi8-r?B?J/DB28En?= <Pavel.Dovgaluk@ispras.ru>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
	<1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
	<5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>
	<ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com>
In-Reply-To: <ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com>
Date: Wed, 5 Jun 2019 17:22:30 +0300
Message-ID: <001e01d51baa$1c190650$544b12f0$@Fursova@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdUbn5dVomEoJ1bbQxiyw0FvHJZsTgAClymw
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


