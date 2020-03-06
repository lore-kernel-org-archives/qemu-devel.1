Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF74C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E1F207FD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L01Lkpdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E1F207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA8wu-0005C0-G4
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 04:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jA8w8-0004jE-RR
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jA8vz-0000v6-DG
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:06:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39699
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jA8vz-0000rl-9N
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583485576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZwooMAFgDjeQScf1c3SoI9bssB6zjdw9PwGn9Ek7z0M=;
 b=L01LkpduU0CuPsCDCqCmUn8hLyBBHbv/ak4evYcE0baMWgv15Dqiey/jA5cdJYkFuXuKWv
 KiyL/7gxJQ3uhRAW0XbMZ86mXGc/WHrU3DZq16bCNq7mLF66d3lzMX3yWVaCpbMx+TVg0l
 AuJaRJEFcV9iaS28HM6tCyJ06mJ64AQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-s2tPgnD-ONa0UwSuwIaN_w-1; Fri, 06 Mar 2020 04:06:14 -0500
X-MC-Unique: s2tPgnD-ONa0UwSuwIaN_w-1
Received: by mail-wm1-f71.google.com with SMTP id y7so630822wmd.4
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 01:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZwooMAFgDjeQScf1c3SoI9bssB6zjdw9PwGn9Ek7z0M=;
 b=QqV3dXfuW5OWiGqMT6NAM/Un1GxvFiMhM0J8hoF6se0iE7tz0J7Gh99JkqSduP6Q9e
 KJHcnBKk7xtyZLpzdwPooiYgqcF/JgG0fJ5FyRVHOBK/HMVXvQEkCdPNdfYpdhmTXDK/
 CQvvOGSfH6Uc7oTpGzdovg6cTSv8jmJ92dOI+Rldop88qdX91Ekpk2WebzyEwdI1+xzX
 tz6V2s26H5QydfMHojlYYyQkcff7TQ+Qxnh4T2twtxW09DCxSwz8HVnidejRMS2BEE0h
 EFkU/bzRW/7N/Y4rtItf3MBt5nKvT6wexFqXYa7hVFS3A66FPm0p7Z/nX3Io2Co7TWPz
 E7qw==
X-Gm-Message-State: ANhLgQ2XewpR83q50N7g1YQqxhu/nx/1Kjn/A9fB6yPh2ztb6wIHhkqo
 foygwab1J55F+GHkI1p6zLEm7o0nlugSLRdVw1mRzJHJs+s3/gVc+dh+HWiRHo8qoPwHu+I0/A3
 F2EMpLvI6RunCXKM=
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr3043320wmj.56.1583485573535;
 Fri, 06 Mar 2020 01:06:13 -0800 (PST)
X-Google-Smtp-Source: ADFU+vt6BgmCGj2RwV8Z9+4MeOZ6+BRHdukgUKJ1mDqwo71wkYGdq21ULDW9JtckHq6nX1MRHrgrHg==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr3043247wmj.56.1583485572889;
 Fri, 06 Mar 2020 01:06:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b99a:4374:773d:f32e?
 ([2001:b07:6468:f312:b99a:4374:773d:f32e])
 by smtp.gmail.com with ESMTPSA id p17sm45206297wre.89.2020.03.06.01.06.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 01:06:11 -0800 (PST)
Subject: Re: [PATCH] mem-prealloc: initialize cond and mutex
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20200306085014.120669-1-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b39d4dcf-fbcf-7f9f-7124-28f407d023e7@redhat.com>
Date: Fri, 6 Mar 2020 10:06:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306085014.120669-1-borntraeger@de.ibm.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 bauerchen <bauerchen@tencent.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/03/20 09:50, Christian Borntraeger wrote:
> Guests with mem-prealloc do fail with
> qemu-system-s390x: /home/cborntra/REPOS/qemu/util/qemu-thread-posix.c:76: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.
> qemu-system-s390x: /home/cborntra/REPOS/qemu/util/qemu-thread-posix.c:161: qemu_cond_broadcast: Assertion `cond->initialized' failed.
> 
> Let us initialize cond and mutex.
> 
> Cc: bauerchen <bauerchen@tencent.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Fixes: 037fb5eb3941 ("mem-prealloc: optimize large guest startup")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  util/oslib-posix.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 897e8f3ba6..52650183d3 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -470,6 +470,8 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>      char *addr = area;
>      int i = 0;
>  
> +    qemu_cond_init(&page_cond);
> +    qemu_mutex_init(&page_mutex);
>      memset_thread_failed = false;
>      threads_created_flag = false;
>      memset_num_threads = get_memset_num_threads(smp_cpus);
> 

Thank you very much.  It's my fault, but is it too much to ask that
submitters test their patches???

Paolo


