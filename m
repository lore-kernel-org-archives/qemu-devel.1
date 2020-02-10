Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D006FC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2C220842
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0FlcJPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2C220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1CRu-0000R0-PY
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 12:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1j1CPo-0006jh-FE
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1j1CPm-0008Hx-6m
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:00:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58634
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1j1CPl-0008HR-Tf
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581354004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=s6JBxGllA5vxyJ1DROXunLofJ9+EPWLrYz6J/SfQH1E=;
 b=Q0FlcJPF3YUQgxPsJnOz1MYD2t7AbQcdQa5sDvxWbKgH4+gJEbdxvsWJkbXOLjh8Qzx578
 3qOf7dZYYPjhqLkEzP0lw8fmAfPk4IM8CUkZXzIj8rAeSuu7FsIHuHpsC4fPByfFyLt3P2
 4r3X6BSMlQdJPFKOTI+xKWuEraxkags=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-YR-RwlLxPzmdV8gFRaoa6A-1; Mon, 10 Feb 2020 12:00:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ED61800D4E;
 Mon, 10 Feb 2020 16:59:59 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-219.ams2.redhat.com [10.36.116.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 934415C1D6;
 Mon, 10 Feb 2020 16:59:54 +0000 (UTC)
Subject: Re: [PATCH v2] tests/acceptance: Add a test for the canon-a1100
 machine
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200129090420.13954-1-thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a967c93c-58b2-9a8d-02fe-e7fc9e833827@redhat.com>
Date: Mon, 10 Feb 2020 17:59:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200129090420.13954-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: YR-RwlLxPzmdV8gFRaoa6A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/01/2020 10.04, Thomas Huth wrote:
> The canon-a1100 machine can be used with the Barebox firmware. The
> QEMU Advent Calendar 2018 features a pre-compiled image which we
> can use for testing.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Rename file and add class docstring to please pylint
>  - Add entry to MAINTAINERS
>  - Add :avocado: tags=3Ddevice:pflash_cfi02
>=20
>  MAINTAINERS                                |  1 +
>  tests/acceptance/machine_arm_canona1100.py | 35 ++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 tests/acceptance/machine_arm_canona1100.py
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efd3f3875f..ddf6fe0794 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -561,6 +561,7 @@ S: Odd Fixes
>  F: include/hw/arm/digic.h
>  F: hw/*/digic*
>  F: include/hw/*/digic*
> +F: tests/acceptance/machine_arm_canona1100.py
[...]

 Hi Peter,

could you maybe take this patch through your ARM tree?

 Thanks,
  Thomas


