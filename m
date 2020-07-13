Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69591C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BED205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTLhI/b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BED205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzTv-0005ZQ-Ec
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1juzMv-0002va-T7
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:23:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21264
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1juzMr-0008G3-N4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594650220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2EWCz6/pptEdulWE31b88qcavGs4kkrw5SmEWLxFtXY=;
 b=gTLhI/b4mGmiNhbZNb6gAVMKE2q25X9roVZ9Fv/mYlVr4AZaUkdcPUUnKEGkAnW+SvhwE/
 cAGrMESoTNLHoIAAfvOb444TW9O3kAh42BTsyOek/VdQ+IFLy3YHjSDEYXd+u1L95Urs4R
 dgf0JdVhWLmBVqnNgmrnYDvaHa2pdaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-BQcsv97HOI2rYZ2Bkqyk6g-1; Mon, 13 Jul 2020 10:23:37 -0400
X-MC-Unique: BQcsv97HOI2rYZ2Bkqyk6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9FA88015F3;
 Mon, 13 Jul 2020 14:23:34 +0000 (UTC)
Received: from localhost (ovpn-119-232.rdu2.redhat.com [10.10.119.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B200319D61;
 Mon, 13 Jul 2020 14:23:34 +0000 (UTC)
Date: Mon, 13 Jul 2020 10:23:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add Python library stanza
Message-ID: <20200713142333.GV780932@habkost.net>
References: <20200710215718.13034-1-jsnow@redhat.com>
 <20200710215718.13034-2-jsnow@redhat.com>
 <87365v1qsx.fsf@linaro.org>
 <e07c2650-7582-753c-ed66-dad43389e552@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e07c2650-7582-753c-ed66-dad43389e552@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 09:59:49AM -0400, John Snow wrote:
> 
> 
> On 7/13/20 9:35 AM, Alex Bennée wrote:
> > 
> > John Snow <jsnow@redhat.com> writes:
> > 
> >> I'm proposing that I split the actual Python library off from the other
> >> miscellaneous python scripts we have and declare it maintained. Add
> >> myself as a maintainer of this folder, along with Cleber.
> >>
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> ---
> >>  MAINTAINERS | 9 ++++++++-
> >>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 6aa54f7f8f..fe1dcd5a76 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -2280,11 +2280,18 @@ S: Maintained
> >>  F: include/sysemu/cryptodev*.h
> >>  F: backends/cryptodev*.c
> >>  
> >> +Python library
> >> +M: John Snow <jsnow@redhat.com>
> >> +M: Cleber Rosa <crosa@redhat.com>
> >> +R: Eduardo Habkost <ehabkost@redhat.com>
> >> +S: Maintained
> >> +F: python/*
> > 
> > I don't think that's equivalent to what you drop bellow:
> > 
> >     F:	drivers/net/	all files in and below drivers/net
> >     F:	drivers/net/*	all files in drivers/net, but not below
> > 
> > So I think you should drop the *
> > 
> 
> I didn't realize that, thanks for correcting it.
> 
> >> +T: git https://gitlab.com/jsnow/qemu.git python
> >> +
> >>  Python scripts
> >>  M: Eduardo Habkost <ehabkost@redhat.com>
> >>  M: Cleber Rosa <crosa@redhat.com>
> >>  S: Odd fixes
> >> -F: python/qemu/*py
> >>  F: scripts/*.py
> >>  F: tests/*.py
> > 
> > Otherwise:
> > 
> > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > 
> 
> I swear I talked to Cleber and Eduardo before sending this, we'll wait
> for them to say hi :)

You did!  And I'm happy to see you are volunteering to replace me
as maintainer on many of those files.

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo


