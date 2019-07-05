Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4959CC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF1E218CA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJxHzMGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF1E218CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjO6x-0003Al-N9
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 09:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hjO6N-0002kW-TQ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hjO6I-00050t-10
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:18:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hjO6F-0004YX-Jm
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:18:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id a10so8828402wrp.9
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6bNbsVhiKHRlioxAvtysV+YsBkIgiy5Tr3VVeNfiOjA=;
 b=hJxHzMGbpvCUdywXL+VTswjJxo4DBNMrQYSctZvhUpWHlQ0KsXQT+12LXeqUoIAP4K
 J3/vpowyOGP98dDSTwtYrNaiF+1p3J9mmXdxIJ4uaiZSJtSIkudbLgPiskT6tnuO6+ES
 8UwBESfM1vQV+StpqGiXaNfpfr1yX5FSMZ3YEAvKpUpNTMc7AG8lgbfGSw3fs54D7c8S
 Uc2dtHQgBq50huEWdsDB+981X397WhyexqmPRYxccy5Tza45NJeFX/VskvBLMBmkuHVy
 wKwMDCE4LImB2xV4lugefmE0fGxOy2D84fFNI4roqpc0jt7H2KoX31wqbPsso6fHOPr5
 D9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6bNbsVhiKHRlioxAvtysV+YsBkIgiy5Tr3VVeNfiOjA=;
 b=YSAOvdRbnf73xD2WS3TEiYrmrKRAYcyt5akse+pEM1Mtt0Ly6226oY+b089R49xtlz
 H5gNEXhyrohcH59h+evXalZZ3/W9oduqYByV19TO7TyuEW158baeBkTfOY5G8OgAhXCt
 qsDUK4yWivdZsF96UNdaMe5Yjd9t1ta1Iaw2aesT6mSIWiSt4EN8P1VhLxDMRbrgvreV
 0JFY6vIt68cnpVKSVtlHiIufiRvWSQ5mMChDFOrl4NEn3ZEjAJR6bVO/Vhymod4BUG0p
 6w5a6AgQPPBuKQqDbufjNviocp6tnCa9bn7GL+7lsNtd18/BlxyXNkalS5P64pkQElYK
 Qstw==
X-Gm-Message-State: APjAAAWUBjXSZ7qKno6m9zSltJuJH8j+pveaT9KSvfs65/zDg9eDOPFK
 NdfemMdSBOMwBj/T4sd3hPIfuQ==
X-Google-Smtp-Source: APXvYqzf6VYL7B0m8GdTfSh8lk+LAAuhkyI6oKMsQKk2zlNAZ6eclOB8gx9Wil+xXto+UkkFg7+/vA==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr4056672wrm.12.1562332678817;
 Fri, 05 Jul 2019 06:17:58 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x18sm6976784wmi.12.2019.07.05.06.17.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 06:17:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CF0CB1FF87;
 Fri,  5 Jul 2019 14:17:57 +0100 (BST)
References: <4453b1be-8775-1d47-83fa-19102bf8dd95@ilande.co.uk>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-reply-to: <4453b1be-8775-1d47-83fa-19102bf8dd95@ilande.co.uk>
Date: Fri, 05 Jul 2019 14:17:57 +0100
Message-ID: <87wogwvcvu.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] Unable to set register on qemu-system-sparc64 via
 gdbstub
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
Cc: qemu-devel <qemu-devel@nongnu.org>, arilou@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> Hi all,
>
> It looks as if the recent gdbstub code rework has broken the ability to s=
et registers
> under qemu-system-sparc64:
>
> $ sparc64-linux-gdb obj-sparc64/openbios-builtin.elf.nostrip
> GNU gdb (GDB) 8.1
> Copyright (C) 2018 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "--host=3Dx86_64-pc-linux-gnu --target=3Dsparc=
64-linux".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
> <http://www.gnu.org/software/gdb/documentation/>.
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from obj-sparc64/openbios-builtin.elf.nostrip...done.
> (gdb) target remote :1234
> Remote debugging using :1234
> 0x000001fff0000020 in ?? ()
> (gdb) info regi $g1
> g1             0x0      0
> (gdb) set $g1 =3D 0x55
> Could not write register "g1"; remote failure reply 'E00'
> (gdb)
>
> I managed to narrow this down to the recent gdbstub rework, and in partic=
ular to this
> patch:
>
> commit 62b3320bddd79c050553ea7f81f20c6d3b401ce3
> Author: Jon Doron <arilou@gmail.com>
> Date:   Wed May 29 09:41:36 2019 +0300
>
>     gdbstub: Implement set register (P pkt) with new infra
>
>     Signed-off-by: Jon Doron <arilou@gmail.com>
>     Message-Id: <20190529064148.19856-9-arilou@gmail.com>
>     Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Tracing through I see that the problem occurs because of this code in gdb=
stub's
> handle_set_reg:
>
> static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
> {
>     int reg_size;
>
>     if (!gdb_has_xml) {
>         put_packet(gdb_ctx->s, "E00");
>         return;
>     }
>
>     ...
>     ...
> }
>
> Because SPARC doesn't have any GDB XML files then this check always
> fails which is

