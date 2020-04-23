Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3180C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA5220728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLeEpP4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA5220728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiTi-0003Pi-O9
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiSw-0002GG-NL
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiSw-00017s-8c
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:28:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53005
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRiSv-000159-Si
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587673736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZg6pEAUvn97OTQ5jarDiEfHbU4WyT3SLjHZ7UwgMAg=;
 b=eLeEpP4gyX17gGu+1FEhR25dEuyOiQxKuxwTSv9tYpEX5EaXLdUBlWhi+SHHXApXCT9K/7
 MWKnNTRUa4xLLfoAsJ8/XdceRjNyk84tfplcojJktr2xMaD74wjnoTmQ7CSlu8Yux5k9oY
 qEQQQ2/TZu5JxakUCev+qV+w0Ol4W7E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-LYz9gO2ONwOoatD7vXAetQ-1; Thu, 23 Apr 2020 16:28:54 -0400
X-MC-Unique: LYz9gO2ONwOoatD7vXAetQ-1
Received: by mail-wm1-f69.google.com with SMTP id f81so2997883wmf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=atySbhyW+/idkR85OgtNddX73C/6aH2wHEU2jimS3q8=;
 b=naId64kBDBdIpy75LEfDXlVs3k8ne9qOYdi0AjPnX2+n6UhD0SbsLSFBox1h8wF+Qu
 uCdMBikV1oeVOgEk+vli4Bqv0y0onz47XKOslj35O2ZISciFVKMowLzHdLucrWSgB6XQ
 ei6qHVSXAaf/cmOcvekY/IC6mKquvPfdgAyxomgme0RZjz5Xeqj7acShEqm9AQrRU9ih
 dnySSue6Ve6lu92ZifrTdG73FBiwOKGU5IUCZ0EABJnHmE37O1/LjLLGcsJPXIaLY0ll
 1TLkS0DGVx9MzMKSGUYni1s69QzV+ztRAtMyH0+H20bFUKDLMvC40IZ0mG7X9dkovKBK
 jbPA==
X-Gm-Message-State: AGi0PubBZm4KNY/sbRP8pGJos9AtvrBjXCbs6/QvVxcCdydqW9IMj/w1
 8ax8XaByXVufVnVB6N71ZEIUQ9YaM060LQjVyUNSAeAyWjyvOmGPz1/LRKubBpxucLYyOXKC4s7
 WSkT+/41sujMC1v8=
X-Received: by 2002:a05:600c:4112:: with SMTP id
 j18mr5946174wmi.69.1587673733072; 
 Thu, 23 Apr 2020 13:28:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypKJb4b25kQENainxPNWNrQfDIvJFCiQgaDQznTrdOse5jnfOaRR6+Pv6p4emjecZCjbcEUXPg==
X-Received: by 2002:a05:600c:4112:: with SMTP id
 j18mr5946116wmi.69.1587673732169; 
 Thu, 23 Apr 2020 13:28:52 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b2sm5987669wrn.6.2020.04.23.13.28.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 13:28:51 -0700 (PDT)
Subject: Re: [PATCH v1 05/14] configure: favour gdb-multiarch if we have it
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200423170557.31106-1-alex.bennee@linaro.org>
 <20200423170557.31106-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d0da4db0-7049-7130-486d-e338d8243faf@redhat.com>
Date: Thu, 23 Apr 2020 22:28:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200423170557.31106-6-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 16:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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

On 4/23/20 7:05 PM, Alex Benn=C3=A9e wrote:
> As gdb will generally be talking to "foreign" guests lets use that if
> we can. Otherwise the chances of gdb barfing are considerably higher.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 23b5e93752..c58787100f 100755
> --- a/configure
> +++ b/configure
> @@ -303,7 +303,7 @@ libs_qga=3D""
>   debug_info=3D"yes"
>   stack_protector=3D""
>   use_containers=3D"yes"
> -gdb_bin=3D$(command -v "gdb")
> +gdb_bin=3D$(command -v "gdb-multiarch" || command -v "gdb")
>  =20

Good one!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>   if test -e "$source_path/.git"
>   then
>=20


