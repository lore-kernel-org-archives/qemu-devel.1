Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EF6C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E339220658
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPikHwa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E339220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOtw-0001NT-4a
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1izOt9-0000bF-6r
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1izOt7-0003o1-QO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:54:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31697
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1izOt7-0003fk-ML
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580925297;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcjfV6jtv09m2W2iGyYyuQo3fsacRY9Qezp+vGQ9Qk0=;
 b=CPikHwa2R5ewpJX/fp6a57vF7zKc6M/jOyTijVKIKcbjiGoIkccqtRSZEdiIBm0iHS0ua2
 a4WyxAhw1STzzORcwgK2kYzR98dn8E+HuYchADc2VJuhwlBXNpaI6unp5l8ae7mB/P0n40
 4rAQqSwuSKZ9smzrpc9NcKaxMXoUHs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-xkjzDxyrOQGkt5Z_HqOhKw-1; Wed, 05 Feb 2020 12:54:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7E8BDB60;
 Wed,  5 Feb 2020 17:54:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FE4F859A0;
 Wed,  5 Feb 2020 17:54:42 +0000 (UTC)
Date: Wed, 5 Feb 2020 17:54:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-5.0 3/4] Remove the core bluetooth code
Message-ID: <20200205175440.GU2221087@redhat.com>
References: <20191120091014.16883-1-thuth@redhat.com>
 <20191120091014.16883-4-thuth@redhat.com>
 <7a775153-f18d-e766-1d8f-33607f5fa05b@amsat.org>
 <2396dfd4-6c85-d17a-b358-bd058c757f14@redhat.com>
 <CAAdtpL7vPCQ8k91nvBWc_NLrmhu6OPVprUSL8uzi_v6HMiSrnw@mail.gmail.com>
 <CAL1e-=gd-ymYd3_cods8BAtwbQeJFodmnmsNo-gLx381rXHKxQ@mail.gmail.com>
 <9c1f04bd-a0e7-6fbc-68d7-fd5babf1e8d0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9c1f04bd-a0e7-6fbc-68d7-fd5babf1e8d0@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: xkjzDxyrOQGkt5Z_HqOhKw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 05, 2020 at 06:46:24PM +0100, Thomas Huth wrote:
> On 05/02/2020 18.40, Aleksandar Markovic wrote:
> > On Sat, Feb 1, 2020 at 7:53 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
> >>
> >> On Sat, Feb 1, 2020 at 7:51 PM Thomas Huth <thuth@redhat.com> wrote:
> >>> On 01/02/2020 17.09, Philippe Mathieu-Daud=C3=A9 wrote:
> [...]
> >>>>> index 6099be1d84..ecce4ada2d 100755
> >>>>> --- a/configure
> >>>>> +++ b/configure
> >>>>> @@ -349,7 +349,6 @@ unset target_list_exclude
> >>>>>  # Distributions want to ensure that several features are compiled =
in, and it
> >>>>>  # is impossible without a --enable-foo that exits if a feature is =
not found.
> >>>>>
> >>>>> -bluez=3D""
> >>>>>  brlapi=3D""
> >>>>>  curl=3D""
> >>>>>  curses=3D""
> >>>>> @@ -1151,10 +1150,6 @@ for opt do
> >>>>>    ;;
> >>>>>    --enable-brlapi) brlapi=3D"yes"
> >>>>>    ;;
> >>>>> -  --disable-bluez) bluez=3D"no"
> >>>>> -  ;;
> >>>>> -  --enable-bluez) bluez=3D"yes"
> >>>>> -  ;;
> >>>>
> >>>> Now than I'm bisecting over this commit, I realize removing this
> >>>> option was not a good idea, we should have done like commit
> >>>> cb6414dfec8 or 315d3184525:
> >>>>
> >>>>   @@ -886,10 +885,6 @@ for opt do
> >>>>   -  --disable-uuid) uuid=3D"no"
> >>>>   -  ;;
> >>>>   -  --enable-uuid) uuid=3D"yes"
> >>>>   -  ;;
> >>>>   ...
> >>>>   +  --enable-uuid|--disable-uuid)
> >>>>   +      echo "$0: $opt is obsolete, UUID support is always built" >=
&2
> >>>>   +  ;;
> >>>
> >>> Looks trivial ... so if it bugs you, just send a patch?
> >>
> >> I thought about it but this won't fix much, it is too late now.
> >>
> >> I simply wanted to share this bugged me so we try to avoid doing the
> >> same mistake again.
> >>
> >=20
> > I vote for addition of a change similar to what Philippe described.
>=20
> Feel free to send a patch if it bugs you.

I don't think we should do this (nor the original uuid compat hack
above). We don't want to set an expectation that configure arguments
are considered "stable" interface to QEMU requiring back compat.
This will constrain our future build system work as we move to
introduce meson initially and then gradually elminate more & more
of configure until it can be deleted entirely.

Certainly we should document configure arg removals in the release
notes, but we don't need to go beyond that IMHO.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


