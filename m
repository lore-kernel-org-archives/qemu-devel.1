Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11373C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA88321721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFJumeMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA88321721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafkM-0004cl-1U
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iafeU-00009t-Rm
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iafeS-0005Vq-RW
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:45:38 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:38829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iafeF-0005GD-B2
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:45:28 -0500
Received: by mail-oi1-x235.google.com with SMTP id a14so25974426oid.5
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GykbMelGlwlX8WRaocx9HMeCFyPIwcWqRXoTX3pvRFU=;
 b=iFJumeMPqEZlR7biGOIT+Ja1XJCCIT32rNfE9N8rlIMjB3X2pAU5aJVdiEUXOPoXca
 oc3mCwdoGotBT1aRyvzy+KmT+B6aDqqbHbGIjSQnDi+j7Wo4DxfTP0wE19VsBrH5/ZIo
 T5ph4ZcITaA0lIAobb3ec1bTw+UNUBYk7xciKbforqlHvpyk/x9Y4aOT2LQYxAmZRKML
 4HdJY6gspAcl5sL7vdxXTXxKLiwhZFP74IE/OMufpw1FSIv2JpfoGMI7iPhiSdCrdmzJ
 ZC1NtDwja7wgRqyrFn/PMGfosAz+ltH6b58ZkptDr4qubDoHe6xb7iFQsF5TgwQi7euB
 orqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GykbMelGlwlX8WRaocx9HMeCFyPIwcWqRXoTX3pvRFU=;
 b=O953+63JkOGik3hiT93G3GxGeCSaa9q839ltiyqBRPQ5O74k3SH2S+LdokW2879hxc
 ORgmZDlkxfVeH4kpirqIzi8mA98kKOs5YqbDPykqmuBB0dfOfGwVU4u6gdkgorTtyLxZ
 /VhUnGm3tHP831p0W3U7I4K92ZmWDyhrSOXM/CbpRJFSZJrIyCzw3bN4UnPYaD0xEB32
 5hNOo0M+HBiAlrbxuz16XWbbtAAD1vj+goCqUThbZhVDJBKe58UoYHI7qppfUcL7sh8x
 6mChFPMLoG0t4eOd6KN8N5JXBEvpGmt8sVl8WZhFPLKzaaRSeAoD8Et7eyHyi/XGu3Up
 UP3w==
X-Gm-Message-State: APjAAAXuatpihHjYQjw/O7gke9P9BQul9a22+RgUVeCZplp0RfTWIjUS
 uUICTgNBJ14/Rh4D4vofhFdUTAEkTqu2NiRrzsifeA==
X-Google-Smtp-Source: APXvYqwQUYaJksTKJ+ZOXIX4nRoaTKBNmB5tRVpWTZBqcTplbCzVoa8UCUkeKN5BPsnBgS+4Gwko/CyNASlPHBCn9x8=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr629348oih.98.1575031520929; 
 Fri, 29 Nov 2019 04:45:20 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA9E-Z-RPwFsAiz9Pi3_MtBUFEU7enJFVrpOQ7UKW8e1DQ@mail.gmail.com>
 <20191128182705.0635d1d4@redhat.com>
 <CAFEAcA-qA6n49KdHsGLqt422L_b_9xPfSaJB3tATQvRdfKt-xw@mail.gmail.com>
 <20191129132641.4c7da6c5@redhat.com>
In-Reply-To: <20191129132641.4c7da6c5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 12:45:09 +0000
Message-ID: <CAFEAcA_gcxqu+N5iV0L5WLyWmm5yxTFNMtmqQryBgVd4CCCT8A@mail.gmail.com>
Subject: Re: qom device lifecycle interaction with hotplug/hotunplug ?
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 at 12:26, Igor Mammedov <imammedo@redhat.com> wrote:
> But from the my very limited understanding, on real hardware,
> once device is uplugged it's gone (finalized) from machine
> perspective, so it's unclear to my why someone would use
> realize->unrealize->realize hotplug scenario.

Well, on real hardware 'unplug' is different from 'unrealize'.
So I think for QEMU if we wanted to allow this sort of 'unplug
and replug the same device' we should do it by:

 instance_init -> realize -> plug -> unplug -> plug -> unplug ->
   unrealize -> finalize

So unrealize/finalize is when the device is actually destroyed,
and if you're going to replug the device you don't destroy it
on unplug.

thanks
-- PMM

