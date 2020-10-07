Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E590DC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 09:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060AA204EC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 09:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+irh71C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060AA204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ5UF-0001b2-O1
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 05:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQ5TR-0001Ah-Uc
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 05:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQ5TP-0005yz-B7
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 05:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602061857;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=lKfT6eyKd0MZzJAXQDDkfc2uapyLL4oDLgqOIcFbEOQ=;
 b=d+irh71C/ZxmAQh2BOfkxuowy8DeYQXGDY/OzLqOTRbi/mImuFA60magjj8vl6Y7vo2lcH
 pyqo09h991O2HQ6bqg33rjjzlZgMNlCEIcWSw2LoN4BSbj04MXm5OdnpR0ayd7wjJ1B/0y
 ZrMJclZjOInnPBVyzFAgu0EDESynv9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-6H85FpLePYmSwkFVGblsUQ-1; Wed, 07 Oct 2020 05:10:53 -0400
X-MC-Unique: 6H85FpLePYmSwkFVGblsUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99E8A802B6C;
 Wed,  7 Oct 2020 09:10:52 +0000 (UTC)
Received: from redhat.com (ovpn-114-68.ams2.redhat.com [10.36.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 387001002C34;
 Wed,  7 Oct 2020 09:10:49 +0000 (UTC)
Date: Wed, 7 Oct 2020 10:10:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 00/21] machine + QOM queue, 2020-10-05
Message-ID: <20201007091046.GH2505881@redhat.com>
References: <20201005211000.710404-1-ehabkost@redhat.com>
 <CAFEAcA_+4b4HHP_8BBqqy+QmoyF6Lx1jmuFvcsbW5THZQDrXww@mail.gmail.com>
 <20201006143637.GP7303@habkost.net>
 <CAFEAcA97upqUtasSsg+wxLFvak5rz+t3DBD7zMu4dnwvpw73AQ@mail.gmail.com>
 <20201006144215.GK2482221@redhat.com>
 <deb55fbb-637b-0b94-6efb-c508c5dc691a@redhat.com>
 <CABgObfbMLLGaw7XcjxtjyXrXSWNcUo_S6HnTsmVgC=7LHiV1kg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABgObfbMLLGaw7XcjxtjyXrXSWNcUo_S6HnTsmVgC=7LHiV1kg@mail.gmail.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 06, 2020 at 09:10:59PM +0200, Paolo Bonzini wrote:
> Il mar 6 ott 2020, 20:47 Thomas Huth <thuth@redhat.com> ha scritto:
> 
> > I think Cirrus-CI needs a github account? Is there a way to use Gitlab now
> > instead? (just like Travis recently added Gitlab support?)
> >
> 
> It does only support GitHub. In theory you can set up an automatic push
> from Gitlab to GitHub but it doesn't work well if you force push to the
> Gitlab repository.

I've configured my GitLab qemu repo to run a "Push" mirror to GitHub
and it propagates force pushes for branches too.

There is some rate limiting though. It won't mirror more frequently
than every 5 minutes, and so in worst case you could be waiting upto
just under 10 minutes for it to sync.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


