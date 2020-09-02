Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EF2C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675EB207D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr90QbJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675EB207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDTU4-0002xc-L8
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDTTN-0002Nk-DE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:10:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38202
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDTTJ-0007l6-W8
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599055845;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0zPfNsvIH4VmXiuz+JG6VfOk18bhG3AOoTc/ab9MvM=;
 b=Xr90QbJLvEvDuRT6JjCpKBLtEDkdqs4GQDBROx9INXYxbBzWqiBax6T2Lzn1H+I3VeQfP/
 6flebJBIIAMrxE9bx1NV8mVa3WUsDBKPteqROjsgNbqRypIJfjJg/46fsOsmLPEDEGiV2x
 rQ3HrgmkTM99K4QjsmiJ9wNNwmRDGfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-NcJernfsOqOLR4gRUeN8iw-1; Wed, 02 Sep 2020 10:10:40 -0400
X-MC-Unique: NcJernfsOqOLR4gRUeN8iw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6BE5801AC2;
 Wed,  2 Sep 2020 14:10:39 +0000 (UTC)
Received: from redhat.com (ovpn-114-158.ams2.redhat.com [10.36.114.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5EBC19C71;
 Wed,  2 Sep 2020 14:10:38 +0000 (UTC)
Date: Wed, 2 Sep 2020 15:10:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: log warning if msize <= 8192
Message-ID: <20200902141035.GK403297@redhat.com>
References: <E1kDR8W-0001s4-Sr@lizzy.crudebyte.com>
 <20200902153934.5a2d7f86@bahia.lan>
 <20200902134503.GJ403297@redhat.com> <2812056.Ea3xXQFrjv@silver>
MIME-Version: 1.0
In-Reply-To: <2812056.Ea3xXQFrjv@silver>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 02, 2020 at 04:08:48PM +0200, Christian Schoenebeck wrote:
> On Mittwoch, 2. September 2020 15:45:03 CEST Daniel P. Berrangé wrote:
> > To be clear, I'm not objecting to warning - just that the proposed warning
> > doesn't give any useful information about what is considered to be a
> > sensible alternative size, and nor does the commit message.
> > 
> > Just like to see the commit message provide the background info above,
> > and ideally have the warning message at least give the user a suggestion
> > that is in the sensible order of magnitude they should be looking at.
> > 
> > eg tell them to aim for 1 MB (or whatever value) as a starting point to
> > tuning.
> 
> Yeah, I know, but the problem is I don't see how I would squeeze the relevant 
> information into only one log message; and even "what's a good starting point" 
> is already questionable.
> 
> For that reason my plan was:
> 
> 	- logging this warning
> 
> 	- describing the 'msize' issue in detail on the QEMU wiki (what's the 
> 	  point, how would you benchmark it)
> 
> So my idea was: user sees the message, "what is 'msize?'" -> Google "msize 
> qemu" -> click 'QEMU wiki' -> read all the details.
> 
> But how about this: I put a QEMU wiki link directly into the log message?

Rather than that, how about putting it in the QEMU man page, and then
just add  "See 'man 1 qemu' for further guidance".


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


