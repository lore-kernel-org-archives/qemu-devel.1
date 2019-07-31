Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF737C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 21:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F1120679
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 21:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F1120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsw4K-000878-Ud
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 17:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46425)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hsw3q-0007iP-I7
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 17:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hsw3p-0000lF-Gk
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 17:23:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5451)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hsw3p-0000kX-Ah
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 17:23:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 47662308FB93;
 Wed, 31 Jul 2019 21:22:59 +0000 (UTC)
Received: from localhost (ovpn-116-22.gru2.redhat.com [10.97.116.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A34C19C5B;
 Wed, 31 Jul 2019 21:22:54 +0000 (UTC)
Date: Wed, 31 Jul 2019 18:22:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190731212252.GW4313@habkost.net>
References: <20190729125755.45008-1-slp@redhat.com>
 <20190730042004-mutt-send-email-mst@kernel.org>
 <87ftmmwg0e.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftmmwg0e.fsf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 31 Jul 2019 21:22:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 31, 2019 at 02:22:09PM +0200, Sergio Lopez wrote:
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Mon, Jul 29, 2019 at 02:57:55PM +0200, Sergio Lopez wrote:
> >> Implement the modern (v2) personality, according to the VirtIO 1.0
> >> specification.
> >> 
> >> Support for v2 among guests is not as widespread as it'd be
> >> desirable. While the Linux driver has had it for a while, support is
> >> missing, at least, from Tianocore EDK II, NetBSD and FreeBSD.
> >
> > The fact that there was no open source hypervisor implementation has
> > probably contributed to this :)
> >
> >> For this reason, the v2 personality is disabled, keeping the legacy
> >> behavior as default.
> >
> > I agree it's a good default for existing machine types.
> >
> >> Machine types willing to use v2, can enable it
> >> using MachineClass's compat_props.
> >
> > Hmm. Are compat_props really the recommended mechanism to
> > tweak defaults? I was under the impression it's
> > only for compatibility with old machine types.
> > Eduardo, any opinion on this?
> 
> Stefan suggested using something like "-global virtio-mmio.modern=true"
> which does the trick for the command line, but I'd also like a way to
> set it to true by default on microvm. We can discuss the best way to
> achieve that (if using compat_props isn't acceptable) on the next
> microvm patch series.

Compatibility is the most common use case, but IMO compat_props
can be used for other kinds of machine-specific defaults.  It's
better than burying defaults inside non-introspectable machine
initialization functions.

-- 
Eduardo

