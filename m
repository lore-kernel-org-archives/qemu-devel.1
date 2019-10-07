Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D81C352AA
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FE12084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FE12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHPxg-0004fr-Bn
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 06:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHPwh-0003eN-8F
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHPwg-0000Pq-9M
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:08:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59898)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHPwg-0000PH-34
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:08:50 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2B31C4FCD9
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2019 10:08:49 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id n3so5973933wmf.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 03:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=diOWLvkRHMp26IzCTd0+dQKDG1zd8TuEniXpfbalnMQ=;
 b=nQpAxHqJhHOKUVQLzjbohJckKbHkM9bBdKf2lFLwJSCjamQHhgjX4X8uEnynNTi9as
 dfB15Lf8MsI5peIUu5zChkrhqb3GQX5gLzFxzyw31uk7M3diH4MqqlHDObF/q109j2em
 XmVA50vKVT1yM+0DUoEBgupF0csU0/N+ZwFouzKfHJM1HrfUshO9AI49SfMSo9dG35pY
 ZuUvkMt1owhgngdpHIWwQYrcEgKDR6WBUUfnz3+pxSJPaf9rWLjkZM1DDEkG4u45KsCu
 OceyirUx5zb7kjJ+b11cwVfV36IUm51uzum3Tdjqjh0yr8gatjNJFFfk6lKo+RD3u1j3
 8pZQ==
X-Gm-Message-State: APjAAAU60jaqwgqD5CcsaUQqsdaq6EoLmA6/RtS/i3TZRfGQVBUixBEt
 jTdkJvwJNQq4HozS+T1hUozp4+BJwNZpsqvs2R4MwQcxt0pLfAUV380wvvXP/vMo9TQfjAFMuk5
 lYIGeeVTvxYODoNY=
X-Received: by 2002:a5d:4689:: with SMTP id u9mr21852666wrq.78.1570442927680; 
 Mon, 07 Oct 2019 03:08:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfIzcWmXMpsAGg8bYJB5A+TAHqfzFRSLmucHZHfd6qN9fftcLXo/ffG1fAG5INZ5QPEUv5Fg==
X-Received: by 2002:a5d:4689:: with SMTP id u9mr21852640wrq.78.1570442927464; 
 Mon, 07 Oct 2019 03:08:47 -0700 (PDT)
Received: from [192.168.1.115] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id s1sm25114154wrg.80.2019.10.07.03.08.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2019 03:08:46 -0700 (PDT)
Subject: Re: [PATCH 4/4] migration: report SaveStateEntry id and name on
 failure
To: Wei Yang <richardw.yang@linux.intel.com>, quintela@redhat.com,
 dgilbert@redhat.com
References: <20191005220517.24029-1-richardw.yang@linux.intel.com>
 <20191005220517.24029-5-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d2131549-6de5-ee1b-a3bb-a7795780220d@redhat.com>
Date: Mon, 7 Oct 2019 12:08:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191005220517.24029-5-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/19 12:05 AM, Wei Yang wrote:
> This provides helpful information on which entry failed.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>   migration/savevm.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 9f0122583d..feb757de79 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1215,6 +1215,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool p=
ostcopy)
>           save_section_footer(f, se);
>  =20
>           if (ret < 0) {
> +            error_report("failed to save SaveStateEntry with id(name):=
 %d(%s)",
> +                         se->section_id, se->idstr);
>               qemu_file_set_error(f, ret);
>           }
>           if (ret <=3D 0) {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

