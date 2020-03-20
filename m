Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D78C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C951020724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UjLfi/HJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C951020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJzK-0007HH-Vk
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFJyQ-0006cH-Gt
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFJyO-0002Cf-Sy
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:54:14 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:38236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFJyO-0002CH-IF
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:54:12 -0400
Received: by mail-ot1-x32b.google.com with SMTP id t28so6427995ott.5
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WR4ZjY9w3wcgk9iWbPISOI1l444nD/YC8jeQRPff9nY=;
 b=UjLfi/HJQIxFeQHPi7sMZ0ihU3Pz31oqJ6dIm5KYlcVVdixsxSKRstNkwPTYlbgkYN
 w7wHS8XO9SAHazA4lpTUhKFFPoqeVokYYvBaHL0abSutLvmDgpJJ3LtK1KrPa0xElHnv
 0PFN561o2okZA+x7AtjdUQklLLMcLndZy7gkhUsHTuP8UAK3Fw9pyBebLzcype8bQxJY
 iKuNXZDmGRjVb4sgMlj+nbYpYP5z9NWMwTq0avndx+l5wJflDnalt2HyudloLscqWmwM
 HLKICgM24aMXBZ1nlOogHS1gU8ukSM1FS8M6ft2dTZsjnxIA7Egf6MbCQjJ1NAjQJXMX
 B/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WR4ZjY9w3wcgk9iWbPISOI1l444nD/YC8jeQRPff9nY=;
 b=NCCI6ECKe+SJ9DC9uDvnDprHWSez+VdB3k2fDE8UlEs2vVpGSZKM/frBrPpYBv6NLr
 IywWHV5C2xcEDPIr3NZscSkVwb+FLu/sl/+gnYnyYdMLNmir6aRF8urKQWW5OeXnkIj4
 NIG4sP7i5p6MjIdxTZQIGgrV1U2uamu76LgXlPcwFUQXmyYpQXQGwuiAfcPUUHkaxZrA
 5srbpJTI/0YCD1/NTFDjIqwMYw3OJoxfCJs2CaGP+H9KSxVTNmC5c4aa4RV4yLG0Mkqg
 4cj1dSaRCOWrO2ijBEqaRbaKhRICs9b1hloTqEjXpN56X77bgG/KY88HZ9ABNWpy6qEm
 A9Jg==
X-Gm-Message-State: ANhLgQ2yGOoFeOTYj7BAjZBUvdaw6hOVvAdwILsMZQ8TpzQWudQkwc1t
 51rp/Hg7QQ2/SuG83KSfO5HrjuklOVDlDbHYKn/qQg==
X-Google-Smtp-Source: ADFU+vvDdyqCbUndp0LgVB2bPYt0aunLkYdSdHYqeQw5g5WdnF6NlYTZYu/BfHHWHSLDf/3fF63wJ6Zvx6ywSXew9/M=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr6938067ota.221.1584719651433; 
 Fri, 20 Mar 2020 08:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20170717093839.15341-1-kraxel@redhat.com>
 <20170717093839.15341-3-kraxel@redhat.com>
In-Reply-To: <20170717093839.15341-3-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 15:54:00 +0000
Message-ID: <CAFEAcA8MWO5bo65Jv=QX=9ucB2xCyShnBRQ7Sow6UCEs58+-Tw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 2/3] hmp: Update info vnc
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Jul 2017 at 10:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The QMP query-vnc interfaces have gained a lot more information that
> the HMP interfaces hasn't got yet. Update it.
>
> Note the output format has changed, but this is HMP so that's OK.

Hi; another "ancient change Coverity has only just noticed has
a problem" email :-)   This is CID 1421932. It looks like any
"info vnc" will leak memory if there are any VNC servers to
display info about...

>  void hmp_info_vnc(Monitor *mon, const QDict *qdict)
>  {
> -    VncInfo *info;
> +    VncInfo2List *info2l;
>      Error *err = NULL;
> -    VncClientInfoList *client;
>
> -    info = qmp_query_vnc(&err);
> +    info2l = qmp_query_vnc_servers(&err);

Here we get a list of VNC servers, which is allocated memory...

>      if (err) {
>          error_report_err(err);
>          return;
>      }
> -
> -    if (!info->enabled) {
> -        monitor_printf(mon, "Server: disabled\n");
> -        goto out;
> -    }
> -
> -    monitor_printf(mon, "Server:\n");
> -    if (info->has_host && info->has_service) {
> -        monitor_printf(mon, "     address: %s:%s\n", info->host, info->service);
> -    }
> -    if (info->has_auth) {
> -        monitor_printf(mon, "        auth: %s\n", info->auth);
> +    if (!info2l) {
> +        monitor_printf(mon, "None\n");
> +        return;
>      }
>
> -    if (!info->has_clients || info->clients == NULL) {
> -        monitor_printf(mon, "Client: none\n");
> -    } else {
> -        for (client = info->clients; client; client = client->next) {
> -            monitor_printf(mon, "Client:\n");
> -            monitor_printf(mon, "     address: %s:%s\n",
> -                           client->value->host,
> -                           client->value->service);
> -            monitor_printf(mon, "  x509_dname: %s\n",
> -                           client->value->x509_dname ?
> -                           client->value->x509_dname : "none");
> -            monitor_printf(mon, "    username: %s\n",
> -                           client->value->has_sasl_username ?
> -                           client->value->sasl_username : "none");
> +    while (info2l) {
> +        VncInfo2 *info = info2l->value;
> +        monitor_printf(mon, "%s:\n", info->id);
> +        hmp_info_vnc_servers(mon, info->server);
> +        hmp_info_vnc_clients(mon, info->clients);
> +        if (!info->server) {
> +            /* The server entry displays its auth, we only
> +             * need to display in the case of 'reverse' connections
> +             * where there's no server.
> +             */
> +            hmp_info_vnc_authcrypt(mon, "  ", info->auth,
> +                               info->has_vencrypt ? &info->vencrypt : NULL);
> +        }
> +        if (info->has_display) {
> +            monitor_printf(mon, "  Display: %s\n", info->display);
>          }
> +        info2l = info2l->next;

...but the loop iteration here updates 'info2l' as it goes along...

>      }
>
> -out:
> -    qapi_free_VncInfo(info);
> +    qapi_free_VncInfo2List(info2l);

...so here we end up passing NULL to qapi_free_VncInfo2List(),
which will do nothing, leaking the whole list.

Would somebody like to send a patch?

thanks
-- PMM

