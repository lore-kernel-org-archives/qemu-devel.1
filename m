Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FDEC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26BA2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26BA2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxCqc-00022p-2M
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 12:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxCqE-0001c1-7K
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxCqD-0002m7-6J
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:06:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxCqD-0002ln-0j
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:06:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so52454wmc.4
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 09:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9K+EYzTj0XKxZbE5QO/IWPMlb51gCV1XwARiAD6jop4=;
 b=sCTqyu7WaZZjTOL530QVbuX6AUmKPc2fm2t33rzprUhPPL8frCwSYUuTMFeNNcT1tk
 6sfSiaraT43YK3lcmMYgby3AErrXWjw60i4td+OSHzaOD76p5JeqPSTx7tlodRFJCMXo
 PCSM0AUqjpYyZQQ15eGDhCRPqTavN4lNI4o7+uOmFn/9c+HJRNTRWPqWsPkqKK8ZyHkP
 SClEPoKB5ZU1bwhCE/JQRqLdlG3bnlscZIyJ75TW9YBDI8p/CeV6ugEYzV8YCLtNunGY
 bJka4XI0neFk0/4wcya51XwTCFYwutmaf0QWdLiOMLgBWRuPa7tHq8Kv0dT/mAJxelfA
 EOTA==
X-Gm-Message-State: APjAAAXjSKdiasr31uldcsnIoQH+33zbeOsVoFxSjCnbq7jbJxOn4my4
 ZwWd5IfJmxw4/4YZgNrVUs7gMxUXIq0=
X-Google-Smtp-Source: APXvYqx4S555fd1Q1fIkrWlyxhJU+cB5O8+X+/MVMB8msSUE6qIF0LbIrvYZFWW0O1hZEhIFAQHDWw==
X-Received: by 2002:a1c:a70d:: with SMTP id q13mr68720wme.26.1565625995733;
 Mon, 12 Aug 2019 09:06:35 -0700 (PDT)
Received: from [192.168.1.34] (59.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.59])
 by smtp.gmail.com with ESMTPSA id o7sm451wmc.36.2019.08.12.09.06.34
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 09:06:35 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190812052359.30071-1-armbru@redhat.com>
 <20190812052359.30071-29-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cdb0ecbd-95d1-8a75-0473-104dcbc6f209@redhat.com>
Date: Mon, 12 Aug 2019 18:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190812052359.30071-29-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v4 28/29] sysemu: Move the
 VMChangeStateEntry typedef to qemu/typedefs.h
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/19 7:23 AM, Markus Armbruster wrote:
> In my "build everything" tree, changing sysemu/sysemu.h triggers a
> recompile of some 1800 out of 6600 objects (not counting tests and
> objects that don't depend on qemu/osdep.h, down from 5400 due to the
> previous commit).
> 
> Several headers include sysemu/sysemu.h just to get typedef
> VMChangeStateEntry.  Move it from sysemu/sysemu.h to qemu/typedefs.h.
> Spell its structure tag the same while there.  Drop the now
> superfluous includes of sysemu/sysemu.h from headers.
> 
> Touching sysemu/sysemu.h now recompiles some 1100 objects.
> qemu/uuid.h also drops from 1800 to 1100, and
> qapi/qapi-types-run-state.h from 5000 to 4400.

Nice :)

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/usb/hcd-ehci.h           | 1 -
>  include/hw/ide/internal.h   | 3 ++-
>  include/hw/ppc/spapr_xive.h | 1 -
>  include/hw/scsi/scsi.h      | 1 -
>  include/hw/virtio/virtio.h  | 1 -
>  include/qemu/typedefs.h     | 1 +
>  include/sysemu/sysemu.h     | 1 -
>  hw/block/vhost-user-blk.c   | 1 +
>  hw/block/virtio-blk.c       | 1 +
>  hw/display/virtio-gpu.c     | 1 +
>  hw/misc/macio/macio.c       | 1 +
>  hw/net/virtio-net.c         | 1 +
>  hw/s390x/s390-ccw.c         | 1 +
>  hw/s390x/s390-virtio-ccw.c  | 1 +
>  hw/scsi/scsi-bus.c          | 1 +
>  hw/scsi/vhost-scsi.c        | 1 +
>  hw/scsi/vhost-user-scsi.c   | 1 +
>  hw/usb/hcd-ehci.c           | 1 +
>  hw/virtio/virtio-rng.c      | 1 +
>  hw/virtio/virtio.c          | 1 +
>  vl.c                        | 6 +++---
>  21 files changed, 19 insertions(+), 9 deletions(-)

