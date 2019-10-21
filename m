Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3296CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD062089C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMRnZ6zT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD062089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVxL-0000FH-1N
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMVo2-0005xU-H0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMVo1-00023X-8t
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:24:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59579
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMVo1-00023J-5U
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571657096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpsWai1ZT6Q7AvH7o7WuAKnUIHrC4dtS+Wo+VEpDVeA=;
 b=WMRnZ6zTRbh6iZK9k4yQsDff298XEeO7swHjslqa3IP+6XGTBjWaAsFQRT96qEO9yqmyYm
 +7cHsg2xhfOq7YHd4KQBrzoRvSlQIMEBEGliWTWwL9RuJI6hLWCONX8FiU8LJ4q11Pej15
 qpG1Pi0HrA8o6qkgnxrHj/Mf6KgEXrg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-8bvSNuZoP_WhBoy_soXIEQ-1; Mon, 21 Oct 2019 07:24:55 -0400
Received: by mail-wr1-f72.google.com with SMTP id f15so3487979wrs.13
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 04:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sY+hoIVb780tVb0oxVUtsh+mA9ccrphWiTSCVz5JN14=;
 b=PhW/n3qx7guZQNyFIhgiUdLSLkne2NavRMZ93CGzn1t6YDFnW3o9tZkVc2O0n1Lc6B
 swej/ozNk1oE8L3bJ9AReJk9gCKpx64dT5jM25a07LaasLRBsalmFqINRbaTw6S2FHAh
 x+l3Rj4+aZ6NF0AogRhSL40Kh/osRqJ8w+3vqwcRsbXGbzcecLeAojf+EbmE8uYRtEEb
 TV0DhlW/DHly7iQsQO2PyZ24bpIXcYiZoDSBgvCTyAjRfkN6MECjPY/GWUKbsuBlXQZ5
 kgfv7aeOTUOqL3b43TIHieimjnkwyYWxw9IYUC8fzu8T5pvrgGLjDlFgKCLIkvcXY1yM
 piqw==
X-Gm-Message-State: APjAAAUxjE69aeNZagwl/FBwJWcN/7Pk725RX3ETdfOp47ijI8bU3BP4
 SqqzvkWB0zRvPbJ7t5wSgXofcCfLnEEzENjHl+Y43voQpIPhxuZ9l+eT4M4ffh+SVzxY9Ai7Zgk
 4yZeGc1MlIL8chLs=
X-Received: by 2002:a5d:6949:: with SMTP id r9mr19899160wrw.106.1571657093050; 
 Mon, 21 Oct 2019 04:24:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw4UIvYcns6+wAYMzfx4LyX7Y+Xfuauc+PtxH6hlE8TD1VxG/Abk0+8JvvBY5NGWOJnAor+aw==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr19899144wrw.106.1571657092725; 
 Mon, 21 Oct 2019 04:24:52 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id d4sm13609848wrq.22.2019.10.21.04.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 04:24:52 -0700 (PDT)
Subject: Re: [PATCH 7/7] seabios-hppa: update to latest version
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191020204724.31537-1-svens@stackframe.org>
 <20191020204724.31537-8-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e25de312-f675-4043-e7a3-db6aafea30ea@redhat.com>
Date: Mon, 21 Oct 2019 13:24:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191020204724.31537-8-svens@stackframe.org>
Content-Language: en-US
X-MC-Unique: 8bvSNuZoP_WhBoy_soXIEQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sven,

On 10/20/19 10:47 PM, Sven Schnelle wrote:
> Required for STI support.

Please add the changelog. This might be enough:

$ git shortlog 0f4fe846..f8706d6f
Helge Deller (12):
       Add PDC_MEM_MAP and ENTRY_INIT_SRCH_FRST for OSF/MkLinux
       Return non-existant BTLB for PDC_BLOCK_TLB
       Add serial, parallel and LAN port support of  LASI chip
       Implement ENTRY_IO_BBLOCK_IN IODC function
       Do not print \r on parisc SeaBIOS
       Fix serial ports and add PDC_MODEL functions for special=20
instructions enablement
       Implement SeaBIOS returning additional addresses. Fixes HP-UX boot.
       Fix mod_pgs (number of pages) for graphic cards
       Merge pull request #3 from svenschnelle/sti
       Merge pull request #4 from svenschnelle/parisc-qemu-4.1.0
       parisc: Implement PDC rendenzvous
       parisc: Improve soft power button emulation

Sven Schnelle (7):
       parisc: fix PDC info for graphics adapter
       parisc: add missing header guard to hppa.h
       parisc: add LASI PS/2 emulation.
       parisc: Add STI support
       parisc: wire up graphics console
       parisc: Add support for setting STI screen resolution
       parisc: support LASI RTC register

Also, maybe it's clearer to use "update to parisc-qemu-4.2" in subject.

>=20
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   pc-bios/hppa-firmware.img | Bin 783724 -> 772876 bytes
>   roms/seabios-hppa         |   2 +-
>   2 files changed, 1 insertion(+), 1 deletion(-)
[...]

You can send this patch using 'git format-patch --no-binary'
and share a link to one of your repository, such=20
https://github.com/svenschnelle/qemu.

GIT-FORMAT-PATCH(1)

  --no-binary
            Do not output contents of changes in binary files,
            instead display a notice that those files changed.
            Patches generated using this option cannot be applied
            properly, but they are still useful for code review.

> diff --git a/roms/seabios-hppa b/roms/seabios-hppa
> index 0f4fe84658..9312de136f 160000
> --- a/roms/seabios-hppa
> +++ b/roms/seabios-hppa
> @@ -1 +1 @@
> -Subproject commit 0f4fe84658165e96ce35870fd19fc634e182e77b
> +Subproject commit 9312de136fc31b41774239f8bed8c2a817b98344

I'm getting:

fatal: bad object 9312de136fc31b41774239f8bed8c2a817b98344

Is this the correct hash?

Regards,

Phil.


