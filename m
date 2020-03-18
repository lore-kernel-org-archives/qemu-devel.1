Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0DBC5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0699F2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hipc8vZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0699F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jETwY-0004jg-69
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 04:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jETvw-0004GK-4I
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jETvu-0003Tb-Ql
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:20:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jETvu-0003QS-MO
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584519610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mtaylrayXrEncs5n8U1Zrij6XWECBQH5Q3zop5Iz3M=;
 b=Hipc8vZmQiq+Yof7bV9T9G2+h3yevh4lbGAGcTe+FhzPSNEGlvi260E4yRcoBWaG6EPQBR
 K7Y0eGz0A8Rt/o/595rbXXARaupE7b238wBaXwYSLEPW+ngsFGFjgI3PQ1pzJTMmawS9Ca
 DHVn1qnf7K2SZYr4INdrPDuV+7TLPhM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-I_VFaaAoO9OdW4w-UqTpww-1; Wed, 18 Mar 2020 04:20:06 -0400
X-MC-Unique: I_VFaaAoO9OdW4w-UqTpww-1
Received: by mail-wr1-f71.google.com with SMTP id i18so876835wrx.17
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 01:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=byygqPtNDxhf5cy3bSSDqk/DVqwdvItGrlcNhICT9Lw=;
 b=Y+EfHCZ07zGc7WxOi1iSbIiEBtNphRP+pBulYNRnLY5tIdJ/Kd+KEhwfHulc+46vtP
 Pngdv44VmzHrGtPgaxz9hz8D+hWA2vrbiPZYZ/nf8u/EXODgXlMwGSrLHJ2jio4nUJuY
 BwzzM2X270UCrvaAc3nj65tOUu1r46fBojjJSHgrcwct/52Mc1wk2+dNms8T8LdUJIjS
 6NeKejVxsGOUQfIZfy5xWdDbVvICokOCLjIMHRQwwhrXr+sNHLnW11D2oKNaaU7LI9Cw
 +O8NCficRDPHJnf7/9kyY1EqbYEynd2E+1OHaJgR9H/n8Ttm3ivINgwnqoLjleOwRSdz
 /Jow==
X-Gm-Message-State: ANhLgQ3p9Hkozke47+9oFdBKBxfm1kvktnWKrjHajSS70FmAUdakpK/8
 QpTPy22AzEjS2A5dx4/GKCyytJjl2r4tmGPObNqpNuHzt9q+YoyBVT/iq67t126w1HG/XDB2yOU
 1HisKpnGvfsfqFEA=
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr4293054wrh.357.1584519605120; 
 Wed, 18 Mar 2020 01:20:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtiTDRhNEQZ6W1BsJUnuFTvTiD7AfUh89gS1FYh+bLSsKHheu7YWnwInH0KSq4ESEisYp1dXA==
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr4293018wrh.357.1584519604848; 
 Wed, 18 Mar 2020 01:20:04 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id x5sm8225644wrv.67.2020.03.18.01.20.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 01:20:03 -0700 (PDT)
Subject: Re: [PULL 00/13] target: Add the Renesas RX architecture
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
References: <20200317163616.30027-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <61ccc6ca-b8e6-324b-aff5-82c0fa5e1c68@redhat.com>
Date: Wed, 18 Mar 2020 09:20:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317163616.30027-1-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 3/17/20 5:36 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> This pull request adds the architectural part of the Renesas RX
> architecture.  Richard Henderson temporarily handed it over for
> the 5.0 release.
>=20
> The following changes since commit a98135f727595382e200d04c2996e868b7925a=
01:
>=20
>    Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-re=
quest' into staging (2020-03-16 14:55:59 +0000)
>=20
> are available in the Git repository at:
>=20
>    https://gitlab.com/philmd/qemu.git tags/target_renesas_rx-20200317
>=20
> for you to fetch changes up to d9ecf331340137dc091bdcf3d3ef60087deac9ac:
>=20
>    Add rx-softmmu (2020-03-17 16:01:58 +0100)
>=20
> ----------------------------------------------------------------
>=20
> Introduce the architectural part of the Renesas RX
> architecture emulation, developed by Yoshinori Sato.
>=20
> CI jobs results:
>    https://gitlab.com/philmd/qemu/pipelines/127060924
>    https://travis-ci.org/github/philmd/qemu/builds/663524971
>=20
> ----------------------------------------------------------------
>=20
> Richard Henderson (6):
>    target/rx: Disassemble rx_index_addr into a string
>    target/rx: Replace operand with prt_ldmi in disassembler
>    target/rx: Use prt_ldmi for XCHG_mr disassembly
>    target/rx: Emit all disassembly in one prt()
>    target/rx: Collect all bytes during disassembly
>    target/rx: Dump bytes for each insn during disassembly
>=20
> Yoshinori Sato (7):
>    hw/registerfields.h: Add 8bit and 16bit register macros
>    MAINTAINERS: Add entry for the Renesas RX architecture
>    target/rx: TCG translation
>    target/rx: TCG helpers
>    target/rx: CPU definitions
>    target/rx: RX disassembler
>    Add rx-softmmu
>=20
>   configure                       |   11 +-
>   default-configs/rx-softmmu.mak  |    2 +
>   qapi/machine.json               |    4 +-
>   include/disas/dis-asm.h         |    5 +
>   include/exec/poison.h           |    1 +
>   include/hw/registerfields.h     |   30 +
>   include/sysemu/arch_init.h      |    1 +
>   target/rx/cpu-param.h           |   30 +
>   target/rx/cpu-qom.h             |   54 +
>   target/rx/cpu.h                 |  180 +++
>   target/rx/helper.h              |   31 +
>   target/rx/insns.decode          |  621 ++++++++
>   arch_init.c                     |    2 +
>   target/rx/cpu.c                 |  226 +++
>   target/rx/disas.c               | 1446 ++++++++++++++++++
>   target/rx/gdbstub.c             |  112 ++
>   target/rx/helper.c              |  149 ++
>   target/rx/op_helper.c           |  470 ++++++
>   target/rx/translate.c           | 2439 +++++++++++++++++++++++++++++++
>   tests/qtest/machine-none-test.c |    1 +
>   MAINTAINERS                     |    5 +
>   gdb-xml/rx-core.xml             |   70 +
>   target/rx/Makefile.objs         |   11 +
>   23 files changed, 5899 insertions(+), 2 deletions(-)
>   create mode 100644 default-configs/rx-softmmu.mak
>   create mode 100644 target/rx/cpu-param.h
>   create mode 100644 target/rx/cpu-qom.h
>   create mode 100644 target/rx/cpu.h
>   create mode 100644 target/rx/helper.h
>   create mode 100644 target/rx/insns.decode
>   create mode 100644 target/rx/cpu.c
>   create mode 100644 target/rx/disas.c
>   create mode 100644 target/rx/gdbstub.c
>   create mode 100644 target/rx/helper.c
>   create mode 100644 target/rx/op_helper.c
>   create mode 100644 target/rx/translate.c
>   create mode 100644 gdb-xml/rx-core.xml
>   create mode 100644 target/rx/Makefile.objs
>=20

In case you don't notice the other post on Eduardo pull request [*], I=20
suggested skip the RX one to get Eduardo's one first, then I'll repost=20
fixed on top.

Regards,

Phil.

[*] https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg05890.html


