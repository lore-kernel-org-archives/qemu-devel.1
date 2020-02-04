Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04DEC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 00:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2582084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 00:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2582084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iylgL-0000mP-PA
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 19:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1iylfl-0000Kv-Jd
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 19:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1iylfk-0001w3-CO
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 19:02:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54948 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1iylfk-00012i-0z
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 19:02:32 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 8CBA8756147D7E972C4D;
 Tue,  4 Feb 2020 08:02:23 +0800 (CST)
Received: from [127.0.0.1] (10.177.246.209) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0;
 Tue, 4 Feb 2020 08:02:20 +0800
Subject: Re: [PATCH] configure: Fix typo of the have_afalg variable
To: Thomas Huth <thuth@redhat.com>, <qemu-devel@nongnu.org>
References: <20200203160046.23194-1-thuth@redhat.com>
From: "Longpeng (Mike)" <longpeng2@huawei.com>
Message-ID: <cc2785a6-9402-fd2e-a0b2-6abe0d8192d0@huawei.com>
Date: Tue, 4 Feb 2020 08:02:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200203160046.23194-1-thuth@redhat.com>
Content-Type: text/plain; charset="gbk"
X-Originating-IP: [10.177.246.209]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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

=D4=DA 2020/2/4 0:00, Thomas Huth =D0=B4=B5=C0:
> The variable is called 'have_afalg' and not 'hava_afalg'.
>=20
> Fixes: f0d92b56d88 ('introduce some common functions for af_alg backend=
')
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 5095f01728..115dc38085 100755
> --- a/configure
> +++ b/configure
> @@ -5843,7 +5843,7 @@ fi
> =20
>  ##########################################
>  # check for usable AF_ALG environment
> -hava_afalg=3Dno
> +have_afalg=3Dno
>  cat > $TMPC << EOF
>  #include <errno.h>
>  #include <sys/types.h>
>=20
Reviewed-by: Longpeng(Mike) <longpeng2@huawei.com>

--=20
Regards,
Longpeng(Mike)


