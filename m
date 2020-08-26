Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B21C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8C42075E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrnAq/ph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8C42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAw21-0002ap-NW
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kAw1E-0001c5-RB
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kAw19-0001p3-W4
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598450590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xniwJ9wWgZoTKxdbJgmtdpvnn0eQy8RUtEm5IBfYorQ=;
 b=SrnAq/ph0QtISQBsNktTOrK/3UXhGhWKSS0hH+rPZ5yomzcn/06zrZpMavy4wFdEScsY65
 QFvxUsQCgKp6qK4occqTzCvw1JoobDZRUbyLtyxZA8UO0+piI5fwAplWUYMin/LykHVTuW
 y3eHfunsrRL/gUmwyTMArrR4svH1fnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-HMIdVZXPPHCq9ypEJ4DPOw-1; Wed, 26 Aug 2020 10:03:07 -0400
X-MC-Unique: HMIdVZXPPHCq9ypEJ4DPOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93B98107464C;
 Wed, 26 Aug 2020 14:03:06 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23F4C708FF;
 Wed, 26 Aug 2020 14:02:59 +0000 (UTC)
Date: Wed, 26 Aug 2020 16:02:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
Message-ID: <20200826160258.0e9047f4@redhat.com>
In-Reply-To: <20200826133638.GO168515@redhat.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200826143849.59f6970b@redhat.com>
 <20200826125059.GN168515@redhat.com>
 <20200826153034.115126cb@redhat.com>
 <20200826133638.GO168515@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ehabkost@redhat.com, mst@redhat.com, Michal Privoznik <mprivozn@redhat.com>,
 qemu-devel@nongnu.org, Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Aug 2020 14:36:38 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Wed, Aug 26, 2020 at 03:30:34PM +0200, Igor Mammedov wrote:
> > On Wed, 26 Aug 2020 13:50:59 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Wed, Aug 26, 2020 at 02:38:49PM +0200, Igor Mammedov wrote: =20
> > > > On Fri, 21 Aug 2020 17:12:19 -0500
> > > > Babu Moger <babu.moger@amd.com> wrote:
> > > >    =20
> > > > > To support some of the complex topology, we introduced EPYC mode =
apicid decode.
> > > > > But, EPYC mode decode is running into problems. Also it can becom=
e quite a
> > > > > maintenance problem in the future. So, it was decided to remove t=
hat code and
> > > > > use the generic decode which works for majority of the topology. =
Most of the
> > > > > SPECed configuration would work just fine. With some non-SPECed u=
ser inputs,
> > > > > it will create some sub-optimal configuration.
> > > > > Here is the discussion thread.
> > > > > https://lore.kernel.org/qemu-devel/c0bcc1a6-1d84-a6e7-e468-d5b437=
c1b254@amd.com/
> > > > >=20
> > > > > This series removes all the EPYC mode specific apicid changes and=
 use the generic
> > > > > apicid decode.   =20
> > > >=20
> > > > the main difference between EPYC and all other CPUs is that
> > > > it requires numa configuration (it's not optional)
> > > > so we need an extra patch on top of this series to enfoce that, i.e=
:
> > > >=20
> > > >  if (epyc && !numa)=20
> > > >     error("EPYC cpu requires numa to be configured")   =20
> > >=20
> > > Please no. This will break 90% of current usage of the EPYC CPU in
> > > real world QEMU deployments. That is way too user hostile to introduc=
e
> > > as a requirement.
> > >=20
> > > Why do we need to force this ?  People have been successfuly using
> > > EPYC CPUs without NUMA in QEMU for years now.
> > >=20
> > > It might not match behaviour of bare metal silicon, but that hasn't
> > > obviously caused the world to come crashing down. =20
> > So far it produces warning in linux kernel (RHBZ1728166),
> > (resulting performance might be suboptimal), but I haven't seen
> > anyone reporting crashes yet.
> >=20
> >=20
> > What other options do we have?
> > Perhaps we can turn on strict check for new machine types only,
> > so old configs can keep broken topology (CPUID),
> > while new ones would require -numa and produce correct topology. =20
>=20
> No, tieing this to machine types is not viable either. That is still
> going to break essentially every single management application that
> exists today using QEMU.
for that we have deprecation process, so users could switch to new CLI
that would be required.


> Breaking stuff existing apps is not acceptable for something that is
> merely reporting sub-optimal performance. That's simply a documentation
> task to highlight best practice to app developers.
>=20
> Regards,
> Daniel


