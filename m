Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AA9C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2BC20724
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Od2DdEuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2BC20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8kev-0000vL-Tj
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 09:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8keK-0000VH-93
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 09:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8keH-00020t-Uv
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 09:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597930232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rOKQel6QayhkMuf8Zj0HPITTdRRLecvzICgBZPp9fhc=;
 b=Od2DdEuRn0+PdizluC0jog53OjiPzjwHjrsPtMb5dTtN8MG7umWOPbusV0pL4TidgYKGWa
 kw6Uu0MLT5qHJtudKMCbfc3cRYS87XngY609BGs8YHgCi9D++Cm0NDgUeWQlqkoObvte5L
 swvj9+Xsw5pSwouN3RdB4/71TYAoX4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-D2p4E8vEOIqs98gYuGpTGQ-1; Thu, 20 Aug 2020 09:30:29 -0400
X-MC-Unique: D2p4E8vEOIqs98gYuGpTGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3DE8800467;
 Thu, 20 Aug 2020 13:30:28 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-185.ams2.redhat.com [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B71E416E30;
 Thu, 20 Aug 2020 13:30:24 +0000 (UTC)
Date: Thu, 20 Aug 2020 15:30:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200820133023.GD99531@linux.fritz.box>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <alpine.BSF.2.22.395.2003212338020.36211@zero.eik.bme.hu>
 <20200323133244.GK261260@stefanha-x1.localdomain>
 <CAFEAcA9VPgQ1MPYhcda4tdxMuhMC5R9fd6D=OVOZKRLMO8n_xw@mail.gmail.com>
 <20200820105401.GA99531@linux.fritz.box>
 <9bdbb3b9-01df-2a6b-0c82-b58ef6e0edf9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9bdbb3b9-01df-2a6b-0c82-b58ef6e0edf9@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:28:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.08.2020 um 13:56 hat Paolo Bonzini geschrieben:
> On 20/08/20 12:54, Kevin Wolf wrote:
> >> Paolo's conversion-to-Meson patchseries is about to land, so now
> >> is the time for people who would like this "automatically create
> >> a build directory and use it" behaviour to write the necessary
> >> patches. Any volunteers ?
> >>
> >> My current plan is to land the Meson series first, because it is
> >> really painful for Paolo to try to keep rebasing it as other
> >> changes to the old build system occur. This would break
> >> in-tree builds temporarily until the "automatic creation and
> >> use of a builddir" patches go in on top of it.
> >
> > Usually, our requirement is that patch series don't break anything. And
> > if something slips through, whoever broke it is supposed to fix it, not
> > whoever is affected.
> 
> The Meson conversion was announced in October 2019 as breaking in-tree
> builds, and the deprecation request is from March 2020.  So I don't
> think this is a breakage but rather a widely-announced change.

Wasn't the decision after that discussion that we do _not_ want to
deprecate './configure; make' from the source directory?

I seem to remember that we wanted to merge a message to make a
recommendation for out-of-tree builds, but looking at configure, I can't
find even that.

So without that, and also without a mention in deprecated.rst, I don't
think having mentioned a wish to break things a while ago means that we
should just follow through with that despite the objections.

At least this isn't how it has worked for other patch series. If it is
the new standard, I can remove -drive tomorrow. I've been mentioning for
years that I don't like it and want to remove it, so people can just
deal with it.

Kevin


