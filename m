Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562D6C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B3F20675
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B3F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43125 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH970-0001kp-82
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:38:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH94h-0008Q5-5o
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH8pM-0006YH-PG
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:19:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hH8pM-0006Hb-ID
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:19:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so3424640wre.7
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 08:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=eRji3Zrnn9M62MQbNCTIjkWUFP5o4Q/JNXuJtZJdsbs=;
	b=T64rjdbeg5IpO1Xi3yx9fE9Xk0MsSNXwaJTlxQuNzdgUDH9yUDUq/RkB4J4GhR6azb
	s++/CEafgNWXMi648fW7GDvqtH8O98FPi8j6emSoT91dGaTzEdowdKgg0GqKw0J/wUZf
	d0wY+SlZHTnMYy0CMYppSna9Lo4871+qI43T2om0CM4eeJR0xBV7AmBsxq/bGcGlYoXq
	oHsxJ5s9qAoAJ+K8yE0crpYdNbCkWxxsicT9Nn/2JzP4Fvb1ZoJcHIWkJPvWkI/JaE0B
	m0H2fhN5V/l5eL/x2tUjSGOTbS3VGTzDHfCaZs98NyNQKwKca7E0sdXCOdFJ+J2iwoez
	G9cw==
X-Gm-Message-State: APjAAAXPdgHVDJ9ufBHDYoO0z7kWpRsP+iXgJrOyZRw4Qg7JbOUtj6YP
	sfh1hnj2+kddU/MO5BloF5sE2Bdy4LE=
X-Google-Smtp-Source: APXvYqwLpRuBWvK8UXyhotl2xBNL3uQ4aSY7egBySVq81xqLSU0FmDMEvQ5JjkoKvrKW+G+P87/YoQ==
X-Received: by 2002:adf:b611:: with SMTP id f17mr3297726wre.162.1555600786794; 
	Thu, 18 Apr 2019 08:19:46 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	r30sm5814382wrr.46.2019.04.18.08.19.46
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Apr 2019 08:19:46 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
Date: Thu, 18 Apr 2019 17:19:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418145355.21100-2-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-bridge-helper: Fix misuse of
 isspace()
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418151945.RT5vrOWsn_zyI6IuG678B4vQhferu5HGGk4x2yVrhQI@z>

On 4/18/19 4:53 PM, Markus Armbruster wrote:
> parse_acl_file() passes char values to isspace().  Undefined behavior
> when the value is negative.  Not a security issue, because the
> characters come from trusted $prefix/etc/qemu/bridge.conf and the
> files it includes.
> 
> Fix by using qemu_isspace() instead.

Can we use g_ascii_isspace() and remove qemu_isspace()?

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-bridge-helper.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
> index 5396fbfbb6..0d60c07655 100644
> --- a/qemu-bridge-helper.c
> +++ b/qemu-bridge-helper.c
> @@ -29,6 +29,7 @@
>  #include <linux/if_bridge.h>
>  #endif
>  
> +#include "qemu-common.h"
>  #include "qemu/queue.h"
>  
>  #include "net/tap-linux.h"
> @@ -75,7 +76,7 @@ static int parse_acl_file(const char *filename, ACLList *acl_list)
>          char *ptr = line;
>          char *cmd, *arg, *argend;
>  
> -        while (isspace(*ptr)) {
> +        while (qemu_isspace(*ptr)) {
>              ptr++;
>          }
>  
> @@ -99,12 +100,12 @@ static int parse_acl_file(const char *filename, ACLList *acl_list)
>  
>          *arg = 0;
>          arg++;
> -        while (isspace(*arg)) {
> +        while (qemu_isspace(*arg)) {
>              arg++;
>          }
>  
>          argend = arg + strlen(arg);
> -        while (arg != argend && isspace(*(argend - 1))) {
> +        while (arg != argend && qemu_isspace(*(argend - 1))) {
>              argend--;
>          }
>          *argend = 0;
> 

