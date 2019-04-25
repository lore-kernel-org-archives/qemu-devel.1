Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8EAC10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 11:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985D820811
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 11:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985D820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55555 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJcXY-0007ZT-N7
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 07:27:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJcWa-0007As-CP
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJcWZ-0008C8-9C
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:26:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJcWZ-0008As-2S
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:26:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id c5so20923621wrs.11
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 04:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=4rqdylySYY9TvtV2zgJgBSFY61913fXKAlZW9/EgK3o=;
	b=EUj/APB5OsYsYzCLm4dK1slKuFvSL/Te9Mt2UODvjHTTJJarDAqnTHF/6rEPZOkr9q
	xdqi82C31MucGbNqHc3XDr8qrav+zWGHJBzNAvOzwGWm+CCB3rpGp0p2qUXJJRO5gkK0
	FQWzIijsym/0u5HxK48B2z3IsewOpcNlg1H1LtnE9zG3sKaBDEzcZc4e8bxLAAU05wzn
	TvLofE+YAnpYZkHjfawE+wq4/BVjnRgaYDvyiIKC5sN0tCr+EU018T9LGWEmDV8GSM4R
	GV/vssm30fS6zUaTklJgSGzCpP2mo0hqzATSTWhrW6BtaS0UQ6IGb0MJGWS9KSSb5SPz
	g6Hg==
X-Gm-Message-State: APjAAAUVqWXLmDTdSoRYKpOu/cReFVquOQ4OOCBK96opslQao15Y8IMy
	HNMLdyz+N8bQ/7Mg56uvjmsE8Q==
X-Google-Smtp-Source: APXvYqx10B9wGSuriBI2jd/P0yXC7yhElxoy2qsmOMD0EQfzaI/OflziLM5I3uLLEhDY3yj9lNv8Xg==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr20194296wrn.235.1556191601820;
	Thu, 25 Apr 2019 04:26:41 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	d11sm8063023wrc.32.2019.04.25.04.26.40
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 04:26:41 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-14-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <eb84bda8-ed90-6cf7-41cb-f346d52c5e93@redhat.com>
Date: Thu, 25 Apr 2019 13:26:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556170489-131927-14-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v3 13/13] tests: acpi: print error unable
 to dump ACPI table during rebuild
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
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425112639.mfriwKlNtD-usVYoxgZ3u11q-MxyfTz5ndq-wOVy3cI@z>

On 4/25/19 7:34 AM, Igor Mammedov wrote:
> Instead of just asserting print the error that lead to assert first.
> While at it move assert into rebuild branch, which removes reduntant

"redundant"

> check done in case of !rebuild branch is taken (the later is taken
> care of by g_assert_no_error).
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/bios-tables-test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index f117461..5a5d036 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -199,11 +199,14 @@ static void dump_aml_files(test_data *data, bool rebuild)
>                                         sdt->aml, ext);
>              fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>                          S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
> +            if (fd < 0) {
> +                perror(aml_file);
> +            }
> +            g_assert(fd >= 0);
>          } else {
>              fd = g_file_open_tmp("aml-XXXXXX", &sdt->aml_file, &error);
>              g_assert_no_error(error);
>          }
> -        g_assert(fd >= 0);
>  
>          ret = qemu_write_full(fd, sdt->aml, sdt->aml_len);
>          g_assert(ret == sdt->aml_len);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

