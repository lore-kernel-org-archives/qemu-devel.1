Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290E8C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46C62070A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwiqbYSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46C62070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k033z-0000kv-7B
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k033D-0000Dx-2k
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:20:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28812
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k033A-00067U-Mx
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595856016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jrcXXs1yEh3OOU7gsBHcqIm2H/mCao8DCc7NJB9MyZo=;
 b=OwiqbYSEXhDcP89ir2Zv0uOJXyhAsgXRfQ4qYLKimI5+Sgqca2Lsd7rv9bAYbDOQ/xgEjO
 gCxdoepw98p9v7QN5FwyiWcOml6LBwFBklJ+oae9DTQGvZF03g/sbH6tfjQtw/LYr239QR
 npH4QI4bIz0KMyGJPhpTlfVPsFCo2UU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-_V8MRfr1MqKq-WdqXkmcuw-1; Mon, 27 Jul 2020 09:20:14 -0400
X-MC-Unique: _V8MRfr1MqKq-WdqXkmcuw-1
Received: by mail-wm1-f70.google.com with SMTP id z10so1475994wmi.8
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jrcXXs1yEh3OOU7gsBHcqIm2H/mCao8DCc7NJB9MyZo=;
 b=MeOWZRC5FM/Si4Ss8IBR+VZb+AWbubiwpRCxkeFa4Sl6TfDr/jaIVi8hiL/2fItsBx
 fPTctTpAEcpw5Ke1rflpw3q1OoFdMwG6aIeL8ZyuC7I5f/331Md08//i58OUTBLgm+EL
 LW8uS9TMP2BxNLPvpXHwxtC81+KOtGZPKIUPVQphGgFmFh0aw29EokGQz4dSxXpFBzOU
 mrDc+tWgx4iydBTo9ys1U33r56c26rSDfLUzChtnbVd7DNob5IcjxS3DITsUK8f0J+UT
 yi/YK/82Ke9ouW5dYQPgtnRFb1P3r+eQ/wcTa2MjOBKzoZ+pdbxYIlT3Fsf40k66NSGK
 PaoA==
X-Gm-Message-State: AOAM530YJp6ChiBWG7q9TTrotEPgoNeunPjt+WG/rckbx437WxiLQ95I
 zf1PaM8ThDl0T31snRF7wxIYHpPw4XHqjou2XuLpRL9LB68xRE+ZgBQwP9FZ+6XBcGBS0u/gVsj
 K+RfQ7rSBGbIDzd0=
X-Received: by 2002:a5d:6744:: with SMTP id l4mr19561179wrw.105.1595856013021; 
 Mon, 27 Jul 2020 06:20:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSBThggsrJZriFpBWQw3ZuCiBOGxeOAD0Q2DvgupYYrG4n+9tsPPrb1lvAkxFF1Nsz0qHTmQ==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr19561146wrw.105.1595856012762; 
 Mon, 27 Jul 2020 06:20:12 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id t202sm18264236wmt.20.2020.07.27.06.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:20:12 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:20:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [RFC] ivshmem v2: Shared memory device specification
Message-ID: <20200727091802-mutt-send-email-mst@kernel.org>
References: <f109fe5a-92eb-e5a5-bb83-ada42b3a9b61@siemens.com>
MIME-Version: 1.0
In-Reply-To: <f109fe5a-92eb-e5a5-bb83-ada42b3a9b61@siemens.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Jailhouse <jailhouse-dev@googlegroups.com>, liang yan <lyan@suse.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 09:58:28AM +0200, Jan Kiszka wrote:
> #### Vendor Specific Capability (ID 09h)
> 
> This capability must always be present.
> 
> | Offset | Register            | Content                                        |
> |-------:|:--------------------|:-----------------------------------------------|
> |    00h | ID                  | 09h                                            |
> |    01h | Next Capability     | Pointer to next capability or 00h              |
> |    02h | Length              | 20h if Base Address is present, 18h otherwise  |
> |    03h | Privileged Control  | Bit 0 (read/write): one-shot interrupt mode    |
> |        |                     | Bits 1-7: Reserved (0 on read, writes ignored) |
> |    04h | State Table Size    | 32-bit size of read-only State Table           |
> |    08h | R/W Section Size    | 64-bit size of common read/write section       |
> |    10h | Output Section Size | 64-bit size of output sections                 |
> |    18h | Base Address        | optional: 64-bit base address of shared memory |
> 
> All registers are read-only. Writes are ignored, except to bit 0 of
> the Privileged Control register.


Is there value in making this follow the virtio vendor-specific
capability format? That will cost several extra bytes - do you envision
having many of these in the config space?
Also, do we want to define an extended capability format in case this
is a pci extended capability?

-- 
MST


