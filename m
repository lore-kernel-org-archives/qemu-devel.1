Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43713C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE0020838
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE0020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl9Xc-0003FV-EN
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 06:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35651)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hl9X8-0002p7-Vj
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:09:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hl9X7-0004Wv-U9
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:09:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hl9X7-0004Vs-O3
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:09:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so1782590wrm.8
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 03:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UMYo+wVq/EqFnxgUvSeD3ZFkjQTYbJrALc4tB2osABg=;
 b=tVBTyk3cwIZaZ/BYFtUGSOu5MPJo72bWVapxTjdT67INnRI8TDE5+DOhgMqF5vNf0s
 50EjLOYn9mJeiBNPsO1YqB1UJzOaT/VgqFzj3zJ9sryaXIf33fRc/DJD7J5xStnG2YeG
 zCF8xvdrgoL5rijHVimQlhCg08UgrpuFbnGlB6eTjS5x7WkAe4g2FbESo5EjTOnQ1Cy7
 eAYZsEOVjgMitKqlF53jhY8QWfC+HVKzSIAujMMTKCkcZn2rJL2ylZ+TC4EDWtZPrMml
 nwEAqnpbMSF0aWxA36Yx831RYamlxybTFg2FUm2/Wy+vZ1RHuJ3LiCrqC0qzHP9mlE16
 BbXw==
X-Gm-Message-State: APjAAAVURgsug8ffm364g0WD7HWLNK+JKR48NNqI6T4NeJWnSdTygpMD
 uAo9hBEl9dBh6K16dZLAP0tVrGcfmlw=
X-Google-Smtp-Source: APXvYqw/UA3mSWGf0JljSsybi5i2Vy36F5meCXowObOAuHN86cuaQ13SpQs3AiL2IwwNqUvodX9kOw==
X-Received: by 2002:a5d:668e:: with SMTP id l14mr26534452wru.156.1562753344509; 
 Wed, 10 Jul 2019 03:09:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id g11sm1988207wrq.92.2019.07.10.03.09.03
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 03:09:04 -0700 (PDT)
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>, kwolf@redhat.com,
 mreitz@redhat.com, mst@redhat.com, stefanha@redhat.com, fam@euphon.net,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f790cb77-fa6a-c304-bc7f-62bbede78751@redhat.com>
Date: Wed, 10 Jul 2019 12:09:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 0/4] virtio: handle zoned backing devices
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/19 22:38, Dmitry Fomichev wrote:
> Currently, attaching zoned block devices (i.e. storage devices
> compliant to ZAC/ZBC standards) using several virtio methods doesn't
> work - the zoned devices appear as regular block devices at the guest.
> This may cause unexpected i/o errors and, potentially, some data
> corruption.
> 
> To be more precise, attaching a zoned device via virtio-pci-blk,
> virtio-scsi-pci/scsi-disk or virtio-scsi-pci/scsi-hd demonstrates the
> above behavior. A simple fix is needed to make
> virtio-scsi-pci/scsi-block work and this is covered by a different
> patch. The virtio-scsi-pci/scsi-generic method appears to handle zoned
> devices without problems.

The problem with this approach is that other devices (e.g. ide-hd or sd
card) also break with zoned devices and the only way to fix it would be
to add code denying zoned block devices to all of them.

The question then becomes how to define a whitelist.  One possiblity is
to add a QOM interface (for example TYPE_ZONED_BLOCK_SUPPORT) to
scsi-block and scsi-generic.  In do_parse_drive you can query the
BlockBackend with bdrv_get_zoned_info, and return an error if the
backend is a zoned block device and the device does not implement
TYPE_ZONED_BLOCK_SUPPORT.  (Commit 6b1566c is an example of adding a new
QOM interface; in your case, it would be simpler as the interface would
not have any method).  Kevin, what do you think?

Also, why deny passing Host Aware devices?

Paolo

