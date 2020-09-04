Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8FEC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8C9206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8C9206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE6cf-0000OW-Ng
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 03:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kE6c7-0008NQ-Bm
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:58:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54287
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kE6c5-0000cF-MJ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:58:27 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-N0Uh4I6IOu2QfOSE_GnwUQ-1; Fri, 04 Sep 2020 03:58:23 -0400
X-MC-Unique: N0Uh4I6IOu2QfOSE_GnwUQ-1
Received: by mail-ej1-f69.google.com with SMTP id m24so2221393eje.20
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 00:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cbamT1anqRXC1BHuxA18KtGCfk0XyzGTnyVJbFvkHvs=;
 b=iL5BIuOktERR6eAgc/gaUHC6XdthGVDw4+rMcFBn/I+UaavbmzkzRIp5m3iRSzbCWl
 M+atLNOluQi3WywoJpAP7YXCiG724AK++bs8ec6GIOYK6ebD1PUTOeZrYRg0wCa8fxp8
 HxHQMc94Ek4I+WkhC2NsSoNag979AgUXCOS3M/v07cKLrWFbuL6rGDpGhQ+pCMyXSQwr
 Kb5KYfI2EqPCR+o7zgvFdguryz6O/TFiIEgSOKif3bWRTpRsEMeAANlFddowsppJXiBc
 +QOqV6lUmxKZr2/gB3W5u27sl55Op0nXD7Fc8TJNYCvSKaVkxWELkMFq9NVQcGXI4f7O
 eI6Q==
X-Gm-Message-State: AOAM533LjIapP8KqzMaHzOsm4F/JmbXvM16cwYOrr6frtGxRbwwAbeqI
 ml66EAm5H1iLoqEDIseKoKCKjbl/zAeyyN/VpWyoQJY0HV4qd6cH9cj84xBJAjbyohjfYnmrFQ8
 HrcPjQRncb3nlXfo=
X-Received: by 2002:aa7:d458:: with SMTP id q24mr7311174edr.23.1599206302543; 
 Fri, 04 Sep 2020 00:58:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxn+qinoG9NH7edAnyK5uVYUKzac6aCZE0JpY1H6ACNYkKo5RERWK0r+2VreTSoxy+ryOZDSw==
X-Received: by 2002:aa7:d458:: with SMTP id q24mr7311156edr.23.1599206302357; 
 Fri, 04 Sep 2020 00:58:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6276:52ed:96d5:c094?
 ([2001:b07:6468:f312:6276:52ed:96d5:c094])
 by smtp.gmail.com with ESMTPSA id t14sm5394353ejj.28.2020.09.04.00.58.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 00:58:21 -0700 (PDT)
Subject: Re: [PATCH v2] tests: Trying fixes test-replication.c on msys2.
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20200903220655.1333-1-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4581f74-5079-5d1a-3687-bdf85aaf7aab@redhat.com>
Date: Fri, 4 Sep 2020 09:58:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903220655.1333-1-luoyonggang@gmail.com>
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/09/20 00:06, Yonggang Luo wrote:
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/test-replication.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/test-replication.c b/tests/test-replication.c
> index 9ab3666a90..d0e06f8d77 100644
> --- a/tests/test-replication.c
> +++ b/tests/test-replication.c
> @@ -23,14 +23,18 @@
>  
>  /* primary */
>  #define P_ID "primary-id"
> -static char p_local_disk[] = "/tmp/p_local_disk.XXXXXX";
> +#define P_LOCAL_DISK "%s/p_local_disk.XXXXXX"
> +static char p_local_disk[PATH_MAX];
>  
>  /* secondary */
>  #define S_ID "secondary-id"
>  #define S_LOCAL_DISK_ID "secondary-local-disk-id"
> -static char s_local_disk[] = "/tmp/s_local_disk.XXXXXX";
> -static char s_active_disk[] = "/tmp/s_active_disk.XXXXXX";
> -static char s_hidden_disk[] = "/tmp/s_hidden_disk.XXXXXX";
> +#define S_LOCAL_DISK "%s/s_local_disk.XXXXXX"
> +static char s_local_disk[PATH_MAX];
> +#define S_ACTIVE_DISK "%s/s_active_disk.XXXXXX"
> +static char s_active_disk[PATH_MAX];
> +#define S_HIDDEN_DISK "%s/s_hidden_disk.XXXXXX"
> +static char s_hidden_disk[PATH_MAX];
>  
>  /* FIXME: steal from blockdev.c */
>  QemuOptsList qemu_drive_opts = {
> @@ -571,7 +575,12 @@ static void setup_sigabrt_handler(void)
>  int main(int argc, char **argv)
>  {
>      int ret;
> +    const char *tmpdir = g_get_tmp_dir();
>      qemu_init_main_loop(&error_fatal);
> +    sprintf(p_local_disk, P_LOCAL_DISK, tmpdir);
> +    sprintf(s_local_disk, S_LOCAL_DISK, tmpdir);
> +    sprintf(s_active_disk, S_ACTIVE_DISK, tmpdir);
> +    sprintf(s_hidden_disk, S_HIDDEN_DISK, tmpdir);
>      bdrv_init();
>  
>      g_test_init(&argc, &argv, NULL);
> 

Cc: qemu-block@nongnu.org


