Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA950C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 09:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B123B233FE
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 09:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B123B233FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1p5R-0000bY-RW
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 05:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i1p4F-00007i-Nb
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 05:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i1p4E-0000ri-3C
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 05:44:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1i1p4D-0000qf-U7
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 05:44:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D6E612A2;
 Sun, 25 Aug 2019 09:44:08 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4E145D6A3;
 Sun, 25 Aug 2019 09:44:03 +0000 (UTC)
Message-ID: <01aadba9669734bfde832a01bb62f7746a57f905.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 25 Aug 2019 12:44:02 +0300
In-Reply-To: <20190821084113.1840-8-kraxel@redhat.com>
References: <20190821084113.1840-1-kraxel@redhat.com>
 <20190821084113.1840-8-kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Sun, 25 Aug 2019 09:44:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 07/15] audio: audiodev= parameters no longer
 optional when -audiodev present
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
Cc: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Michael Walle <michael@walle.cc>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?ISO-8859-1?Q?Zolt=E1n?= <DirtY.iCE.hu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-08-21 at 10:41 +0200, Gerd Hoffmann wrote:
> From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>
>=20
> This means you should probably stop using -soundhw (as it doesn't allow
> you to specify any options) and add the device manually with -device.
> The exception is pcspk, it's currently not possible to manually add it.
> To use it with audiodev, use something like this:
>=20
>     -audiodev id=3Dfoo,... -global isa-pcspk.audiodev=3Dfoo -soundhw pc=
spk

Hi!

There is one corner case this breaks.
In qemu 4.1.0, there is no way to specify audiodev for a sound device, sp=
ecifying it
fails with error.
So some of my machines have audiodev (which is miles better that using ol=
d env variables)
but also have sound devices without audiodev reference since this wasn't =
supported.


In what will be qemu 4.2, you must specify it, thus this kind of breaks b=
ackward compatibility.
Maybe we can have audiodev reference optional for a version or two?

This is just a minor itch, as otherwise the sound improvements are really=
 good. The days
of installing that old realtek driver are finally gone :-)


Another thing I noted, that there is no way for pulseaudio audiodev to sp=
ecify the 'client name',
it always shows up in pavucontrl as the socket path to the server.=20
Thus if I added two PA audiodevs, I can't really distinguish between them=
.
The in|out.name=3D seems to specify the pulseaudio source/sink to connect=
 to, which is not the same.

Best regards,
	Maxim Levitsky



