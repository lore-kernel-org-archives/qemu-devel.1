Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3CFC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD97320658
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJnFmqGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD97320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyvOw-0006Kh-0k
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyvO6-0005Q6-4q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyvO4-0002qi-0Q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:24:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56192
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyvO3-0002nq-Kj
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580811895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dyTYIQGG17vdXPq5VRYaHsyuldMQHvPtAkjC7m6Uo1g=;
 b=bJnFmqGfhgpW4lp4RcXmbRLrj00pzkJM02RcW2NkCOqKiXMKqXN9m/RHnhuBy/UE/3OqIp
 fiLpKCp2pntH78jy2tE/TxetRQOEcbLQJtxM7q+q7ZwF1toCyelo85EbLullV41/5JuHT3
 sEcDpsIhuNLN6cjB0Lz7qCE69jTtTG8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-gom05LJjPvuUQbRdo2SVWQ-1; Tue, 04 Feb 2020 05:24:53 -0500
Received: by mail-qv1-f72.google.com with SMTP id dw11so11338064qvb.16
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 02:24:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DOmpzdrXGyPe1r3ilfjz+b3yrJN3h9OfgTSHBPj/2jM=;
 b=Vsx6OoBVl3Xgq0hOc72yo3+9rTL+w+9ZYkiim80wLy/WNc9tQPRDdKDyRyG5qdRSR7
 UDOPkK1abLXAHeykqc0hP8IJzuChRilQSaf8evfhtYqwHRM4mBuWUkMLR9fHmtPPEOMg
 Y6znBtO7VTsuLMuWhHfCUreIf5+E4wfB7o+c27p2E2KClCUKxVm6taPlZY6fr1/V/ADa
 0SFdgxceol1w4GrwPVmGLt6pO9Psc9L8b2gK0vQZA/FZh0t26eo6CadQOj9Y9Rdu+riL
 6LAKYBE8OE2tzRIqejUmexc6S07WgObMc/kkqqE//51/T8sJhbluQkqDP8rlZE3ylq1b
 gy5w==
X-Gm-Message-State: APjAAAXfAU8Bfh4lkgfdb60N+Qamu74Kgpwg1e1362UgxH4BxfEohz5r
 gE88GAIymFqNZVmskJ4+2KOvcaF7lY3PJ6GAILgTrWBBe60Y/l6Y96D1++xCMmbkZFI/2Zd1t8+
 mf18Yt21wpw4mGf0=
X-Received: by 2002:a37:9d0c:: with SMTP id g12mr22598660qke.35.1580811892739; 
 Tue, 04 Feb 2020 02:24:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxz49wCGkztxjCFjoQ3o/A9nLt8YqF+8CS00OTi4zohanPFlD8xmlcTNACppkwsrc94/w7IlQ==
X-Received: by 2002:a37:9d0c:: with SMTP id g12mr22598642qke.35.1580811892451; 
 Tue, 04 Feb 2020 02:24:52 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id 16sm10884354qkm.93.2020.02.04.02.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 02:24:51 -0800 (PST)
Date: Tue, 4 Feb 2020 05:24:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laine Stump <laine@redhat.com>
Subject: Re: Disabling PCI "hot-unplug" for a guest (and/or a single PCI
 device)
Message-ID: <20200204013947-mutt-send-email-mst@kernel.org>
References: <16db1dcd-d1a3-5bd9-2daa-d16a0f2d168e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <16db1dcd-d1a3-5bd9-2daa-d16a0f2d168e@redhat.com>
X-MC-Unique: gom05LJjPvuUQbRdo2SVWQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 05:19:51PM -0500, Laine Stump wrote:
> 3) qemu could add a "hotpluggable=3Dno" commandline option to all PCI dev=
ices
> (including vfio-pci) and then do whatever is necessary to make sure this =
is
> honored in the emulated hardware (is it possible to set this on a per-slo=
t
> basis in a PCI controller? Or must it be done for an entire controller?

I think it's possible on a per-slot basis, yes.


