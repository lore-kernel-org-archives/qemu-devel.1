Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EB7C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 20:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6592089E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 20:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBGz7t8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6592089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyM72-0007B1-MZ
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 16:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1hyM6N-0006l5-SN
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 16:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hyM6L-0005xd-Gb
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 16:12:03 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:39167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hyM6L-0005xG-C7
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 16:12:01 -0400
Received: by mail-qk1-x742.google.com with SMTP id 125so2861257qkl.6
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZHKbK//yD5FjCNY0JuTB2bcbkyE0ej63ioowkBQzhxY=;
 b=TBGz7t8GLzdar0z8XefGtg/KFPs9hvsS9fY6XPgYkViA48zqaspgO2egZpL5FGxRyR
 A1RYnM1jEwDQJX+pJBgxQnbS4QoyIh5nssSDWoY93BnVveEg9TS4YV5kEZ64etsnihnP
 vW0N+ZALpg+ytzNGF0YU/KcphG4SBdUofw6l5Yh+KOs4N/OZkN3zUHu+9tL9t/6Vr9wo
 T4IEoU95lPzdOo+PrnE+Abwsfrck1yJierltTOm6gELGH6fAZ0kkz1C38uhtG3cgVZcF
 HIgMfv7YcOsFQ0VvtiPzQwBCo16Ig4PM8BYUfpIVym03X860B9m9Xr06v4ITW8kdCzwZ
 DGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZHKbK//yD5FjCNY0JuTB2bcbkyE0ej63ioowkBQzhxY=;
 b=SP8NsFslDp5zMFDytGv2z8kr8hJoafMYqRKNg4FzU5b29bkIyBX7bew/ayTQJo2kPM
 /AkMd5pyfp8t34XbVmC3dGaAzUD7rSYwgEEMGQk40ipG8PHuoyYmdhvH9yeIi2SHVB6R
 2gxBRZZnmACxzAlnZvMBQ7nwJl7EWeS0Kv2sw2zGx7I429NxiQPLfJtpjnzFAqrP1KCB
 rEUKBDaqk7GE5WARwD8qc3PQgG2SwXaRdq3yRMsO/sDUS8Kd+i3nRFky3HURDMXgJLJc
 cJplHH9X/Ppa96iiintPji+eHd1LnBjvH6G7MLdAiioKRAF/vN5go9DDllZr+6hLkBpQ
 H8dA==
X-Gm-Message-State: APjAAAVBclRwDdFoX4y77T7jAGAl/xROjBVXQpOqxhKUKJtbFbNueBT7
 sKfqy+VWleL3v27N06ZbSYyrc9mFkfZr//zKL3Y=
X-Google-Smtp-Source: APXvYqzD+6Q8A+FK9onnfhEbR6SA+ghuiVx+/Jfl51n1N6MErrwZibR7n+V+ygVEFiD/na8MdEoW15/nIiyDX8HlyQc=
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr5702590qkb.394.1565899920490; 
 Thu, 15 Aug 2019 13:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190815183803.13346-1-ehabkost@redhat.com>
 <20190815183803.13346-3-ehabkost@redhat.com>
In-Reply-To: <20190815183803.13346-3-ehabkost@redhat.com>
From: Vanderson Martins do Rosario <vandersonmr2@gmail.com>
Date: Thu, 15 Aug 2019 17:11:49 -0300
Message-ID: <CAMzYVD1CiUehHxzHf=PgxqFFZNvLmTPLuo+VzqeE0nKMxR5+hw@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 2/3] pc: Improve error message when die-id
 is omitted
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
Cc: Peter Krempa <pkrempa@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>

Vanderson M. Rosario


On Thu, Aug 15, 2019 at 3:43 PM Eduardo Habkost <ehabkost@redhat.com> wrote:

> The error message when die-id is omitted doesn't make sense:
>
>   $ qemu-system-x86_64 -smp 1,sockets=6,maxcpus=6 \
>     -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0
>   qemu-system-x86_64: -device
> qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0: \
>     Invalid CPU die-id: 4294967295 must be in range 0:0
>
> Fix it, so it will now read:
>
>   qemu-system-x86_64: -device
> qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0: \
>     CPU die-id is not set
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/i386/pc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 24b03bb49c..fb4ac5ca90 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2410,6 +2410,10 @@ static void pc_cpu_pre_plug(HotplugHandler
> *hotplug_dev,
>              error_setg(errp, "Invalid CPU socket-id: %u must be in range
> 0:%u",
>                         cpu->socket_id, max_socket);
>              return;
> +        }
> +        if (cpu->die_id < 0) {
> +            error_setg(errp, "CPU die-id is not set");
> +            return;
>          } else if (cpu->die_id > pcms->smp_dies - 1) {
>              error_setg(errp, "Invalid CPU die-id: %u must be in range
> 0:%u",
>                         cpu->die_id, pcms->smp_dies - 1);
> --
> 2.21.0
>
>
>
