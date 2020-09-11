Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3B4C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4630020770
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAtcz74o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4630020770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkvs-00032f-Dq
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGkuQ-0001xa-FE
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:24:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35167
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGkuN-0006Oc-Pa
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599837855;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xdg6kiQbx4t6mfdB8vw8E9TPvsPyMjvWzwqpQumToK4=;
 b=UAtcz74oR53EKrhX7RsdkcGxEQ/PyL+GakKNndkfZQdmnI2lcL+rkV0hbhxSr0cGEk44ur
 O5qj1jhDXXk+let3zo5uNgm/uDCcJtkZ8YxdzT8H2374Vt2ki6zX8K08TPQAtx7/Pn34VS
 Ue2h/CujI7v51h3ucUp7vBNCMIrw4XU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-NAuC4LlXM2ehMAuaiXkDdQ-1; Fri, 11 Sep 2020 11:24:03 -0400
X-MC-Unique: NAuC4LlXM2ehMAuaiXkDdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC2D4107B273;
 Fri, 11 Sep 2020 15:24:01 +0000 (UTC)
Received: from redhat.com (ovpn-113-229.ams2.redhat.com [10.36.113.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D67E60C04;
 Fri, 11 Sep 2020 15:23:56 +0000 (UTC)
Date: Fri, 11 Sep 2020 16:23:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: PATCH: Increase System Firmware Max Size
Message-ID: <20200911152353.GI1203593@redhat.com>
References: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <20c5210f-8199-a9e7-9297-0bea06c4d9ae@redhat.com>
 <20200911083408.GA3310@work-vm>
 <ae2d820e-78c6-da92-2fa6-73c1a7d10333@redhat.com>
 <20200911150602.GH3310@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200911150602.GH3310@work-vm>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 09:43:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "McMillan,
 Erich" <erich.mcmillan@hp.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 04:06:02PM +0100, Dr. David Alan Gilbert wrote:
> * Laszlo Ersek (lersek@redhat.com) wrote:
> > On 09/11/20 10:34, Dr. David Alan Gilbert wrote:

> > > it doesn't have any pretty graphics
> > > or snazzy stuff,
> > 
> > Which is arguably completely superfluous on every possible platform one
> > can imagine. On the other hand, if you want a real serial port on
> > workstation class hardware, you may have to order a separate part (if
> > you are lucky and you *can* order one). Serial-over-LAN is a complete
> > non-replacement.
> > 
> > The reason (should I say: excuse) for the firmware to exist is to (a)
> > boot operating systems, (b) abstract away some ugly platform-specific
> > hardware for OS runtime (by providing ACPI and SMBIOS descriptions, and
> > a *small* set of runtime services). We can maybe add (c) "root of trust".
> > 
> > In practice, physical firmware is becoming the hw vendor's OS before
> > (and under) your OS, one you cannot replace, and one whose updates can
> > brick your hardware. Permitting the same feature creep on virtual
> > platforms is wrong.
> 
> On the firmware you develop that choice is fine; but there's no reason
> to force that restriction onto others.
> 
> > > or have to survive configuring lots of hardware; also
> > > I'm aware of other companies who are looking at putting big blobs
> > > of stuff in firmware for open uses;
> > 
> > Key term being "open uses". Let us see them.
> 
> Well yes, I think we know who we're speaking about here and we're
> working on it.

I don't think we need to dictate that firmware used with QEMU has to be
open source.

If someone wants to use a closed source firmware that is fine. They simply
can't expect us to help debug problems in QEMU when using the closed source
firmware, without first demonstrating it with an open source firmware we can
see.

> > > so I don't see a problem with
> > > changing this limit from the QEMU side of things.
> > 
> > I do. Software and data always expand to consume all available space,
> > and it's going to cause a conflict between UEFI features and platform
> > MMIO sooner or later. Then I'll get the privilege of shuffling around
> > the crap in OVMF (all of which is "indispensable" or course).
> > 
> > If we ever go down this route, it needs to benefit open source directly
> > and significantly.
> 
> Being able to use QEMU to let vendors debug their platform firmware is a
> perfectly reasonable use of QEMU; maybe not of your OVMF build - we
> need to keep the restrictions on the two separate.

Agreed, I can understand the motivation to not want to change the QEMU
defaults, but I don't see why we should have this as a hard coded
limit that is not runtime configurable.

IOW, why can't we keep our current default and provide a machine type
property "firmware_max_size" which users can opt-in to setting if
their particular firmware exceeds normal defaults. That won't impact
us for migration compat in any way, and lets users have flexibility t
do what they want.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


