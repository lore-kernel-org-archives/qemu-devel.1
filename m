Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE74C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64F520880
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64F520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho3ez-0007g5-J4
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 06:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60036)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1ho3eo-0007H8-L9
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ho3en-000860-Eb
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:29:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ho3en-000857-7E
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:29:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so13087390wrr.9
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 03:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8y+VbipRelHaRQSfKA0Z/jpG1xGcyvB3Xy6J4198Wp4=;
 b=Qt24aEkWNXcPwirERvuhht7Y4FH9zvAeBkDBcu8J3EuqoU8KfpWeZghKEslpMqf9z5
 knFwK0Z3izK/Q206Pqr6pb3XAlvYExxQbBSj/B4pLZUF1eFIC0zL2acyFOXc+b5uAWSl
 EOpQh9lh0ROYl7DbZTGR1FF/t3EUIhy+HmX9W1fC2kyQruj6PLlk2mwfvVbz7gMp7cqw
 pk1a/Wr0onTocj3Gle5/dIoCfp6eOh6KTe4W3gyQ+gmi75RD570wA7wJUNQv5hBPX4an
 BT0PfqksFlds1K6RYeNiQTZLm1gb4tpq7rwhJLl2eyYM5N+DuriW7TDzNME9opEXOBOi
 W2dw==
X-Gm-Message-State: APjAAAW4/Tv6pd9p/693Th8/TkRwode9hjvR4gRFuhLRdYzaFqKG81B2
 6Bnvg9Ot0prdUyII3EKaw1kKxQ==
X-Google-Smtp-Source: APXvYqwNF6hHIj3IM6M6bKmJJ/RixKe6+lT2B6mPxrx0xSNh54dt01HU8ZeUl6YU+hHghuqnY2O0iA==
X-Received: by 2002:a5d:4b91:: with SMTP id b17mr11475926wrt.57.1563445739434; 
 Thu, 18 Jul 2019 03:28:59 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id t15sm24285603wrx.84.2019.07.18.03.28.58
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 03:28:58 -0700 (PDT)
To: Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
References: <20190718092219.20081-1-chen.zhang@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <375615d7-7cdf-4711-68fb-47ce3c8cb308@redhat.com>
Date: Thu, 18 Jul 2019 12:28:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190718092219.20081-1-chen.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH V3] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/18/19 11:22 AM, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> This patch to fix the origin "char *data" menory leak, code style issue

"memory"

> and add necessary check here.
> Reported-by: Coverity (CID 1402785)
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  net/colo-compare.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 909dd6c6eb..fcccb4c6f6 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -127,6 +127,17 @@ static int compare_chr_send(CompareState *s,
>                              uint32_t vnet_hdr_len,
>                              bool notify_remote_frame);
>  
> +static bool packet_matches_str(const char *str,
> +                               uint8_t *buf,

You can use 'uint8_t *buf'.

> +                               uint32_t packet_len)
> +{
> +    if (packet_len != strlen(str)) {
> +        return false;
> +    }
> +
> +    return !memcmp(str, buf, strlen(str));

If you don't want to use a local variable to hold strlen(str), you can
reuse packet_len since it is the same value:

       return !memcmp(str, buf, packet_len);

However it makes the review harder, so I'd prefer using a str_len local var.

> +}
> +
>  static void notify_remote_frame(CompareState *s)
>  {
>      char msg[] = "DO_CHECKPOINT";
> @@ -1008,21 +1019,24 @@ static void compare_notify_rs_finalize(SocketReadState *notify_rs)
>  {
>      CompareState *s = container_of(notify_rs, CompareState, notify_rs);
>  
> -    /* Get Xen colo-frame's notify and handle the message */
> -    char *data = g_memdup(notify_rs->buf, notify_rs->packet_len);
> -    char msg[] = "COLO_COMPARE_GET_XEN_INIT";
> +    const char msg[] = "COLO_COMPARE_GET_XEN_INIT";
>      int ret;
>  
> -    if (!strcmp(data, "COLO_USERSPACE_PROXY_INIT")) {
> +    if (packet_matches_str("COLO_USERSPACE_PROXY_INIT",
> +                           notify_rs->buf,
> +                           notify_rs->packet_len)) {
>          ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
>          if (ret < 0) {
>              error_report("Notify Xen COLO-frame INIT failed");
>          }
> -    }
> -
> -    if (!strcmp(data, "COLO_CHECKPOINT")) {
> +    } else if (packet_matches_str("COLO_CHECKPOINT",
> +                                  notify_rs->buf,
> +                                  notify_rs->packet_len)) {
>          /* colo-compare do checkpoint, flush pri packet and remove sec packet */
>          g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> +    } else {
> +        error_report("COLO compare got unsupported instruction '%s'",
> +                     (char *)notify_rs->buf);
>      }
>  }
>  
> 

