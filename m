Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17804C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C051207C3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYRkE595"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C051207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkMe-0004yR-DO
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHkGY-0003YW-LA
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:55:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35462
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHkGW-0005xi-Kk
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600073711;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jRB1h5J2Cri9ZN+hGh81po34aJSpZ0Dk1pqJQnkFBOk=;
 b=aYRkE59517u6xrli5p0fT6+iyeSicyENHicC3S+AUAGva45IktfJH0eIDUBpDLdLqVE3Cm
 wkYvmgnGpbtbemXyWHHsu+YSjobKJ98yIr1/Ypj8+fU7FsgVJHR2vTTyOvhEeB+S8ofgIe
 +SXOid65EPxb+KydDWe9Xb6s3HzwpGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-1oY67yqBOk6Mo8s3qi3N_w-1; Mon, 14 Sep 2020 04:55:03 -0400
X-MC-Unique: 1oY67yqBOk6Mo8s3qi3N_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC29B800470;
 Mon, 14 Sep 2020 08:55:02 +0000 (UTC)
Received: from redhat.com (ovpn-114-99.ams2.redhat.com [10.36.114.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A35405DEC2;
 Mon, 14 Sep 2020 08:55:01 +0000 (UTC)
Date: Mon, 14 Sep 2020 09:54:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: About 'qemu-security' mailing list
Message-ID: <20200914085458.GA1252186@redhat.com>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 04:51:49PM +0100, Peter Maydell wrote:
> On Fri, 11 Sep 2020 at 15:22, P J P <ppandit@redhat.com> wrote:
> > Proposal: (to address above limitations)
> > =========
> >
> > * We set up a new 'qemu-security' mailing list.
> >
> > * QEMU security issues are reported to this new list only.
> >
> > * Representatives from various communities subscribe to this list. (List maybe
> >    moderated in the beginning.)
> >
> > * As QEMU issues come in, participants on the 'qemu-security' list shall
> >    discuss and decide about how to triage them further.
> 
> Way way back, the idea of a qemu-security list was proposed, and
> it was decided against because there wasn't a clear way that
> people could send encrypted mail to the security team if it
> was just a mailing list. So that's why we have the "handful
> of individual contacts" approach. Is that still something people
> care about ?
> 
> My question is, who decides who's on the qemu-security list?
> Is this just "it's the same handful of contacts, but they
> have a mailing list for convenience" ? It sounds like you
> want it to be a larger grouping than that and maybe also
> want to use it as a mechanism for informing downstream distros
> etc about QEMU security issues, which is to say you're
> proposing an overhaul and change to our security process,
> not merely "we'd like to create a mailing list" ?

Yes, that is a reasonable description. 

Do we think the current QEMU security process is working well for the
community as a whole in terms of our downstream consumers learning about
security flaws in an appropriate timeframe and manner ?  

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


