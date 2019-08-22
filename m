Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AE4C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3447D2339F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3447D2339F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0lPI-0004W2-NP
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0lNy-0003ai-5e
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0lNw-00070y-Sn
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:36:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i0lNt-0006yk-Ma; Thu, 22 Aug 2019 07:36:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 52B9F2BE94;
 Thu, 22 Aug 2019 11:36:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BD37600CD;
 Thu, 22 Aug 2019 11:35:58 +0000 (UTC)
Date: Thu, 22 Aug 2019 12:35:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190822113556.GR3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814202219.1870-1-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 22 Aug 2019 11:36:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/13] RFC: luks/encrypted qcow2 key
 management
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 14, 2019 at 11:22:06PM +0300, Maxim Levitsky wrote:
> Hi!
> 
> This patch series implements key management for luks based encryption
> It supports both raw luks images and qcow2 encrypted images.
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1731898
> 
> There are still several issues that need to be figured out,
> on which the feedback is very welcome, but other than that the code mostly works.
> 
> The main issues are:
> 
> 1. Instead of the proposed blockdev-update-encryption/blockdev-erase-encryption
> interface, it is probably better to implement 'blockdev-amend-options' in qmp,
> and use this both for offline and online key update (with some translation
> layer to convert the qemu-img 'options' to qmp structures)
> 
> This interface already exists for offline qcow2 format options update/
> 
> This is an issue that was raised today on IRC with Kevin Wolf. Really thanks
> for the idea!
> 
> We agreed that this new qmp interface should take the same options as
> blockdev-create does, however since we want to be able to edit the encryption
> slots separately, this implies that we sort of need to allow this on creation
> time as well.
> 
> Also the BlockdevCreateOptions is a union, which is specialized by the driver name
> which is great for creation, but for update, the driver name is already known,
> and thus the user should not be forced to pass it again.
> However qmp doesn't seem to support union type guessing based on actual fields
> given (this might not be desired either), which complicates this somewhat.

Given this design question around the integration into blockdev, I'd
suggest splitting the series into two parts.

One series should do all the work in crypto/ code to support adding
and erasing key slots.

One series should focus on block/ layer QMP/qemu-img integration.

The block layer QAPI stuff shouldn't leak into the crypto/ code.

So this will let us get on with reviewing & unit testing the
crypto code, while we discuss block layer design options in more
detail.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

