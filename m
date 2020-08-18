Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ADEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 08:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E910206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 08:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SBIH624Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E910206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7wua-0005pE-MY
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 04:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@amarulasolutions.com>)
 id 1k7wu1-0005Fv-SK
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 04:23:30 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@amarulasolutions.com>)
 id 1k7wtz-000229-8C
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 04:23:29 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so17414194wrw.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QI58JgN3jn/WkuIJshc9tL1XFTcqRMcJuei4GSMSxKs=;
 b=SBIH624Y7/M7JGCQmhdE3njRJSSRmvVAdFVfU8wmyE2sT4NdX5hVWGktBu7Q/4D4jD
 FVD2s08olNpqipdogcIDoFk/oDJfPWZZK8xGACyRY4s9hHyOtZjgJIhBxVXe38FQwfHz
 omWn7vDQ6z/vz9dtgzEmQOOZfkQmnZAa6H/sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QI58JgN3jn/WkuIJshc9tL1XFTcqRMcJuei4GSMSxKs=;
 b=ZhoIniNdvk8FAKzXuSPBWFB7ERNd3JC/+ZRyv+7EyUfujJ7egy1PtCblhHL8kE8C3W
 wXTM2Nvh17xDcWdyi1/1NcA0iOpDfZa2EnUHrjrhMl3E4QwK7hxuj+UckHyJ2CP1bIkH
 ShyAjztz8nADetNx0RpmK0MdhLqlkK3AdEueBOulI8D5J5+9Goxy8MTIhQBEuWd3XsvM
 Wtp3FnKzqeyHyxXmCE+d358Ri94ksJ2jfniVgmvrf4Cb1e67MaeZELYwtQRhYlqhH2II
 tMsmhklEH0gxrFR5TBcXONQFmEQj4CpYQJNNvh7y5lY37YJW+z+UGwViYI/rb8jgIwA5
 lVpA==
X-Gm-Message-State: AOAM533dcCX3c58/m8/dryQOeMeAOd3RzMj3E52AwF96C4T0rnSTPHHu
 bjXMWYNxpkSSQn96wnLJWmIA0xesB5UZZB4BkjXlVQ==
X-Google-Smtp-Source: ABdhPJxByyVd5HNxUjFrl4ON0PymPgcNu6wVI4+0SqVgVfxXsgN7oVUSMINjWLrN2bGrAJUK4uxE3qGa8joDPeGYreY=
X-Received: by 2002:a5d:6589:: with SMTP id q9mr5742669wru.383.1597739004473; 
 Tue, 18 Aug 2020 01:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200812152149.260163-1-michael@amarulasolutions.com>
 <20200817064701.o3q3plnjhzyz3s42@sirius.home.kraxel.org>
 <CAOf5uwn94gZPZXChFDXWZ-1w0jOY_SxRqzF4Mk8hrtLq-r3yCg@mail.gmail.com>
 <20200817072841.lvbco4k7hzzimxsb@sirius.home.kraxel.org>
 <CAOf5uwn2KAajFo7oXYkZg5q3jbJyRC50hJafcoWCVzrdvkqXMw@mail.gmail.com>
 <20200818060214.z2irps623upmbe2w@sirius.home.kraxel.org>
In-Reply-To: <20200818060214.z2irps623upmbe2w@sirius.home.kraxel.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 18 Aug 2020 10:23:13 +0200
Message-ID: <CAOf5uwmKuRGf1F6SouBXcGTmErgCL=CL2RwL=CBbK0SkvOSH2Q@mail.gmail.com>
Subject: Re: [PATCH] hw: dev-wacom: Support wacom tablet emulation in linux
 qemu
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=michael@amarulasolutions.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Aug 18, 2020 at 8:02 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Mon, Aug 17, 2020 at 06:42:02PM +0200, Michael Nazzareno Trimarchi wrote:
> > Hi Gerd
> >
> > Have another small question. Do you know how force show cursor working
> > in this case?
>
> Which display and which vga do you use?

/usr/bin/qemu-system-i386 -M pc \
-enable-kvm -cpu host \
-m 1024 \
-vga std \
-global VGA.vgamem_mb=4 \
-kernel out/w_and_h_emulator/images/bzImage \
-drive file=out/w_and_h_emulator/images/rootfs.ext2,if=virtio,format=raw \
-append "root=/dev/vda console=" \
-net nic,model=virtio \
-net user,hostfwd=tcp::22222-:22,hostfwd=tcp::10000-:10000,hostfwd=tcp::10001-:10001
\
-usb -device usb-wacom-tablet \
-usb -device usb-host,vendorid=0x04d8,productid=0x000a -show-cursor

But I need to use the framebuffer. So what happens for instance in
software like ts_calibrate you can not see the cursor

Michael
>
> take care,
>   Gerd
>


-- 
Michael Nazzareno Trimarchi
Amarula Solutions BV
COO Co-Founder
Cruquiuskade 47 Amsterdam 1018 AM NL
T. +31(0)851119172
M. +39(0)3479132170
[`as] https://www.amarulasolutions.com

