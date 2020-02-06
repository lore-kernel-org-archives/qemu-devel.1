Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB33C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC260214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7tpmCEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC260214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izkcZ-0008EZ-2L
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izkWa-0001LV-PP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izkWY-0003y8-5W
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:01:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22361)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izkWX-0003wY-W9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581008465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cksqt17eUPSaSH25Py2YB1c36CvRVSrv6JYR9mOjB98=;
 b=Q7tpmCEh/Pq4uFJEZYksxHukMPs4qfU3x/rsL+7mib3BkBljkcyimYpRxv2djWJHRkk2q7
 VCYMccMJVxBKOT+2zQPXs789ApH6umMHEcbkLPY2xUKRuNRpYTd/kfVQKGFIfmVFLAziVh
 Vkqs8uxIjSbbwvUAwSpL5GlFfkkXBxo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-LfZzmRX2No-SLqg-VSQfWA-1; Thu, 06 Feb 2020 12:00:44 -0500
Received: by mail-wm1-f70.google.com with SMTP id m18so326941wmc.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0sfDc8+HE75CKdJLmKZ1mQZWgaRzTOTUYskbmSUMR7s=;
 b=AGrwxWS1/Dx4WymJO86YMQAxrXOXa7uk/4uwk4Pbjqn0g1sUj8l7w0qKJ71GaDrCmJ
 ifslavkvMvW8+vsoE5Kf4JQnr3jEOBnJwyi9vultXPLyNDqS9fTWAXwusvWHlWsuhIi7
 VmhgRV+Ysa/RTGHngwTs5nh6h8w35S7dNSep7Am73sSmt0xbFoEMmZJZfpG5+iybpeMe
 zb3yMwH0/N5NO+gLlt9Vb8GuT0gJ03tGKr4e/R/O6Ep8r2YDNmuT5b/NMEtgxDMBdvXY
 V0rjoGmAIwEVQfXmirBuhDDJbNK5jXnVjErYnVnq1BFWA3DAr/JLM4oYM36gVGQAlIVm
 7X8g==
X-Gm-Message-State: APjAAAUM57IU3v8XaKWe3nuqZAUzIg3E8xVvXFuduI/EMkNnnFXlmmw6
 foVm1tEpRRgP6e4w7KNrc7saRn8+P8z7+BPrhIpvKAMs2877vIncTlSVHhFrWaftOwfYf0NOxHm
 fCE1zqqah8DdpWFo=
X-Received: by 2002:a1c:1d09:: with SMTP id d9mr5761370wmd.91.1581008442872;
 Thu, 06 Feb 2020 09:00:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyyutWKFAtqNwE52G4QbHW7JTW+1gbK+ju86SqH3up7tzvpuZ1ioQ5Ubmj+bRTztYtlAu7tFA==
X-Received: by 2002:a1c:1d09:: with SMTP id d9mr5761335wmd.91.1581008442578;
 Thu, 06 Feb 2020 09:00:42 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t131sm147158wmb.13.2020.02.06.09.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 09:00:42 -0800 (PST)
Subject: Re: [PATCH v2] .readthedocs.yml: specify some minimum python
 requirements
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
References: <20200206163120.31899-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0c206609-0e39-5a19-cc25-8ca6b932cc77@redhat.com>
Date: Thu, 6 Feb 2020 18:00:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206163120.31899-1-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: LfZzmRX2No-SLqg-VSQfWA-1
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 5:31 PM, Alex Benn=C3=A9e wrote:
> QEMU is all about the Python 3 now so lets also hint that to
> ReadTheDocs in its config file.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> ---
> If anyone wants to include this is their next PR please do, otherwise
> it will be a misc patch in my next series ;-)
> ---
>   .readthedocs.yml | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>   create mode 100644 .readthedocs.yml
>=20
> diff --git a/.readthedocs.yml b/.readthedocs.yml
> new file mode 100644
> index 00000000000..8355dbc6343
> --- /dev/null
> +++ b/.readthedocs.yml
> @@ -0,0 +1,20 @@
> +# .readthedocs.yml
> +# Read the Docs configuration file
> +# See https://docs.readthedocs.io/en/stable/config-file/v2.html for deta=
ils
> +
> +# Required
> +version: 2
> +
> +# Build documentation in the docs/ directory with Sphinx
> +sphinx:
> +  configuration: docs/conf.py
> +
> +# We want all the document formats
> +formats: all
> +
> +# For consistency, we require that QEMU's Sphinx extensions
> +# run with at least the same minimum version of Python that
> +# we require for other Python in our codebase (our conf.py
> +# enforces this, and some code needs it.)
> +python:
> +  version: 3.5
>=20

I wonder if this could also help:

   submodules:
     exclude: all

See https://docs.readthedocs.io/en/stable/config-file/v2.html#submodules

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Patch applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


