Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5810DC55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDF620776
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFtX8zSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDF620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHtt-0004XI-AW
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRHra-0001k4-8v
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRHrT-0003fA-H9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:04:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25701
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRHrS-0003Cs-IG
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587571464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJgg3e6ZdBdbAdXq1rNpGr9QWOUH8cnG66yxh4yXYXI=;
 b=SFtX8zSA3q08y+r0rKSFv499oRD0CNdehYSAX2gqclzAaHb9hYHHwTgkD4Xmf+8tB5R3dJ
 GNOw7eSG6rrzxV4iKS+ieblkEEPhimVVsf6DbULnL7fS2dv2snBy/l6Wa52R9LJhJs/6iC
 S2lr37M3lHZQIFmBCfn3YxFd0oGRiSk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-R8XwUbz_O4eMOZewhdKQWA-1; Wed, 22 Apr 2020 12:04:21 -0400
X-MC-Unique: R8XwUbz_O4eMOZewhdKQWA-1
Received: by mail-wr1-f71.google.com with SMTP id r11so1264859wrx.21
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 09:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PysFP9Eo7yZhh/HmFyG2n+ZPfLAUd+R7KTs5AfN+pc0=;
 b=VsRHZYjuaqAUyT+RGNOuJ7F3v9/vWx9DKShwyb0ruQrbWx3HqaGH80L96TllWSfUDo
 MQ0jPwXPhWJxQO0Hs+jhO3+VGPw1+62n8xsKHrNCsL5gQNFRE3TG1y52t7JH0lZx+MmR
 aXsi0NwTnVVqA52NXqpMEl4GqEhOg4Oso7ppucqSNOwmJKOhlaq/f88rR+kgBBKUQoY2
 eFF5l0Vai0UpVk0KpZYlL5tPS+X8hdm/1GUEYDj/Gt5lWF7KDYvqnetwOTMWNTGdVX3U
 oOw1Zhq5wVrPDYJx2wg0ycIkgfliz08R8DOowHCMq6ujVNr+GA4DVNnQ4y22xAnsUAJ2
 LNXA==
X-Gm-Message-State: AGi0PuYooiW6Sbq0EVqcZdlkyChYCklGwiyRzThIRNEj/VS5RAcQlkEp
 x9ymWjTZJKhZrgC47dU7UeSrl2V/P9LbAy2yb7h+NLdrica3jvf/Z6t+gRNxzaN07yZSovfeb/F
 a3eS+iLZhoCiUwGg=
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr31766146wrj.114.1587571460351; 
 Wed, 22 Apr 2020 09:04:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypL5KEnbpAcrgHdimWLJR58SuA5pF3PI9cBMhVMF6A1B7VBOUcjgs1gmxw6bKdsHNRxSP9yVZQ==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr31766116wrj.114.1587571460106; 
 Wed, 22 Apr 2020 09:04:20 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id t2sm8710524wmt.15.2020.04.22.09.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 09:04:19 -0700 (PDT)
Subject: Re: [PATCH 1/2] crypto/secret: fix inconsequential errors.
To: Alexey Krasikov <alex-krasikov@yandex-team.ru>, berrange@redhat.com,
 qemu-devel@nongnu.org
References: <20200415201336.24195-1-alex-krasikov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f19e117f-6dfb-fdfc-12ef-e21ec98baedd@redhat.com>
Date: Wed, 22 Apr 2020 18:04:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415201336.24195-1-alex-krasikov@yandex-team.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 10:13 PM, Alexey Krasikov wrote:
> * change condition from QCRYPTO_SECRET_FORMAT_RAW
>    to QCRYPTO_SECRET_FORMAT_BASE64 in if-operator, because
>    this is potencial error if you add another format value.
>=20
> Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
> ---
>   crypto/secret.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/crypto/secret.c b/crypto/secret.c
> index 1cf0ad0ce8..546b965afe 100644
> --- a/crypto/secret.c
> +++ b/crypto/secret.c
> @@ -204,7 +204,7 @@ qcrypto_secret_prop_set_loaded(Object *obj,
>               input =3D output;
>               inputlen =3D outputlen;
>           } else {
> -            if (secret->format !=3D QCRYPTO_SECRET_FORMAT_RAW) {
> +            if (secret->format =3D=3D QCRYPTO_SECRET_FORMAT_BASE64) {
>                   qcrypto_secret_decode(input, inputlen,
>                                         &output, &outputlen, &local_err);
>                   g_free(input);
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


