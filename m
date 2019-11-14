Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384A8C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041CC2071B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BX+TFUSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041CC2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVF2f-0002FD-KV
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 08:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iVF23-0001ih-15
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iVF21-0005Xw-EV
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:19:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29399
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iVF21-0005XF-8p
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573737568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5I5JoSX06XVHqE63psH6O/z+D6wSYmt4lduj2s+2cYQ=;
 b=BX+TFUSuZzjt/2YqjUQXjO0R2icgftlzr3hdlExaDYGAb8zT9HETVeT7zAykQ4xcuTQP8h
 DMGh9LtAEBcTOGSSWfx/WiIgkxkeBp3OIg1XnjE2dglZj05Q7HeMe1VDczJsVqBqnQ+sbH
 gCcr7XwTB3sgiHdDno8XyO3fZMZM32o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-Ki42blwsMryAUiEa4YjGKg-1; Thu, 14 Nov 2019 08:19:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F64E1852E20;
 Thu, 14 Nov 2019 13:19:23 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 021605E25C;
 Thu, 14 Nov 2019 13:19:17 +0000 (UTC)
Date: Thu, 14 Nov 2019 14:19:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v1] s390x: kvm-unit-tests: a PONG device for Sub
 Channels tests
Message-ID: <20191114141915.6dd5b9c8.cohuck@redhat.com>
In-Reply-To: <20191114140235.30a788d6.pasic@linux.ibm.com>
References: <1573671753-15115-1-git-send-email-pmorel@linux.ibm.com>
 <20191114113823.5d752648.cohuck@redhat.com>
 <20191114140235.30a788d6.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Ki42blwsMryAUiEa4YjGKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, frankja@linux.ibm.com,
 Pierre Morel <pmorel@linux.ibm.com>, david@redhat.com, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 14:02:35 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 14 Nov 2019 11:38:23 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > On Wed, 13 Nov 2019 20:02:33 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >=20
> > Minor nit for $SUBJECT: this isn't a kvm-unit-tests patch, that's just
> > one consumer :) =20
>=20
> And subchannel is one word in s390-speak.
>=20
> >  =20
>=20
> [..]
>=20
> > Some questions regarding this device and its intended usage:
> >=20
> > - What are you trying to test? Basic ccw processing, or something more
> >   specific? Is there any way you can use the kvm-unit-test
> >   infrastructure to test basic processing with an existing device? =20
>=20
> I'm also curious about the big picture (what is in scope and what out
> of scope). Your design should be evaluated in the light of intended
> usage.
>=20
> BTW have you had a look at this abandoned patch-set of mine:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04220.html

Do you recall why it was abandoned? Or did we just forget to follow up
on it?

>=20
> We made some different design decisions, while aiming essentially for the
> same. Maybe it's due to different scope, maybe not. For instance one
> can't test IDA with PONG, I guess.

Now that I saw this again, I also recall the discussion of comparing it
with the "testdev" for pci/isa. Anybody knows if these are used by
kvm-unit-tests?

>=20
> Regards,
> Halil
>=20
> > - Who is instantiating this device? Only the kvm-unit-test?
> > - Can you instantiate multiple instances? Does that make sense? If yes,
> >   it should probably not request a new chpid every time :)
> > - What happens if someone instantiates this by hand? The only drawback
> >   is that it uses up a subchannel and a chpid, right?
> > - Do you plan to make this hotpluggable later?
> >=20
> >  =20
>=20


