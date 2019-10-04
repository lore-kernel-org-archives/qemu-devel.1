Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D01C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 18:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDC92077B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 18:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDC92077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGSYg-0003UZ-Ag
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 14:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iGSUv-00028Z-L7
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iGSUr-0000wi-A0
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:40:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iGSUp-0000s8-7c
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:40:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B60EF10CC1EE;
 Fri,  4 Oct 2019 18:40:03 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-253.rdu2.redhat.com
 [10.10.121.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E2857BE40;
 Fri,  4 Oct 2019 18:39:53 +0000 (UTC)
Subject: Re: [PATCH 1/7] tests/libqos/fw_cfg: Document io_fw_cfg_init to drop
 io_fw_cfg_uninit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191003225437.16651-1-philmd@redhat.com>
 <20191003225437.16651-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0c8684e4-d8e9-cda0-3bb3-e8a31a9bbf7b@redhat.com>
Date: Fri, 4 Oct 2019 20:39:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191003225437.16651-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 04 Oct 2019 18:40:03 +0000 (UTC)
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
> Document io_fw_cfg_init() return value must be released
> with g_free(). Directly calling g_free() we don't really
> need io_fw_cfg_uninit(): remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/libqos/fw_cfg.c |  5 -----
>  tests/libqos/fw_cfg.h | 11 +++++++++--
>  2 files changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
> index 1f46258f96..37c3f2cf4d 100644
> --- a/tests/libqos/fw_cfg.c
> +++ b/tests/libqos/fw_cfg.c
> @@ -157,8 +157,3 @@ QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t ba=
se)
> =20
>      return fw_cfg;
>  }
> -
> -void io_fw_cfg_uninit(QFWCFG *fw_cfg)
> -{
> -    g_free(fw_cfg);
> -}
> diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
> index 13325cc4ff..15604040bd 100644
> --- a/tests/libqos/fw_cfg.h
> +++ b/tests/libqos/fw_cfg.h
> @@ -36,8 +36,15 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *=
filename,
> =20
>  QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
>  void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
> +/**
> + * io_fw_cfg_init():
> + * @qts: The #QTestState that will be referred to by the QFWCFG object=
.
> + * @base: The I/O address of the fw_cfg device in the guest.
> + *
> + * Returns a newly allocated QFWCFG object which must be released
> + * with a call to g_free() when no longer required.
> + */
>  QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
> -void io_fw_cfg_uninit(QFWCFG *fw_cfg);
> =20
>  static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
>  {
> @@ -46,7 +53,7 @@ static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
> =20
>  static inline void pc_fw_cfg_uninit(QFWCFG *fw_cfg)
>  {
> -    io_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>  }
> =20
>  #endif
>=20


This more or less reverts 0729d833d6d6 ("tests/libqos: Add
io_fw_cfg_uninit() and mm_fw_cfg_uninit()", 2019-05-23).

I'm fine either way.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

