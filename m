Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B7EC742D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC1A20665
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC1A20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzQL-0003Xw-77
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38710)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hlzQ9-00039i-Pt
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hlzQ8-00007w-Tg
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:33:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hlzQ8-00007N-Nn
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:33:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so5455234wma.4
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3Qd8NVefFr2h7kNIWG6QfSW1JG7rtbmBjRwk9fGvtMs=;
 b=FYTTPbVJz6s93CW/9KTy6fO2y2rcj+7z5ugxs5GdBhOK9JWOpPAKOkSWe4t3cJF9/c
 tXuY85NVx9TmWNjTKa5zybwOWYH7W5nDkWEl2T/Hi+LDcZ/056BqYpqpj/2gtBEmFwpc
 QsCFwf5YyaptDgQKB4U7iYon+Ear8MrCBm4dA42Rm2kRtBcoiX+zZJwI5APlZMWfyw88
 PSH22IHMaOxvn5/1qCVeEAKn33HAQj7yPw9ODpHiFxwuSZfyqq4Do49Psx0A25qjEQSi
 eMBbbx+mV7lMoJtBbKRPzk7OkwAGTWGDYRqcnVxcEmkzoeUlj9d7ewbTUVVSCMrghe+Y
 qFBQ==
X-Gm-Message-State: APjAAAWmJ6VVIznt8/NZAI3SSsr2hWK9ubvtvSeQ3eQ5Kcbx417K0TlU
 QV4Ahf7KqckMgT+aN1Y9YFov+A==
X-Google-Smtp-Source: APXvYqwZnQSqZyM4RTq+4HAk28hHFY4wXXI6pk/4i0cuYCzp2BHDq5U72XOPpaZx8loLG6EMAh4Mqw==
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr9686734wmj.87.1562952799580; 
 Fri, 12 Jul 2019 10:33:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id d10sm3228820wrx.34.2019.07.12.10.33.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 10:33:19 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190712165154.11504-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f8039ba2-c562-fb7d-8bc5-52310f6be662@redhat.com>
Date: Fri, 12 Jul 2019 19:33:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712165154.11504-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] rdmacm-mux: fix strcpy string warning
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
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/07/19 18:51, Marc-André Lureau wrote:
> ../contrib/rdmacm-mux/main.c: In function ‘parse_args’:
> ../contrib/rdmacm-mux/main.c:118:13: error: ‘strncpy’ specified bound 3835 equals destination size [-Werror=stringop-truncation]
>   118 |             strncpy(unix_socket_path, optarg, SOCKET_PATH_MAX);
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/rdmacm-mux/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
> index 30c7052651..de53048f06 100644
> --- a/contrib/rdmacm-mux/main.c
> +++ b/contrib/rdmacm-mux/main.c
> @@ -115,7 +115,7 @@ static void parse_args(int argc, char *argv[])
>  
>          case 's':
>              /* This is temporary, final name will build below */
> -            strncpy(unix_socket_path, optarg, SOCKET_PATH_MAX);
> +            strncpy(unix_socket_path, optarg, SOCKET_PATH_MAX - 1);
>              break;
>  
>          case 'p':
> 

Queued, thanks.

Paolo

