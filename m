Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC73C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 06:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C1C207CD
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 06:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C1C207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jryCA-0007SZ-AC
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 02:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1jryBD-0006oB-Nq; Sun, 05 Jul 2020 02:31:11 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:38612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1jryB9-0007r8-A0; Sun, 05 Jul 2020 02:31:10 -0400
Received: by mail-ej1-f68.google.com with SMTP id w16so39185042ejj.5;
 Sat, 04 Jul 2020 23:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AC0bKtFkufkyNwdJUNbQrXinwDiu3+IvdQQi3k0ExBk=;
 b=QPvPgAWMdZVws2Kp5/L9ptW0zp+5ro97UW9GZu+7aPRQTElCI0FpL+qD5pYA9Q1sTf
 IWeIy5rxIPjFzjC4/aDDVSSCcCdRw72YeZzzmDf+6K9ATN4iDmOwsZkqGhvmIjAz1KDk
 Tw5ntoRc9nVI1yAFhAGeon/KyrrKbliL5MM6Bh6qhmj//gE3PCFpV9KWVsuo+JKAxR5J
 1OpD2EYRjIlD/D4J1tN8N6hyVxmszp7HsYRBmPaptcsH7d3IxAQ+0wbQZ7GfQC3imOnO
 2f5YcLc8rCYjF8Gi2BXWVZTUhm8V641j253RLLNPz5QLPf+UMfKx+Nt4jZ9C9w6MdV+u
 td6Q==
X-Gm-Message-State: AOAM532BjjrlBLTqHEftg6ht14PL6Us7wBTiM5LMAFARMuKKa39hXYW4
 pJiT3HepUby1nDNySM/Xebw=
X-Google-Smtp-Source: ABdhPJyArN3Df+uaJN/4OlyiwvauV0WFeBmtrHxUe4PEdiMCltn1oIUMe8ewC47UMB1fL0rez67gmQ==
X-Received: by 2002:a17:906:1751:: with SMTP id
 d17mr22130319eje.140.1593930664580; 
 Sat, 04 Jul 2020 23:31:04 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id by20sm14519161ejc.119.2020.07.04.23.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 23:31:04 -0700 (PDT)
Date: Sun, 5 Jul 2020 08:31:00 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 15/23] hw/m68k/mcf520x: Emit warning when old
 code is used
Message-ID: <20200705083100.19e74e4a@thl530.multi.box>
In-Reply-To: <20200704153908.12118-16-philmd@redhat.com>
References: <20200704153908.12118-1-philmd@redhat.com>
 <20200704153908.12118-16-philmd@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.68; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 02:31:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 qemu-riscv@nongnu.org, Stafford Horne <shorne@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, "Daniel
 P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Sat,  4 Jul 2020 17:39:00 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> This code hasn't been QOM'ified yet. Warn the user.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Add comment (thuth)
> ---
>  hw/m68k/mcf5206.c | 5 +++++
>  hw/m68k/mcf5208.c | 3 +++
>  2 files changed, 8 insertions(+)

Acked-by: Thomas Huth <huth@tuxfamily.org>

