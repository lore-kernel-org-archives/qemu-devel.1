Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F948C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9D12072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3iiiV0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9D12072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiHts-00038F-GK
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 09:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jiHsd-0002Xd-6a
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:31:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23398
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jiHsb-0005g8-Jr
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591623116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tPVzldjJJNnkRaNdn/VsItofhkeod9E0zRG0RaxQv2M=;
 b=b3iiiV0mv06NrJlbWe+KQC8XRvS+SwnU7suXgc8iO78D2AJdZTTmKPG4WaVcsC0u6J5avP
 nP7ktP5GLYkxQpwU0Fn7jDabq/HY/sJ9x4Mv3FAeg1/Fa87PIlfXOScFpTQQ8QIE2/oh/G
 CvdFeyekWg0y940A1wniLFsSjrt3DOc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-QJZj0fJyP-a0AiEvHVLNbg-1; Mon, 08 Jun 2020 09:31:52 -0400
X-MC-Unique: QJZj0fJyP-a0AiEvHVLNbg-1
Received: by mail-wr1-f69.google.com with SMTP id o1so7113350wrm.17
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 06:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tPVzldjJJNnkRaNdn/VsItofhkeod9E0zRG0RaxQv2M=;
 b=WVuQ+0R6Gz9dXKU91gB4fNd6ZKBFPW2/VD2geTP0f3+0tIiwtldzDuO7RSLGiH8jOM
 M1pewqs+TWGru9DKYzmUObALNUhruEZ4ZNntvEgyKD0ClDE8G/7xpzcgz8fzfrBA15S1
 +f9z3XTLMRZZsltMnUMAsDDXwVVB+0pOydP2xhm6HUtlh5uxbp2tAfvnVSKubazXP/Xb
 r1RT2P/fkmU62kTvS08BGFXAuJQEZaCVQ/MNm4eu7w94Cg18U0n/J7/PnfnsTbxtYN0k
 /disJt5p/3FSJBsWjl/nBJ3Zr5t+eqItx4abaTgzILLMG8Gn0fj5HllTOuIvtqtPgvpx
 11yA==
X-Gm-Message-State: AOAM5329rOJPRvubdNCfVktctK9Wv8g1aK8GoCwGZCa7d6+69Km41tCM
 MmyFWGggS08+E5+KKK88anFObD80ndh+d1mBeh/hc6+epDP4IvqVRq7y50Sx35jH0T8aZkA3VCt
 ojAkqAER+GsmTidI=
X-Received: by 2002:a1c:66d5:: with SMTP id
 a204mr16198846wmc.134.1591623111303; 
 Mon, 08 Jun 2020 06:31:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxA2HGg4NasaA8mCwPnDF9hNXQFQyNEekHr1Gs1mIC4JFKlyCAxU1yaGFm2tkHNCg14ZmLU4Q==
X-Received: by 2002:a1c:66d5:: with SMTP id
 a204mr16198827wmc.134.1591623111104; 
 Mon, 08 Jun 2020 06:31:51 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 j190sm22821770wmb.33.2020.06.08.06.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 06:31:50 -0700 (PDT)
Date: Mon, 8 Jun 2020 09:31:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 0/4] microvm: memory config tweaks
Message-ID: <20200608093125-mutt-send-email-mst@kernel.org>
References: <20200529073957.8018-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200529073957.8018-1-kraxel@redhat.com>
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org, imammedo@redhat.com,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 09:39:53AM +0200, Gerd Hoffmann wrote:
> With more microvm memory config tweaks split this into its owns series,
> the microvm acpi patch series is already big enough ...

Looks sane:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

microvm things so should use that tree ...

> v2:
>  - use 3G split.
>  - add patch to move virtio-mmio region.
>  - pick up acks & reviews.
> v3:
>  - fix xen build.
>  - pick up acks & reviews.
> 
> take care,
>   Gerd
> 
> Gerd Hoffmann (4):
>   microvm: use 3G split unconditionally
>   microvm: drop max-ram-below-4g support
>   x86: move max-ram-below-4g to pc
>   microvm: move virtio base to 0xfeb00000
> 
>  include/hw/i386/microvm.h |  2 +-
>  include/hw/i386/pc.h      |  2 ++
>  include/hw/i386/x86.h     |  4 ----
>  hw/i386/microvm.c         | 35 +----------------------------
>  hw/i386/pc.c              | 46 +++++++++++++++++++++++++++++++++++++++
>  hw/i386/pc_piix.c         | 10 ++++-----
>  hw/i386/pc_q35.c          | 10 ++++-----
>  hw/i386/x86.c             | 46 ---------------------------------------
>  hw/i386/xen/xen-hvm.c     |  2 +-
>  9 files changed, 61 insertions(+), 96 deletions(-)
> 
> -- 
> 2.18.4


