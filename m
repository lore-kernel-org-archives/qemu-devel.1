Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68188C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 07:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E252173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 07:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E252173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48059 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSz2A-00014J-G5
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 03:18:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hSz1H-0000S5-NH
	for qemu-devel@nongnu.org; Tue, 21 May 2019 03:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hSz1F-00013c-SK
	for qemu-devel@nongnu.org; Tue, 21 May 2019 03:17:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hSz1D-0000TA-T6
	for qemu-devel@nongnu.org; Tue, 21 May 2019 03:17:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 798C8307D869;
	Tue, 21 May 2019 07:16:34 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-194.rdu2.redhat.com
	[10.10.120.194])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9BB6F646B2;
	Tue, 21 May 2019 07:16:28 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190520213700.12620-1-philmd@redhat.com>
	<20190520213700.12620-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6740fdc2-1628-f540-2f33-5e98ddefc3b8@redhat.com>
Date: Tue, 21 May 2019 09:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190520213700.12620-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 21 May 2019 07:16:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/7] tests/libqos: Add
 io_fw_cfg_uninit() and mm_fw_cfg_uninit()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/20/19 23:36, Philippe Mathieu-Daud=C3=A9 wrote:
> The mm_fw_cfg_init() allocates a QFWCFG object,
> add mm_fw_cfg_uninit() to deallocate it.
> Similarly with io_fw_cfg_init(), add io_fw_cfg_uninit().
>=20
> Signed-off-by: Li Qiang <liq3ea@163.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20190424140643.62457-2-liq3ea@163.com>
> [PMD: Split patch, filled commit description]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/libqos/fw_cfg.c | 10 ++++++++++
>  tests/libqos/fw_cfg.h |  2 ++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
> index d0889d1e22a..c6839c53c80 100644
> --- a/tests/libqos/fw_cfg.c
> +++ b/tests/libqos/fw_cfg.c
> @@ -81,6 +81,11 @@ QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t bas=
e)
>      return fw_cfg;
>  }
> =20
> +void mm_fw_cfg_uninit(QFWCFG *fw_cfg)
> +{
> +    g_free(fw_cfg);
> +}
> +
>  static void io_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>  {
>      qtest_outw(fw_cfg->qts, fw_cfg->base, key);
> @@ -107,3 +112,8 @@ QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t ba=
se)
> =20
>      return fw_cfg;
>  }
> +
> +void io_fw_cfg_uninit(QFWCFG *fw_cfg)
> +{
> +    g_free(fw_cfg);
> +}
> diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
> index 0353416af07..391669031a3 100644
> --- a/tests/libqos/fw_cfg.h
> +++ b/tests/libqos/fw_cfg.h
> @@ -33,7 +33,9 @@ uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key=
);
>  uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
> =20
>  QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
> +void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
>  QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
> +void io_fw_cfg_uninit(QFWCFG *fw_cfg);
> =20
>  static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
>  {
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

