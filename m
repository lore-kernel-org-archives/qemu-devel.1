Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3603C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487F5221E3
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oie9pX1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487F5221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGeWQ-0002jh-3w
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGeVk-00023W-Jn
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGeVi-0001SE-L7
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599813261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I4H9O8FeQ22hLqTb6o6t6FP/Z++k4JXXfQAP73NJZoI=;
 b=Oie9pX1kziPSKHINq5ap0nsVYkzk5CmSqfrO7H1/gcnN3Q19IuVz8BjGf9yIYSLZp7bBjn
 znxFysuL+XeNnRHbOejp5QMehIAcCInlN/hTriBjDIMg9CjCo0EQV4/m4ixaMDUxEQv1AR
 SYd/O2mPMKvTy+hdcn3579Hc5vfrqTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-lYwBtNtzOyKaz28imnsAWQ-1; Fri, 11 Sep 2020 04:34:18 -0400
X-MC-Unique: lYwBtNtzOyKaz28imnsAWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C586C1005E60;
 Fri, 11 Sep 2020 08:34:16 +0000 (UTC)
Received: from work-vm (ovpn-113-52.ams2.redhat.com [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 562F27E8F4;
 Fri, 11 Sep 2020 08:34:11 +0000 (UTC)
Date: Fri, 11 Sep 2020 09:34:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: PATCH: Increase System Firmware Max Size
Message-ID: <20200911083408.GA3310@work-vm>
References: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <20c5210f-8199-a9e7-9297-0bea06c4d9ae@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20c5210f-8199-a9e7-9297-0bea06c4d9ae@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 23:26:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "McMillan,
 Erich" <erich.mcmillan@hp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Laszlo Ersek (lersek@redhat.com) wrote:
> +Markus, Dave, Phil
> 
> On 09/11/20 03:45, McMillan, Erich wrote:
> > Hi all,
> > 
> > (this is my first Qemu patch submission, please let me know if my formatting/content needs to be fixed).
> > We have a need for increased firmware size, currently we are building Qemu with the following change to test our Uefi Firmware and it works well for us. Hope that this change can be made to open source. Thank you.
> > -------
> > Increase allowed system firmware size to 16M per comment suggesting up to 18M is permissible.
> > 
> >  Signed-off-by: Erich McMillan <erich.mcmillan@hp.com>
> > 
> > diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> > index b8d8ef59eb17c6ace8194fc69c3d27809becfbc0..f6f7cd744d0690cee0355fbd19ffdcdb71ea75ca 100644
> > --- a/hw/i386/pc_sysfw.c
> > +++ b/hw/i386/pc_sysfw.c
> > @@ -46,7 +46,7 @@
> >   * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB in
> >   * size.
> >   */
> > -#define FLASH_SIZE_LIMIT (8 * MiB)
> > +#define FLASH_SIZE_LIMIT (16 * MiB)
> > 
> >  #define FLASH_SECTOR_SIZE 4096
> > -------
> > 
> > 
> 
> (1) This is not a trivial change, so qemu-trivial: please ignore.
> 
> (2) The comment has not been updated.
> 
> (3) I'm almost certain that *if* we want to change this, it needs to be
> turned into a machine type (or some device model) property, for
> migration compatibility.

I'm missing what this constant exists for - why is the
check there at all  Is there something else that lives below this
address that we have to protect?
My reading of the code is that increasing that constant doesn't change
the guests view at all, as long as the guest was given the same flash
files - so if the guests view doesn't change, then why would we tie
it to the machine type?

> (4) I feel we need much more justification for this change than just
> "our firmware is larger than upstream OVMF".
> 
> In the upstream 4MB unified OVMF build, there's *plenty* of free room.
> Of course that's not to say that we're willing to *squander* that space
> -- whenever we include anything new in the upstream OVMF platform(s),
> there must be a very good reason for it --, just that, given the
> upstream OVMF status, the proposed pflash increase in QEMU is staggering.
> 
> Considering upstream OVMF and QEMU, it should take *years* to even get
> close to filling the 4MB unified flash image of OVMF (hint: link-time
> optimization, LZMA compression), let alone to exhaust the twice as large
> (8MB) QEMU allowance.
> 
> Unless you are committed to open source your guest firmware too (maybe
> as part of upstream edk2, maybe elsewhere), I seriously doubt we should
> accommodate this use case in *upstream* QEMU. It complicates things
> (minimally with regard to migration), and currently I don't see the
> benefit to the upstream community.
> 
> Clearly, for building your firmware image, you must have minimally
> modified the DSC and FDF files in OVMF too, or created an entirely
> separate firmware platform -- DSC and FDF both.
> 
> If you are using your downstream OVMF build as a testbed for your
> proprietary physical platform firmware, that's generally a use case that
> we're mildly interested in not breaking in upstream OvmfPkg. But in
> order to make me care for real (as an OvmfPkg co-maintainer), you'd need
> to upstream your OVMF platform to edk2 (we already have Xen and --
> recently added -- bhyve firmware platforms under OvmfPkg, not just
> QEMU). You'd also have to offer long-term reviewership and testing for
> that platform in edk2 (like the Xen and bhyve stake-holders do). Then we
> could consider additional complexity in QEMU for booting that firmware
> platform.

Our UEFI firmware is pretty sparse; it doesn't have any pretty graphics
or snazzy stuff, or have to survive configuring lots of hardware; also
I'm aware of other companies who are looking at putting big blobs
of stuff in firmware for open uses;  so I don't see a problem with
changing this limit from the QEMU side of things.

Dave

> 
> Thanks,
> Laszlo
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


