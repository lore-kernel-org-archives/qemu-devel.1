Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9C9C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 04:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05FB82073A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 04:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnnX4Etk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FB82073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ7tq-0003K1-TX
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 00:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJ7t7-0002sn-6h
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 00:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJ7t5-0004mG-3Y
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 00:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600402840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=roqUm4xBZX0M5YwTRsi43dswJPMSQ77v3XjDGfFpg1M=;
 b=fnnX4Etka2R9FmXQLOqh37P9EeyR6vex06DzskbGwd9K8dBwSGS+6m9py7xioZOZzhMyIe
 Zs1MdHBn2Nut+pt7WvEm3DNjZVRwNHq4Sn7qEpGFM2VKu7kQ+YG810qZpLKwhbt3FobObX
 bfNwM/92xUN932qPaVs3JWYMuQVRvDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-lQ34FwMQOgOYvMB0ux3j2g-1; Fri, 18 Sep 2020 00:20:39 -0400
X-MC-Unique: lQ34FwMQOgOYvMB0ux3j2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD02B81F02E;
 Fri, 18 Sep 2020 04:20:37 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 191EC10013C1;
 Fri, 18 Sep 2020 04:20:36 +0000 (UTC)
Date: Fri, 18 Sep 2020 00:20:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v3 2/2] Mark Icelake-Client CPU models deprecated
Message-ID: <20200918042036.GY7594@habkost.net>
References: <1600245434-63021-1-git-send-email-robert.hu@linux.intel.com>
 <1600245434-63021-2-git-send-email-robert.hu@linux.intel.com>
 <20200917180158.GT7594@habkost.net>
 <de6e39509242483607525f9e27aeff92e510a5dc.camel@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <de6e39509242483607525f9e27aeff92e510a5dc.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com, robert.hu@intel.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 10:18:56AM +0800, Robert Hoo wrote:
> On Thu, 2020-09-17 at 14:01 -0400, Eduardo Habkost wrote:
> > On Wed, Sep 16, 2020 at 04:37:14PM +0800, Robert Hoo wrote:
> > > Going to obsolete Icelake-Client CPU models in the future.
> > > 
> > > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > > ---
> > > Change log
> > > v3:
> > > Obsolete in v5.2 --> v5.3.
> > > 
> > >  target/i386/cpu.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 9cb82b7..15c1c00 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -3467,7 +3467,12 @@ static X86CPUDefinition builtin_x86_defs[] =
> > > {
> > >          .xlevel = 0x80000008,
> > >          .model_id = "Intel Core Processor (Icelake)",
> > >          .versions = (X86CPUVersionDefinition[]) {
> > > -            { .version = 1 },
> > > +            {
> > > +                .version = 1,
> > > +                .deprecated = true,
> > > +                .note = "Deprecated. Will be obsoleted in v5.3.
> > > Please use "
> > > +                        "'Icelake-Server-v1' CPU model",
> > 
> > What's the difference between "deprecated" and "obsoleted"?
> > 
> Forgive my non-native understanding on English word:-D

No problem!  I'm not a native speaker either.  :-)

> Here is my understanding:
> 'Deprecate' is to express strong disapproval on the usage; but, can
> still be used if user insists.
> 'Obsolete' means not usable anymore.
> 
> You can feel free to reword the note words.
> Perhaps substitute 'removed' for 'obsolete' will be better.

"Removed" would be clearer, yes.  It's probably better to not
mention the exact version, and just say it will be removed in
the future.

Or maybe just make the message shorter and set deprecation_note
to "Please use Icelake-Server instead".  The details can be
documented in docs/system/deprecated.rst.

-- 
Eduardo


