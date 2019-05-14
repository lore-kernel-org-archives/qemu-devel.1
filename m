Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F397BC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE06120850
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE06120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52075 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQbsR-0007th-3C
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 14:10:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQbog-0005HS-IV
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQboe-0004KO-Se
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:06:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQboe-0004J3-My
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:06:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id x64so29934wmb.5
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 11:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=MkiUMEED3MRtRWb7zQWf9ZN2jh/3e2BZfyl/WWm/4E4=;
	b=pZYQqYG8OV/V6vGe9yXWpqC6rKTS0djQRp8C+jvNyHUOY7dtF+5ksNgYdfybiU83Zu
	8uo61afXwuN4FyCDRBsGe3mOe1OvaShrrCeM+D+Q5qm2uKCbgmKh6egwtnVLkuGmdMug
	b2alSZUWP+bl99/0eBlw4edgOEtm/r2e5WxiTIbkFShHAvAa2HChSEOAoWcFm+mrNGWS
	EEIasO0lHJSMu+JpskXaWEIYPSXIn0/ShvgZl6k9tlAVLXrE2zCJPtwnJX+s0nTlm40P
	XUgQHWCZ3VQcAK8LPJtYg764OH2fbJrvotTcgdjAL2K2xGoHY+Wss66MPUiX0TWlmBq5
	ZJ5w==
X-Gm-Message-State: APjAAAU/o4IgHeWC9Wf1AcfjrQyZFnbQ6xxzSkMTZRmW/9ap57lkhpVv
	RW1ydYZ442pdsAKaJLgew2D1FA==
X-Google-Smtp-Source: APXvYqwGlyJnlEq59mLMKWbsp++RpwLlOzOKGqXSO3wmeCPATfTk0pVzc08tE0JekugYulSf+RTbLg==
X-Received: by 2002:a1c:7e8d:: with SMTP id z135mr9980198wmc.72.1557857174089; 
	Tue, 14 May 2019 11:06:14 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id u9sm4707159wmd.14.2019.05.14.11.06.13
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 11:06:13 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190514180311.16028-1-armbru@redhat.com>
	<20190514180311.16028-7-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a27c149b-9a7c-0a59-159c-d1f878f1fbf6@redhat.com>
Date: Tue, 14 May 2019 20:06:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514180311.16028-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 6/6] cutils: Simplify how parse_uint()
 checks for whitespace
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
Cc: thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 8:03 PM, Markus Armbruster wrote:
> Use qemu_isspace() so we don't have to cast to unsigned char.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/cutils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/cutils.c b/util/cutils.c
> index d682c90901..9aacc422ca 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -683,7 +683,7 @@ int parse_uint(const char *s, unsigned long long *value, char **endptr,
>      }
>  
>      /* make sure we reject negative numbers: */
> -    while (isspace((unsigned char)*s)) {
> +    while (qemu_isspace(*s)) {
>          s++;
>      }
>      if (*s == '-') {
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

