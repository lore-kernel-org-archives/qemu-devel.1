Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04813C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 19:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CE12084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 19:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CE12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGStu-0007as-2l
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 15:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iGSm2-00039c-P8
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iGSlx-0004Lf-7O
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:57:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iGSlx-0004LR-2N
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:57:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24DA8210C;
 Fri,  4 Oct 2019 18:57:48 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-253.rdu2.redhat.com
 [10.10.121.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F7345C21A;
 Fri,  4 Oct 2019 18:57:37 +0000 (UTC)
Subject: Re: [PATCH 5/7] tests/libqos/fw_cfg: Pass QTestState as argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191003225437.16651-1-philmd@redhat.com>
 <20191003225437.16651-6-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a9ebbc5e-7241-fab1-5f9a-cf31fe50e115@redhat.com>
Date: Fri, 4 Oct 2019 20:57:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191003225437.16651-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 04 Oct 2019 18:57:48 +0000 (UTC)
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/04/19 00:54, Philippe Mathieu-Daud=C3=A9 wrote:
> Since a QFWCFG object is not tied to a particular test, we can
> call *_fw_cfg_init() once before creating QTests and use the same
> for all the tests, then release the object with g_free() once all
> the tests are run.
>=20
> Refactor the qfw_cfg* API to take QTestState as argument.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/boot-order-test.c  | 12 ++++----
>  tests/fw_cfg-test.c      | 49 ++++++++++++++++----------------
>  tests/libqos/fw_cfg.c    | 61 ++++++++++++++++++++--------------------
>  tests/libqos/fw_cfg.h    | 30 +++++++++-----------
>  tests/libqos/malloc-pc.c |  4 +--
>  5 files changed, 77 insertions(+), 79 deletions(-)

Not much fun to review. :)

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

