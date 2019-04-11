Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED579C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9AF20818
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9AF20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWBw-0003xN-Tt
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:40:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWBA-0003fi-4D
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWB9-0005OK-52
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:39:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWB8-0005Nf-RL
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:39:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so5769109wmk.4
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Rf1J5szixYKWdQmfGZlABZyCa3KiC7wcBXB8C1TAq8s=;
	b=P2Xz8+CrrbN74Hw751KvjDQzGR6QyJpuJnrUDOEB42sY8Fvy/yJzx+hAT1WRmQg5vm
	rutebQcqx4quPNkqVTC4R60/vA4qZpGlmYNV7Lm+HkPchLVP7y5RSV/iwxonrFl52eRD
	/edGXWQv/bRq5kB8dDg4o2mbh8KFCV0pjij2xMuk+twt6xFOBlGiTP99cr6VEXNqZ6Y+
	gqmwASGg0Pz7/CkOV8YbcYFHvrRBi9V3eVKV0tXKpUUV7RBJabUHA89AAustGEtKy1ag
	RbhkGHosNFIsSAgQA6FnZN5ncaw19hNEkbhDbcGxDS4TS07wbgY8+VhdNWUDFx0lmsX5
	v/Zg==
X-Gm-Message-State: APjAAAWevSInDPb1XA3nvI9bzGbai3nYHQPVfYbExdG7y2atCTdipWmU
	zBR0tv/uI7ce6hr9UXsDDVcDmA==
X-Google-Smtp-Source: APXvYqwKwO3fxiCYm0wdZi00v+QBLRbUL9C5FEFC6tOiCBt51O0FG8FrWdHitjLs7yjpZaniDHIzuA==
X-Received: by 2002:a1c:f115:: with SMTP id p21mr5834551wmh.93.1554975569870; 
	Thu, 11 Apr 2019 02:39:29 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	x205sm6937866wmg.9.2019.04.11.02.39.29
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 02:39:29 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <73de8c44-6616-d876-33a5-05524b9e05ae@redhat.com>
Date: Thu, 11 Apr 2019 11:39:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v3 07/23] ui/vnc: Split out
 authentication_failure
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
Message-ID: <20190411093928.eZsmBTn6rbo0D3AlL58ElW3BVqVztvaMiPwNTXnKgAI@z>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> There were 3 copies of this code, one of which used the wrong
> data size for the failure indicator.

Which, as the comment said, has never been called.

Good cleanup.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  ui/vnc.c | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 1871422e1d..785edf3af1 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -2535,6 +2535,18 @@ void start_client_init(VncState *vs)
>      vnc_read_when(vs, protocol_client_init, 1);
>  }
>  
> +static void authentication_failed(VncState *vs)
> +{
> +    vnc_write_u32(vs, 1); /* Reject auth */
> +    if (vs->minor >= 8) {
> +        static const char err[] = "Authentication failed";
> +        vnc_write_u32(vs, sizeof(err));
> +        vnc_write(vs, err, sizeof(err));
> +    }
> +    vnc_flush(vs);
> +    vnc_client_error(vs);
> +}
> +
>  static void make_challenge(VncState *vs)
>  {
>      int i;
> @@ -2609,14 +2621,7 @@ static int protocol_client_auth_vnc(VncState *vs, uint8_t *data, size_t len)
>      return 0;
>  
>  reject:
> -    vnc_write_u32(vs, 1); /* Reject auth */
> -    if (vs->minor >= 8) {
> -        static const char err[] = "Authentication failed";
> -        vnc_write_u32(vs, sizeof(err));
> -        vnc_write(vs, err, sizeof(err));
> -    }
> -    vnc_flush(vs);
> -    vnc_client_error(vs);
> +    authentication_failed(vs);
>      qcrypto_cipher_free(cipher);
>      return 0;
>  }
> @@ -2638,13 +2643,7 @@ static int protocol_client_auth(VncState *vs, uint8_t *data, size_t len)
>       * must pick the one we sent. Verify this */
>      if (data[0] != vs->auth) { /* Reject auth */
>         trace_vnc_auth_reject(vs, vs->auth, (int)data[0]);
> -       vnc_write_u32(vs, 1);
> -       if (vs->minor >= 8) {
> -           static const char err[] = "Authentication failed";
> -           vnc_write_u32(vs, sizeof(err));
> -           vnc_write(vs, err, sizeof(err));
> -       }
> -       vnc_client_error(vs);
> +       authentication_failed(vs);
>      } else { /* Accept requested auth */
>         trace_vnc_auth_start(vs, vs->auth);
>         switch (vs->auth) {
> @@ -2673,13 +2672,7 @@ static int protocol_client_auth(VncState *vs, uint8_t *data, size_t len)
>  
>         default: /* Should not be possible, but just in case */
>             trace_vnc_auth_fail(vs, vs->auth, "Unhandled auth method", "");
> -           vnc_write_u8(vs, 1);
> -           if (vs->minor >= 8) {
> -               static const char err[] = "Authentication failed";
> -               vnc_write_u32(vs, sizeof(err));
> -               vnc_write(vs, err, sizeof(err));
> -           }
> -           vnc_client_error(vs);
> +           authentication_failed(vs);
>         }
>      }
>      return 0;
> 

