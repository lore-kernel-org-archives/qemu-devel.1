Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF29C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429D4208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429D4208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfn16-00085M-7Y
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 11:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53010)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hfmsh-0003IA-Dj
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hfmsf-0001dR-Az
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:57:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hfmsd-0001aZ-Bk
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:57:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9848C30043E8;
 Tue, 25 Jun 2019 14:56:56 +0000 (UTC)
Received: from work-vm (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B298600C7;
 Tue, 25 Jun 2019 14:56:53 +0000 (UTC)
Date: Tue, 25 Jun 2019 15:56:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190625145651.GM3226@work-vm>
References: <20190625050008.12789-1-ehabkost@redhat.com>
 <20190625050008.12789-5-ehabkost@redhat.com>
 <20190625093201.GF3226@work-vm> <20190625134029.GP1862@habkost.net>
 <20190625143216.GL3226@work-vm> <20190625145309.GQ1862@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625145309.GQ1862@habkost.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 25 Jun 2019 14:57:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/6] i386: Infrastructure for versioned CPU
 models
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> On Tue, Jun 25, 2019 at 03:32:16PM +0100, Dr. David Alan Gilbert wrote:
> > * Eduardo Habkost (ehabkost@redhat.com) wrote:
> > > On Tue, Jun 25, 2019 at 10:32:01AM +0100, Dr. David Alan Gilbert wrote:
> > > > * Eduardo Habkost (ehabkost@redhat.com) wrote:
> > > > > Base code for versioned CPU models.  This will register a "-4.1"
> > > > > version of all existing CPU models, and make the unversioned CPU
> > > > > models be an alias for the -4.1 versions on the pc-*-4.1 machine
> > > > > types.
> > > > > 
> > > > > On older machine types, the unversioned CPU models will keep the
> > > > > old behavior.  This way, management software can use old machine
> > > > > types while resolving aliases if compatibility with older QEMU
> > > > > versions is required.
> > > > > 
> > > > > Using "-machine none", the unversioned CPU models will be aliases
> > > > > to the latest CPU model version.
> > > > > 
> > > > > Includes a test case to ensure that:
> > > > > old machine types won't report any alias to versioned CPU models;
> > > > > "pc-*-4.1" will return aliases to -4.1 CPU models;
> > > > > and "-machine none" will report aliases to some versioned CPU model.
> > > > > 
> > > > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > 
> > > > What happens when we add the next new CPU model?  So say in 4.2 we add
> > > > a new CPU, does that default to being newcpu-4.2 ?
> > > 
> > > We can choose between providing old versions of the CPU model
> > > retroactively ("NewModel-4.1" and "NewModel-4.2"), or providing
> > > only "NewModel-4.2".
> > > 
> > > The question is: if we provide only "NewModel-4.2", what should
> > > be the behavior of "-machine pc-i440fx-4.1 -cpu NewModel"?
> > 
> > Perhaps the existing CPUs and the first instance of a new CPU
> > we should use something non-numeric, e.g. 'orig' rather than 4.1;
> > we only go numeric when we cause a divergence.
> 
> What would be the advantage of a non-numeric version identifier?
> I believe it would be more confusing to have (e.g.)
> ["NewModel-orig", "NewModel-4.3"] in QEMU 4.3 instead of
> ["NewModel-4.2", "NewModel-4.3"].

To my mind it answers your question:
> > > The question is: if we provide only "NewModel-4.2", what should
> > > be the behavior of "-machine pc-i440fx-4.1 -cpu NewModel"?

NewModel-orig doesn't look weird in pc-i440fx-4.1

Dave


> However, you have another interesting point: should we introduce
> -4.2 versions of all CPU models in QEMU 4.2, or only for the ones
> that actually changed?  I think I prefer consistency, even if it
> means making the list of CPU models larger.
> 
> What do others think?
> 
> -- 
> Eduardo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

