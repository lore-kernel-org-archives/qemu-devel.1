Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB37FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 13:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715E72168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 13:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715E72168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKjVW-0005sI-GG
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 09:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iKjUR-0004sV-I1
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iKjUQ-00066w-8n
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:37:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iKjUQ-00066E-2d
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:37:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 92C1D30044C9;
 Wed, 16 Oct 2019 13:37:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3D8E60605;
 Wed, 16 Oct 2019 13:37:19 +0000 (UTC)
Date: Wed, 16 Oct 2019 14:37:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: TOPOEXT and CentOs 7 guests
Message-ID: <20191016133717.GC16089@redhat.com>
References: <SN6PR02MB513583C0D0C43777B47910D1F1920@SN6PR02MB5135.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR02MB513583C0D0C43777B47910D1F1920@SN6PR02MB5135.namprd02.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 16 Oct 2019 13:37:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Qemu-Devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 12:51:58PM +0000, Ani Sinha wrote:
> Hi :
>=20
> I am looking at a patch where we disable TOPOEXT when -cpu host or -cpu=
 max is passed to qemu :
>=20
> if (cpu->max_features) {
> =C2=A0 =C2=A0for (w =3D 0; w < FEATURE_WORDS; w++) {
> =C2=A0 =C2=A0 =C2=A0/* Override only features that weren't set explicit=
ly
> =C2=A0 =C2=A0 =C2=A0 * by the user.
> =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 env->features[w] |=3D
> =C2=A0 =C2=A0 =C2=A0 x86_cpu_get_supported_feature_word(w, cpu->migrata=
ble) &
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~env->user_features[w] & \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~feature_word_info[w].no_autoenable_f=
lags;
> =C2=A0 =C2=A0 }
> }
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg01641.html
>=20
> We are using a setup where we pass =E2=80=9Ckvm64=E2=80=9D as the cpu m=
odel along with
> other hypervisor CPIUD capabilities as detected by libvirt to a centOS
> 7.7 guest and the guest is unable to boot. We are using a AMD EPYC
> platform and we have traced it down to TOPOEXT flag being the offending
> CPUID from the host CPU which is causing the issue. Does it makes sense
> to not enable this flag by default on all other guest CPU models as wel=
l
> except for EPYC and EPTC-IBPB?
>=20
> Just looking at the code very recently and thought I=E2=80=99d get an o=
pinion
> from the wiser qemu community.

I don't have any insight into the particular problem cause. I do very
vaguely recall some previous bug I've seen related to AMD/topoext but
don't recall the details.

The single best advice though is to **NOT** use the 'kvm64' CPU
model. This is an *awful* CPU model that IIRC represents the lowest
common denominator of the first generation of x86 CPUs with hardware
virt.  Trying to take an old CPU model and turn on an arbitarary
set of extra features is well know to cause bugs.

See our guidance on CPU models to use for AMD hosts:

https://qemu.weilnetz.de/doc/qemu-doc.html#preferred_005fcpu_005fmodels_0=
05famd_005fx86

Essentially either use host passthrough, or use a plain named CPU model.
Only very few individual features make sense as extra things to turn
on above what the named CPU model supports. Mostly this is just side
channel vulnerability fixes, and a couple of perf related things like
pdpe1gb for huge page enablement as described in the above doc.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

