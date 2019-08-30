Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEECC3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 08:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECF6238C5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 08:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECF6238C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3cR1-0003Kd-4K
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 04:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tgolembi@redhat.com>) id 1i3cPe-0002tV-C5
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 04:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tgolembi@redhat.com>) id 1i3cPZ-0005kh-EV
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 04:37:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1i3cPZ-0005f7-3J
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 04:37:37 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9AABF3C91A
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 08:37:35 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id c11so2241664wml.6
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 01:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=vwxaT7OCc1RZ7eQKQEKNPCJBflfvRaM9wuBpmNuj0oc=;
 b=Zx7xZeWP0vyiw1IokOz9GHOyK7vY8iu3HdqDpRnAOf7pV5JRv/bXff/daJb9DgNlbP
 dmuBlxSbV3dQlRvJqgv28a/pdWIIXavxcqpezl5xr/ILdgg362Udpu18a48T9Ovyw4dw
 dU7nv4CV1pqZMM+ky75yqJ19zcT57GJi9pzaeDDYedIm+BBSg8nKH0/ksbttkEF+3A7c
 bOBeTsG0ZpbO34FCnzroLc4rP/9oLE573ld+6UfFFYedc4mOHDRTox67j18j1ZP9n9xy
 OUCKziYuaX5FLkP7R/65T62y+Pw5l14Yrlv0nlY5nlIIM1G7P/fP1cdaZwibMpiEdhLS
 iqwQ==
X-Gm-Message-State: APjAAAUdpRHx5WPHr8EMkao+UvIJnfdPWcR2S5gPwSl/8sXWERzcBsZB
 waHJc/bKeW6gdJgrtrjtpeSHrgkJ/iYhzJS3SafDuqRbww1ci8UFOZ2N9wRZhqPDFvqA1MMyl6x
 yLA0jqeOWeVTRDgM=
X-Received: by 2002:a7b:cd0f:: with SMTP id f15mr4327440wmj.86.1567154254217; 
 Fri, 30 Aug 2019 01:37:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwOhr+VDML8pKDpb0jUsxToXDLnbd9+iyxyBz5pB+42Q7mUYjqUQl5JT9dqvKR22eqOFRpwxA==
X-Received: by 2002:a7b:cd0f:: with SMTP id f15mr4327403wmj.86.1567154253900; 
 Fri, 30 Aug 2019 01:37:33 -0700 (PDT)
Received: from fiorina (ip-94-112-73-67.net.upcbroadband.cz. [94.112.73.67])
 by smtp.gmail.com with ESMTPSA id i5sm6876944wrn.48.2019.08.30.01.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 01:37:33 -0700 (PDT)
Date: Fri, 30 Aug 2019 10:37:30 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190830103730.37ab6833@fiorina>
In-Reply-To: <f30adddb-311b-acff-e6ec-a5418f70158f@redhat.com>
References: <10eeadc9a86a7e3b9fa287c0389f0597f5c6a49b.1567094601.git.tgolembi@redhat.com>
 <f30adddb-311b-acff-e6ec-a5418f70158f@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qga: add command guest-get-devices for
 reporting VirtIO devices
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Aug 2019 11:13:53 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 8/29/19 11:03 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> > Add command for reporting devices on Windows guest. The intent is not so
> > much to report the devices but more importantly the driver (and its
> > version) that is assigned to the device.
> >=20
> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> =
=20
>=20
> > +++ b/qga/qapi-schema.json
> > @@ -1242,3 +1242,35 @@
> >  ##
> >  { 'command': 'guest-get-osinfo',
> >    'returns': 'GuestOSInfo' }
> > +
> > +##
> > +# @GuestDeviceInfo:
> > +#
> > +# @vendor-id: vendor ID as hexadecimal string in uper case without 0x =
prefix
> > +# @device-id: device ID as hexadecimal string in uper case without 0x =
prefix =20
>=20
> s/uper/upper/ twice

duh

>=20
> Should these be ints instead of strings (yes, it means they would be
> decimal over the wire, which is not the typical representation)?

Yes, I'm also indecisive in this point too. Although I sort of planned
to switch it to `int` in v2 anyway.

>=20
> > +# @driver-name: name of the associated driver
> > +# @driver-date: driver release date in format MM/DD/YY =20
>=20
> Why US-centric?  Better would be something like ISO, YYYY-MM-DD

I admit ISO form would be more fool proof (and I would like it better
too), but this is to stay consistent with format used in Windows
drivers[1].

>=20
> > +# @driver-version: driver version
> > +#
> > +# Since: 4.1.1 =20
>=20
> 4.2.  We don't tend to add features on stable backport branches (as this
> missed 4.1.0, we're unlikely to add it for 4.1.1).

Ah, ok.

Thanks,

    Tomas

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/install/inf-d=
riverver-directive

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

