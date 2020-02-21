Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F6CC35659
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58B8206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx3wpFsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58B8206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CGP-0007Yp-2O
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j5C9C-0006pz-H5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j5C9B-00087s-3Q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:30 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:44895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j5C9A-00087h-UP; Fri, 21 Feb 2020 12:31:29 -0500
Received: by mail-qk1-x744.google.com with SMTP id j8so2508926qka.11;
 Fri, 21 Feb 2020 09:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6LEMoX+bgUuZ7zLmOYRBsz+y9b9IiNxSfKfSpZUQgx8=;
 b=gx3wpFsQefMYdbfvAJkuqRMsV4oCVurO5SDyLm1NLq5tnngx80hdVROCzoJ2Qb/xuf
 tTEWFfWOJ42b6kjd+FJA553qgalj9sZ5NJ0RGONDOhN948i0bFnWoUmV7qa58ciFC7D0
 Cl0iXrga2GAEWlY4GsgxGzVJeyLuerKNa6d7cfT51EJvXF9LHb5IU6iR9diG1Q6INctF
 rwEZ/5K78PtUlo5IxcGgQj5x0Ins7MaSQi0dMvvTYrPbE8wixMFiH/87fLBnvAQYq0kD
 yATQt59PhuxNSpsEgpx0Kk1C62qQ/NtfwcaQHJC1Hcmeuez2E6D0+AtdlZ5Ns6qROPlU
 +lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6LEMoX+bgUuZ7zLmOYRBsz+y9b9IiNxSfKfSpZUQgx8=;
 b=pN1C8wyB0FiZ/0PQEg0waba99QH3qhAR8nZ3hnKjZgRAqQ8PEPy4Qlz/ELIEQ9WYHd
 yxiXbdGdQzv0I+qwBeeY7kZFuAgidPaLO/xFYb3TlHePvnn3a5fdllA1pT+yhOvSlG/V
 9z9dx3NR9f2E9Z4DocuklX8aTFwSiy5Tiql8Uw45DTgwyg/KKwkLPSYN9XF0caYFZew3
 grikcVbbOkd8OtctgVkpbEkvWVRTopTqFkarUD0s8V6h6u0xnkb7FL9ljfwZGy5ikuW6
 oRDrybj7mfQ3gQBCA2AFoueTYLOZuv+ExuHXKE0OG2MFXEbzUjFh2FUDQagsouQ6RHyY
 snTw==
X-Gm-Message-State: APjAAAUB0Oblvyti+oxiMUy1Iy+bwN+wuASbURyQriJAYVYQ1AfcGn2M
 RKYWLvMAve+Xr7mHRsYUBKi9pixhicRtELMi01Y=
X-Google-Smtp-Source: APXvYqwkyGjYuF+NJcA7hgtDH+ZUn1SV+zA0m2PxLqb7pTxioTAQOe9yqqk8qeAlXy8nYy9wOszYC1f8iNDOrv7+k68=
X-Received: by 2002:a05:620a:20d4:: with SMTP id
 f20mr9217501qka.196.1582306287337; 
 Fri, 21 Feb 2020 09:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20200218224811.30050-1-andrzej.jakowski@linux.intel.com>
 <20200221134555.GK1484511@stefanha-x1.localdomain>
 <e8aa39fd-b5eb-8ed2-445b-02cce3301748@linux.intel.com>
In-Reply-To: <e8aa39fd-b5eb-8ed2-445b-02cce3301748@linux.intel.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 21 Feb 2020 17:31:16 +0000
Message-ID: <CAJSP0QWXsZXBr_iVJp11FHYYj2Zb1NU62vA6kaR36mOH9B8abA@mail.gmail.com>
Subject: Re: [PATCH v1] block/nvme: introduce PMR support from NVMe 1.4 spec
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>,
 qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Zhang Yi <yi.z.zhang@linux.intel.com>, Junyan He <junyan.he@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 3:36 PM Andrzej Jakowski
<andrzej.jakowski@linux.intel.com> wrote:
> On 2/21/20 6:45 AM, Stefan Hajnoczi wrote:
> > Why is msync(2) done on memory loads instead of stores?
>
> This is my interpretation of NVMe spec wording with regards to PMRWBM field
> which says:
>
> "The completion of a memory read from any Persistent
> Memory Region address ensures that all prior writes to the
> Persistent Memory Region have completed and are
> persistent."

Thanks, I haven't read the PMR section of the spec :).

A synchronous operation is bad for virtualization performance.  While
the sync may be a cheap operation in hardware, it can be arbitrarily
expensive with msync(2).  The vCPU will be stuck until msync(2)
completes on the host.

It's also a strange design choice since performance will suffer when
an unrelated read has to wait for writes to complete.  This is
especially problematic for multi-threaded applications or multi-core
systems where I guess this case is hit frequently.  Maybe it's so
cheap in hardware that it doesn't matter?  But then why didn't NVDIMM
use this mechanism?

If anyone knows the answer I'd be interested in learning.  But this
isn't a criticism of the patch - of course it needs to implement the
hardware spec and we can't change it.

Stefan

