Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62ACC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7446D207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DevruSdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7446D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8BC-00040K-KW
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 12:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iw8Ac-0003Wu-Kv
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iw8Aa-0000v4-Gc
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:27:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47326
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iw8Aa-0000u8-7D
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580146046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lt0o8e9IGB464vq22Oyx6NEu1aZHCDOJJqjlcr12FhQ=;
 b=DevruSdVoTclADZdr10sBhkctE8w5u74QJ/Ottobo3XfXx4VjViD5u87vc/f7Pfhkr2t05
 IbiAC9+H365CgEyoWajWy/cFVmuS9sAuWilLJWCKW+cGvjYtJOkUIMvDuXHZtTFBZlyqRz
 M5VL9pzJcz5s2rMfcZSmv7UUeY3FOBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-9IQiPcIUPwOZDjKlwhYxjA-1; Mon, 27 Jan 2020 12:27:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1945418A8C82;
 Mon, 27 Jan 2020 17:27:22 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6346780A5C;
 Mon, 27 Jan 2020 17:27:18 +0000 (UTC)
Date: Mon, 27 Jan 2020 18:27:16 +0100
From: Andrew Jones <drjones@redhat.com>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 7/8] tests/vm: Added a new script for ubuntu.aarch64.
Message-ID: <20200127172716.xvfkyhqznjlxefgn@kamzik.brq.redhat.com>
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-8-robert.foley@linaro.org>
 <87imkxeyew.fsf@linaro.org>
 <CAEyhzFtRV_4oss4gxYJi5ojGrXvNZExXfM+Ae-idLqidtcPpcQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEyhzFtRV_4oss4gxYJi5ojGrXvNZExXfM+Ae-idLqidtcPpcQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 9IQiPcIUPwOZDjKlwhYxjA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, Peter Puhov <peter.puhov@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 27, 2020 at 11:47:35AM -0500, Robert Foley wrote:
> On Mon, 27 Jan 2020 at 10:01, Alex Benn=E9e <alex.bennee@linaro.org> wrot=
e:
> > >  vm-boot-ssh-%: $(IMAGES_DIR)/%.img
> > >       $(call quiet-command, \
> > > -             $(SRC_PATH)/tests/vm/$* \
> > > +             $(PYTHON) $(SRC_PATH)/tests/vm/$* \
> >
> > This seems like it should be in a different patch.
>=20
> Good point, will move it to a different patch.
>=20
> > > +
> > > +DEFAULT_CONFIG =3D {
> > > +    'cpu'          : "max",
> > > +    'machine'      : "virt,gic-version=3Dmax",
> >
> > According to virt.c:
> >
> >   Valid values are 2, 3 and host
> >
> > but max should work on TCG. However we need a more recent QEMU than my
> > system one for it to work. Otherwise you see:
> >
> >   DEBUG:qemu.machine:Error launching VM
>=20
> Good point.  We were trying to avoid having different values for KVM
> vs TCG, which we
> could do with the latest QEMU.
> We will update this to make sure this works with older versions of QEMU a=
s well.
>=20
> On my system I have qemu 2.11.1 installed by default.
> It seems that we will need the following defaults based on our environmen=
t.
>=20
> For KVM we end up with the below args since max cpu and max
> gic-version is not available.
> kvm:  -cpu host -machine virt,gic-version=3Dhost
>=20
> For TCG max cpu is also not available: qemu-system-aarch64: unable to
> find CPU model 'max',
> so we pick cortex-a57.
> TCG: -cpu cortex-a57 -machine virt,gic-version=3D3
>=20
> I suppose we could check the version of QEMU and use the above
> defaults only for earlier versions of QEMU.
> This is something we will probably move to aarch64vm.py since it is commo=
n.

What versions of QEMU do these tests *have* to support? Because we could
just skip the tests for QEMU that doesn't support cpu=3Dmax,gic-version=3Dm=
ax.
'max' is indeed the nicest selection for using the same command line on
KVM (gicv2 and gicv3 hosts) and TCG.

Thanks,
drew


