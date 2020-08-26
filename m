Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8987DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6DB2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoqJ4T0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6DB2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB0G0-0002r8-VG
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 14:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kB0FD-0002PW-06
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 14:33:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44724
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kB0FA-0008NM-Go
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 14:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598466835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eI4oEWkZ5+44IEOcbq7uN5oTB32hFfCiWBbJplL1NHM=;
 b=XoqJ4T0r2pOkjclHCTOcVkDQBJi23uMH/DZTnF2sG/mHdzypSeGlKu2s6ZrKWRTjGjTtnc
 hsTqfHo8vUakS901uRSWa4Me+gfAXmAfEoKdt9JxdwEnwYfanvKKX4kLonWMKL2Eyovptn
 dM8FBRCsLViM4N6L2qnOTD+CmdD5K68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-PMxQ_Yg8N0SCLN30BB8hnQ-1; Wed, 26 Aug 2020 14:33:39 -0400
X-MC-Unique: PMxQ_Yg8N0SCLN30BB8hnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9302D1009443;
 Wed, 26 Aug 2020 18:33:38 +0000 (UTC)
Received: from work-vm (ovpn-112-133.ams2.redhat.com [10.36.112.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 163E775261;
 Wed, 26 Aug 2020 18:33:33 +0000 (UTC)
Date: Wed, 26 Aug 2020 19:33:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
Message-ID: <20200826183331.GA3977@work-vm>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200826143849.59f6970b@redhat.com>
 <20200826125059.GN168515@redhat.com>
 <20200826153034.115126cb@redhat.com>
 <5c00dac9-5ea5-405c-93be-1ac903ddff62@amd.com>
MIME-Version: 1.0
In-Reply-To: <5c00dac9-5ea5-405c-93be-1ac903ddff62@amd.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Babu Moger (babu.moger@amd.com) wrote:
> 
> > -----Original Message-----
> > From: Igor Mammedov <imammedo@redhat.com>
> > Sent: Wednesday, August 26, 2020 8:31 AM
> > To: Daniel P. Berrangé <berrange@redhat.com>
> > Cc: Moger, Babu <Babu.Moger@amd.com>; pbonzini@redhat.com;
> > rth@twiddle.net; ehabkost@redhat.com; qemu-devel@nongnu.org;
> > mst@redhat.com; Michal Privoznik <mprivozn@redhat.com>
> > Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
> > decode
> > 
> > On Wed, 26 Aug 2020 13:50:59 +0100
> > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > > On Wed, Aug 26, 2020 at 02:38:49PM +0200, Igor Mammedov wrote:
> > > > On Fri, 21 Aug 2020 17:12:19 -0500
> > > > Babu Moger <babu.moger@amd.com> wrote:
> > > >
> > > > > To support some of the complex topology, we introduced EPYC mode
> > apicid decode.
> > > > > But, EPYC mode decode is running into problems. Also it can become
> > > > > quite a maintenance problem in the future. So, it was decided to
> > > > > remove that code and use the generic decode which works for
> > > > > majority of the topology. Most of the SPECed configuration would
> > > > > work just fine. With some non-SPECed user inputs, it will create some sub-
> > optimal configuration.
> > > > > Here is the discussion thread.
> > > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > > > lore.kernel.org%2Fqemu-devel%2Fc0bcc1a6-1d84-a6e7-e468-
> > d5b437c1b25
> > > > >
> > 4%40amd.com%2F&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C8a5c
> > 52f92
> > > > >
> > 3f04082a40808d849c43d49%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> > C0
> > > > >
> > %7C637340454473508873&amp;sdata=VnW28H1v4XwK3GaNGFxu%2BhwiMeA
> > YO%2B
> > > > > 3WAzo3DeY5Ha8%3D&amp;reserved=0
> > > > >
> > > > > This series removes all the EPYC mode specific apicid changes and
> > > > > use the generic apicid decode.
> > > >
> > > > the main difference between EPYC and all other CPUs is that it
> > > > requires numa configuration (it's not optional) so we need an extra
> No, That is not true. Because of that assumption we made all these apicid
> changes. And here we are now.
> 
> AMD supports varies mixed configurations. In case of EPYC-Rome, we have
> NPS1, NPS2 and NPS4(Numa Nodes per socket). In case of NPS1, basically we
> have all the cores in a socket under one numa node. This is non-numa
> configuration.
> Looking at the various configurations and also discussing internally, it
> is not advisable to have (epyc && !numa) check.

Indeed on real hardware, I don't think we always see NUMA; my single
socket, 16 core/32 thread 7302P Dell box, shows the kernel printing
'No NUMA configuration found...Faking a node.'

So if real hardware hasn't got a NUMA node, what's the real problem?

Dave

> > > > patch on top of this series to enfoce that, i.e:
> > > >
> > > >  if (epyc && !numa)
> > > >     error("EPYC cpu requires numa to be configured")
> > >
> > > Please no. This will break 90% of current usage of the EPYC CPU in
> > > real world QEMU deployments. That is way too user hostile to introduce
> > > as a requirement.
> > >
> > > Why do we need to force this ?  People have been successfuly using
> > > EPYC CPUs without NUMA in QEMU for years now.
> > >
> > > It might not match behaviour of bare metal silicon, but that hasn't
> > > obviously caused the world to come crashing down.
> > So far it produces warning in linux kernel (RHBZ1728166), (resulting performance
> > might be suboptimal), but I haven't seen anyone reporting crashes yet.
> > 
> > 
> > What other options do we have?
> > Perhaps we can turn on strict check for new machine types only, so old configs
> > can keep broken topology (CPUID), while new ones would require -numa and
> > produce correct topology.
> > 
> > 
> > >
> > > Regards,
> > > Daniel
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


