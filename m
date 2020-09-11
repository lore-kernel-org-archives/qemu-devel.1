Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C16BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C3D208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0v2youB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C3D208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlpy-0007KR-Jv
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGlpJ-0006C7-2s
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGlpG-0007wt-Tc
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599841381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ogCUpFA1nyPzdCXfnAqTQ3wyky+zL3F2m25FbzkpviQ=;
 b=I0v2youBeJLHsWZ0yJpTCZf4WVRQ5lc8DHfzSQxpcUStEf/SELCdafcmGuyUTRYYSLXN6C
 OzMad1hWVoj7gwkbT9ysSk9Nhi5557TWWLNVmW2PfFE5k35WYWBSUvfssLeo6ajQEsPJVN
 vU3bDsgZdPnZt3xwpuMyhYTElA7eIc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-QuSvtX_oM9Kn8JRmXHT8EQ-1; Fri, 11 Sep 2020 12:23:00 -0400
X-MC-Unique: QuSvtX_oM9Kn8JRmXHT8EQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09FCE18B9ECA;
 Fri, 11 Sep 2020 16:22:59 +0000 (UTC)
Received: from work-vm (ovpn-113-52.ams2.redhat.com [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DC5B60C15;
 Fri, 11 Sep 2020 16:22:54 +0000 (UTC)
Date: Fri, 11 Sep 2020 17:22:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: PATCH: Increase System Firmware Max Size
Message-ID: <20200911162251.GA3311@work-vm>
References: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <20c5210f-8199-a9e7-9297-0bea06c4d9ae@redhat.com>
 <20200911083408.GA3310@work-vm>
 <ae2d820e-78c6-da92-2fa6-73c1a7d10333@redhat.com>
 <20200911150602.GH3310@work-vm>
 <8e2d0bf7-a206-124c-15b0-0f0071ef5a11@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8e2d0bf7-a206-124c-15b0-0f0071ef5a11@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 08:18:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> On 09/11/20 17:06, Dr. David Alan Gilbert wrote:
> > * Laszlo Ersek (lersek@redhat.com) wrote:
> >> On 09/11/20 10:34, Dr. David Alan Gilbert wrote:
> 
> >>> I'm missing what this constant exists for - why is the
> >>> check there at all  Is there something else that lives below this
> >>> address that we have to protect?
> >>
> >> Yes, some MMIOs that I'm at least aware of are IO_APIC_DEFAULT_ADDRESS
> >> (0xfec00000), TPM_PPI_ADDR_BASE (0xFED45000), APIC_DEFAULT_ADDRESS
> >> (0xfee00000).
> >>
> >> They are not directly adjacent with pflash; nor should they be.
> > 
> > Hmm those need explicitly checks adding somewhere against
> > FLASH_SIZE_LIMIT!
> 
> Yes, that would be nice. I don't know how it works. Maybe when adding
> the next MemoryRegion there's an error or an assert(). No clue.
> 
> >> If you increase the size limit (without tieing it to a machine type),
> >> then, with an upgraded QEMU and the same (old) machine type, you can
> >> start a guest with a larger-than-earlier (cumulative) flash size. Then,
> >> when you try to migrate this to an old QEMU (but same machine type),
> >> it's a bad surprise. I understand that backwards migration is not
> >> universally supported (or expected), but I don't want this problem to
> >> land on my desk *ever*.
> > 
> > I support backwards migration; but that migration wouldn't work anyway -
> > wouldn't that fail nicely with a mismatched RAMBlock size?
> 
> My point wasn't that the guest would be lost or corrupted, only that it
> couldn't be migrated. We'd say "for this, you have to upgrade QEMU on
> the destination host as well, or use a smaller firmware", and they'd say
> "we don't want either of those things".

My point is that already breaks if you used a smaller firmware on the
source and the current size on the destination.

> >>> Our UEFI firmware is pretty sparse;
> >>
> >> Yes, in part because I strive to keep it that way.
> > 
> > But that's your choice, on our firmware implementation; that's not a
> > requirement of QEMU or q35.
> 
> Right; if we can keep regressions out (not just functional regressions,
> but workflow / use case regressions too), then it's OK to support more
> use cases.
> 
> By workflow / use case regressions I mean that it should not become more
> difficult to maintain OVMF as a result of the patch. (It should not
> imply that now people can stuff even more cruft into OVMF, because "hey
> there's more room now".)
> 
> >> The reason (should I say: excuse) for the firmware to exist is to (a)
> >> boot operating systems, (b) abstract away some ugly platform-specific
> >> hardware for OS runtime (by providing ACPI and SMBIOS descriptions, and
> >> a *small* set of runtime services). We can maybe add (c) "root of trust".
> >>
> >> In practice, physical firmware is becoming the hw vendor's OS before
> >> (and under) your OS, one you cannot replace, and one whose updates can
> >> brick your hardware. Permitting the same feature creep on virtual
> >> platforms is wrong.
> > 
> > On the firmware you develop that choice is fine; but there's no reason
> > to force that restriction onto others.
> 
> Technically, I agree. It's fine to run larger UEFI firmware as long as
> the default size restriction for the default (or traditional) UEFI
> firmware remains the same.
> 
> Turn the size limit into a property, keep the same default value,
> implement the migration aspects; specify *very clearly* in the commit
> message what particular firmware this knob is being introduced for.

I don't think there is a migration aspect here; and this knob is a
general knob - it's just Erich here is the poor unfortunate person
who wanted to tune that knob for the first time.

> ... And I'd still be grumpy, because it increases maintenance burden for
> QEMU (and possibly OVMF too -- "hey we got more room now!"; see above),
> without open source users benefiting from the change. It's not like
> we'll ever be able to run, or read the source code of, that 8MB+
> firmware image, is it?

Sorry, not QEMU's problem; we don't restrict RAM to 640k just because
it should be enough for anyone.

> >>> or have to survive configuring lots of hardware; also
> >>> I'm aware of other companies who are looking at putting big blobs
> >>> of stuff in firmware for open uses;
> >>
> >> Key term being "open uses". Let us see them.
> > 
> > Well yes, I think we know who we're speaking about here and we're
> > working on it.
> 
> Sorry, I wasn't clear enough.
> 
> I *know* we're going to see *those* "open uses" that you meant.
> 
> Precisely because they are "open uses", they have a chance at justifying
> the churn.
> 
> My intent was to apply your (valid) argument to *this* proposal -- let
> us see the "open uses" for *this* particular proposal.
> 
> Notice, in the thread starter:
> 
> "We have a need for increased firmware size", "our Uefi Firmware",
> "change can be made to open source" --> it's obviously for the sake of a
> proprietary platform firmware. Do you feel comfortable about taking on
> more risks, reviews and maintenance for that?

I'm not seeing any more risks, reviews or maintenance in QEMU due to it.
Indeed replacing an undocumented, unchecked constant comparison with
a proper property seems better.

> (Note that I'm not singling out this particular proprietary guest
> payload. I feel the exact same way when QEMU is being contorted for
> Windows of OSX guests, but at least those guest payloads are universally
> available to users, if the users are willing to comply with the
> corresponding terms and conditions.)
> 
> > Being able to use QEMU to let vendors debug their platform firmware is a
> > perfectly reasonable use of QEMU; maybe not of your OVMF build - we
> > need to keep the restrictions on the two separate.
> 
> You as a QEMU maintainer / reviewer, and I as an OVMF maintainer /
> reviewer, are going to pay with our time and effort for a proprietary
> guest oriented change that normal QEMU users won't even be able to run,
> let alone read, modify, distribute.

We have lots of complex hideous changes that I'm never going to use but
seem reasonable;  this is a tiny change that seems perfectly reasonable
both for open and closed firmware.
I realise herding OVMF developers is tricky, but that's not a reason
to nack a reasonable almost trivial change in QEMU.

Dave

> But yes, technically speaking, we can replace the size limit constant
> with a property, I think.
> 
> Laszlo
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