I think the gdb_has_xml test in this case is if the gdb protocol
understand XML (as well as us having an XML spec in QEMU). I assume your
gdb is fairly modern?

> why the E00 error code is being returned.

Previously we'd fallback to unknown_command which would send an empty
packet. That results in gdb sending a series of additional packets
instead of just failing:

  10423@1562330441.283482:gdbstub_io_command Received: P8=3D0000000000103500
  10423@1562330441.283505:gdbstub_io_reply Sent:
  10423@1562330441.283670:gdbstub_io_command Received: G0000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000001035000000000000000001000000400=
08013380000000000000000000000000000000000000000000000000000004000800a810000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000010045000000000001004540000000082009=
207000000000000000000000000000000000000000000000000
  10423@1562330441.283710:gdbstub_io_reply Sent: OK
  10423@1562330441.283902:gdbstub_io_command Received: g
  10423@1562330441.283934:gdbstub_io_reply Sent: 00000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000010350000000000000000010000004000801338=
0000000000000000000000000000000000000000000000000000004000800a8100000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000100450000000000010045400000000820092070000=
00000000000000000000000000000000000000000000
  10423@1562330441.284267:gdbstub_io_command Received: m100450,4
  10423@1562330441.284289:gdbstub_io_reply Sent: 1700040f
  10423@1562330441.284453:gdbstub_io_command Received: m10044c,4
  10423@1562330441.284471:gdbstub_io_reply Sent: 1100040d
  10423@1562330441.284562:gdbstub_io_command Received: m10043c,4
  10423@1562330441.284573:gdbstub_io_reply Sent: bc100000
  10423@1562330441.284661:gdbstub_io_command Received: m10043c,4
  10423@1562330441.284671:gdbstub_io_reply Sent: bc100000

Which is the G packet (Write general registers) instead of the "ignored"
P packet (Write register n). As you have seen skipping the gdb_xml test
results in:

15029@1562331181.902711:gdbstub_io_command Received: P8=3D0000000000103500
15029@1562331181.902733:gdbstub_io_reply Sent: OK
15029@1562331181.902925:gdbstub_io_command Received: g
15029@1562331181.902951:gdbstub_io_reply Sent: 0000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000001035000000000000000001000000400080133800=
00000000000000000000000000000000000000000000000000004000800a810000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000010045000000000001004540000000082009207000000=
000000000000000000000000000000000000000000
15029@1562331181.903286:gdbstub_io_command Received: m100450,4
15029@1562331181.903311:gdbstub_io_reply Sent: 1700040f
15029@1562331181.903454:gdbstub_io_command Received: m10044c,4
15029@1562331181.903466:gdbstub_io_reply Sent: 1100040d
15029@1562331181.903566:gdbstub_io_command Received: m10043c,4
15029@1562331181.903582:gdbstub_io_reply Sent: bc100000
15029@1562331181.903695:gdbstub_io_command Received: m10043c,4
15029@1562331181.903710:gdbstub_io_reply Sent: bc100000


> In fact if I simply comment out the above check then everything appears t=
o work
> again, however I'm not sure that this is the correct fix because there ar=
e several
> other references to gdb_has_xml remaining in the file?

I suspect the best fix would be to define an XML for sparc so we can use
the more modern features. However given the age of the architecture and
without knowing if it is actively developed in gdb I suspect the easiest
fix would be to do the same as handle_get_reg (and what it did pre re-facto=
r):

    /*
     * Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
     * This works, but can be very slow.  Anything new enough to
     * understand XML also knows how to use this properly.
     */
    if (!gdb_has_xml) {
        put_packet(gdb_ctx->s, "");
        return;
    }

I'll spin up a patch doing that.

--
Alex Benn=C3=A9e

