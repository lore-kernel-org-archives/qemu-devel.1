Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D7AFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22EA215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeEjITWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22EA215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6dk-0008BH-5s
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iT6cy-0007Tm-AB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iT6cw-0007is-5g
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:56:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32494
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iT6cw-0007i4-1M
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573228605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FHqr1TVF3ufbo38zQakdQOBdWxqZfUmbI3vsj5ZzLbM=;
 b=EeEjITWLOm3MU/4IbI/zAgRlee4HngVTSXesRCLm2SatBZ4y6uw4CHRsOddeYfFZEy5sEU
 2Mxk8YUWG+Pcy1LLz4qkF+NCvbfIX6+NoFzPc1xAMjp3mSRo4w79R0Kafd2IygffiaFu/m
 yirBbJnQoww06Tcl0QaS3UtkNWeV+Pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-EbmLw8BONo6piafnQq-V3w-1; Fri, 08 Nov 2019 10:56:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CD891800D7B;
 Fri,  8 Nov 2019 15:56:40 +0000 (UTC)
Received: from [10.3.117.38] (ovpn-117-38.phx2.redhat.com [10.3.117.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A41A60856;
 Fri,  8 Nov 2019 15:56:36 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] hw/block/pflash: Remove dynamic field width from
 trace events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191108144042.30245-1-philmd@redhat.com>
 <20191108144042.30245-2-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9e7990b7-87ed-84d4-5256-8397bc25a1f4@redhat.com>
Date: Fri, 8 Nov 2019 09:56:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191108144042.30245-2-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: EbmLw8BONo6piafnQq-V3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 8:40 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Since not all trace backends support dynamic field width in
> format (dtrace via stap does not), replace by a static field
> width instead.
>=20
> Reported-by: Eric Blake <eblake@redhat.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1844817
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   hw/block/pflash_cfi01.c | 8 ++++----
>   hw/block/pflash_cfi02.c | 8 ++++----
>   hw/block/trace-events   | 8 ++++----
>   3 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 566c0acb77..787d1196f2 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -276,7 +276,7 @@ static uint32_t pflash_data_read(PFlashCFI01 *pfl, hw=
addr offset,
>           DPRINTF("BUG in %s\n", __func__);
>           abort();
>       }
> -    trace_pflash_data_read(offset, width << 1, ret);
> +    trace_pflash_data_read(offset, width << 3, ret);

Umm, why is width changing?  That's not mentioned in the commit message.

> @@ -389,7 +389,7 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr =
offset,
>  =20
>           break;
>       }
> -    trace_pflash_io_read(offset, width, width << 1, ret, pfl->cmd, pfl->=
wcycle);
> +    trace_pflash_io_read(offset, width << 3, ret, pfl->cmd, pfl->wcycle)=
;

And even this one is odd.  Matching up to the trace messages:


> -pflash_io_read(uint64_t offset, int width, int fmt_width, uint32_t value=
, uint8_t cmd, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d value:0x%0*x =
cmd:0x%02x wcycle:%u"

> +pflash_io_read(uint64_t offset, int width, uint32_t value, uint8_t cmd, =
uint8_t wcycle) "offset:0x%04"PRIx64" width:%d value:0x%04x cmd:0x%02x wcyc=
le:%u"

you are changing from:

"%04"PRIx64" %d %0*x...", offset, width, width << 1, ret,...

(where width<<1, ret matches *x)

into

"%04"PRIx64" %d %04x...", offset, width << 3, ret,...

where you are now printing a different value for width.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


