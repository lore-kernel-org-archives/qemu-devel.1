Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF273C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF41B21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdISksXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF41B21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiO0-0004lG-Uv
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iuhui-0008UD-TG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iuhuf-0001LM-0H
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:13:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53052
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iuhue-0001Iz-Ry
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579806787;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmqwHsq/6kNZleyUcpr94GK0qacjySOyfnFrjzvetHo=;
 b=RdISksXJ9b4pJWtZQ0XSEkG2CKUxIgAatjTR5ajFfsSbyt9cXdsqYVfcHmTv/Xcm8FfZyJ
 3WoVPhf9uVOQy8r9J1Mb1R+nqmzFhqlRB4NnUxXf5UPtmVYllTjF/JoQRRIDuz2zYKpQ4Z
 diaCpiNPElCJcAWqRjBexTrOsYCOd2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-vrD4GUDvMcOVL4jzcWl0JQ-1; Thu, 23 Jan 2020 14:13:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC801107ACC7;
 Thu, 23 Jan 2020 19:13:04 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54DA487EED;
 Thu, 23 Jan 2020 19:12:55 +0000 (UTC)
Date: Thu, 23 Jan 2020 19:12:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200123191252.GJ657556@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <20191224130035.GC2710539@redhat.com>
 <a95b7572-d863-bc88-66aa-3beed679cefe@redhat.com>
 <20200123102705.GC657556@redhat.com>
 <0ba8f074-fde8-a0f6-5880-d2f5eabeca98@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0ba8f074-fde8-a0f6-5880-d2f5eabeca98@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: vrD4GUDvMcOVL4jzcWl0JQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 01:13:33PM -0500, John Snow wrote:
>=20
>=20
> On 1/23/20 5:27 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Jan 22, 2020 at 05:42:10PM -0500, John Snow wrote:
> >>
> >>
> >> On 12/24/19 8:00 AM, Daniel P. Berrang=C3=A9 wrote:
> >>> Based on experiance in libvirt, this is an even larger job than (4),
> >>> as the feature set here is huge.  Much of it directly ties into the
> >>> config problem, as to deal with SELinux / namespace setup the code
> >>> needs to understand what resources to provide access to. This
> >>> requires a way to express 100% coverage of all QEMU configuration
> >>> in use & analyse it to determine what resources it implies. So this
> >>> ties strongly into QAPI-ification completion.
> >>
> >> Is it totally bonkers to suggest that QEMU provide a method of digesti=
ng
> >> a given configuration and returning a configuration object that a
> >> standalone jailer can use?
> >>
> >> So we have a QEMU manager, the generic jailer, and QEMU. QEMU and the
> >> manager cooperate to produce the jailing configuration, and the jailer
> >> does what we ask it to.
> >=20
> > It isn't clear what you mean by "QEMU" here. If this QEMU, the system
> > emulator process, then this is the untrustworthy part of the stack,
> > so the jailer must not use any data that QEMU is providing. In fact
> > during startup the jailer does its work before QEMU even exists.
> >=20
>=20
> I worried about this. Hence the "Nuts?" ask. It sounds like the ultimate
> problem is nobody can know -- except QEMU -- what permissions are truly
> needed for a given configuration. Even if we had an immaculate API, how
> would anyone except QEMU developers know?
>=20
> Trial and error, perhaps, on behalf of the jailer developers. Trial and
> error is not the greatest feature of a security mechanism. Clearly, a
> lot of effort has been spent to get libvirt's implementation correct,
> but Stefan raises the idea that other projects have need of
> understanding how to map QEMU configurations to appropriate jails.
>=20
> Worse, it could still change on a whim. We (QEMU developers) probably
> are not used to thinking of permitted syscall lists as ABI that we
> strive to maintain. It can change.
>=20
> How do we make this easier in a way that doesn't trust QEMU? I feel like
> QEMU needs to provide *some* kind of information that can be used to
> build better jailing configurations...

I think the key thing to understand is that once you involve a "jailer"
then "QEMU" is no longer a single thing we can refer to. It is immediately
split into two pieces, "the launcher" and "the runtime", with a jailer
sitting in between the pair.

The configuration information needed by the launcher is a superset
of the information needed by the runtime. The launcher is trustworthy
and the runtime is untrustworthy.

In the current world qemu-system-* is the runtime and libvirt is
the launcher, and they each have their own completely different
vocabulary for configuration.

Essentially what you're talking about is a way to bring the concept
of the launcher under the responsibility of the QEMU project, and
have much closer alignment between the configuration for the launcher
and the runtime. One would still need to be the superset of the
other, but they could be 90% common.=20

Having "the launcher" be part of the QEMU project deliverables is
a completely reasonable concept. Libvirt only took on that role
itself because QEMU has never provided any solution for this
problem itself.  I don't think this is a technically difficult
task. The issues are simply around the practicality of the size/
scope of the work required in order to achieve deliver it for the
diverse range of QEMU functionality & use cases.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


