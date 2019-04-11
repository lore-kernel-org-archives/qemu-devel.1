Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37704C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA062084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA062084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45306 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWO0-0002kB-AO
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:52:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWMY-0001uP-DJ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWMX-0005Ti-Ae
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:51:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWMX-0005TS-2B
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:51:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so5876328wmj.3
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=BeCjfqeGaqgGO3youlEtVt6Gzq6SWCJHBr4xCmfAYak=;
	b=R+0V4U/6Br1cEvYBx+bPVutKEs0aU4NYVbrhH94I5sfZcJol790L8OL/Xm9SOAl31t
	dXKPxofCFI4pCEwtxzZXUOvl9f7kOTvZvkY67MSmdi8dh4/4C+ZdXjF3WLfeVzRXDgZY
	XvTE5H/QvzSZuaepIDrS9h7wy5/QVd6dpN+aNqAXNRenm4igp6EKLLWJc/rhgFNRXxUq
	/CtrCVor+C2znWGdXZe89xFk8o+iEFHo8wNA36wFNhEVfVmmq0y4JsS2/y56/W4XtXDB
	57xskb4GDKF/dWqNJTr6icMAZkXTcysQ0G7IqdQm27lG7C+Tqz3kRt+bKNo7VQgIG8Qk
	Vh7A==
X-Gm-Message-State: APjAAAVoDOYo/hvf63tKEBwVvVQwVXSdj48GsOgHlHXZXomzlXM5iAgF
	pqHsWIiyq3OGFzmP+drXoTpjgDgiwwk=
X-Google-Smtp-Source: APXvYqwfc6/FqWij/X2N+excWNtj3s2Wlo2PPGgnOEUKf0h2Vy0Z0dBNYaWjByXDglnTHVt3O30h+Q==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr5615375wmh.13.1554976276126; 
	Thu, 11 Apr 2019 02:51:16 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	r196sm6548612wmf.22.2019.04.11.02.51.15
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 02:51:15 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <eaee1235-7b72-468e-dce3-5900f0592906@redhat.com>
Date: Thu, 11 Apr 2019 11:51:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v3 15/23] linux-user: Remove srand call
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411095115.c8vHoXThxIMYDMmHn7WBIMStLKcP96z06SC5ymQr_mo@z>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> We no longer use rand() within linux-user.
> 
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 8478306eef..80cb9fdfbe 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -621,8 +621,6 @@ int main(int argc, char **argv, char **envp)
>  
>      cpu_model = NULL;
>  
> -    srand(time(NULL));
> -
>      qemu_add_opts(&qemu_trace_opts);
>  
>      optind = parse_args(argc, argv);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

