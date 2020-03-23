Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CEEC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C63720781
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxNgXO9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C63720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKyl-0007ib-4e
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jGKy3-0007CZ-M7
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jGKy2-0006a7-JM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:10:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32786)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jGKy2-0006a2-FG
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584961802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvNjm/mqUpJ9xAK3azuVBFh+cNYOrYYr6uFWvRECuF4=;
 b=hxNgXO9Wnzs0Hvi+pwf6bwwMRmuYYaWQ/TGBGkvFsXdRNA5PUH01n2KxI7THbQ488GuiVg
 /nI5LlOOtDeJp+4me8vH5vRozoPH5nQuuBWAEpFY19TRayoCrupz8YnEjFvUNjMa8TyLrH
 O3tvDRXBeY6+dLukWkPOovHsNYiiPlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-NRTl9M1aNDKkVYhgcmmy7Q-1; Mon, 23 Mar 2020 07:09:58 -0400
X-MC-Unique: NRTl9M1aNDKkVYhgcmmy7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4760C477;
 Mon, 23 Mar 2020 11:09:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B863819C70;
 Mon, 23 Mar 2020 11:09:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DE76017449; Mon, 23 Mar 2020 12:09:55 +0100 (CET)
Date: Mon, 23 Mar 2020 12:09:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paul Zimmerman <pauldzim@gmail.com>
Subject: Re: [PATCH 0/6] dwc-hsotg (aka dwc2) USB host contoller emulation
Message-ID: <20200323110955.mpgbtvp6qoobq5hz@sirius.home.kraxel.org>
References: <20200322222726.10244-1-pauldzim@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200322222726.10244-1-pauldzim@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, jsnow@redhat.com,
 f4bug@amsat.org, stefanha@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> 1) I have used printf-based debug statements while developing the
>    code, and have not implemented any tracing statements. I'm not
>    sure if that is considered acceptable for new code?

Please use tracepoints.  I'd suggest to use the "log" trace backend
which comes very close to printf-debugging; effectively all trace
points are turned into runtime-switchable printf's.

Mixing (temporary) debug printfs and tracepoints works.

> 2) I have imported the register description file from the Linux
>    kernel. This file is licensed GPL-2 only, is this OK?

Yes.  There even is a script to keep things in sync and apply some
tweaks like replacing linux kernel types with standard C types
(s/u32/uint32_t/ etc).

See scripts/update-linux-headers.sh

You might consider hooking up your file there, but probably this is
overkill given that the register descriptions are unlikely to see
frequent updates.

> 3) The emulation does not respect the max-packet size when
>    transferring packets. Since the dwc-hsotg controller only has
>    one root port, and the Qemu USB hub is only full-speed, that
>    means every device connected has to run at full speed. That
>    makes mass-storage devices in particular run very slowly. Using
>    transfers greater than max-packet size alleviates this. Is this
>    OK? I think the EHCI emulation does the same thing, since its
>    transfers seem to run at greater than real world transfer rates.

I don't think ehci uses larger packets.  I think it simply does more
transfers than physical hardware would be able to do.

uhci is pretty strict here, it counts bytes transfered and simply stops
processing queues when it has transfered enough data for the current
frame.  On the next frame timer tick it resumes work.  There is a
bandwidth=3D property to tweak the transfer limit, you can use that to
make uhci emulation run at the speed you want ;)

ehci and xhci simply don't count bytes and don't have a limit, they go
process queues as long as there is work to do (and they don't have to
wait for host block I/O).

> 4) I have only implemented host mode for now. Would there be any
>    benefit to implementing gadget mode as well? It seems it could
>    be useful to emulate gadget devices in Qemu, but I am not sure
>    if Qemu currently offers any support for that?

No, there isn't any gadget support yet.

cheers,
  Gerd


