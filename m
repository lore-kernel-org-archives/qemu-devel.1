Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FEBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0699D20738
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZM9aNvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0699D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvE6-0003Vv-2G
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1kAvCu-0002VE-FA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:11:16 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:50243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1kAvCs-0002jW-OS
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:11:16 -0400
Received: by mail-wm1-x332.google.com with SMTP id t2so1701815wma.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p3782pjVKEIST6AJb8oZZ3aB4b1LVv0uYVCW54CyN94=;
 b=TZM9aNvs1uYlkDlHY2XPGZ1fzCE1gr5FKZoWnBPp5uDoYnsu0fE1jFE3+MokyNtaRs
 pLxAHP7ZOyZ0aiJtiAGlvwCW8c46HYE05MLwczC4ffRqHbChlULE8ilYSY3bth3pT+ua
 dK1PketQ4d3S8X/naitjeFeyELA2G1T04zKI7FJmlWin2pPnBc09g3euDBepb1IJxImh
 ncLZulPtSoov8lqHQtdzjlTht7XAzOvJ0ZdgTAIwDF6HED6vYWA1WAMyx9OZftWZuGsU
 8fOHevZQOh10sXarfSWortBTgp1fmsA9LsDBPoheFdVYUVbLonqHeMKA6kvphOSyRs2D
 ZkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p3782pjVKEIST6AJb8oZZ3aB4b1LVv0uYVCW54CyN94=;
 b=TnF/ctgVEfLOtHL/URAb1X/fg3njjIoZqyWPblX50vHtK/6N6Ts9NNP8b1VLB4+07d
 6wSUmGnvtqpQJa4Xy81TTHhtIemSsiygjKFbillxxafmbUwJk8wZpMSGgnArXW8FFkCd
 nFaAnTZoRk+hmFF5+uE8FCY9Xe72fJ2uCZwJ25Pn/7Hq+VD79IuW1O4UAjUWVe2Imcv0
 D+yZCnUtnk4z2JcZEn5d+3Kxdmg1g4BV4/V5vaZSOdJbwkD0dLcojjjvhWHXBaao/LUi
 ZXbFn92rfyZfgKPL0zgSgK57lA83cH0SocMAkMFuRhTRqt+B5gHTdGO58/gvwy07OzWX
 ODFA==
X-Gm-Message-State: AOAM532X+g5zzzXYC3U7bo5Xd8X/djC14yySBFL71hn7AQBodHReq6FM
 oSHLE0yyXS7P1noFiBdxU7YI2Do1HJhjNQ==
X-Google-Smtp-Source: ABdhPJwHhB2BzMMj8gQ6T209czlnK1veSfz7uZJHyOwT3a/wCiNXHPjSs8TvAQta4AaGvPrFuv6G3w==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr5144146wmc.23.1598447472673; 
 Wed, 26 Aug 2020 06:11:12 -0700 (PDT)
Received: from [192.168.15.71] ([195.200.173.126])
 by smtp.gmail.com with ESMTPSA id v12sm6433315wri.47.2020.08.26.06.11.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Aug 2020 06:11:12 -0700 (PDT)
From: "Emmanuel Blot" <eblot.ml@gmail.com>
To: qemu-devel@nongnu.org
Subject: Meson build on macOS: undefined symbol treatment
Date: Wed, 26 Aug 2020 15:11:11 +0200
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <E79B1486-1C3C-4271-9B76-62B2C4B8BCA7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=eblot.ml@gmail.com; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I=E2=80=99ve noticed that since meson builds have been enabled, on macOS,=
 the =

build outcome with undefined symbols has changed:

- prior to meson introduction (v5.1.0):
   * referencing an undeclared symbol in source code led to a warning at =

compile stage
   * referencing an undeclared symbol at link stage led to a fatal build =

error (as usually expected)

- since meson introduction
   * same behavior at compile stage
   * however, the linker does silently generate an application - which =

fails at launch since the symbol is undefined.

Step to reproduce:

   from softmmu/main.c, replace for example call to qemu_init() with =

qemu_init2();

- v5.1.0:
   softmmu/main.c:48:5: warning: implicit declaration of function =

'qemu_init2' is invalid in C99 [-Wimplicit-function-declaration]
     qemu_init2(argc, argv, envp);
       LINK    riscv64-softmmu/qemu-system-riscv64
   Undefined symbols for architecture x86_64:
     "_qemu_init2", referenced from:
         _qemu_main in main.o
   ld: symbol(s) not found for architecture x86_64
   clang: error: linker command failed with exit code 1 (use -v to see =

invocation)
   make[1]: *** [qemu-system-riscv64] Error 1

- current master:
   softmmu/main.c:49:5: warning: implicit declaration of function =

'qemu_init2' is invalid in C99 [-Wimplicit-function-declaration]
     qemu_init2(argc, argv, envp);
     ^
   1 warning generated.
   [3/3] Linking target qemu-system-riscv64

  > riscv64-softmmu/qemu-system-riscv64
   dyld: lazy symbol binding failed: Symbol not found: _qemu_init2
     Referenced from: =

/Users/eblot/Sources/Git/github.com/QEMU/upstream/build/riscv64-softmmu/q=
emu-system-riscv64
     Expected in: flat namespace

     'riscv64-softmmu/qemu-system-ris=E2=80=A6' terminated by signal SIGA=
BRT =

(Abort)


This new behavior is likely to come from the linker flag:

    -Wl,-undefined,dynamic_lookup

I=E2=80=99m not sure whether it is a new feature or a bug, but if the for=
mer =

stands true, is there a way to disable this feature?


Thanks,
Emmanuel.

