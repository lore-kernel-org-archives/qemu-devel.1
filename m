Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8E1C5ACBF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD97206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwzIOUuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD97206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCnKO-0005pU-Ha
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 12:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCnIW-0002nK-Rk
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCnIV-0002Rp-Tb
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:36:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42004
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCnIV-0002RH-QO
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584117391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGip5yhBe2AGfSrVzymQqdbmV1M/Ni3RGNuc6zGOAtQ=;
 b=ZwzIOUuDwFOFDJj+NWEDaOaY/bq1BPRR++q8a2Tcb6knP2NfanGsQgb4TklxP3UDOBPzrQ
 qAREWaMyJTluhZRuSjiHzy1on+4fS/3usA+AtYp8Np/q95sNyl2flFICtJLEMuALQsGqzs
 yO31ClqS8b0tJg6Z8bysPDNzkwnLXBQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-yoRZXT4sMMS7nisnbxW2Jg-1; Fri, 13 Mar 2020 12:36:29 -0400
X-MC-Unique: yoRZXT4sMMS7nisnbxW2Jg-1
Received: by mail-wm1-f69.google.com with SMTP id z26so3587625wmk.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9Ko+6eUIrjlG7al6HJWBj/3gXEZZRRS6tabLqanNTaY=;
 b=JpOGBJatl1Kl71/468opPW6qHsc3C3bFUmDvGGHu46TPOBqIu6/JImtFXS83oJJwVv
 HCqOig6yK4ds9Q9NL7YFcx7jm5pRxDBBvsBZXLevAdtPNy0qxnTsBPzoRDBVLXPqdHfv
 DsojEmUC3JdGIgQK00dVyYVrrZjti7/REZmPv/bPNRTjwx+S8T6s2UHny0eGCckuaqEg
 DYQyWrFgYy+bJjeu1SS/A8bR1tJHguyiQIFuW+qbACKXJD5miaH2wFzLWI/HTBc+OFQw
 2D8otFOqEtInAKKFU5duL96dslWbPqsnvBRlp0oAdT5D9CMKiUj8JbZ6NtndCReECWYG
 Mxjg==
X-Gm-Message-State: ANhLgQ1JBkIjQjspcvO8xAYVoy+yvEfyZpRay37w2Cj4km1QluyYfbDE
 GekYLkdOovlhBHKtmJlMN4js3Ih2k6RBk6Iw8JY4QAG5GezmU9c4Wn7bFDIjk9p+mu8yXqF2lx4
 QXmMUWvG87tNV/h8=
X-Received: by 2002:a1c:f214:: with SMTP id s20mr11145092wmc.57.1584117370440; 
 Fri, 13 Mar 2020 09:36:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vujSwzrSuyw3QLNmGLhmyf0rssQjSUjArz686HjVQUPf7Z6Md71oB7Ot4M/Z/Ejpo46SbqgLg==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr11145081wmc.57.1584117370249; 
 Fri, 13 Mar 2020 09:36:10 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id 138sm12588695wmb.21.2020.03.13.09.36.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 09:36:09 -0700 (PDT)
Subject: Re: [PATCH 3/3] MAINTAINERS: Add a file to the main MIPS section
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <1584061252-16635-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1584061252-16635-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b346737c-8c30-948f-c0a0-d09c1d411be7@redhat.com>
Date: Fri, 13 Mar 2020 17:36:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1584061252-16635-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 2:00 AM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>=20
> A recently added acceptance test is important not only for
> Malta machine, but for overall MIPS target, since it tests
> smp feature.
>=20
> CC: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8411c96..5c56e14 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -226,6 +226,7 @@ F: include/hw/mips/
>   F: include/hw/misc/mips_*
>   F: include/hw/timer/mips_gictimer.h
>   F: tests/acceptance/linux_ssh_mips_malta.py
> +F: tests/acceptance/machine_mips_malta.py
>   F: tests/tcg/mips/
>   K: ^Subject:.*(?i)mips
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


