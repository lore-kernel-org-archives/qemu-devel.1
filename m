Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8AAC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 19:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E942070D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 19:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrosWoqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E942070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36875 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEJ3O-0002j5-BQ
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 15:38:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEIum-000570-CZ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEIhF-0003CS-Cw
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:15:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hEIhF-0003By-26
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:15:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id j9so4259750wrn.6
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=d7sqDYOCKBKaPcaM7/FPZAGN0gMq2XRHcGGKv3GEMC8=;
	b=LrosWoqJD5D3FtQHddCCbxFzAtGmu32nvsQj3GWD7Q3ORUNZQVL8R/nPg2EPOpen5q
	6O1LC76AO7BQvaz99wOGIX7YJklZGwYTPIysOIJg5ItR3u5eQc6w2WM3S6MXiXPm50tc
	Y7bdGqlOc0aaxti7oCXzXEjxiuXee2wA5mZBWF9+0Dp1EzOeeYQd383Mqlvh0hJgNG19
	N5p8YTqhRc6xxmm/oCERdqE6vuSXAWU2hqFw6b362FjHcBo5NeKT9FuJSV5nOrDOCNnj
	QEh6QUxNi/Rp+DiHY0QCfClV38pADnJobpYbLtDE6lKx2x2kYWIQQU1S8vXqSBjPq8vn
	pK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=d7sqDYOCKBKaPcaM7/FPZAGN0gMq2XRHcGGKv3GEMC8=;
	b=iWeJJfLYzFArd3RCV4JuZedB/TBGpXUYBEdX+Ah43RDb9g0waAwmMgHptZiZClP3IH
	lZRIgg9WaYqW9Kcwf4WOePKgagAMGmxmot8DOzdpywtZIDgR5j/HEqDbNuB+H2AtBE+3
	EYDTUZXxKx4Ud/n5ixcd/12Osgn7C/5DAq5VyzY/T09QjiMAK2qOZsGGZLDwPyVjLMz6
	8WKGMGpJUhW2fzTRI9+bJ0nnAPQT2J6vhc4G/6MI5iHkCQbE7j5zfQRkp3eqiZID9leE
	4yY+jzLzJPWZip8lagkiGJOxGC2uBSuDmZ3YnvNtSiTo/I5ursYaJ39iZ/9DKZkXrjcv
	4VwQ==
X-Gm-Message-State: APjAAAVAbh2jzTCZaEZrABHSW+oxKRz+su9vGV8Lo3C/p8nHMCdY4U9M
	iyYI2e37rVreVUTxFmLjRRlbbbdDPIxuNYCBFvc=
X-Google-Smtp-Source: APXvYqwyAJuCTz7A2GOtfal+1fxB/YDEwPQso11L+DnuFZ9uwZHV05EBune4h0iRoA2re6TXmTBCLwQ1hgEo/L7zFdM=
X-Received: by 2002:adf:f5c7:: with SMTP id k7mr752270wrp.197.1554923743631;
	Wed, 10 Apr 2019 12:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190401111843.54528-1-ybettan@redhat.com>
	<20190409131734.GE16944@stefanha-x1.localdomain>
	<1871f593-ec5b-fede-7da5-a7ae78056249@redhat.com>
In-Reply-To: <1871f593-ec5b-fede-7da5-a7ae78056249@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 10 Apr 2019 20:15:32 +0100
Message-ID:
 <CAJSP0QVpPGKO_NH2CXpdYtQfLsMF+OjKx2QzjtKJVkOnnoBHdw@mail.gmail.com>
To: Yoni Bettan <ybettan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RFC-PATCH] Introducing virtio-example device.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Amnon Ilan <ailan@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410191532.pW2EEHkeaZcje9OlFBO-LtOO6drszRy3rL0aWQR6bkU@z>

On Wed, Apr 10, 2019 at 4:45 PM Yoni Bettan <ybettan@redhat.com> wrote:
> On 4/9/19 4:17 PM, Stefan Hajnoczi wrote:
> > On Mon, Apr 01, 2019 at 02:18:43PM +0300, Yoni Bettan wrote:
> The final purpose is to have:
>
> 1. device specification
>
> 2. device implementation
>
> 3. device driver
>
> 4. blog
>
> maybe I should have written it at the beginning, this is not the entire
> project but it is its start.

The way I'd design VIRTIO devices without prior knowledge is:

1. Learn the VIRTIO device model.  Understand the concepts in VIRTIO.
<-- this is hard today, there's not much good documentation

2. Design an initial version of the device spec.  Mostly configuration
layout, virtqueues, and request structs.  Not much text is necessary
at this point, but it's critical for thinking through features before
implementation.

3. Implement guest driver and device emulation.

4. Iterate on spec and implementation until it's functionally complete.

5. Submit the spec to the VIRTIO Technical Committee.

6. Submit driver and device emulation patches.  They can be merged
when the spec is approved/close to approved.

Are you jumping to #3?  This is likely to lead to poor quality
implementations and specs because the fundamental VIRTIO concepts
weren't understood.

If the point is to educate others and/or do it "the right way", then I
would really avoid hacking around without first doing the other steps.

Stefan

