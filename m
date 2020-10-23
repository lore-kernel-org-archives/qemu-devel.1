Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557A0C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6AB2192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0z4ysMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6AB2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVura-0008HN-Ir
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 07:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVupM-0007LG-Bt
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVupI-0002Yg-UU
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603450899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PvoB5wXGezv8epvQZdnuV9fA1HDSoEYAe4byGWWcguY=;
 b=R0z4ysMttt/c8TdAS0EpY1XTYwxRYJWzU2c6Joc1OKRg95UFZrF8q9z3gzccL/b/ftrjpe
 S90Ly5ixVD/oN2MrmEpU4kZ0obsKY5wqljuMUgnHJAuvZ7YR5eSfU4dphaGKC2y6tW2boG
 fIrhHlpUA4pN4OgRJ8FgbL/BSsG7gPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-gdTY8utXP3ynUwIEa3SC-Q-1; Fri, 23 Oct 2020 07:01:37 -0400
X-MC-Unique: gdTY8utXP3ynUwIEa3SC-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E687F107B470;
 Fri, 23 Oct 2020 11:01:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C7925D9DC;
 Fri, 23 Oct 2020 11:01:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B3EEB204A1; Fri, 23 Oct 2020 13:01:35 +0200 (CEST)
Date: Fri, 23 Oct 2020 13:01:35 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 1/2] virtio-gpu: add virtio-gpu-pci module
Message-ID: <20201023110135.lrjq5mqvma4fzavi@sirius.home.kraxel.org>
References: <20201023064618.21409-1-kraxel@redhat.com>
 <20201023064618.21409-2-kraxel@redhat.com>
 <CAJ+F1CK0A1+vOMZq55guJi9OPg1zyVyRQ_azYA7NNVg5Kx5hDA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CK0A1+vOMZq55guJi9OPg1zyVyRQ_azYA7NNVg5Kx5hDA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> Hmm, I realize we have a different behaviour when building devices as
> modules shared by different qemu system binaries.
> 
> It will attempt to load any kind of modules:
> 
> ./qemu-system-m68k  -kernel ~/Downloads/vmlinux-5.8.0-3-m68k  -device
> virtio-gpu-pci
> Failed to open module:
> /home/elmarco/src/qemu/buildnodoc/hw-display-virtio-gpu-pci.so: undefined
> symbol: virtio_instance_init_common
> qemu-system-m68k: -device virtio-gpu-pci: 'virtio-gpu-pci' is not a valid
> device model name

Yes.  The last line is printed for non-modular builds too.
The module load error can obviously only happen on modular builds.

> $ qemu-system-m68k -device help
> Failed to open module: /usr/lib64/qemu/hw-usb-smartcard.so: undefined
> symbol: ccid_card_send_apdu_to_guest
> Failed to open module: /usr/lib64/qemu/hw-display-qxl.so: undefined symbol:
> vga_ioport_read

That one is fixed meanwhile:

commit 501093207eb1ed4845e0a65ee1ce7db7b9676e0b
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Wed Sep 23 11:12:17 2020 +0200

    module: silence errors for module_load_qom_all().

take care,
  Gerd


