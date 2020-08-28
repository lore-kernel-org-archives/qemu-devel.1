Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF77C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E54207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1opDbLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E54207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBeSa-0007kq-7Z
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBeQW-0005cH-U2
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:28:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25939
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBeQU-0005sh-W1
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598621298;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oh3aIhzQXp6YWCdF9XUNLXWNjMOXhcoZLcRbYCwENnE=;
 b=N1opDbLJxi4ERL/yag43MclEFQmUTDkNuCZMzEi8NCENNTXja1wwuEet0sWXU4zdiqAz0v
 +jt48vEoR4KXiEVh5cDVKF2L1K7h3EuZm2tMDZYNG5xiTcpu6wf/A3Zf2ryjX1ovSYTZ4n
 2R5FV5zO+s1r0MRzAFWDGAXYfvlqA9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-L8l54P5hMdOhcJiMrwM1AQ-1; Fri, 28 Aug 2020 09:28:10 -0400
X-MC-Unique: L8l54P5hMdOhcJiMrwM1AQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B6506408E;
 Fri, 28 Aug 2020 13:28:09 +0000 (UTC)
Received: from redhat.com (ovpn-113-167.ams2.redhat.com [10.36.113.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2DA95C1C2;
 Fri, 28 Aug 2020 13:28:08 +0000 (UTC)
Date: Fri, 28 Aug 2020 14:28:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 01/17] crypto: Move QCryptoCipher typedef to
 qemu/typedefs.h
Message-ID: <20200828132805.GH224144@redhat.com>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
 <20200813032537.2888593-2-richard.henderson@linaro.org>
 <20200817164801.GK4775@redhat.com>
 <01f1a99c-9983-9b92-b91d-bd117055cf21@linaro.org>
 <03d945f7-bd4a-8f55-433c-b5c9ab7080c4@linaro.org>
 <9b3a8dd6-067f-4813-1415-1b74ce1c8754@linaro.org>
MIME-Version: 1.0
In-Reply-To: <9b3a8dd6-067f-4813-1415-1b74ce1c8754@linaro.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 01:02:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 01:50:21PM -0700, Richard Henderson wrote:
> On 8/17/20 1:42 PM, Richard Henderson wrote:
> > On 8/17/20 1:38 PM, Richard Henderson wrote:
> >> On 8/17/20 9:48 AM, Daniel P. Berrangé wrote:
> >>> On Wed, Aug 12, 2020 at 08:25:21PM -0700, Richard Henderson wrote:
> >>>> This allows header files to declare pointers without pulling
> >>>> in the entire crypto subsystem.
> >>>>
> >>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >>>> ---
> >>>>  include/crypto/cipher.h | 2 --
> >>>>  include/qemu/typedefs.h | 1 +
> >>>>  2 files changed, 1 insertion(+), 2 deletions(-)
> >>>
> >>> I'm not in favour of this change or the next. Using #include "cipher.h"
> >>> is not a burden on the users of the crypto code. Moving typedefs away
> >>> from the associated struct is a step backwards IMHO.
> >>
> >> Consider if you put a pointer to QCryptoCipher in a relatively generic header
> >> file (e.g. "target/foo/cpu.h"), restricting "cipher.h" to a portion of the
> >> implementation (e.g. target/foo/helper_crypto.c).
> >>
> >> This sort of thing is exactly why "qemu/typedefs.h" exists.
> > 
> > As for the next patch for QCryptoCipherDriver, I could easily see not moving
> > the typedef to typedefs.h, but instaed to "crypto.h", where we do in fact want
> > to declare an incomplete structure.  I think it's a real mistake to be using
> > void* there at present.
> 
> That said, I can drop this first patch because, in the end, I'm *not* going to
> put QCryptoCipher in target/arm/cpu.h.

Thanks, I'd appreciate that. We can re-visit the discussion if needs
change again in future.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


