Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF250C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 07:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8827621773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 07:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8827621773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48114 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSz6f-0002a7-KR
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 03:22:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hSz5m-00028x-D0
	for qemu-devel@nongnu.org; Tue, 21 May 2019 03:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hSz5l-0003QL-BQ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 03:21:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hSz5l-0003Pm-4W
	for qemu-devel@nongnu.org; Tue, 21 May 2019 03:21:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E324307D932;
	Tue, 21 May 2019 07:21:40 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-194.rdu2.redhat.com
	[10.10.120.194])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BCEB860FBE;
	Tue, 21 May 2019 07:21:28 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190520213700.12620-1-philmd@redhat.com>
	<20190520213700.12620-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f7dc4d44-e867-9009-0f5e-1155280b667e@redhat.com>
Date: Tue, 21 May 2019 09:21:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190520213700.12620-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 21 May 2019 07:21:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/7] tests/libqos: Add
 pc_fw_cfg_uninit() and use it
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
> The pc_fw_cfg_init() function allocates an IO QFWCFG object.
> Add the pc_fw_cfg_uninit() function to deallocate it (and use it).
>=20
> Signed-off-by: Li Qiang <liq3ea@163.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20190424140643.62457-2-liq3ea@163.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [PMD: Split patch, fill commit description, call uninit in malloc-pc.c]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/fw_cfg-test.c      | 1 +
>  tests/libqos/fw_cfg.h    | 5 +++++
>  tests/libqos/malloc-pc.c | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 1c5103fe1c5..a370ad56678 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -128,6 +128,7 @@ int main(int argc, char **argv)
> =20
>      ret =3D g_test_run();
> =20
> +    pc_fw_cfg_uninit(fw_cfg);
>      qtest_quit(s);
> =20
>      return ret;
> diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
> index 391669031a3..60de81e8633 100644
> --- a/tests/libqos/fw_cfg.h
> +++ b/tests/libqos/fw_cfg.h
> @@ -42,4 +42,9 @@ static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
>      return io_fw_cfg_init(qts, 0x510);
>  }
> =20
> +static inline void pc_fw_cfg_uninit(QFWCFG *fw_cfg)
> +{
> +    io_fw_cfg_uninit(fw_cfg);
> +}
> +
>  #endif
> diff --git a/tests/libqos/malloc-pc.c b/tests/libqos/malloc-pc.c
> index 949a99361d1..6f92ce41350 100644
> --- a/tests/libqos/malloc-pc.c
> +++ b/tests/libqos/malloc-pc.c
> @@ -29,5 +29,5 @@ void pc_alloc_init(QGuestAllocator *s, QTestState *qt=
s, QAllocOpts flags)
>      alloc_init(s, flags, 1 << 20, MIN(ram_size, 0xE0000000), PAGE_SIZE=
);
> =20
>      /* clean-up */
> -    g_free(fw_cfg);
> +    pc_fw_cfg_uninit(fw_cfg);
>  }
>=20

The 2nd part of the patch is a refactoring, but the first patch adds a
brand new g_free(), in effect. I think it would be better to separate
them -- in theory anyway. But I realize this patch is already the result
of splitting another patch. I guess we wouldn't want an army of 1-liner
patches...

If you split this patch even further, that's great, you can add my R-b
to both resultant patches. If you decide to keep it as-is, you can also
add my

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

(I'm going to skip the rest of the patches, as they are from Li Qiang,
and you reviewed them already, without implementing changes on top, IIUC.=
)

Thanks
Laszlo

