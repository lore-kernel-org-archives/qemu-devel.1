Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7879CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F4E20658
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrW0GqRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F4E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5SdC-00087t-B3
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 07:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k5ScA-0007Gz-5L
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:38:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55421
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k5Sc5-0007i8-EU
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597145918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+EcuOyXtByccegQh34RNY1frfHWqd1Ut9ToeCRgCGnk=;
 b=LrW0GqRiaaWkrYUPXA/O6za5C09alSNpubkyVLLLxOLwJz7xHiwSqHoLJUKizxlBEjxrew
 gBlwnt5Xwa4+ZNn6HlOCbyxdrPoSrTfFG2uTIsedsaAOthn5UhlhE+WjgdUT99xbXArlYl
 gpYcdMupLBMx/EBOkjaUmyr1TCk8tZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-tk_qx-kiNlOn_SWjeow68Q-1; Tue, 11 Aug 2020 07:38:33 -0400
X-MC-Unique: tk_qx-kiNlOn_SWjeow68Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CD00804449;
 Tue, 11 Aug 2020 11:38:27 +0000 (UTC)
Received: from gondolin (ovpn-113-33.ams2.redhat.com [10.36.113.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B68136F152;
 Tue, 11 Aug 2020 11:38:20 +0000 (UTC)
Date: Tue, 11 Aug 2020 13:38:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 000/147] Meson integration for 5.2
Message-ID: <20200811133818.385badaf.cohuck@redhat.com>
In-Reply-To: <20200811114139.336ac1f8.cohuck@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <20200811114139.336ac1f8.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 06:40:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, berrange@redhat.com,
 alex.bennee@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, alxndr@bu.edu, stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Aug 2020 11:41:39 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, 10 Aug 2020 19:06:38 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > This version is substantially less "draft-like", and the diffstat
> > is actually quite large with Thursday's draft.
> > 
> > The changes are as follows:
> > - updated oss-fuzz build script
> > - various cases fixed that broke depending on present/absent dependencies
> > - all build scripts handle --python correctly
> > - git submodules properly updated before running meson
> > - no warnings from Meson master (will be 0.56.0), one from upcoming 0.55.1
> > - installation matches current build system
> > - fixes for virtio-vga broken merge
> > - includes updated s390-ccw patch from Thomas
> > - less noisy "make check"
> > - tested with GitLab CI, BSD VM builds and various Docker builds
> > - input-keymap files properly regenerated
> > 
> > Of our supported build platforms, only Mac OS and non-x86 hosts are
> > still untested.  But I guess this might finally count as a v1.
> > 
> > This is available from https://gitlab.com/bonzini/qemu.git branch
                                   ^^^^^^^^^^

> > meson-poc-next.  
> 
> Trying this branch, configure is already unhappy on Fedora 31:

(...)

I pulled from *github*, not *gitlab*... using the proper branch,
everything seems to work fine (ran make check and did some light
testing.)


