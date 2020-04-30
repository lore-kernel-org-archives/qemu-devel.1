Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FAFC83006
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6476721973
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSzTQPuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6476721973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3pq-0007px-J9
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jU3p9-0006wE-1E
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jU3op-0002Dw-1T
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:41:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41771
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jU3oo-0002De-Hi
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588232473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zC1dkD2Ku3U/rQ3vGbEgN/L7ampgCzHPn3S2CXa55GI=;
 b=GSzTQPuFViMzOXnBiHdbKVlYIqhRBXv/gSDgNoUH4OJasML/lC0di08F7xqrxPvDiy3XOK
 kUt6j6iRSOvsUF9ap1v740INFgYtpf21FO4pufkNwqpN3NijkjJd4fNq8iLj8kH9ul5RMr
 yu52WTAjv+YDyj4vM1jyaWCv1LxomcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132--w9woaBQMUKuImHcfvC5kQ-1; Thu, 30 Apr 2020 03:41:11 -0400
X-MC-Unique: -w9woaBQMUKuImHcfvC5kQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E3CF107AD9B
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 07:41:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B53DA196AE;
 Thu, 30 Apr 2020 07:41:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id ADF5F9D98; Thu, 30 Apr 2020 09:41:08 +0200 (CEST)
Date: Thu, 30 Apr 2020 09:41:08 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 00/12] audio: deprecate -soundhw
Message-ID: <20200430074108.pxgbu3uyvk77vivd@sirius.home.kraxel.org>
References: <20200429110214.29037-1-kraxel@redhat.com>
 <f2d7187a-953c-2b53-07fb-0a3e5f32193d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f2d7187a-953c-2b53-07fb-0a3e5f32193d@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 06:54:08PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Gerd,
>=20
> On 4/29/20 1:02 PM, Gerd Hoffmann wrote:
> >=20
> >=20
> > Gerd Hoffmann (12):
> >    stubs: add isa_create_simple
> >    stubs: add pci_create_simple
> >    audio: add deprecated_register_soundhw
> >    audio: deprecate -soundhw ac97
> >    audio: deprecate -soundhw es1370
> >    audio: deprecate -soundhw adlib
> >    audio: deprecate -soundhw cs4231a
> >    audio: deprecate -soundhw gus
> >    audio: deprecate -soundhw sb16
> >    audio: deprecate -soundhw hda
> >    audio: deprecate -soundhw pcspk
> >    [RFC] audio: try use onboard audiodev for pcspk
>=20
> I don't understand what you are trying to fix with this series.

Almost nothing.  I'm just deprecating -soundhw, and I don't feel like
putting too much effort into code which I want remove anyway.

The new deprecated_register_soundhw() is there to allow removing the
init callback for most hardware and have common code handle the simple
cases.  Alternatively I could leave things as-is and just copy&paste the
deprecation warning into each init callback.

The only functional change (beside the added deprecation warnings) is
that the pcspk realize function initializes audio in case audiodev is
set, so "-global isa-pcspk.audiodev=3D<something>" is enough to activate
the speaker.  The need to also have "-soundhw pcspk" on the command line
is gone.

> I suppose there is a problem with the pcspk, as I had a problem when I tr=
ied
> to make the soundhw more QOM-friendly.

I see your patch adds a deprecation warning for -soundhw too.  I'm
wondering why you want convert this to QOM now just to throw away the
code in a few months?

cheers,
  Gerd


