Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25547C5DF9E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 15:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE0A20759
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 15:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbnjlKih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE0A20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9Ug-0001M9-6c
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 11:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kY9TT-0008CJ-Mc
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 11:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kY9TP-0002e4-Iy
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 11:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603983857;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=pva3JxCHhwv7vkIKQiq5rlQ3SR4xWvloil2Z9CUG4uA=;
 b=SbnjlKihc0wEvpXr6xFqynvPA23o4EdVFYbtnBHZKjK9KSA8Er6D7iJY2zXUr3f4EA9M3y
 vexx2zlIxgA7pEXCuqvPA2rx8QMD3JspjNphdOKR/F8EKU+1KABPeIKVLt9hKmcxknWUSi
 dxn+MrUk3Vt5jCdgQsHcHfMbLj6QinA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-Su3kk5gDPD2MKyB-Ck-Dhg-1; Thu, 29 Oct 2020 11:04:09 -0400
X-MC-Unique: Su3kk5gDPD2MKyB-Ck-Dhg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06DEC1016D18;
 Thu, 29 Oct 2020 15:04:08 +0000 (UTC)
Received: from redhat.com (ovpn-115-62.ams2.redhat.com [10.36.115.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 983811001901;
 Thu, 29 Oct 2020 15:04:06 +0000 (UTC)
Date: Thu, 29 Oct 2020 15:04:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/13] 9p queue 2020-10-23
Message-ID: <20201029150403.GF27369@redhat.com>
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
 <5649161.sut93UlCx4@silver>
 <CAFEAcA-+4Ac7tGyXxDjkPrsJw7NmH3bijkuXLY9gF=Vr7p1LWQ@mail.gmail.com>
 <3209306.Oi7kq7t7ax@silver>
 <CAFEAcA9KYtb7tFp5tnPGMiYg0gpurao7GbcU_ND934tvFiU-aw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9KYtb7tFp5tnPGMiYg0gpurao7GbcU_ND934tvFiU-aw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 02:52:16PM +0000, Peter Maydell wrote:
> On Thu, 29 Oct 2020 at 14:31, Christian Schoenebeck
> <qemu_oss@crudebyte.com> wrote:
> >
> > On Donnerstag, 29. Oktober 2020 15:15:19 CET Peter Maydell wrote:
> > > On Thu, 29 Oct 2020 at 14:06, Christian Schoenebeck
> > >
> > > <qemu_oss@crudebyte.com> wrote:
> > > > Ok, I'll use mkdtemp() instead, that avoids other potential parallel
> > > > config
> > > > colissions that I may not have considered yet.
> > > >
> > > > The original motivation against mkdtemp() was that /tmp is isually a
> > > > ramfs,
> > > > hence very limited regarding large file tests. But that's not an issue
> > > > right now.
> > >
> > > How large is "large" here ?
> 
> > E.g. ~10 GiB which might be a problem for cloud based CI platforms.
> 
> Yeah, 10GB is too big by an order of magnitude for anything in the
> standard "make check" set. It could go in an optional "I'm the 9p
> maintainer and I want to run a wider set of tests" target though.

I think as a rough rule of thumb, tests should not create files
that are larger than the size of the QEMU build dir, and if it is
creating non-trivially sized files, then they should be created in
the build dir, not /tmp.  This probably puts 1 GB as a upper bound
on size but bear in mind tests can run in parallel, so ideally biggest
file sizes should be more in the 100s of MB range


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


