Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E24C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 07:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA772071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 07:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlMhcf2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA772071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNWl7-00048k-DR
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 03:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kNWjd-0002z0-HT
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 03:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kNWjY-0003x7-7l
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 03:41:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601451662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ORVgAM0mTh9D0pXEoWvi3h8M1hG+ojkMT+sY9ABo5Mk=;
 b=KlMhcf2t5dqamkDpMZrLHbme1UFMJIxU/yZTUy51fElReXT4GstVGC+uFxRpRv+AT1tjft
 AC+ZTvAouw8pWRLIuOsftTzd/bqnHyzWPkeeywcuzqdwZPeEXHd3i++PfjBojRnSN7HzJn
 pGDibpmKjFjLkI3l5pFcc1d77cQ0K48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-EP848805OZi0Ds43qjhlPg-1; Wed, 30 Sep 2020 03:40:59 -0400
X-MC-Unique: EP848805OZi0Ds43qjhlPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 772EC802B47;
 Wed, 30 Sep 2020 07:40:56 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D2BE7B40D;
 Wed, 30 Sep 2020 07:40:50 +0000 (UTC)
Date: Wed, 30 Sep 2020 09:40:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH 00/16] hw/mips: Set CPU frequency
Message-ID: <20200930094048.739faff1@redhat.com>
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 19:15:23 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> All the MIPS cores emulated by QEMU provides the Coproc#0
> 'Count' register which can be used as a free running timer.
>=20
> Since it's introduction in 2005 this timer uses a fixed
> frequency of 100 MHz (for a CPU freq of 200 MHz).
> While this is not an issue with Linux guests, it makes
> some firmwares behave incorrectly.
>=20
> The Clock API allow propagating clocks. It is particularly
> useful when hardware dynamicly changes clock frequencies.
>=20
> To be able to model such MIPS hardware, we need to refactor
> the MIPS hardware code to handle clocks.
>=20
> This series is organized as follow:
>=20
> - let all CPU have an input clock,
> - MIPS CPU get an input clock
> - when the clock is changed, CP0 timer is updated
> - set correct CPU frequencies to all boards
> - do not allow MIPS CPU without input clock

is this clock an integral part of MIPS cpus or it's an external device?

> I used a MIPSsim test suggested by Thomas. It is also included
> as bonus at the end.
>=20
> Possible follow up:
> - QOM'ify the GIC
> - let the GIC handle dynamic clock changes
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=C3=A9 (16):
>   hw/core/cpu: Let CPU object have a clock source
>   target/mips: Move cpu_mips_get_random() with CP0 helpers
>   target/mips/cp0_timer: Explicit unit in variable name
>   target/mips/cpu: Introduce mips_cpu_properties[]
>   target/mips/cpu: Set default CPU frequency to 200 MHz
>   target/mips: Keep CP0 counter in sync with the CPU frequency
>   hw/mips/r4k: Explicit CPU frequency is 200 MHz
>   hw/mips/fuloong2e: Set CPU frequency to 533 MHz
>   hw/mips/mipssim: Correct CPU frequency
>   hw/mips/jazz: Correct CPU frequencies
>   hw/mips/cps: Expose input clock and connect it to CPU cores
>   hw/mips/boston: Set CPU frequency to 1 GHz
>   hw/mips/malta: Set CPU frequency to 320 MHz
>   hw/mips/cps: Do not allow use without input clock
>   target/mips/cpu: Do not allow system-mode use without input clock
>   tests/acceptance: Test the MIPSsim machine
>=20
>  include/hw/core/cpu.h                    |  5 +++
>  include/hw/mips/cps.h                    |  2 +
>  target/mips/cpu.h                        |  9 ++++
>  target/mips/internal.h                   |  2 +-
>  hw/core/cpu.c                            | 12 +++++
>  hw/mips/boston.c                         | 13 ++++++
>  hw/mips/cps.c                            |  8 ++++
>  hw/mips/fuloong2e.c                      |  8 +++-
>  hw/mips/jazz.c                           | 16 ++++++-
>  hw/mips/malta.c                          | 20 +++++++--
>  hw/mips/mipssim.c                        | 12 ++++-
>  hw/mips/r4k.c                            |  8 +++-
>  target/mips/cp0_helper.c                 | 25 +++++++++++
>  target/mips/cp0_timer.c                  | 51 ++++++---------------
>  target/mips/cpu.c                        | 43 +++++++++++++++++-
>  MAINTAINERS                              |  1 +
>  tests/acceptance/machine_mips_mipssim.py | 56 ++++++++++++++++++++++++
>  17 files changed, 244 insertions(+), 47 deletions(-)
>  create mode 100644 tests/acceptance/machine_mips_mipssim.py
>=20


