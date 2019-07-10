Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2653C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 21:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCECD2084B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 21:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCECD2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJqj-0004C7-3z
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 17:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44382)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hlJqG-0003iD-1T
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 17:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hlJqE-0000px-Tm
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 17:09:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hlJqB-0000ik-H4; Wed, 10 Jul 2019 17:09:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A4C895D672;
 Wed, 10 Jul 2019 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-179.ams2.redhat.com
 [10.36.117.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56C3160BFC;
 Wed, 10 Jul 2019 21:09:16 +0000 (UTC)
Date: Wed, 10 Jul 2019 23:09:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190710210914.GC6501@localhost.localdomain>
References: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
 <f790cb77-fa6a-c304-bc7f-62bbede78751@redhat.com>
 <20190710110241.GB6501@localhost.localdomain>
 <eea2bb4e-813e-456b-8aa9-514f63c5057e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eea2bb4e-813e-456b-8aa9-514f63c5057e@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 10 Jul 2019 21:09:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/4] virtio: handle zoned backing devices
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
Cc: fam@euphon.net, qemu-block@nongnu.org, mst@redhat.com,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.07.2019 um 13:33 hat Paolo Bonzini geschrieben:
> On 10/07/19 13:02, Kevin Wolf wrote:
> > Hm... Actually, file-posix implements .bdrv_check_perm and could just
> > refuse attaching a parent there if it doesn't request a specific
> > permission like BLK_PERM_SUPPORT_ZONED. That should give us the
> > whitelist semantics through existing infrastructure.
> 
> I'd like Dmitry to have something more precise to base his work on.  The
> permissions system is really complicated and I never really wrapped my
> head around it, so I need your help.
> 
> IIUC, blkconf_apply_backend_options would grow a new argument (like
> "resizable") and that argument would add BLK_PERM_SUPPORT_ZONED to the
> perm that blkconf_apply_backend_options passes to blk_set_perm.  On the
> other side raw_check_perm would say something like
> 
>     if (is_zoned(s) && !(perm & BLK_PERM_SUPPORT_ZONED)) {
>         error_setg(....);
>         return -ENOTSUP;
>     }
> 
> Is this correct?

Yes, I think this is how you'd best implement it.

> In addition, BLK_PERM_SUPPORT_ZONED would have to be a shared
> permission, since it's possible to assign the same block device to
> multiple scsi-block devices.  So BLK_PERM_SUPPORT_ZONED would be added
> unconditionally to shared_perm.

Right, this part shows that we're kind of abusing the permission system
here. I think unconditionally adding BLK_PERM_SUPPORT_ZONED to the set
of shared permissions could probably happen centrally in
bdrv_child_perm().

> ps: I have always thought that shared_perm is expressed the wrong way
> and should have been "denied_perm".  How hard would it be to change that
> now?

I'm not sure it would be better. It is shared_perm because that means
that the default is restrictive (error mode: operation refused, clearly
reported, easy to fix) rather than permissive (error mode: image
corruption, hard to figure out where we were too permissive). Basically,
whitelist instead of blacklist, once again.

But if we did indeed decide to change it, the only way to find out how
hard it is would be doing it. I suspect not too hard in principle, but
making sure that we converted all callers and don't introduce wrong
callers later through (silent) merge conflicts is the more concerning
part.

Kevin

