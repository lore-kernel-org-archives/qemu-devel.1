Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C74C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 21:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029EC214C6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 21:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029EC214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47551 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHESz-00030s-AM
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 17:21:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hHE9o-0004m5-Az
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 17:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hHE9n-0003i6-Bd
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 17:01:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hHE9n-0003hZ-5K
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 17:01:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so4558204wra.12
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=f+V1aHf6tKPLnOrBAYzUxErnfZMtoLyytP6De/m1qyQ=;
	b=b1bVtPVquraGY1DLD3T4HzlMU3Cs21aEDGbm25tSHtkyMKe5b5qhFEAVcSgz57dG7D
	LxWeUggUZ8bGXQ6CXpQ+rcIIUC5rELmzgGp9wE0M3XGmAdxE4Mhr89HcoEjF+FznwaWI
	JuEB/2EbiQBuVC92oVB1VvZISlwq8rKFGB20dtqDtkDhPgnMDit9zMUSci68oOjX3/ur
	ADR15GvBpYyjlGqAUUNA8KDrOnJDA0YaKc5ecEtChIAqTC6XtGhD+jWWPQP+xggLxJ72
	mDUxdWq+YM5Dy8TFssEU5XtqjrCmaDANgrRWX8H+leJICG9NqswJL5kK8ZUPjh0+2CWt
	bdQQ==
X-Gm-Message-State: APjAAAVY8kwRfxv6F2a4BrBBmIsvgfa4ssOxb9FNPxvNPg6gN5lpD9Ou
	CQXu+ifZ+Md9yxvWnxWjtEcnFQ==
X-Google-Smtp-Source: APXvYqx1H2/9VW44JtwWRCJFdtifkuDcVFTLk5qYiu08cpR52pQbD8D4ye1i5NGL9c/+dOMyzCqJjw==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr173983wrr.190.1555621278075;
	Thu, 18 Apr 2019 14:01:18 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id t15sm3738370wmt.2.2019.04.18.14.01.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Apr 2019 14:01:17 -0700 (PDT)
To: Li Qiang <liq3ea@163.com>, thuth@redhat.com, lvivier@redhat.com,
	pbonzini@redhat.com, lersek@redhat.com, kraxel@redhat.com
References: <20190319023030.947-1-liq3ea@163.com>
	<20190319023030.947-3-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <979370c0-99ec-aff1-7cf5-350caa6ac773@redhat.com>
Date: Thu, 18 Apr 2019 23:01:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190319023030.947-3-liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: fw_cfg: add reboot_timeout test
 case
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418210116.m9qsKOJI-5qQadqHurtoDKzISs9oL9MOUvc3X4GDhrI@z>

Hi Li,

On 3/19/19 3:30 AM, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/fw_cfg-test.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 1c5103fe1c..551b51e38f 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -99,6 +99,17 @@ static void test_fw_cfg_boot_menu(void)
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), ==, boot_menu);
>  }
>  
> +static void test_fw_cfg_reboot_timeout(void)
> +{
> +    uint32_t reboot_timeout = 0;
> +    size_t filesize;
> +
> +    filesize = qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
> +                     &reboot_timeout, sizeof(reboot_timeout));
> +    g_assert_cmpint(filesize, ==, sizeof(reboot_timeout));
> +    g_assert_cmpint(reboot_timeout, ==, 15);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      QTestState *s;
> @@ -106,7 +117,8 @@ int main(int argc, char **argv)
>  
>      g_test_init(&argc, &argv, NULL);
>  
> -    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
> +    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8 "
> +                   "-boot reboot-timeout=15");

This modify all tests. I'd rather add a specific test with this option.
Doing so, we can easily modify the timeout and add the <0 and >0xffff cases.

Can you think of a 'splash-time' test (for commit 6912bb0b3d3b1)?

Regards,

Phil.

>  
>      fw_cfg = pc_fw_cfg_init(s);
>  
> @@ -125,6 +137,7 @@ int main(int argc, char **argv)
>      qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
>      qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
>      qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
> +    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
>  
>      ret = g_test_run();
>  
> 

