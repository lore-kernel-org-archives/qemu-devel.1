Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99032C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61124218AC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTTJDu9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61124218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izdvh-0003Ql-LL
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 04:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1izdtj-0002FV-1D
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1izdtf-0000XM-HI
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:56:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45980
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1izdtf-0000QC-84
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580982989;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wvGcVVWN7dt2fAY8WfvoWDjRJxfK0DPrldxxpTv42Fw=;
 b=XTTJDu9Lyt5o0x8i4zri7lT1/o9txTwizjq8laTtbkYt46zDQI1D9PYpigOuJKrXu0IBCF
 cWUEPw0DzHhHfTeF0d15JFPkPb9QvgwMjykfe72jA5QPrizXe6AY9kdQLuuqfR5hh65xCq
 ewl+YX/s7LMsTomajcpruoA2Zw3/74o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-0lCrKGGMOF-zAlOsbHMA4Q-1; Thu, 06 Feb 2020 04:56:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 470A71413;
 Thu,  6 Feb 2020 09:56:15 +0000 (UTC)
Received: from redhat.com (ovpn-112-65.ams2.redhat.com [10.36.112.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F2AD10018FF;
 Thu,  6 Feb 2020 09:56:04 +0000 (UTC)
Date: Thu, 6 Feb 2020 09:56:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH for-5.0 3/4] Remove the core bluetooth code
Message-ID: <20200206095601.GC2391707@redhat.com>
References: <20191120091014.16883-1-thuth@redhat.com>
 <20191120091014.16883-4-thuth@redhat.com>
 <7a775153-f18d-e766-1d8f-33607f5fa05b@amsat.org>
 <2396dfd4-6c85-d17a-b358-bd058c757f14@redhat.com>
 <CAAdtpL7vPCQ8k91nvBWc_NLrmhu6OPVprUSL8uzi_v6HMiSrnw@mail.gmail.com>
 <CAL1e-=gd-ymYd3_cods8BAtwbQeJFodmnmsNo-gLx381rXHKxQ@mail.gmail.com>
 <20200205175115.GT2221087@redhat.com>
 <3585192d-a0c1-4116-bec9-4816d498ca3d@amsat.org>
MIME-Version: 1.0
In-Reply-To: <3585192d-a0c1-4116-bec9-4816d498ca3d@amsat.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 0lCrKGGMOF-zAlOsbHMA4Q-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 05, 2020 at 08:13:19PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> On 2/5/20 6:51 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Feb 05, 2020 at 06:40:31PM +0100, Aleksandar Markovic wrote:
> >> On Sat, Feb 1, 2020 at 7:53 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> >>>
> >>>>>> @@ -1151,10 +1150,6 @@ for opt do
> >>>>>>    ;;
> >>>>>>    --enable-brlapi) brlapi=3D"yes"
> >>>>>>    ;;
> >>>>>> -  --disable-bluez) bluez=3D"no"
> >>>>>> -  ;;
> >>>>>> -  --enable-bluez) bluez=3D"yes"
> >>>>>> -  ;;
> >>>>>
> >>>>> Now than I'm bisecting over this commit, I realize removing this
> >>>>> option was not a good idea, we should have done like commit
> >>>>> cb6414dfec8 or 315d3184525:
> >>>>>
> >>>>>   @@ -886,10 +885,6 @@ for opt do
> >>>>>   -  --disable-uuid) uuid=3D"no"
> >>>>>   -  ;;
> >>>>>   -  --enable-uuid) uuid=3D"yes"
> >>>>>   -  ;;
> >>>>>   ...
> >>>>>   +  --enable-uuid|--disable-uuid)
> >>>>>   +      echo "$0: $opt is obsolete, UUID support is always built" =
>&2
> >>>>>   +  ;;
> >>>>
> >>>> Looks trivial ... so if it bugs you, just send a patch?
> >>>
> >>> I thought about it but this won't fix much, it is too late now.
> >>>
> >>> I simply wanted to share this bugged me so we try to avoid doing the
> >>> same mistake again.
> >>>
> >>
> >> I vote for addition of a change similar to what Philippe described.
> >>
> >> Furthermore, it looks to me the correct way would be to now do full
> >> deprecation of --enable-bluez and --disable-bluez. This means adding
> >> this to documentation (not related to bluetooth devices support), not
> >> only a change in "configure". This also means that only after two next
> >> full cycles these options could be removed.
> >>
> >> True, this could have been done together with bluetooth devices
> >> support deprecation (and in that case we could have deleted these
> >> options right away), but it wasn't. Users don't have a crystal ball to
> >> know that we assumed that --enable-bluez and --disable-bluez were part
> >> of bluetooth devices support, and could rightfully complain about an
> >> abrupt elimination of a compile time option.
> >=20
> > The deprecation policy is primarily intended for notifying of changes
> > to QEMU's stable interfaces ( CLI, HMP, QMP) which affect behaviour
> > and usage of QEMU at runtime & are liable to break apps managing
> > QEMU.
> >=20
> > Changes to build time options have no strong reason to be subjected to
> > the deprecation process. If we remove an option at build time the effec=
t
> > is noticed immediately and the solution is straightforward (stop passin=
g
> > the option). We have added / removed configure options at will with lit=
tle
> > negative feedback historically. We'll have far biggest changes coming t=
o
> > the build system in future too, with the introduction of meson.
>=20
> I understand your point when looking forward (when distribution upgrade,
> it is easy to adapt).
> However this is still an issue when looking backward when running
> bisection to find regressions.

That's only a problem if you were actively setting this particular
command line argument. Most developers are just fine with configure
auto-detecting stuff. The only time I've ever needed to try to
explicitly disable this is in downstream RHEL branches of QEMU

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


