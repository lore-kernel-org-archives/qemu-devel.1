Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3387BC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0867A2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0867A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClTN-0001qX-EK
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iCko1-0004P2-2Q
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iCknz-00006l-Jm
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:24:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iCknz-00006J-CO
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:24:35 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B2D6A89AC5
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 13:24:33 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id 59so1920810qtc.5
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gyt+QtSY5LxRkStjts+Gw8hS4n9Wq+3XVX5S1gdnFC4=;
 b=WoqCqHu8bqwGXIGfdahNujetc7yzekI9dJuzQb/u2sOYD6wi3LqkwgaXMk1v2KnuLY
 u9TrNOb1sIKbDLba6DHMEntfzVhd7ZaqiD7mxj2wqeOQ219YZDKssptalA/wtuNg4fc6
 MOG/+xmb+RdwKbd7TkI5S6ehQHhR/Bt3NUZWDUoxWs7znQEOHENaFvXeifrw698KdetK
 hC9So5FIiu+4lzm+pS3umQvb+TdbH2hCBAGJEk2JM0s2nHxzY/GCA6W20vh52hB/JuhT
 Lgl+C+jQKJ8LbB60a/cdWHQt174MbspW4NJP5cz4LNujSZa3w4ftqv7i6nforKZ+w3Pv
 kb0Q==
X-Gm-Message-State: APjAAAXULyf3/yScpIphCHnFL82oMQhKBVV6cwNYILSfuThmCHCQXbBB
 3V2pFdOMqGDMuQqu+ZNjflpwwsmiqAdyScOKXD7i0UvhWod0ioteXpKEKhgjsphnxqzjvMTnfP7
 oJVXYh3OHUDxuGuk=
X-Received: by 2002:a37:660c:: with SMTP id a12mr2363532qkc.70.1569331473093; 
 Tue, 24 Sep 2019 06:24:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxjgG8mfpqiiLRQUIWFSVWiG7TgSKvyHkDPLEqT5ZrVuaG6L/jb1qOCc2tNCJVI59lHt67jZA==
X-Received: by 2002:a37:660c:: with SMTP id a12mr2363507qkc.70.1569331472881; 
 Tue, 24 Sep 2019 06:24:32 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id v5sm1157556qtk.66.2019.09.24.06.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 06:24:32 -0700 (PDT)
Date: Tue, 24 Sep 2019 09:24:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 8/8] hw/i386: Introduce the microvm machine type
Message-ID: <20190924092222-mutt-send-email-mst@kernel.org>
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-9-slp@redhat.com>
 <2cbd2570-d158-c9ce-2a38-08c28cd291ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cbd2570-d158-c9ce-2a38-08c28cd291ea@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>, lersek@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 kvm@vger.kernel.org, imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 03:12:15PM +0200, Paolo Bonzini wrote:
> On 24/09/19 14:44, Sergio Lopez wrote:
> > microvm.option-roms=bool (Set off to disable loading option ROMs)
> 
> Please make this x-option-roms

Why? We don't plan to support this going forward?

> > microvm.isa-serial=bool (Set off to disable the instantiation an ISA serial port)
> > microvm.rtc=bool (Set off to disable the instantiation of an MC146818 RTC)
> > microvm.kernel-cmdline=bool (Set off to disable adding virtio-mmio devices to the kernel cmdline)
> 
> Perhaps auto-kernel-cmdline?
> 
> Paolo

