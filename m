Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47A8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDDE205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hO+jaUdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDDE205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZVAe-0001KS-TU
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 03:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZVA6-0000uw-Ha
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:53:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34122
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZVA5-0005yQ-OI
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589529220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XdwIa30w6EhsUkL2R6aHH2vZZyzoc0fHM+4Qc47KvnY=;
 b=hO+jaUdkokZ92Y4t/OwK1yei7HqHlh95dX6qReJFngawEOqM3/4CWP0SFSpwmy0OOfvTel
 G/QD+2C7k1motFBedkHotN/gLrGLG5W/KxX7O6Gp4kzf25J2oiS6OQXGcgqyo7fW69GUMm
 v6dFugetol/xHIoLIS4XXPdwJumgI+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-XzLKDYH8MTmjBOx46OE3pg-1; Fri, 15 May 2020 03:53:38 -0400
X-MC-Unique: XzLKDYH8MTmjBOx46OE3pg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B61F783DB39;
 Fri, 15 May 2020 07:53:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BED060C05;
 Fri, 15 May 2020 07:53:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E70811358BC; Fri, 15 May 2020 09:53:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH v2 17/17] hw/mips: Convert Malta "ifdef 0"-ed code to
 comments
References: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
 <20200514192047.5297-18-aleksandar.qemu.devel@gmail.com>
Date: Fri, 15 May 2020 09:53:35 +0200
In-Reply-To: <20200514192047.5297-18-aleksandar.qemu.devel@gmail.com>
 (Aleksandar Markovic's message of "Thu, 14 May 2020 21:20:47 +0200")
Message-ID: <87lfltr5vk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: aleksandar.rikalo@rt-rk.com, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:

> The checkpatch complain about "#ifdef 0". Convert corresponding
> dead code to comments. In future, these cases could be converted
> to some no-nonsense logging/tracing.
>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/mips/mips_malta.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index e4c4de1b4e..f91fa34b06 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -427,10 +427,12 @@ static uint64_t malta_fpga_read(void *opaque, hwadd=
r addr,
>          break;
> =20
>      default:
> -#if 0
> -        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "=
\n",
> -               addr);
> -#endif
> +/*
> + * Possible logging:
> + *
> + *        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx=
 "\n",
> + *               addr);
> + */
>          break;
>      }
>      return val;
> @@ -515,10 +517,12 @@ static void malta_fpga_write(void *opaque, hwaddr a=
ddr,
>          break;
> =20
>      default:
> -#if 0
> -        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx =
"\n",
> -               addr);
> -#endif
> +/*
> + * Possible logging:
> + *
> + *        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_l=
x "\n",
> + *               addr);
> + */
>          break;
>      }
>  }

Please don't.

Checkpatch warns "if this code is redundant consider removing it\n".

If it is redundant, do remove it.

If it is not redundant, do ignore checkpatch's warning, do not abuse
comments to hide from checkpatch.  We'd rather not have to code up a
warning for that :)

These two look like they want to be tracepoints.


