Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD8DC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 21:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFA5212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 21:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOPXxyn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFA5212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLCk6-0000Ix-E4
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 17:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLCir-0008J5-Lz
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 17:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLCiq-0008MY-1s
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 17:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600898083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QIMil7nu+Yrjw64stcxh41q8PGAXKeW4IWuLRumfg2k=;
 b=GOPXxyn6l5KdHTShqMA7EyIRdl1kRQyX3n5ooS3fOc9UxiuE4meCB4ckhNAH0eBQExcR5Q
 5dmI35h/eKSu7lzpkG2q4PwBVvDvT78eR9ilG5hOKRtm/5OYi5gFd07lYbV+L+sNypCCGS
 Zmdf2U1UUy5sZ9Qmd/han0IOmzDV2tI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-WEH8XUofOHW6KF9vbqd7YA-1; Wed, 23 Sep 2020 17:54:41 -0400
X-MC-Unique: WEH8XUofOHW6KF9vbqd7YA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 529B7104D3EE;
 Wed, 23 Sep 2020 21:54:40 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9DEF81C50;
 Wed, 23 Sep 2020 21:54:39 +0000 (UTC)
Date: Wed, 23 Sep 2020 17:54:38 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 31/38] qapi/introspect.py: add _gen_features helper
Message-ID: <20200923215438.GZ3717385@habkost.net>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-32-jsnow@redhat.com>
 <20200923163526.GS3312949@habkost.net>
 <dea63eb3-7842-ff29-918d-12e5e7bc90a0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dea63eb3-7842-ff29-918d-12e5e7bc90a0@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 23, 2020 at 05:43:45PM -0400, John Snow wrote:
> On 9/23/20 12:35 PM, Eduardo Habkost wrote:
> > I believe these two lines above should be removed, as suggested
> > in patch 30, but let's ignore that for now.
> > 
> 
> Yup, headed there.
> 
> > > -    if features:
> > > -        obj['features'] = [(f.name, Extra(None, f.ifcond)) for f in features]
> > I can't say I understand completely why moving these two lines
> > outside _make_tree() is useful, but if it makes the cleanup work
> > you did easier, I trust this is the right thing to do.  The
> > changes look correct.
> 
> The basic premise is:
> 
> Why pass information you want to add to obj['features'] to a function to
> make that assignment, when you could just perform that assignment yourself?
> 
> Otherwise, _make_tree, which accepts any arbitrary object (not just dicts!)
> has to interrogate its arguments to make sure you gave it a dict when you
> give it a features argument.

Oh, I was not aware that obj could be not a dictionary.  In this
case, it makes lots of sense to move the magic outside the
function.

> 
> Type-wise, it's cleaner to perform this transformation when we KNOW we have
> an object than it is to defer to a more abstracted function and
> assert/downcast back to more specific types.

-- 
Eduardo


