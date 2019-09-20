Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0253C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5E520665
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5E520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEtB-0000gN-Kn
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 05:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBEsX-00009v-8u
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBEsW-0004KJ-6h
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:07:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBEsW-0004Jx-2M
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:07:00 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 042E1C057F88
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 09:06:59 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id n18so2016027wro.11
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 02:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eBlqKNtZT05ZBDo6KYmJOzkjQj8kwAMtFwFXsCOIQtU=;
 b=VKY0FTD16g+rcclCsYHzXLjKAvCHEc/e0V27NrzWpAtXy6/LUY7FkK1kyFAmAnCNq7
 Pd2RVnijg6JbVa0uPtm9rxRgA8KaZhC1EDb+j/ynm+N/FdxQapCvaLFWAkapeS2u8XbV
 GdMCWNqERpxi1ypECcU77ns97qllB0KJtyTLQMKD9OuoLtHy/sQQyGbCZfpMyyREfWAP
 oQjvt5uCb1W7GLpywWP7TyUhKcqXwyYJb4LNOWeLmAWm4YK3GwIoRJclLJ+qDNobt9T6
 yz2XsqzgJH0KPxgyb/xQ/DoCiB/EkiNXnDiOgzOHH65ljQFJcxKnAxjzENNk2JHZ0D79
 RI1A==
X-Gm-Message-State: APjAAAWsYT7ZDT0RyUhsXHCaMpumecJ+EuDlvB7V44vP4Ku3wU1wyyG5
 Xp3hp+ZiFfKGu4lqaxM2cptNH5abWdlLsu5vf1FYaiuhqaiaRVOHqeLgNadCiBnZAPtoKfPoVtO
 n9K31h9ugfKn5o98=
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr10660400wrv.327.1568970417809; 
 Fri, 20 Sep 2019 02:06:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxFg4Rgn/M/YAJ8Nv9hVK+8WAJX21KdvS/su4PEyAQvbcTfU/Otio7beOpU8Y3rPC1pU7vC4A==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr10660386wrv.327.1568970417640; 
 Fri, 20 Sep 2019 02:06:57 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id w12sm1758525wrg.47.2019.09.20.02.06.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 02:06:57 -0700 (PDT)
Subject: Re: [PATCH] vhost-user-gpu: Drop trailing json comma
To: Cole Robinson <crobinso@redhat.com>, qemu-devel@nongnu.org
References: <7f5dd2ac9f3504e2699f23e69bc3d8051b729832.1568925097.git.crobinso@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3c5f289e-3f9c-d243-0a67-846ba853acb7@redhat.com>
Date: Fri, 20 Sep 2019 11:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7f5dd2ac9f3504e2699f23e69bc3d8051b729832.1568925097.git.crobinso@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 10:33 PM, Cole Robinson wrote:
> Trailing comma is not valid json:
>=20
> $ cat contrib/vhost-user-gpu/50-qemu-gpu.json.in | jq
> parse error: Expected another key-value pair at line 5, column 1

Shouldn't we add this as a test?

> Signed-off-by: Cole Robinson <crobinso@redhat.com>
> ---
>  contrib/vhost-user-gpu/50-qemu-gpu.json.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/contrib/vhost-user-gpu/50-qemu-gpu.json.in b/contrib/vhost=
-user-gpu/50-qemu-gpu.json.in
> index 658b545864..f5edd097f8 100644
> --- a/contrib/vhost-user-gpu/50-qemu-gpu.json.in
> +++ b/contrib/vhost-user-gpu/50-qemu-gpu.json.in
> @@ -1,5 +1,5 @@
>  {
>    "description": "QEMU vhost-user-gpu",
>    "type": "gpu",
> -  "binary": "@libexecdir@/vhost-user-gpu",
> +  "binary": "@libexecdir@/vhost-user-gpu"
>  }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

