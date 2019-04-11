Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9228C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8551F20818
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8551F20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWD3-000525-NI
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:41:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWCC-0004HZ-5c
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWCB-0005pA-43
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:40:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWC3-0005l0-VH
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:40:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so6406083wre.7
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=s71QxVDj5kMmlKe7QE3TQoyfj0xSCesYOFviL6dcq54=;
	b=bSrGpELeCt23Awd9TPX61eR+3YR3mgaznT50hOrhJ8aAEoTGwMZzbNVF1m7oo3OJbh
	P80cnrA0b020yidQwWJKwjPu34u+Jtfm48B+QCr/3emtGnhiJu4sq+pNOEi24ZUCln7s
	OWluyyMSjb4WNLk1tCQXYSaxPfR7/FNKqiAtfuVwej06zMSzAh06V+FRXmRs0xSwF21y
	uyCWR8RvgQwoA1e1S2Kt8YM8+6CzV+OLKBXTeKkK6p1knKEpuTq4UcJNnofecYuAredt
	qwsNRWNPEd48cEQUzoE1lxzvV73+Pe2VuNzkQErNwOAys2EkxWBQHbb3C8kr6p89wZHm
	ZE/g==
X-Gm-Message-State: APjAAAXdVbtmVnywRssXCaT5JQGukRFv5BBufenDm09vWquy58WZEfbn
	lCY/iyf3Jt+N5ZBBhGMuLfd/Sg==
X-Google-Smtp-Source: APXvYqyhggyAwdAyOLKb+SLquDv6jVs+jNbg0s1deOs+dgK5tH/2+3jHwlxg+U45AV5JOLi+GEGiuw==
X-Received: by 2002:a5d:69c2:: with SMTP id s2mr29734103wrw.83.1554975622841; 
	Thu, 11 Apr 2019 02:40:22 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	g12sm39627502wrw.40.2019.04.11.02.40.21
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 02:40:22 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <73b0d19e-aad2-b9f0-1f12-64889e77521d@redhat.com>
Date: Thu, 11 Apr 2019 11:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 08/23] ui/vnc: Use gcrypto_random_bytes
 for start_auth_vnc
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411094021.4co5AwCByb_a2LRD9ghdp1QQW9rfpzwKRVQydpIPpI8@z>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> Use a better interface for random numbers than rand().
> Fail gracefully if for some reason we cannot use the crypto system.
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v2: Use qcrypto_random_bytes, not qemu_getrandom, as there is
>     no need for deterministic results for this interface.
> v3: Fail gracefully in the event qcrypto_random_bytes fails.
> ---
>  ui/vnc.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 785edf3af1..d83f4a6ff9 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -43,6 +43,7 @@
>  #include "crypto/hash.h"
>  #include "crypto/tlscredsanon.h"
>  #include "crypto/tlscredsx509.h"
> +#include "crypto/random.h"
>  #include "qom/object_interfaces.h"
>  #include "qemu/cutils.h"
>  #include "io/dns-resolver.h"
> @@ -2547,16 +2548,6 @@ static void authentication_failed(VncState *vs)
>      vnc_client_error(vs);
>  }
>  
> -static void make_challenge(VncState *vs)
> -{
> -    int i;
> -
> -    srand(time(NULL)+getpid()+getpid()*987654+rand());
> -
> -    for (i = 0 ; i < sizeof(vs->challenge) ; i++)
> -        vs->challenge[i] = (int) (256.0*rand()/(RAND_MAX+1.0));
> -}
> -
>  static int protocol_client_auth_vnc(VncState *vs, uint8_t *data, size_t len)
>  {
>      unsigned char response[VNC_AUTH_CHALLENGE_SIZE];
> @@ -2628,7 +2619,16 @@ reject:
>  
>  void start_auth_vnc(VncState *vs)
>  {
> -    make_challenge(vs);
> +    Error *err = NULL;
> +
> +    if (qcrypto_random_bytes(vs->challenge, sizeof(vs->challenge), &err)) {
> +        trace_vnc_auth_fail(vs, vs->auth, "cannot get random bytes",
> +                            error_get_pretty(err));
> +        error_free(err);
> +        authentication_failed(vs);
> +        return;
> +    }
> +
>      /* Send client a 'random' challenge */
>      vnc_write(vs, vs->challenge, sizeof(vs->challenge));
>      vnc_flush(vs);
> 

