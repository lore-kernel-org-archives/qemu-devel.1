Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E774AC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 16:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0A020815
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 16:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0A020815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEyNT-0006Vc-P0
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 12:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jdenemar@redhat.com>) id 1iEyLX-0005ZI-IQ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdenemar@redhat.com>) id 1iEyLU-0002jz-KP
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:16:21 -0400
Received: from smtp.vivo.cz ([185.219.166.8]:35104)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1iEyLS-0002i8-Kd
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:16:19 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.vivo.cz (Postfix) with ESMTP id 9D20F151303A;
 Mon, 30 Sep 2019 18:16:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vivo.cz
Received: from smtp.vivo.cz ([127.0.0.1])
 by localhost (smtp.vivo.cz [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 3Qv8z-1C5Mdo; Mon, 30 Sep 2019 18:16:11 +0200 (CEST)
Received: from orkuz.int.mamuti.net (185-219-164-37-static.vivo.cz
 [185.219.164.37])
 by smtp.vivo.cz (Postfix) with ESMTPS id C6E72151301D;
 Mon, 30 Sep 2019 18:16:11 +0200 (CEST)
Received: by orkuz.int.mamuti.net (Postfix, from userid 500)
 id 5C1032A61A4; Mon, 30 Sep 2019 18:16:11 +0200 (CEST)
Date: Mon, 30 Sep 2019 18:16:11 +0200
From: Jiri Denemark <jdenemar@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] cpu_map: Remove pconfig from Icelake-Server CPU model
Message-ID: <20190930161611.GP4884@orkuz.int.mamuti.net>
References: <20190926214305.17690-1-ehabkost@redhat.com>
 <20190930102453.GO4884@orkuz.int.mamuti.net>
 <20190930141104.GA4084@habkost.net>
 <9E79D1C9A97CFD4097BCE431828FDD31173BCF76@SHSMSX104.ccr.corp.intel.com>
 <b9fbca16-9877-04b9-78fa-bf711c8f3053@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9fbca16-9877-04b9-78fa-bf711c8f3053@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.219.166.8
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
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Kang,
 Luwei" <luwei.kang@intel.com>, Robert Hoo <robert.hu@linux.intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Hu, Robert" <robert.hu@intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 30, 2019 at 17:16:27 +0200, Paolo Bonzini wrote:
> On 30/09/19 16:31, Hu, Robert wrote:
> >> This might be a problem if there are plans to eventually make KVM support
> >> pconfig, though.  Paolo, Robert, are there plans to support pconfig in KVM in the
> >> future?
> > [Robert Hoo] 
> > Thanks Eduardo for efforts in resolving this issue, introduced from my Icelake CPU
> > model patch.
> > I've no idea about PCONFIG's detail and plan. Let me sync with Huang, Kai and answer
> > you soon.
> 
> It's really, really unlikely.  It's possible that some future processor
> overloads PCONFIG in such a way that it will become virtualizable, but
> not IceLake.

I guess, the likelihood of this happening would be similar to
reintroducing other features, such as osxsave or ospke, right?

> Would it make sense for libvirt to treat absent CPU flags as "default
> off" during migration, so that it can leave out the flag in the command
> line if it's off?  If it's on, libvirt would pass pconfig=on as usual.
> This is a variant of [2], but more generally applicable:
> 
> > [2] However starting a domain with Icelake-Server so that it can be
> > migrated or saved/restored on QEMU in 3.1.1 and 4.0.0 would be
> > impossible. This can be solved by a different hack, which would drop
> > pconfig=off from QEMU command line.

The domain XML does not contain a complete list of all CPU features.
Features which are implicitly included in a CPU model are not listed in
the XML. Count in the differences in libvirt's vs QEMU's definitions of
a particular CPU model and you can see feat=off cannot be mechanically
dropped from the command line as the CPU model itself could turn it on
by default and thus feat=off is not redundant.

Jirka

