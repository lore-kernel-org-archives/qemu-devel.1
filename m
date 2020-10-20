Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20243C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39095222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSdEDwak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39095222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUn2Q-0007vj-0r
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUn1Q-0007FB-Al
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:29:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUn1N-0007Ms-NW
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603182567;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBHfkinYj4WQ8dP9GBaM1IYz1RFJaMySOcSUl9MBr2g=;
 b=OSdEDwakmUrmcmSXPeoCRCdq6uixX7UK90+8i6tm2lH/RuPXMAOCFjWjCliYp6zR+LbOnn
 trEdPL7RsyUPuzcoikZliygBB5uQD2cg4kdH/bxFLFVQ+Vk4d7bcWkd+UE6fZ1d2CpG03+
 JO6uMLiQA64hQjCBKbREFI/3OBGcw20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-0LoHRz6sM3ObF4gbeVOurQ-1; Tue, 20 Oct 2020 04:29:25 -0400
X-MC-Unique: 0LoHRz6sM3ObF4gbeVOurQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A0061006C83;
 Tue, 20 Oct 2020 08:29:24 +0000 (UTC)
Received: from redhat.com (ovpn-114-206.ams2.redhat.com [10.36.114.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37521100238C;
 Tue, 20 Oct 2020 08:29:14 +0000 (UTC)
Date: Tue, 20 Oct 2020 09:29:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Erik Skultety <eskultet@redhat.com>
Subject: Re: [PATCH v4 3/4] Jobs based on custom runners: docs and
 gitlab-runner setup playbook
Message-ID: <20201020082911.GB287149@redhat.com>
References: <20201019015003.1527746-1-crosa@redhat.com>
 <20201019015003.1527746-4-crosa@redhat.com>
 <20201019102610.GB495479@nautilus>
 <20201019204138.GC1617151@localhost.localdomain>
 <20201020065839.GE495479@nautilus>
MIME-Version: 1.0
In-Reply-To: <20201020065839.GE495479@nautilus>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 08:58:39AM +0200, Erik Skultety wrote:
> On Mon, Oct 19, 2020 at 04:41:38PM -0400, Cleber Rosa wrote:
> > On Mon, Oct 19, 2020 at 12:26:10PM +0200, Erik Skultety wrote:
> > > On Sun, Oct 18, 2020 at 09:50:02PM -0400, Cleber Rosa wrote:
> > > > To have the jobs dispatched to custom runners, gitlab-runner must
> > > > be installed, active as a service and properly configured.  The
> > > > variables file and playbook introduced here should help with those
> > > > steps.
> > > > 
> > > > The playbook introduced here covers a number of different Linux
> > > > distributions and FreeBSD, and are intended to provide a reproducible
> > > > environment.
> > > > 
> > > > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > > > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > ---
> > > 
> > > In general, there's been put quite some effort into the playbooks - sorry I'm
> > > late to the game - is there a plan to introduce QEMU as a project to lcitool?
> > 
> > I think it's becoming quite clear that having so much duplication (in
> > the dockerfiles, tests/vm, this playbook, etc) is costly and error
> > prone.  I don't know if anyone has invested time in a PoC to
> > consolidate those (with lcitool), but I can certainly see the upside
> > to that.  BTW, are you volunteering (wink wink)? :)
> 
> I don't think I was trying to :), but sure, I can dedicate some time to it.
> I'll need a bit of guidance in the QEMU world though for sure.

I think the obvious and easy place is start using lcitool is for the
tests/docker/dockerfiles/*.  All that's required is to add mappings
to lcitool for the various deps that QEMU has which libvirt does not
already have. Then we should be able to start auto-generating the
dockerfiles without too much difficulty. This will be a significant
step forward because it will help us keep te package lists in sync
across all the dockerfiles which is a major fail in QEMU right now.


Dealing with tests/vm replacement or these ansible recipes is likely
to be a significantly more challenging proposition. Perhaps we can
again start by just automating creation of the package lists that
the tests/vm and ansibile recipes need, as again those are all
inconsistent.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


