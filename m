Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7B7C10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 08:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D832073F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 08:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D832073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48923 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGfx6-0006vI-Pn
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 04:29:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGfwM-0006c1-T6
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGfwK-0001ck-UV
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:29:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hGfwK-0001Xn-FH
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:29:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B49F30832C6
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 08:29:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com
	[10.36.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3E0735D71B;
	Wed, 17 Apr 2019 08:29:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 7332A1747B; Wed, 17 Apr 2019 10:29:04 +0200 (CEST)
Date: Wed, 17 Apr 2019 10:29:04 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Bandan Das <bsd@redhat.com>
Message-ID: <20190417082904.jzqjzgznfreuz3pb@sirius.home.kraxel.org>
References: <jpgwojv9pwv.fsf@linux.bootlegged.copy>
	<jpg8swbi55o.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <jpg8swbi55o.fsf@linux.bootlegged.copy>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 17 Apr 2019 08:29:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: change default to success for
 usb_mtp_update_object
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417082904.pCkrOrCGHp4YWpew1JNmpn4heU-7vtzFO5isHgeBhyg@z>

On Mon, Apr 15, 2019 at 12:50:43PM -0400, Bandan Das wrote:
> Forgot to cc people ...
> 
> Bandan Das <bsd@redhat.com> writes:
> 
> > Commit c5ead51f90cf (usb-mtp: return incomplete transfer on a lstat
> > failure) checks if lstat succeeded when updating attributes of a
> > file. However, it also changed behavior to return an error by
> > default. This is incorrect because for smaller file sizes, Qemu
> > will attempt to write the file in one go and there won't be
> > an object for it.

Patch added to usb queue.

Current queue is https://git.kraxel.org/cgit/qemu/log/?h=queue/usb

If anything is missing there please resend.

thanks,
  Gerd


