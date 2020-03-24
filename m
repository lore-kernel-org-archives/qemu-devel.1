Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA2CC41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A40E20775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqfChfb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A40E20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjUT-0004tG-5N
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGjTh-0003xm-03
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGjTb-0000ic-Qb
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:20:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49657)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGjTb-0000hl-MV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585056015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ShwtzyjCJA65XBQq0mzZKXKhyJecXYZ8q2T40tPRaEw=;
 b=fqfChfb3DQfd/79xK0Ew/NnGBw/j96OE2SJDm6FTvc6OyZcyokZjhdJ3KCWBhkX8dwLKCr
 xGkBdX+C+vihsLu84T9yxS7e7ZKt6qOtzwfT2+ltaLVsKSbIRPXR5tvN1cjvBouRBu3fcf
 tyc6RBZSW9zPJuRYIcpt6gF6zVKZxhQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-aBXh0u8mNua7XKwqNG7wJQ-1; Tue, 24 Mar 2020 09:20:10 -0400
X-MC-Unique: aBXh0u8mNua7XKwqNG7wJQ-1
Received: by mail-ed1-f72.google.com with SMTP id b9so13737030edj.10
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 06:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ShwtzyjCJA65XBQq0mzZKXKhyJecXYZ8q2T40tPRaEw=;
 b=UMy3skdFgzHefIpIcqoZXHj8RUMfywH3WdsS2S+UETtZLx6Vy1R46j/nhGUDTXHLFs
 4hoDcIcPwALayT/GcOsSLqrek5pJn3NdhY7A591cI5aGjXTfCtaD6vEpjoTOJeuKLtOc
 Dv0uvs5gPnLcIU6M/9Cjft/kzS1mqdyH15bKy77vCwcAvuOcwqvrfxBZdvqKsnVCbtD0
 OyPwsh//+Re8gwt15n5EwNPBe8XaekcUNKTz0lCOXaEcCZzJftGDWM7vV2S5/l7YOSNz
 IWD8D1IMe4GcANu9PrnZK4JCvIJBCWalWNmPZvYj2fGOrIi7cpQ/3vYKAYvM+Q8WYgX2
 gu8g==
X-Gm-Message-State: ANhLgQ120+eBpK0jVKR/L77eE74bvSzurYizmnsMnpHLp7XT4uTrSo/r
 Fqz9KRn5PVqfpq10s3b9KsiXMhYDI75d83bbOHLYS6zRHIN+E4KZWrM8+4B4qixuWx7wZU3WrLu
 Fh+cNoCFNsRPLo/I=
X-Received: by 2002:a50:cf4d:: with SMTP id d13mr17563232edk.175.1585056009643; 
 Tue, 24 Mar 2020 06:20:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu6aVd9WzedfRnLs1Fllwwr+pRjhSpC1osfoHJJx2pRQe/oIe1MBm6Ofu7FfnTJDIMjN8WNYQ==
X-Received: by 2002:a50:cf4d:: with SMTP id d13mr17563200edk.175.1585056009314; 
 Tue, 24 Mar 2020 06:20:09 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id s19sm1106438ejx.2.2020.03.24.06.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 06:20:08 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] qga-win: prevent crash when executing
 guest-file-read with large count
To: Basil Salman <basil@daynix.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
References: <20200311170417.13415-1-basil@daynix.com>
 <20200311170417.13415-4-basil@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <26fa941f-b578-06e7-947e-34ab426097bc@redhat.com>
Date: Tue, 24 Mar 2020 14:20:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311170417.13415-4-basil@daynix.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Yan Vugenfirer <yan@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/11/20 6:04 PM, Basil Salman wrote:
> BZ: #1594054

^ This is not very helpful as it... (think to ppl with no knowledge of 
'BZ', what to do with this number). Instead ...

> guest-file-read command is currently implemented to read from a
> file handle count number of bytes. when executed with a very large count number
> qemu-ga crashes.
> after some digging turns out that qemu-ga crashes after trying to allocate
> a buffer large enough to save the data read in it, the buffer was allocated using
> g_malloc0 which is not fail safe, and results a crash in case of failure.
> g_malloc0 was replaced with g_try_malloc0() which returns NULL on failure,
> A check was added for that case in order to prevent qemu-ga from crashing
> and to send a response to the qemu-ga client accordingly.
> 

... add here (see 
https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message):

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1594054

Also add:

Cc: qemu-stable@nongnu.org

> Signed-off-by: Basil Salman <basil@daynix.com>
> ---
>   qga/commands-win32.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 9c744d6405..b49920e201 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -343,7 +343,13 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
>       }
>   
>       fh = gfh->fh;
> -    buf = g_malloc0(count+1);
> +    buf = g_try_malloc0(count + 1);
> +    if (!buf) {
> +        error_setg(errp,
> +                   "failed to allocate sufficient memory "
> +                   "to complete the requested service");
> +        return NULL;
> +    }

Can you fix the equivalent problem in qga/commands-posix.c too please?

Also use "PATCH-for-5.0" in the patch subject so we don't miss it for 
the next release.

Thanks!

Phil.

>       is_ok = ReadFile(fh, buf, count, &read_count, NULL);
>       if (!is_ok) {
>           error_setg_win32(errp, GetLastError(), "failed to read file");
> 


