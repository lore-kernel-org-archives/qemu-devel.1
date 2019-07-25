Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF52C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED0F3229F9
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0F3229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqiY4-0007No-5a
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 14:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40386)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hqiXt-0006zV-PO
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hqiXm-0006q5-0s
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:32:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55706)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hqiXg-0006lS-RW; Thu, 25 Jul 2019 14:32:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24D0B859FF;
 Thu, 25 Jul 2019 18:32:39 +0000 (UTC)
Received: from work-vm (ovpn-117-187.ams2.redhat.com [10.36.117.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4AEF1018A31;
 Thu, 25 Jul 2019 18:32:37 +0000 (UTC)
Date: Thu, 25 Jul 2019 19:32:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190725183235.GO2656@work-vm>
References: <20190725163710.11703-1-peter.maydell@linaro.org>
 <20190725163710.11703-2-peter.maydell@linaro.org>
 <20190725170228.GL2656@work-vm>
 <CAFEAcA9RQBz=t8F_nOTH9FZu_jKD0XVMJtPwmdnJBfnFR4G9oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9RQBz=t8F_nOTH9FZu_jKD0XVMJtPwmdnJBfnFR4G9oA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 25 Jul 2019 18:32:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1? 1/2] stellaris_input: Fix vmstate
 description of buttons field
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Thu, 25 Jul 2019 at 18:02, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Peter Maydell (peter.maydell@linaro.org) wrote:
> > > gamepad_state::buttons is a pointer to an array of structs,
> > > not an array of structs, so should be declared in the vmstate
> > > with VMSTATE_STRUCT_VARRAY_POINTER_INT32; otherwise we
> > > corrupt memory on incoming migration.
> > >
> > > We bump the vmstate version field as the easiest way to
> > > deal with the migration break, since migration wouldn't have
> > > worked reliably before anyway.
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > OK, it would be great to change num_buttons to uint32_t and make that a
> > UINT32 at some point;  it's hard to press negative buttons.
> 
> Is there much benefit though?

Not much and it's not urgent

> As an aside, I'm surprised also the macro doesn't complain
> that we said the num_buttons field is int32 but it's really "int"...
> arguably a different kind of missing type check.

I was just concerned what would happen if your migration stream
had a negative value in.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

