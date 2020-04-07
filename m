Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190A4C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 05:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46BB206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 05:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mo5p+8ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46BB206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLgTd-0005LZ-08
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 01:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jLgSt-0004qm-4q
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jLgSs-0002Vm-7T
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:07:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31281
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jLgSs-0002Vb-4V
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586236077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LjMD0jkEzb9cWwxW5LveFzkmbNvZsVEkT9sE07/io2Y=;
 b=Mo5p+8ox5+7WeceEEh6EEv7Kv9ttMC/e3yNRFNYJbESzfjneCB2tsDDmouBflfeqlguCOX
 tJ7NhBsNcfUQMSeY1NQBDC2DBPQGs5XCIfw2CnO9F//AvY9iuoF+L+SNxH640HZNiJhfmz
 e5UnBxZBshDLgVnWgHpI8d/Hzp8iUWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-h-C7YXPpO0ayr779Oj1-mA-1; Tue, 07 Apr 2020 01:07:54 -0400
X-MC-Unique: h-C7YXPpO0ayr779Oj1-mA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9ED6218A8C80;
 Tue,  7 Apr 2020 05:07:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 675375DA60;
 Tue,  7 Apr 2020 05:07:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D38E211385C8; Tue,  7 Apr 2020 07:07:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH v9 5/9] docs/clocks: add device's clock documentation
References: <20200406135251.157596-1-damien.hedde@greensocs.com>
 <20200406135251.157596-6-damien.hedde@greensocs.com>
Date: Tue, 07 Apr 2020 07:07:47 +0200
In-Reply-To: <20200406135251.157596-6-damien.hedde@greensocs.com> (Damien
 Hedde's message of "Mon, 6 Apr 2020 15:52:47 +0200")
Message-ID: <87pncjzxwc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 mark.burton@greensocs.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Damien Hedde <damien.hedde@greensocs.com> writes:

> Add the documentation about the clock inputs and outputs in devices.
>
> This is based on the original work of Frederic Konrad.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
> v9:
>  + fix a few typos (Alistair)
>
> v8:
>  + fix list indentation
>  + reduce title size
>
> v7:
>  + update ClockIn/Out types
>  + switch to rst format
> ---
>  docs/devel/clocks.rst | 360 ++++++++++++++++++++++++++++++++++++++++++
>  docs/devel/index.rst  |   1 +
>  2 files changed, 361 insertions(+)
>  create mode 100644 docs/devel/clocks.rst
>
> diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
> new file mode 100644
> index 0000000000..ead9f55561
> --- /dev/null
> +++ b/docs/devel/clocks.rst
> @@ -0,0 +1,360 @@
> +Modeling a clock tree in QEMU
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +What are clocks
> +---------------
> +
> +Clocks are QOM objects developed for the purpose of modeling the
> +distribution of clocks in QEMU.
> +
> +They allow us to model the clock distribution of a platform and detect
> +configuration errors in the clock tree such as badly configured PLL, clo=
ck
> +source selection or disabled clock.
> +
> +The object is *Clock* and its QOM name is ``CLOCK``.

PATCH 1 has

    #define TYPE_CLOCK "clock"

Ignorant question: how is this related to *Clock* and ``CLOCK``?

[...]


