Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47369C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC4A2072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETFRtQx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC4A2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiHmU-0008Iu-BV
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 09:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jiHlS-0007Td-BK
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:24:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23835
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jiHlR-0004PB-Hz
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591622672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RFcgcxHt4KVtVwQue4tCUUHeptgn+tNaljqupfRE57Y=;
 b=ETFRtQx9wPBjAq+8ATS5HTHCouw/ORoXmW4/FkrN87Y9i0YuP91vGIimnii5oaKVBxPwo7
 l7E8Oc65oo+/BIPLn+rH1UiDfToLMDGNKhZBOxL+HpTJ01zblPVYZxjaW0cudbx9CK9O85
 DDDwToNrf8yLHP2B9HabSWNsmiDIKZU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-ziJ9nCArPLeL9CEFgbF-GA-1; Mon, 08 Jun 2020 09:24:31 -0400
X-MC-Unique: ziJ9nCArPLeL9CEFgbF-GA-1
Received: by mail-wm1-f69.google.com with SMTP id v24so1767291wmh.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 06:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RFcgcxHt4KVtVwQue4tCUUHeptgn+tNaljqupfRE57Y=;
 b=ALNA4JEf8MEWdTs/U/W08O4quGnXpmmg8DF67aAIACGsnTjIOiWH/qbOj03krkmkS3
 U/U2yd4u9IPr2XXd2eBz7zyjYfLzxhE2ue0tx9xGkJIYxB8OHghm1wWCGLh0z+oLC+Oo
 Y8Qp4APaoSUxiWVex3u+9wxbKeqymZdSmMUnkwI1/R07bF/ZzPV8GW3cgOpvc4WMm4Le
 MoA2UiGan1NZUQ1VgKoNBQ1MUkYzT9PoVYO6eI15f4efPCADr2Pq26incg3FgPBOMRy0
 HxBbmblO5ftREUTZcZejmQE+ZI5IWYh8tZCTn6zh6pY2gEgL5QUfX9An756jOznwkd4/
 8Vpg==
X-Gm-Message-State: AOAM531jVeFlwDWD/M209eEDgaPIOKsDxubPRBqIGwM0/Fy1g38icadB
 INs9N2efIkpgey+YdfP8MWWZsmZ/b2/60j7TI7PDd3sHBW2DGQ4Z7IK9KX/zVc1OpFbhXLkDtd6
 iVAbJlWx30KfJeGg=
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr15948125wmh.38.1591622670107; 
 Mon, 08 Jun 2020 06:24:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgLA6WOLoZIsBhkrFQAGS4FHiUCdW4n5SBRDCT9xHKGYl8RuU+z5zj6eDvxhx/Oh4K0uyHJg==
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr15948088wmh.38.1591622669775; 
 Mon, 08 Jun 2020 06:24:29 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 q13sm22916745wrn.84.2020.06.08.06.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 06:24:29 -0700 (PDT)
Date: Mon, 8 Jun 2020 09:24:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 00/16] acpi: i386 tweaks
Message-ID: <20200608092408-mutt-send-email-mst@kernel.org>
References: <20200515150421.25479-1-kraxel@redhat.com>
 <20200608132245.3ttg6srmyhzbjrbt@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200608132245.3ttg6srmyhzbjrbt@sirius.home.kraxel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 08, 2020 at 03:22:45PM +0200, Gerd Hoffmann wrote:
> On Fri, May 15, 2020 at 05:04:05PM +0200, Gerd Hoffmann wrote:
> > First batch of microvm patches, some generic acpi stuff.
> > Split the acpi-build.c monster, specifically split the
> > pc and q35 and pci bits into a separate file which we
> > can skip building at some point in the future.
> > 
> > v2 changes: leave acpi-build.c largely as-is, move useful
> > bits to other places to allow them being reused, specifically:
> > 
> >  * move isa device generator functions to individual isa devices.
> >  * move fw_cfg generator function to fw_cfg.c
> > 
> > v3 changes: fix rtc, support multiple lpt devices.
> > 
> > v4 changes:
> >  * drop merged patches.
> >  * split rtc crs change to separata patch.
> >  * added two cleanup patches.
> >  * picked up ack & review tags.
> > 
> > v5 changes:
> >  * add comment for rtc crs update.
> >  * add even more cleanup patches.
> >  * picked up ack & review tags.
> > 
> > v6 changes:
> >  * floppy: move cmos_get_fd_drive_type.
> >  * picked up ack & review tags.
> 
> Ping.  What is the status here?
> 
> take care,
>   Gerd

It's queued and will be in the next pull. Thanks a lot!


