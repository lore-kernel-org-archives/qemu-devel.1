Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A290C10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D3F22522
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6UzwGb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D3F22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA9Do-0006wO-5k
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 04:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jA9D6-0006Lw-Mt
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jA9D5-0005ee-BP
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:24:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39711
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jA9D5-0005ce-3y
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583486638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtVK4BFDHb7p+oiNFUrphKF7XMZoZh2XSFGhvTVLTls=;
 b=G6UzwGb4wnXsg3JR66YOuBCPY5/q+Cw39UpRGEHjRffJNjgWIf81De8yVCz0gzi6Qn9lOL
 3NUP9X76bJ+fIVsbegmOAUeS/QjTGpaZmcW5zzDyCjPEVNWoWyb4R27qsUqzRr5UXdJZDd
 B4qoOBy3zl6Z5QOdXU94NWD7Bu3Wotw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-q-RC2yzpPF2lWHQXcoXbpw-1; Fri, 06 Mar 2020 04:23:56 -0500
X-MC-Unique: q-RC2yzpPF2lWHQXcoXbpw-1
Received: by mail-wr1-f70.google.com with SMTP id o9so741376wrw.14
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 01:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QBsVmMlrTGuubKxpYEy/Asmz1QzMkBk1urMD4D5nG00=;
 b=bCUUxF8j+FisQHl//ScL9F0mKGDl3WhZ7FYcXxX3sjmK06z0WrwZ47KRJicY88HZG4
 N4rFYNxPw6IpbYCLCgvo5O2CKPAgcJ+DmXLWRQMHMoL3wNqU5q7n09cPjh09oyyP+jBM
 Dhow/MA7lCq5dXO7ZsZRAZXskFzqqfwUlMfG173genNtlVWvOYX0frBZl9JAq11hbVEJ
 vzCi0huwpjvtED4SkNL7jJNOLksp4H32yTs/WA+O8A7OvdCandr0lSfP1IF9minV3AYt
 +4PJ3mElMsswD+Z6BzJWMilWeuQf6u4q31sdfUsel9Gx0HpfKIebonjup7hyJqI8Kkjx
 T2jQ==
X-Gm-Message-State: ANhLgQ18tK6CUGzSzo4grST/ja4ePweLeuR9ghMTq1wfpUNetmIkBlPb
 tkvbO7obVxQmD/qIGpnZABfz1cyQw1w44ijerJaTJNImm3YhtrlvnTiE2ys5o0KYk/Dh6IIp20P
 ET6fJJqwHHVM0sfk=
X-Received: by 2002:adf:f84d:: with SMTP id d13mr3136965wrq.92.1583486635528; 
 Fri, 06 Mar 2020 01:23:55 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtpFfwSkj6fMSCmjD72ZBzEe3exxjVpuLjiviqv9KguC8pDOIraaNAi1PGwP1f0erjco+hf8w==
X-Received: by 2002:adf:f84d:: with SMTP id d13mr3136938wrq.92.1583486635244; 
 Fri, 06 Mar 2020 01:23:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b99a:4374:773d:f32e?
 ([2001:b07:6468:f312:b99a:4374:773d:f32e])
 by smtp.gmail.com with ESMTPSA id c16sm19382376wrm.24.2020.03.06.01.23.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 01:23:54 -0800 (PST)
Subject: Re: [PATCH 0/2] Makefile: Re-indent 'help' target and list tools
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200305004855.9665-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1685d5d-9e74-4674-7e38-d3a0c618face@redhat.com>
Date: Fri, 6 Mar 2020 10:23:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305004855.9665-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/03/20 01:48, Philippe Mathieu-Daud=C3=A9 wrote:
> This series improves the 'make help' output:
> - re-indent current output
> - list tools targets:
>=20
>     $ make help
>     [...]
>=20
>     Architecture specific targets:
>       x86_64-softmmu/all             - Build for x86_64-softmmu
>=20
>     Tools targets:
>       qemu-ga                        - Build qemu-ga tool
>       qemu-keymap                    - Build qemu-keymap tool
>       elf2dmp                        - Build elf2dmp tool
>       ivshmem-client                 - Build ivshmem-client tool
>       ivshmem-server                 - Build ivshmem-server tool
>       qemu-nbd                       - Build qemu-nbd tool
>       qemu-img                       - Build qemu-img tool
>       qemu-io                        - Build qemu-io tool
>       qemu-edid                      - Build qemu-edid tool
>       fsdev/virtfs-proxy-helper      - Build virtfs-proxy-helper tool
>       scsi/qemu-pr-helper            - Build qemu-pr-helper tool
>=20
>     Cleaning targets:
>       clean                          - Remove most generated files but ke=
ep t=3D
> he config
>       distclean                      - Remove all generated files
>       dist                           - Build a distributable tarball
>=20
> Philippe Mathieu-Daud=3DC3=3DA9 (2):
>   Makefile: Align 'help' target output
>   Makefile: Let the 'help' target list the tools targets
>=20
>  Makefile | 49 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 21 deletions(-)
>=20
> --=3D20
> 2.21.1
>=20

Queued, thanks.

Paolo


