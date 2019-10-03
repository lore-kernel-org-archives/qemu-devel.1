Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1F3C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99507218DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99507218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFyzJ-0007yT-Lp
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 07:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iFyyf-0007T9-UW
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iFyyd-0002Fq-Ve
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:08:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iFyyd-0002FJ-Pd
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:08:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A44A28A1C98;
 Thu,  3 Oct 2019 11:08:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C25B5C21A;
 Thu,  3 Oct 2019 11:08:44 +0000 (UTC)
Date: Thu, 3 Oct 2019 12:08:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Qemu/KVM fuzzing - next steps
Message-ID: <20191003110842.GC7279@redhat.com>
References: <20191003104928.crwjanhymtmwdboc@starbug-mbp>
 <CAFEAcA9df8Jr2LBsWXY=9AsZcRvatd9RW10oNqLxzJ09Lbcjhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9df8Jr2LBsWXY=9AsZcRvatd9RW10oNqLxzJ09Lbcjhg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 03 Oct 2019 11:08:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: alxndr@bu.edu, QEMU Developers <qemu-devel@nongnu.org>,
 Darren Kenny <darren.kenny@oracle.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 03, 2019 at 11:58:23AM +0100, Peter Maydell wrote:
> On Thu, 3 Oct 2019 at 11:50, Darren Kenny <darren.kenny@oracle.com> wrote:
> > How would you like to move forward? Is there an ordered list of
> > device or machines that we'd like to focus on anywhere? If not,
> > could we create one?
> 
> Roughly, "anything that can be used with KVM" is our
> security boundary, so we should start with fuzzing the
> devices and machines that can be used with it.
> QEMU has a ton of implementations of device and machine
> models that can only be used with TCG emulation, but we
> don't make any promises about guest code not being able
> to escape from a TCG-based machine, so we can leave those
> until later (if at all).

Figuring out what can be used with KVM and what is only TCG is itself
not entirely easy.

One way to identify high priority devices would be to use 'virt-install'
to create some KVM guests and look at what devices it turns on for each
host architecture that is important. I'd probably prioritize x86_64
first, then any of ppc64/aarch64/s390x after, as that reflects where
much of the KVM userbase is likely spread.

Certainly anything virtio based is going to be top, but we do also use
some non-virtio stuff fairly often. eg various graphics cards in
particular, since virtio is quite new there &:

  https://www.kraxel.org/blog/2019/09/display-devices-in-qemu/

vfio PCI passthrough is another common non-virtio device.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

