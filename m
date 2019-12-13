Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F710C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CB420663
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hldY2Iea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CB420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifmpu-00077a-Vc
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 10:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifmpG-0006ai-E0
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifmpF-0002fr-3Z
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:25:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29441
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifmpE-0002eR-WF
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576250752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tLgNbc+2hFAqQaiWDWxnQbumug6CmEjP1swZBRyMPBw=;
 b=hldY2IeaeW/r01cOjL2eh5TiN/MlNnGpujTBvacF2RyKNKKRyNUE3HttT2rbEfSDVHkyfs
 Jb0T0c9/HdbaGssx5RViqlpRolYs9/tun1RYpoux70+qnS6p9eorVn2t0rwfAINaJ77lw0
 er0N2w3BPiQMVCZej+jGlG83IJMHQ2g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-psbs4kANNpuvX5Os3oPT1Q-1; Fri, 13 Dec 2019 10:25:50 -0500
Received: by mail-wr1-f71.google.com with SMTP id d8so2688943wrq.12
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S1k6EFV1ep020D1FU5vQ+ItiXbjakJeqjxBtiMYMURE=;
 b=nRPGDnpsYZqGERDHQ5SPFAG4zieB37ITWVy42ySbky5rSonkZ5LUOHuwqoCTd2/Ols
 BVFQVnA5I19ZwAsWiBXUBBbmmwsF+e0r1BhyRHGDBVRZoX6ImR9Km2lKquIuka4u7PD0
 +kXxaDlzFVEogn9KreBOhgPzpjcxTiptj0Dw51nrbiE7upiXvTRuPI/y3MivLFSq+xan
 XZw/yKDW6wYN+gi2Op6X6f/1TRfz8ury6R7oEwDy7LcUWQmH2QEu50bKes94Nel/RK6D
 6o2hU8S+w6pNt+iYhvPxmo74qG7bBbItmFqev1h6OA7aOT/oB20wRwx/EHMV/W7n/W4g
 euNQ==
X-Gm-Message-State: APjAAAVaGq9eL83ydIrQwNoepAeNki+KK31apTV6jeVu7lQn59YRXKbL
 3qmdILJaaMLYHzlbkJWyLyAIDnHzqcH9icX8O6r5YgyYI/X3i+ViFEVf2PHvdWz6tXiJZmxzF/P
 0Yg4wI9c1PQD07K0=
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr14652849wmk.8.1576250749334; 
 Fri, 13 Dec 2019 07:25:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDblYPN1k2VrU0UPOKvThNY+BbUfNvkc3tkt/TigXt40zdOOfg9HStI24jRFI9NmtQWC2zOg==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr14652822wmk.8.1576250749114; 
 Fri, 13 Dec 2019 07:25:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id s65sm10919126wmf.48.2019.12.13.07.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 07:25:48 -0800 (PST)
Subject: Re: [libvirt] [PATCH] virtio-blk: deprecate SCSI passthrough
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
References: <20191213144626.1208237-1-stefanha@redhat.com>
 <a14facd1-731e-f1cd-2476-1bd676da1e7d@redhat.com>
 <20191213150706.GS2441258@angien.pipo.sk>
 <20191213151009.GF2232389@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <239982df-8527-2d13-710e-d3c14c9a22ab@redhat.com>
Date: Fri, 13 Dec 2019 16:25:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191213151009.GF2232389@redhat.com>
Content-Language: en-US
X-MC-Unique: psbs4kANNpuvX5Os3oPT1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Christoph Hellwig <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/19 16:10, Daniel P. Berrang=C3=A9 wrote:
> I don't think it really matters. QEMU is deprecating it with no
> seemless direct replacement, so I don't think libvirt needs to
> be concerned. The feature simply becomes unsupported.
>=20
> At the very most we need to check if it exists before using it,
> but even that's just a nice to have which results in a slightly
> prettier error message.

Libvirt right now assumes that a QEMU without the scsi property defaults
to "on", but if the oldest supported QEMU version is 1.5.3 then it
already has the property.  So you can just give an error if there is no
scsi property and device=3D'lun'.

Paolo


