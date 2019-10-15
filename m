Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4831C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 11:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A8A21848
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 11:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A8A21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKL8n-0004tm-FU
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 07:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKL7i-0003Yp-PP
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKL7g-0000yI-Lt
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:36:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKL7g-0000y7-Dn
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:36:16 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 691BB757C8
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 11:36:15 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id q9so8525406wmj.9
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 04:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CO+WPAn61IG9hwrU8hW/EXIVcQ6h0JKuGP8yRLmYJ3w=;
 b=N6IImGbxNAqpxNENhXaFiOGuozB60zfaxGMw6CJwwas7sD7SDeXONDv4D1pgPXZ4l3
 2WTH8IXptt5ob/UFCLuscKCnLX/MAbfvW5k94JmnEui+cSKhL2vY1KmAkmrnkE3EL6Cz
 l0LNE5ALCfwaDTWhRrpxkQ3qwpLmUXUYW+rpBKDGgCaqOWFj7pSCwebPxV1qJzZFE8HJ
 Yrs3RoQGsK/O6bPxW+nN1vza7pl2F0vvUko5vyj1roa0jWYt7bRVPvY+R7M4Q/B48rP2
 IPV+EbwV07fHkuXYEKb0DOvPUcSt/Qx6V+fT4liq6nFq8OX1SHFq39Su2IE7GC0m8kYz
 4K/w==
X-Gm-Message-State: APjAAAUWyuCVcWyNtOmxRgOncwDgIW6a+gKhqREyQ/uoEL2llnj6ftNc
 vpTtSodO4FHac0WI9DrejfRDWUVFlP84BB7/LtGCNBoxxcTvxlhN9NpRajfY20v+cfwXv1RAtRu
 S9HUsW6G4HzXgWMg=
X-Received: by 2002:a1c:750d:: with SMTP id o13mr18523676wmc.140.1571139371809; 
 Tue, 15 Oct 2019 04:36:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwz5ZLOulfFtXErF2sIS1oWfdE7kmKTG0NkYJ+HCUontbi4aQEjd5roKZkAWXy/3VmFOvo5SQ==
X-Received: by 2002:a1c:750d:: with SMTP id o13mr18523649wmc.140.1571139371579; 
 Tue, 15 Oct 2019 04:36:11 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id t11sm5774425wmi.25.2019.10.15.04.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2019 04:36:10 -0700 (PDT)
Subject: Re: [PATCH v9 04/15] hw/i386/pc: replace use of strtol with
 qemu_strtol in x86_load_linux()
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
References: <20191015112346.45554-1-slp@redhat.com>
 <20191015112346.45554-5-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b7baa2ab-210b-e7ef-399e-4dbbbc0ee0aa@redhat.com>
Date: Tue, 15 Oct 2019 13:36:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191015112346.45554-5-slp@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sergio,

On 10/15/19 1:23 PM, Sergio Lopez wrote:
> Follow checkpatch.pl recommendation and replace the use of strtol with
> qemu_strtol in x86_load_linux().

"with qemu_strtoui"

>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>   hw/i386/pc.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 77e86bfc3d..c8608b8007 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -68,6 +68,7 @@
>   #include "qemu/config-file.h"
>   #include "qemu/error-report.h"
>   #include "qemu/option.h"
> +#include "qemu/cutils.h"
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/cpu_hotplug.h"
>   #include "hw/boards.h"
> @@ -1202,6 +1203,7 @@ static void x86_load_linux(PCMachineState *pcms,
>       vmode =3D strstr(kernel_cmdline, "vga=3D");
>       if (vmode) {
>           unsigned int video_mode;
> +        int ret;
>           /* skip "vga=3D" */
>           vmode +=3D 4;
>           if (!strncmp(vmode, "normal", 6)) {
> @@ -1211,7 +1213,12 @@ static void x86_load_linux(PCMachineState *pcms,
>           } else if (!strncmp(vmode, "ask", 3)) {
>               video_mode =3D 0xfffd;
>           } else {
> -            video_mode =3D strtol(vmode, NULL, 0);
> +            ret =3D qemu_strtoui(vmode, NULL, 0, &video_mode);
> +            if (ret !=3D 0) {
> +                fprintf(stderr, "qemu: can't parse 'vga' parameter: %s=
\n",
> +                        strerror(-ret));

(Cc'ing Markus/Daniel just in case)

I'm wondering if using fprintf() is appropriate, thinking about=20
instantiating a machine via libvirt, is this error reported to the user?

I first thought about using error_report() instead:

     error_report("qemu: can't parse 'vga' parameter: %s",
                  strerror(-ret));

But this API is meaningful when used in console/monitor. We can't get=20
here from the monitor, so:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +                exit(1);
> +            }
>           }
>           stw_p(header + 0x1fa, video_mode);
>       }
>=20

