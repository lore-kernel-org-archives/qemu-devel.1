Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B0FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C413E20723
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cumu4TP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C413E20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbQD-0001hM-18
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jdbPO-0000bM-TQ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:22:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jdbPN-0004wQ-Ul
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590506544;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKsdBN/j3N5BrR9I71n+4e4gatT5x4aE15o8YkzoCAQ=;
 b=cumu4TP8Mc42tvdn5Sgq25u2JkXEVeaz50Kry5tCvVy5EDe2lsIR+03+sBfXbPhaxNIxNf
 jco13AdgZ4UBa5Pd1I4IgB6Gij/zmgs0DXDI44AvwdFyPrpYhhtteJqijygokEA2lEw0Hh
 JHgbnw0zCwHlqHe/dTR3rdR93p1oN5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-UYylQRHeN52PDUt8q73F4Q-1; Tue, 26 May 2020 11:22:15 -0400
X-MC-Unique: UYylQRHeN52PDUt8q73F4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 759501005510;
 Tue, 26 May 2020 15:22:14 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D102A19D71;
 Tue, 26 May 2020 15:22:10 +0000 (UTC)
Date: Tue, 26 May 2020 16:22:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH RFC 01/32] python/qemu: create qemu.lib module
Message-ID: <20200526152207.GK2496524@redhat.com>
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-2-jsnow@redhat.com>
 <b4618eb0-5303-40ab-b5e2-5a08d5738a81@virtuozzo.com>
 <20b3fb10-8028-eb12-49a9-a3cc9dd45ed0@redhat.com>
 <07ff57d4-8348-4409-ca8a-ff4c5278b973@virtuozzo.com>
 <45dc0bb0-6b22-1703-0435-9d49d3df9978@redhat.com>
MIME-Version: 1.0
In-Reply-To: <45dc0bb0-6b22-1703-0435-9d49d3df9978@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 08:27:54PM -0400, John Snow wrote:
> 
> 
> On 5/18/20 3:33 PM, Vladimir Sementsov-Ogievskiy wrote:
> > 18.05.2020 21:23, John Snow wrote:
> >>
> >>
> >> On 5/18/20 2:14 PM, Vladimir Sementsov-Ogievskiy wrote:
> >>> 14.05.2020 08:53, John Snow wrote:
> >>>> move python/qemu/*.py to python/qemu/lib/*.py.
> >>>>
> >>>> To create a namespace package, the 'qemu' directory itself shouldn't
> >>>> have module files in it. Thus, these files will go under a 'lib'
> >>>> package
> >>>> directory instead.
> >>>
> >>> Hmm..
> >>>
> >>> On the first glance, it looks better to have
> >>>
> >>>    from qemu import QEMUMachine
> >>>
> >>> than
> >>>      from qemu.lib import QEMUMachine
> >>>
> >>> why do we need this extra ".lib" part?
> >>>
> >>> Is it needed only for internal use?
> >>>
> >>> Assume we have installed qemu package. Can we write
> >>>
> >>>    from qemu import QEMUMachine
> >>>
> >>> ? Or we still need qemu.lib ?
> >>>
> >>> I don't remember any python package, which made me to write "import from
> >>> package_name.lib ..."
> >>>
> >>>
> >>
> >> It's a strategy to create "qemu" as a PEP420 namespace package; i.e.
> >> "qemu" forms a namespace, but you need a name for the actual package
> >> underneath it.
> >>
> >> "qemu.lib" is one package, with qmp, qtest, and machine modules. "qemu"
> >> isn't really a package in this system, it's just a namespace.
> >>
> >> The idea is that this allows us to create a more modular rollout of
> >> various python scripts and services as desired instead of monolithically
> >> bundling them all inside of a "qemu" package.
> >>
> >> It also allows us to fork or split out the sub-packages to separate
> >> repos, if we wish. i.e., let's say we create a "qemu.sdk" subpackage, we
> >> can eventually fork it off into its own repo with its own installer and
> >> so forth. These subpackages can be installed and managed separately.
> >>
> > 
> > Okay, I understand.. No real objections than.
> > 
> > Still, maybe, everything should not go into lib, maybe something like
> > 
> > qemu/vm/  - qmp, QEMUMachine, etc
> > qemu/qtest/  - qtest
> > 
> > would be more user friendly? But I'm not sure. I just thought that "lib"
> > is too generic.
> > 
> 
> lib is a very generic name, I agree.
> 
> Splitting accel, qmp and QEMUMachine in one package and keeping qtest in
> another is fine too. I'm not sure if I like "vm" for the name of that
> core package, though.
> 
> I want to avoid using "qemu/sdk" because I have some plans for trying to
> generate and package a "real" SDK using that namespace.
> 
> "devkit"? "testkit"? "core"? Naming things is always the worst part.

I'd suggest  "machine", as in

  from qemu.machine import  kvm_available, QEMUMachine

I wouldn't over-think the module naming as it has so little impact on
the code usage - it usually only appears in the "import" statement.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


