Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F44C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 18:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3172053B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 18:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3172053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGSe3-0005US-3J
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 14:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iGSXO-0003ZO-Bi
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iGSXM-0002xc-JA
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:42:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iGSXM-0002u0-BC
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:42:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2029710DCC85;
 Fri,  4 Oct 2019 18:42:43 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-253.rdu2.redhat.com
 [10.10.121.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2F9819C68;
 Fri,  4 Oct 2019 18:42:32 +0000 (UTC)
Subject: Re: [PATCH 3/7] tests/libqos/fw_cfg: Document pc_fw_cfg_init to drop
 pc_fw_cfg_uninit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191003225437.16651-1-philmd@redhat.com>
 <20191003225437.16651-4-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <21230ed6-32dc-0155-2ad3-8ca37ecde6dd@redhat.com>
Date: Fri, 4 Oct 2019 20:42:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191003225437.16651-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 04 Oct 2019 18:42:43 +0000 (UTC)
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
> Document pc_fw_cfg_init() return value must be released
> with g_free(). Directly calling g_free() we don't really
> need pc_fw_cfg_uninit(): remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/fw_cfg-test.c      | 22 +++++++++++-----------
>  tests/libqos/fw_cfg.h    | 14 +++++++++-----
>  tests/libqos/malloc-pc.c |  2 +-
>  3 files changed, 21 insertions(+), 17 deletions(-)
>=20
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 1d3147f821..53ae82f7c8 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -36,7 +36,7 @@ static void test_fw_cfg_signature(void)
>      buf[4] =3D 0;
> =20
>      g_assert_cmpstr(buf, =3D=3D, "QEMU");
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
> =20
> @@ -52,7 +52,7 @@ static void test_fw_cfg_id(void)
>      id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
>      g_assert((id =3D=3D 1) ||
>               (id =3D=3D 3));
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
> =20
> @@ -73,7 +73,7 @@ static void test_fw_cfg_uuid(void)
>      qfw_cfg_get(fw_cfg, FW_CFG_UUID, buf, 16);
>      g_assert(memcmp(buf, uuid, sizeof(buf)) =3D=3D 0);
> =20
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
> =20
>  }
> @@ -88,7 +88,7 @@ static void test_fw_cfg_ram_size(void)
> =20
>      g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE), =3D=3D, =
ram_size);
> =20
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
> =20
> @@ -102,7 +102,7 @@ static void test_fw_cfg_nographic(void)
> =20
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NOGRAPHIC), =3D=3D,=
 0);
> =20
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
> =20
> @@ -116,7 +116,7 @@ static void test_fw_cfg_nb_cpus(void)
> =20
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NB_CPUS), =3D=3D, n=
b_cpus);
> =20
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
> =20
> @@ -129,7 +129,7 @@ static void test_fw_cfg_max_cpus(void)
>      fw_cfg =3D pc_fw_cfg_init(s);
> =20
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_MAX_CPUS), =3D=3D, =
max_cpus);
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
> =20
> @@ -158,7 +158,7 @@ static void test_fw_cfg_numa(void)
> =20
>      g_free(node_mask);
>      g_free(cpu_mask);
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
> =20
> @@ -171,7 +171,7 @@ static void test_fw_cfg_boot_menu(void)
>      fw_cfg =3D pc_fw_cfg_init(s);
> =20
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), =3D=3D,=
 boot_menu);
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
> =20
> @@ -190,7 +190,7 @@ static void test_fw_cfg_reboot_timeout(void)
>      g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout));
>      reboot_timeout =3D le32_to_cpu(reboot_timeout);
>      g_assert_cmpint(reboot_timeout, =3D=3D, 15);
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
> =20
> @@ -209,7 +209,7 @@ static void test_fw_cfg_splash_time(void)
>      g_assert_cmpint(filesize, =3D=3D, sizeof(splash_time));
>      splash_time =3D le16_to_cpu(splash_time);
>      g_assert_cmpint(splash_time, =3D=3D, 12);
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
> =20
> diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
> index 3247fd4000..6316f4c354 100644
> --- a/tests/libqos/fw_cfg.h
> +++ b/tests/libqos/fw_cfg.h
> @@ -54,14 +54,18 @@ QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t ba=
se);
>   */
>  QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
> =20
> +/**
> + * pc_fw_cfg_init():
> + * @qts: The #QTestState that will be referred to by the QFWCFG object=
.
> + *
> + * This function is specific to the PC machine (X86).
> + *
> + * Returns a newly allocated QFWCFG object which must be released
> + * with a call to g_free() when no longer required.
> + */
>  static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
>  {
>      return io_fw_cfg_init(qts, 0x510);
>  }
> =20
> -static inline void pc_fw_cfg_uninit(QFWCFG *fw_cfg)
> -{
> -    g_free(fw_cfg);
> -}
> -
>  #endif
> diff --git a/tests/libqos/malloc-pc.c b/tests/libqos/malloc-pc.c
> index 6f92ce4135..949a99361d 100644
> --- a/tests/libqos/malloc-pc.c
> +++ b/tests/libqos/malloc-pc.c
> @@ -29,5 +29,5 @@ void pc_alloc_init(QGuestAllocator *s, QTestState *qt=
s, QAllocOpts flags)
>      alloc_init(s, flags, 1 << 20, MIN(ram_size, 0xE0000000), PAGE_SIZE=
);
> =20
>      /* clean-up */
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>  }
>=20

I'm getting the impression we're trying to remove "PC" (x86) references
from the cleanup action :)

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

