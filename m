Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84A2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4272084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvt8XGsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4272084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdx6l-0001Ys-SD
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jdx5e-0000Ai-AW
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:31:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21142
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jdx5b-0000Gu-9o
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590589883;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NuMoZKKJfFF9i+2gxTmSdlbk0RJ0ivCytmCd98IeTAA=;
 b=cvt8XGsxIhSCrJu8omXOF4mVE1EB083qeUTE7oIOQD+qqmYT40Sdjt41MMo26+VEOEk1dj
 SIdDn/ErdR8wQbiOBKDZW8yz+W4gMucycKtgXmMGuJFHIpI+9dPLQ3npsWTMSJEMAzQX4J
 tqbkUaD5gPQdjbQO+OnFEVesIXP5wAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-jEFqVgI3N7GzuCPmHaTKQA-1; Wed, 27 May 2020 10:31:09 -0400
X-MC-Unique: jEFqVgI3N7GzuCPmHaTKQA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 688DD107ACF7;
 Wed, 27 May 2020 14:31:08 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1572D5C1C5;
 Wed, 27 May 2020 14:31:04 +0000 (UTC)
Date: Wed, 27 May 2020 15:31:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH RFC 01/32] python/qemu: create qemu.lib module
Message-ID: <20200527143101.GN2665520@redhat.com>
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-2-jsnow@redhat.com>
 <b4618eb0-5303-40ab-b5e2-5a08d5738a81@virtuozzo.com>
 <20b3fb10-8028-eb12-49a9-a3cc9dd45ed0@redhat.com>
 <07ff57d4-8348-4409-ca8a-ff4c5278b973@virtuozzo.com>
 <45dc0bb0-6b22-1703-0435-9d49d3df9978@redhat.com>
 <20200526152207.GK2496524@redhat.com>
 <169ab716-1013-e65b-be9f-9f73f65515c4@redhat.com>
 <20200526152551.GL2496524@redhat.com>
 <914a39b5-a5b6-7a6e-12ea-e8c60802b07c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <914a39b5-a5b6-7a6e-12ea-e8c60802b07c@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 10:28:44AM -0400, John Snow wrote:
>=20
>=20
> On 5/26/20 11:25 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, May 26, 2020 at 05:23:42PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> On 5/26/20 5:22 PM, Daniel P. Berrang=C3=A9 wrote:
> >>> On Mon, May 18, 2020 at 08:27:54PM -0400, John Snow wrote:
> >>>>
> >>>>
> >>>> On 5/18/20 3:33 PM, Vladimir Sementsov-Ogievskiy wrote:
> >>>>> 18.05.2020 21:23, John Snow wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 5/18/20 2:14 PM, Vladimir Sementsov-Ogievskiy wrote:
> >>>>>>> 14.05.2020 08:53, John Snow wrote:
> >>>>>>>> move python/qemu/*.py to python/qemu/lib/*.py.
> >>>>>>>>
> >>>>>>>> To create a namespace package, the 'qemu' directory itself shoul=
dn't
> >>>>>>>> have module files in it. Thus, these files will go under a 'lib'
> >>>>>>>> package
> >>>>>>>> directory instead.
> >>>>>>>
> >>>>>>> Hmm..
> >>>>>>>
> >>>>>>> On the first glance, it looks better to have
> >>>>>>>
> >>>>>>> =C2=A0=C2=A0 from qemu import QEMUMachine
> >>>>>>>
> >>>>>>> than
> >>>>>>> =C2=A0 =C2=A0=C2=A0 from qemu.lib import QEMUMachine
> >>>>>>>
> >>>>>>> why do we need this extra ".lib" part?
> >>>>>>>
> >>>>>>> Is it needed only for internal use?
> >>>>>>>
> >>>>>>> Assume we have installed qemu package. Can we write
> >>>>>>>
> >>>>>>> =C2=A0=C2=A0 from qemu import QEMUMachine
> >>>>>>>
> >>>>>>> ? Or we still need qemu.lib ?
> >>>>>>>
> >>>>>>> I don't remember any python package, which made me to write "impo=
rt from
> >>>>>>> package_name.lib ..."
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>> It's a strategy to create "qemu" as a PEP420 namespace package; i.=
e.
> >>>>>> "qemu" forms a namespace, but you need a name for the actual packa=
ge
> >>>>>> underneath it.
> >>>>>>
> >>>>>> "qemu.lib" is one package, with qmp, qtest, and machine modules. "=
qemu"
> >>>>>> isn't really a package in this system, it's just a namespace.
> >>>>>>
> >>>>>> The idea is that this allows us to create a more modular rollout o=
f
> >>>>>> various python scripts and services as desired instead of monolith=
ically
> >>>>>> bundling them all inside of a "qemu" package.
> >>>>>>
> >>>>>> It also allows us to fork or split out the sub-packages to separat=
e
> >>>>>> repos, if we wish. i.e., let's say we create a "qemu.sdk" subpacka=
ge, we
> >>>>>> can eventually fork it off into its own repo with its own installe=
r and
> >>>>>> so forth. These subpackages can be installed and managed separatel=
y.
> >>>>>>
> >>>>>
> >>>>> Okay, I understand.. No real objections than.
> >>>>>
> >>>>> Still, maybe, everything should not go into lib, maybe something li=
ke
> >>>>>
> >>>>> qemu/vm/=C2=A0 - qmp, QEMUMachine, etc
> >>>>> qemu/qtest/=C2=A0 - qtest
> >>>>>
> >>>>> would be more user friendly? But I'm not sure. I just thought that =
"lib"
> >>>>> is too generic.
> >>>>>
> >>>>
> >>>> lib is a very generic name, I agree.
> >>>>
> >>>> Splitting accel, qmp and QEMUMachine in one package and keeping qtes=
t in
> >>>> another is fine too. I'm not sure if I like "vm" for the name of tha=
t
> >>>> core package, though.
> >>>>
> >>>> I want to avoid using "qemu/sdk" because I have some plans for tryin=
g to
> >>>> generate and package a "real" SDK using that namespace.
> >>>>
> >>>> "devkit"? "testkit"? "core"? Naming things is always the worst part.
> >>>
> >>> I'd suggest  "machine", as in
> >>>
> >>>   from qemu.machine import  kvm_available, QEMUMachine
> >>>
> >>> I wouldn't over-think the module naming as it has so little impact on
> >>> the code usage - it usually only appears in the "import" statement.
> >>
> >> Don't forget linux-user binaries.
> >=20
> > That's why I suggested ".machine", as all the APIs there currently
> > are focused on the machine emulators, and the linx-user binaries
> > share essentially nothing in common with softmmu binaries in terms
> > of control APIs / CLI config. We can add a "qemu.user" package
> > later if we have stuff related to that to expose
> >=20
> I'm re-ordering the series to front-load the linting and type-checking;
> and the package organization will now come second, in a separate series.
>=20
> Module naming isn't a big deal right now, but if we package it and
> upload to PyPI it will be something we shouldn't change frivolously.
>=20
> Daniel, are you suggesting we split it like this? --
>=20
> - qemu.machine (machine.py, qtest.py, accel.py?)
> - qemu.monitor (qmp.py)

I was actually suggesting  everything in qemu.machine, but I guess
qemu.monitor makes sense, given that this is an interface both for
controlling QEMU and the guest agent.

> the only one that's really truly weird is accel.py?, which is just kind
> of a misc function. I guess it can go in `qemu.machine` for now and if
> we adopt a `qemu.user` later, we can pull it out into a common area if
> we need to.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


