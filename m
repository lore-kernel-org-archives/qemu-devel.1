Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144B4C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 23:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00B42080A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 23:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00B42080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnATc-0002e1-1b
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 19:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40216)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hnATR-00029t-9Q
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 19:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hnATQ-0005iU-EG
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 19:33:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47490)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hnATQ-0005hb-8q; Mon, 15 Jul 2019 19:33:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C6E4730821A3;
 Mon, 15 Jul 2019 23:33:34 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-33.ams2.redhat.com
 [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0ED641001B17;
 Mon, 15 Jul 2019 23:33:28 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>
References: <20190715174817.18981-1-philmd@redhat.com>
 <20190715174817.18981-10-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c935b062-4611-9d91-ee48-cfbfdf070582@redhat.com>
Date: Tue, 16 Jul 2019 01:33:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190715174817.18981-10-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 15 Jul 2019 23:33:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v2 9/9] NSIS: Add missing firmware
 blobs
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/15/19 19:48, Philippe Mathieu-Daud=C3=A9 wrote:
> Various firmwares has been added in the pc-bios/ directory:
>=20
> - CCW     (since commit 0c1fecdd523)
> - Skiboot (since commit bcad45de6a0)
> - EDK2    (since commit f7fa38b74c3)
>=20
> Since we install qemu-system able to run the architectures
> targetted by these firmware, include them in the NSIS exe.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qemu.nsi | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/qemu.nsi b/qemu.nsi
> index 75f1608b9e..89c7c04f95 100644
> --- a/qemu.nsi
> +++ b/qemu.nsi
> @@ -122,6 +122,9 @@ Section "${PRODUCT} (required)"
>      File "${BINDIR}\*.bmp"
>      File "${BINDIR}\*.bin"
>      File "${BINDIR}\*.dtb"
> +    File "${BINDIR}\*.fd"
> +    File "${BINDIR}\*.img"
> +    File "${BINDIR}\*.lid"
>      File "${BINDIR}\*.rom"
>      File "${BINDIR}\openbios-*"
> =20
>=20

This is the only patch I can (remotely) comment on... So I guess, from
another patch, NSIS stands for "Nullsoft Installer".

Acked-by: Laszlo Ersek <lersek@redhat.com>

I guess :)

Laszlo

