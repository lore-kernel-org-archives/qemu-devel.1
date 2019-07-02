Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FF4C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A984206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A984206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiLTd-0002tK-9g
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35090)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiKfq-0001G7-Et
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiKfp-0005ES-Ef
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:26:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49079)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiKfp-0005D1-8F
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:26:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8488D81127;
 Tue,  2 Jul 2019 15:26:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A1AA4C492;
 Tue,  2 Jul 2019 15:26:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E8E411132ABF; Tue,  2 Jul 2019 17:26:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Natalia Fursova" <Natalia.Fursova@ispras.ru>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
 <1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
 <5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>
 <ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com>
 <003b01d51f72$5e6f4160$1b4dc420$@Fursova@ispras.ru>
 <67806828-f666-0c9c-00fc-b520f15013d9@suse.de>
 <e4fe4dc0-f3c4-a051-d39d-afd7bfdc680d@redhat.com>
 <98826c5f-4a74-5364-2aef-28a10db12c20@suse.de>
 <39250506-f38f-c440-5728-7b970d32ab41@redhat.com>
 <79b821a4-7cc0-2461-7ca4-d71c3e5ee4ef@suse.de>
 <c49abf01-c209-b206-edee-507c31269011@redhat.com>
 <87o934sdot.fsf@dusky.pond.sub.org>
 <8d391b41-bf6d-b83b-7b22-25fefa18c518@redhat.com>
 <87ftogp7f5.fsf@dusky.pond.sub.org>
 <4ed45e59-6d7d-a9ea-9af3-7ec336c7ec3d@redhat.com>
 <014c01d530cb$73ff1950$5bfd4bf0$@Fursova@ispras.ru>
Date: Tue, 02 Jul 2019 17:26:15 +0200
In-Reply-To: <014c01d530cb$73ff1950$5bfd4bf0$@Fursova@ispras.ru> (Natalia
 Fursova's message of "Tue, 2 Jul 2019 14:44:05 +0300")
Message-ID: <8736jo1mqw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 02 Jul 2019 15:26:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>,
 'Andreas =?utf-8?Q?F=C3=A4rb?= =?utf-8?Q?er'?= <afaerber@suse.de>,
 =?utf-8?B?J9Cf0LDRiNCwJw==?= <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Natalia Fursova" <Natalia.Fursova@ispras.ru> writes:

> Hi there again!
> Thank you for your answers, I have new question.
>  
> I want to identify PCI devices (e.g. network cards) and observed one
> strange thing. I use qmp command "qom-list-type" and build tree from
> it output. Some items don't have parent and don't give information
> about themselves. E. g. "e1000-base". It has three children and it
> belongs to PCI devices, but I can't know it, cuz command
> "qom-list-properties" returns empty message.
>
> There is no information about "e1000-base" in "qom-list-type"
> output. It is referenced only as a parent for network cards.  Is it
> ok? Maybe is there other way for get information about all PCI
> devices?

qom-list-types only returns concrete types by default.  Try passing
"abstract": true.

