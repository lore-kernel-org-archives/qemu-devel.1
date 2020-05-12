Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C0DC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58D9207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeNLiXew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58D9207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYQ51-0007i8-To
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 04:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYQ49-0007A4-Uw
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:15:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56779
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYQ48-0000mi-DS
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589271303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LfY+P4E84ACT4pHKXPJGRE3B2x4svyo782OvyIAXG+g=;
 b=YeNLiXew5SK/nDbXWYulCAmWInyKmLGF/i19Sk78zQueAsUs3L2o4n5Eo3kj0UyIglBbDD
 FAwnKVMWashuIBB+pbqsZ1CDSA+dmp1QFlrguP44+xrzQn3BIPAn5pty8cpifaJembQZz6
 U81u+yNbQHXTnql5lgJ/7dY9vI5DYHc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-zRI2ora7PI6OB9eulN_e9Q-1; Tue, 12 May 2020 04:15:01 -0400
X-MC-Unique: zRI2ora7PI6OB9eulN_e9Q-1
Received: by mail-wr1-f70.google.com with SMTP id r7so350034wrc.13
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 01:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LfY+P4E84ACT4pHKXPJGRE3B2x4svyo782OvyIAXG+g=;
 b=cxHgNmBnv7Pr8InD292FllHV6TvT64cTQql0eNDRadGmAa167n3KeUtKqFLAQSR1SO
 GpTdKrZo3lIKoV2NnnEGAbtka/8E4X2D+KzwPAMx73F4Df0hCGuV7dryQFIRE2ckMePo
 XH9L9Fw/a0JjJ76ezy8vwTHhjzn39Ugj2gsV6INaTE71ZylQyGGPVI9O8Ab961n8YCvr
 E1cuPpC4cjd8QyXVWP0KJ3zgr64roMIPKVhUwldp5FICGNrOCpgzRHWIgjsOSXUNzH/S
 AVCdswQY82ZQQKzREfRlbgJODWi39gx3Nyd4phYVrevfVDYFr7B7HPbuOBqBoUxiOg7a
 G38Q==
X-Gm-Message-State: AGi0PuZMUlu0MtsHRjiJezDS1iNO4ZK9rGFMxZz648hL6sZaRnpVBsap
 w6/5Z0F4i9R2n8AwxeXDkwKxZwGAksDcyxWh6gixQqOEAfDT/8+D/8AWC7M1T8fnT/N9xUut6De
 4W0SU7NoIfUKasno=
X-Received: by 2002:a5d:6750:: with SMTP id l16mr4380788wrw.295.1589271299915; 
 Tue, 12 May 2020 01:14:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypIzskCJV/PM5i2uoDVY1DbRnLyVF7XZRaj77A7Ow3uyBl6Sd43GLn2E12Q3y6o5qbbMwV3EIA==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr4380761wrw.295.1589271299681; 
 Tue, 12 May 2020 01:14:59 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r11sm10264005wro.15.2020.05.12.01.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 01:14:59 -0700 (PDT)
Subject: Re: [PATCH 2/4] fuzz: fix typo in i440fx-qtest-reboot arguments
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200512030133.29896-1-alxndr@bu.edu>
 <20200512030133.29896-3-alxndr@bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9449a966-5baf-1957-265e-9e5de66b4765@redhat.com>
Date: Tue, 12 May 2020 10:14:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512030133.29896-3-alxndr@bu.edu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:20:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 5:01 AM, Alexander Bulekov wrote:
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>   tests/qtest/fuzz/i440fx_fuzz.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
> index ab5f112584..90e75ffaea 100644
> --- a/tests/qtest/fuzz/i440fx_fuzz.c
> +++ b/tests/qtest/fuzz/i440fx_fuzz.c
> @@ -143,7 +143,7 @@ static void i440fx_fuzz_qos_fork(QTestState *s,
>   }
>   
>   static const char *i440fx_qtest_argv = TARGET_NAME " -machine accel=qtest"
> -                                       "-m 0 -display none";
> +                                       " -m 0 -display none";
>   static const char *i440fx_argv(FuzzTarget *t)
>   {
>       return i440fx_qtest_argv;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


