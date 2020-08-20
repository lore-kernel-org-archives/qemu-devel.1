Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7BBC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBC0207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/Wfh36k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBC0207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8nn1-0007WH-6x
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 12:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8nmU-00070W-IE
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:51:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8nmS-0005GC-2W
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597942268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tolxXooYSRPaHVScDuKTkkmiipZ10IFAIlZRSUDDJE8=;
 b=X/Wfh36kou6BKhrmb3oYIR19xWWs/6CkGOVSvhdNEh05ZlQlEnwR5k/BbX7PNzbM1KvCNs
 i+9j+8+pkEeamzpmCS+/yxGa4HUto+jzjLvg65rFtb7EvP9jXfoVGXfvkS0pBOMIQ4UOb8
 UOb1XccIZt2YYBvcbnAAcxNyPYytNvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-0HU7uTSEP5qmpwzciOo42w-1; Thu, 20 Aug 2020 12:51:06 -0400
X-MC-Unique: 0HU7uTSEP5qmpwzciOo42w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CC06801ADD;
 Thu, 20 Aug 2020 16:51:04 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EEB210098AE;
 Thu, 20 Aug 2020 16:51:03 +0000 (UTC)
Date: Thu, 20 Aug 2020 12:51:03 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 02/10] numa: introduce
 MachineClass::forbid_asymmetrical_numa
Message-ID: <20200820165103.GD642093@habkost.net>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-3-danielhb413@gmail.com>
 <20200820011726.GF271315@yekko.fritz.box>
 <20200820021128.GC642093@habkost.net>
 <20200820041504.GN271315@yekko.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200820041504.GN271315@yekko.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: John Snow <jsnow@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 02:15:04PM +1000, David Gibson wrote:
> On Wed, Aug 19, 2020 at 10:11:28PM -0400, Eduardo Habkost wrote:
> > On Thu, Aug 20, 2020 at 11:17:26AM +1000, David Gibson wrote:
> > > On Fri, Aug 14, 2020 at 05:54:16PM -0300, Daniel Henrique Barboza wrote:
> > > > The pSeries machine does not support asymmetrical NUMA
> > > > configurations.
> > > 
> > > This seems a bit oddly specific to have as a global machine class
> > > property.
> > > 
> > > Would it make more sense for machines with specific NUMA constraints
> > > to just verify those during their initialization?
> > 
> > This would be much simpler.  However, I like the idea of
> > representing machine-specific configuration validation rules as
> > data that can eventually be exported to management software.
> 
> Ah, ok, so basically the usual tradeoff between flexibility and
> advertisability.
> 
> So, in that case, I guess the question is whether we envisage "no
> assymmetry" as a constraint common enough that it's worth creating an
> advertisable rule or not.  If we only ever have one user, then we
> haven't really done any better than hard coding the constraint in the
> manageent software.
> 
> Of course to complicate matters, in the longer term we're looking at
> removing that constraint from pseries - but doing so will be dependent
> on the guest kernel understanding a new format for the NUMA
> information in the device tree.  So qemu alone won't have enough
> information to tell if such a configuration is possible or not.

Requiring both QEMU (and possibly management software) to be
patched again after the guest kernel is fixed sounds undesirable.
Perhaps a warning would be better in this case?

In either case, it sounds like this won't be a common constraint
and I now agree with your original suggestion of doing this in
machine initialization code.

-- 
Eduardo


