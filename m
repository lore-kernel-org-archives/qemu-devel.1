Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5D1C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF6D2171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF6D2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAByS-0004yK-At
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 07:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iABvw-0003Vi-Vp
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iABvv-000373-94
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:46:12 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:51365)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iABvu-000362-QO
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:46:11 -0400
Received: from player157.ha.ovh.net (unknown [10.108.42.192])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 3AA34793CA
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 13:46:08 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id E93CA9D6A085;
 Tue, 17 Sep 2019 11:45:30 +0000 (UTC)
Date: Tue, 17 Sep 2019 13:45:29 +0200
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190917134529.4c38f847@bahia.lan>
In-Reply-To: <551745c2-2579-9ce5-4aa4-536c37a1ce45@redhat.com>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
 <551745c2-2579-9ce5-4aa4-536c37a1ce45@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 14375208539410569507
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeigddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.58.91
Subject: Re: [Qemu-devel] [PATCH 00/17] Fix usage of error_append_hint()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFu?=
 =?UTF-8?B?Z8Op?=" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 13:00:37 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> For some reason your email client escaped incorrectly Daniel's email:
>=20
>   "Daniel P. Berrang=C3=A9\" <berrange@redhat.com>
>=20

The client is stgit's "stg mail" command, and indeed it generates this:

 "Daniel P. =3D?utf-8?q?Berrang=3DC3=3DA9=3D22?=3D <berrange@redhat.com>
                                   ^^^
                                double-quote

and if I turn the '=C3=A9' into a 'e':

 "Daniel P. Berrange" <berrange@redhat.com>

This looks like a bug in "stg mail"...

> Which makes my email client very unhappy (Thunderbird):
>=20
> There are non-ASCII characters in the local part of the recipient
> address "Daniel P. Berrang=C3=A9 <berrange@redhat.com>,
> qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
> qemu-s390x@nongnu.org"@d06av23.portsmouth.uk.ibm.com. This is not yet
> supported. Please change this address and try again.
>=20
> Neither is MTA:
>=20
> An error occurred while sending mail. The mail server responded:
> 5.1.2 The recipient address <qemu-s390x@nongnu.org@d06av22.portsmouth.uk.=
ibm
> 5.1.2 .com> is not a valid RFC-5321 address. r28sm2465872wrr.94 - gsmtp.
>  Please check the message recipient
> ""qemu-s390x@nongnu.org"@d06av22.portsmouth.uk.ibm.com" and try again.

Drat... this may prevent recipients starting with Daniel from receiving
the mails... ie, the sub-lists IIUC. Maybe not worth reposting for that.
Hopefully, Daniel may catch up on qemu-devel.

