Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9194C33CAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC484206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sovijNBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC484206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itKWO-0001k8-Q2
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 19:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itKVe-0000im-1h
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itKVc-0002Uc-S2
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:01:37 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itKVc-0002Tz-Lj
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:01:36 -0500
Received: by mail-wr1-x443.google.com with SMTP id q10so27750212wrm.11
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2020 16:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4SQWr8CIappi+/ssbZKA0Sdr8rbZ6f5LwP2/WoHyzJM=;
 b=sovijNBCfuUAlhB+sfJ7ejRD3QsRPdCqLDMfF1dInqLwVnjFslw4dbQ7hGlI1ZNDh9
 93YL+YMPOvNtdPKop15yl+Fp+DtivPaeMOO83HQF6yQnTDPa7ovm9tmqSptutD1MursQ
 +WfZhuE0dEW64WiM+gHWC/JseNCZcUDtgQU8KF5DDz+ILwWJo4zkIAGQhEh3J9VdPXka
 wdkcaO5qkd+aPBoaexbMA4MhFxnEd6pUHajGr5cTQgaJDLKwXAsgocChhZhLdkkG6ecK
 zMY4UIPdQq0mTLDHZ8a0xIiMhS61U/I5UldCBVxyyCVWqoi51uD3ZszdyFj0ERV50BSy
 yTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4SQWr8CIappi+/ssbZKA0Sdr8rbZ6f5LwP2/WoHyzJM=;
 b=lpz3izDEbTN/D1UAkSfUk2uqrzaBHj6PwrqgdPTdnEqCKcYMXjl++cuD6jck5bTha9
 r4OCiEf97yy3o9uLJ9z3NgaxZQRANPwAhKhpp3VfZ2BzA7EqU++GG+4kklYVZLBXXuZ6
 vuItTecRaM/JtvUhIu/AFf/yf3Q6NaqwO+KE6L2ZPLyxiZZH/5+4RC6EuhcBTnup+65p
 tRdKc38DX59t6pTNzdMXZBIEcrZb02RaXdaCHMkwfnGFWhn6u2Ooyavrk9thJljzWk5Q
 7m+UBq11RQfo552clc2EDQRyKhmq9w3ZJqKNQjmCi3qDg+AiPqi9bhGvLEWlwf9ydjln
 QZ+g==
X-Gm-Message-State: APjAAAWJpUJ0AqdNwemdSLEcNzdxcPxDcZpvZ4mmelFY7BUD1R+ttcms
 9AIAjrRl50vXg3mMLG8HyQE=
X-Google-Smtp-Source: APXvYqxmxSh0CwKT8M4ta4W34FnNzRjpnQsfbpA58gFK1VnJ10fXC4GHEI/da1kfY+5e+ZrSmJ6Zww==
X-Received: by 2002:adf:f103:: with SMTP id r3mr15096723wro.295.1579478495019; 
 Sun, 19 Jan 2020 16:01:35 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id 25sm392162wmi.32.2020.01.19.16.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jan 2020 16:01:33 -0800 (PST)
Subject: Re: [PATCH v3] ui: Print available display backends with '-display
 help'
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20200108144702.29969-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <b1581c7e-bc9e-3a79-a913-be48f6f550c7@amsat.org>
Date: Mon, 20 Jan 2020 01:01:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108144702.29969-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On 1/8/20 3:47 PM, Thomas Huth wrote:
> We already print availabled devices with "-device help", or available
> backends with "-netdev help" or "-chardev help". Let's provide a way
> for the users to query the available display backends, too.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v3: Mention -display help in the qemu-doc, too (as suggested by Philippe)
> 
>  include/ui/console.h |  1 +
>  qemu-options.hx      |  3 ++-
>  ui/console.c         | 15 +++++++++++++++
>  vl.c                 |  5 +++++
>  4 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 281f9c145b..f35b4fc082 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -442,6 +442,7 @@ void qemu_display_register(QemuDisplay *ui);
>  bool qemu_display_find_default(DisplayOptions *opts);
>  void qemu_display_early_init(DisplayOptions *opts);
>  void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
> +void qemu_display_help(void);
>  
>  /* vnc.c */
>  void vnc_display_init(const char *id, Error **errp);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index e9d6231438..d593931664 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1586,7 +1586,8 @@ STEXI
>  @item -display @var{type}
>  @findex -display
>  Select type of display to use. This option is a replacement for the
> -old style -sdl/-curses/... options. Valid values for @var{type} are
> +old style -sdl/-curses/... options. Use @code{-display help} to list
> +the available display types. Valid values for @var{type} are
>  @table @option
>  @item sdl
>  Display video output via SDL (usually in a separate graphics
> diff --git a/ui/console.c b/ui/console.c
> index ac79d679f5..69339b028b 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -2333,6 +2333,21 @@ void qemu_display_init(DisplayState *ds, DisplayOptions *opts)
>      dpys[opts->type]->init(ds, opts);
>  }
>  
> +void qemu_display_help(void)
> +{
> +    int idx;
> +
> +    printf("Available display backend types:\n");
> +    for (idx = DISPLAY_TYPE_NONE; idx < DISPLAY_TYPE__MAX; idx++) {
> +        if (!dpys[idx]) {
> +            ui_module_load_one(DisplayType_str(idx));
> +        }
> +        if (dpys[idx]) {
> +            printf("%s\n",  DisplayType_str(dpys[idx]->type));

While listed in the man page, the "none" display is not listed here, any
clue?

> +        }
> +    }
> +}
> +
>  void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp)
>  {
>      int val;
> diff --git a/vl.c b/vl.c
> index 86474a55c9..ee15055ba2 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1869,6 +1869,11 @@ static void parse_display(const char *p)
>  {
>      const char *opts;
>  
> +    if (is_help_option(p)) {
> +        qemu_display_help();
> +        exit(0);
> +    }
> +
>      if (strstart(p, "sdl", &opts)) {
>          /*
>           * sdl DisplayType needs hand-crafted parser instead of
> 

