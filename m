Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FF9C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CDD2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVxzRCEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CDD2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03da-0001Li-WC
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03cX-0008QZ-8Q
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:56:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58172
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03cV-00040m-G2
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595858206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yIyUbH3TjxBkeCeiM81IwjmoKyB0WfEoMp0lKATPcA8=;
 b=BVxzRCEv9169fsDnujlkXG8yix16UBQpIGVIFmmYca2bJDXWSkms3+sVm5Pnq/CXWlqBLT
 3/Oe9UkV6lOXfBmWQgKiC5fAqQ53k1EhPctz0z5dgtKwRkDY9txsYiY6gQ3Sdt3Ucx5skL
 ZnB/wO7QDWdnLgEoGmIGtmx9tA6NaEA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-NQ9l-YkkOuK5BJS6W0xOHA-1; Mon, 27 Jul 2020 09:56:45 -0400
X-MC-Unique: NQ9l-YkkOuK5BJS6W0xOHA-1
Received: by mail-wm1-f72.google.com with SMTP id p23so843158wmc.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yIyUbH3TjxBkeCeiM81IwjmoKyB0WfEoMp0lKATPcA8=;
 b=ZPSMmwoIq8gstGL6c1aDI9fIF28h3hnkwRHMuRPxNpzRqg/1j/l44pB/z+faR3cha9
 LzNER7kwkSPTatHUM7S+lB04IdGZv8uWlDdOsLk2hafFuinsttbREftiu0nZDLALzSrB
 srVVzl4mLRG1GxuN7wADDa6QDezv2blbfJsD3CGXeMzYxfmFM3MZsMQbOoBRe2UYtvBZ
 w6Q7/avZtyLQGpvl+95E6qmjxG8HO3GLyyyIBYZfUVBlwnHspy8iPHe5RvOJ7lMiGlwF
 yhMZ5Ojw0hhiS62mpbwLUe0BG/3nzZr/9QatQL+zR9g4CujkLwSHaDhhfDoYO6lzz3RW
 DnJg==
X-Gm-Message-State: AOAM533OT/h6TUpfpaTKsUnpPXOknkvT+YVfQDFXi/ugaow7ttgHxgjI
 SpVKm+qj6UiWZoSkKfSv7Ikh87M2dt7Vp6TONP35yj+Q/JXYhV9271br5Oa2IEfkW61KaC0c6sX
 oOKvtb7joeQABbRw=
X-Received: by 2002:a5d:6990:: with SMTP id g16mr19928615wru.131.1595858203897; 
 Mon, 27 Jul 2020 06:56:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqAV8gO+USFcIxnkOfN8d/n0QDAkdEyPJP8FKDt0FcFEPVD663oH8VvNP4ha8rf/cODQgdWw==
X-Received: by 2002:a5d:6990:: with SMTP id g16mr19928600wru.131.1595858203636; 
 Mon, 27 Jul 2020 06:56:43 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id j8sm13171857wrd.85.2020.07.27.06.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:56:42 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:56:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [virtio-comment] Re: [RFC] ivshmem v2: Shared memory device
 specification
Message-ID: <20200727095239-mutt-send-email-mst@kernel.org>
References: <f109fe5a-92eb-e5a5-bb83-ada42b3a9b61@siemens.com>
 <20200727091802-mutt-send-email-mst@kernel.org>
 <85f69f31-e4c6-e7af-1fa5-90e5a2c81ae8@siemens.com>
MIME-Version: 1.0
In-Reply-To: <85f69f31-e4c6-e7af-1fa5-90e5a2c81ae8@siemens.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 00:16:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Jailhouse <jailhouse-dev@googlegroups.com>, liang yan <lyan@suse.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 03:39:32PM +0200, Jan Kiszka wrote:
> On 27.07.20 15:20, Michael S. Tsirkin wrote:
> > On Mon, May 25, 2020 at 09:58:28AM +0200, Jan Kiszka wrote:
> > > #### Vendor Specific Capability (ID 09h)
> > > 
> > > This capability must always be present.
> > > 
> > > | Offset | Register            | Content                                        |
> > > |-------:|:--------------------|:-----------------------------------------------|
> > > |    00h | ID                  | 09h                                            |
> > > |    01h | Next Capability     | Pointer to next capability or 00h              |
> > > |    02h | Length              | 20h if Base Address is present, 18h otherwise  |
> > > |    03h | Privileged Control  | Bit 0 (read/write): one-shot interrupt mode    |
> > > |        |                     | Bits 1-7: Reserved (0 on read, writes ignored) |
> > > |    04h | State Table Size    | 32-bit size of read-only State Table           |
> > > |    08h | R/W Section Size    | 64-bit size of common read/write section       |
> > > |    10h | Output Section Size | 64-bit size of output sections                 |
> > > |    18h | Base Address        | optional: 64-bit base address of shared memory |
> > > 
> > > All registers are read-only. Writes are ignored, except to bit 0 of
> > > the Privileged Control register.
> > 
> > 
> > Is there value in making this follow the virtio vendor-specific
> > capability format? That will cost several extra bytes - do you envision
> > having many of these in the config space?
> 
> Of course, this could be modeled with via virtio_pci_cap as well. Would add
> 12 unused by bytes and one type byte. If it helps to make the device look
> more virtio'ish, but I'm afraid there are more differences at PCI level.

I guess it will be useful if we ever find it handy to make an ivshmem
device also be a virtio device. Can't say why yet but if we don't care
it vaguely seems kind of like a good idea. I guess it will also be handy
if you ever need another vendor specific cap: you already get a way to
identify it without breaking drivers.


> I do not see a use case for having multiple of those caps above per device.
> If someone comes around with a valid use case for having multiple,
> non-consequitive shared memory regions for one device, we would need to add
> registers for them. But that would also only work for non-BAR regions due to
> limited BARs.


OK, I guess this answers the below too.

> > Also, do we want to define an extended capability format in case this
> > is a pci extended capability?
> > 
> 
> What would be the practical benefit? Do you see PCIe caps that could become
> useful in virtual setups?

So if we ever have a huge number of these caps, PCIe allows many more
caps.

> We don't do that for regular virtio devices
> either, do we?

We don't, there's a small number of these so we don't run out of config
space.

> 
> Thanks,
> Jan
> 
> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux


