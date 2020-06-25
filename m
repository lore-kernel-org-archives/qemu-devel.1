Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ED2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B4E207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhAOnJWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B4E207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joQ58-0006ga-TT
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1joQ4U-00069Z-0y
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:29:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20490
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1joQ4S-00054H-4g
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593084571;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fwhaXMRI0IBMbT5rPLV/sycfa6hB0PIGb078Xa4HkEQ=;
 b=RhAOnJWaDHJ4HL+KiFIRjopPo0gDwDcC1it//UWmGWu3SRhn64ThRn6Xbp28l9g2wpAQHT
 Tc4ZQcpO62Qb3j6x7BqbvJT15TRzdz0UdIaxAdBtaq5aywRopA1Gf2rWkoELcxYU61eoNZ
 Y8CO1mAflvaME4Nsb7pcx7L/8OORKqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-V_X8rUMMOtmF6qRMadgNdg-1; Thu, 25 Jun 2020 07:29:29 -0400
X-MC-Unique: V_X8rUMMOtmF6qRMadgNdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1381107ACCD;
 Thu, 25 Jun 2020 11:29:28 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37E8819D61;
 Thu, 25 Jun 2020 11:29:22 +0000 (UTC)
Date: Thu, 25 Jun 2020 12:29:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH RFC 0/3] gitlab: build containers to use in build jobs
Message-ID: <20200625112919.GB1014704@redhat.com>
References: <20200622153318.751107-1-berrange@redhat.com>
 <a08ca3b1-ddde-693b-60e0-cca9b0094721@redhat.com>
 <20200625112653.GA1014704@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625112653.GA1014704@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laszlo Ersek <lersek@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 25, 2020 at 12:26:53PM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 25, 2020 at 01:15:52PM +0200, Thomas Huth wrote:
> > On 22/06/2020 17.33, Daniel P. Berrangé wrote:
> > > The current gitlab CI jobs are quite inefficient because they
> > > use the generic distro images and then apt-get/dnf install
> > > extra packages every time.
> > > 
> > > The other downside is that the container environment used is
> > > only defined in thte .gitlab-ci.yml file, so it tedious to
> > > reproduce locally.
> > > 
> > > We already have containers defined in tests/docker for use by
> > > developers building locally. We can use these for CI systems
> > > too if we just had a way to build them....
> > > 
> > > ...GitLab CI offers such a way. We can use docker-in-docker
> > > to build the images at the start of the CI cycle, and use
> > > the built images in later jobs.
> > > 
> > > These later jobs are now faster because they're not having
> > > to install any software.
> > 
> > Did you see any speed-up? I had a look at some pipelines, and it seems to me
> > that they rather got slower now? For example, this is the system1 pipeline
> > before your change:
> > 
> >  https://gitlab.com/huth/qemu/-/jobs/610924897
> > 
> > and after your change:
> > 
> >  https://gitlab.com/huth/qemu/-/jobs/611069374
> > 
> > Duration went up from 35 minutes to 42 minutes.
> > 
> > Seems also to happen in your builds, before the change:
> > 
> >  https://gitlab.com/berrange/qemu/-/jobs/582995084
> > 
> > and after the change:
> > 
> >  https://gitlab.com/berrange/qemu/-/jobs/606175927
> > 
> > ... went from 36 minutes up to 42 minutes.
> > 
> > Could be a coincidence due to the load on the shared runners, but it looks
> > at least a little bit suspicious...
> 
> I think the difference is because we're building more features now. The
> dockerfiles have provided more build pre-requisites that the old gitlab
> recipe did.
> 
> If you compare the configure summary, I see the new build now covers
> SDL, curses, curl, pulseaudio, virtiofs, SASL, libjpeg, xen, docs
> and a few more.  So we've saved time by not intsallling many packages
> each time, but consumed a greater amount of time by compiling more
> features.

Oh a missed a lot more actually - there's also spice, opengl, libiscsi,
libnfs, libusb, seccomp, libssh, lzo, snappy, bzip, zstd, numa and udev
too.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


