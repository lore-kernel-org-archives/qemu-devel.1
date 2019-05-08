Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0FAC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB0B214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB0B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFpm-0007dw-34
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:13:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFp0-0007Lb-EI
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFoz-0000NF-Ao
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:12:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOFoz-0000In-2k
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:12:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id y5so1592486wma.2
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 23:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=GMsu7YknpC0ISph22VAbR6b45a+UYchZv9ITfKRYmUY=;
	b=GhpJOTGeyBvV+BFh+CTcwv2dU3hXzbXeDJtpE0Y/tFmaFzhNKTuFCjQPHJBTHenBMF
	MZSZz9R+NwnJnnq+10Mds1EtCWBzdge3EMcfxfmtyfI+g2ugL11VrAJEjoWW3V1nQGrn
	cwR4W7bbX+ouweXzKMO3wvknC+hlRiM4ew3WItIiAOUTRa8oulvi1iQkxyeLKyaMgho4
	r3zwHZb+dkDlbisV6MzyZdCie4o1h5jsKGNtl536GAdGMzptJ7OWD7gChXGiRWXOl3wP
	uIAEi2PBaxdMQ7oB/jX/BCUHqU5pzVxvPki+g8KbFm9x4nmlkuyFutB//vNzmR67pup4
	hP/w==
X-Gm-Message-State: APjAAAX6X+bWGDC52RrLhzhKejDzZolwfyqXnwd89fv9ExgwRkEaDixu
	pyxpkpDi1efClpwvTiXcvCH/sA==
X-Google-Smtp-Source: APXvYqzP7dUhb1symKZyDfFxkYbF8nsZI/29B+ysib6P2tULSuI0TMxKXHzolV0bZ/IRWfnEubQ5Rw==
X-Received: by 2002:a7b:c093:: with SMTP id r19mr1624433wmh.35.1557295971851; 
	Tue, 07 May 2019 23:12:51 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	v5sm20410429wra.83.2019.05.07.23.12.50
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 23:12:51 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
	<1556808723-226478-11-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <43811b60-c03c-6553-aef1-54186f98898e@redhat.com>
Date: Wed, 8 May 2019 08:12:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556808723-226478-11-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v4 10/15] tests: acpi: ignore SMBIOS tests
 when UEFI firmware is used
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
	"Michael S. Tsirkin" <mst@redhat.com>, linuxarm@huawei.com,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, xuwei5@huawei.com,
	xuwei5@hisilicon.com, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/2/19 4:51 PM, Igor Mammedov wrote:
> once FW provides a pointer to SMBIOS entry point like it does for
> RSDP it should be possible to enable this one the same way.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v3:
>   - add ref to a uefi-test-tools feature req into comment (Laszlo)
> ---
>  tests/bios-tables-test.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 84e1ce2..8302ffc 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -569,8 +569,15 @@ static void test_acpi_one(const char *params, test_data *data)
>          }
>      }
>  
> -    test_smbios_entry_point(data);
> -    test_smbios_structs(data);
> +    /*
> +     * TODO: make SMBIOS tests work with UEFI firmware,
> +     * Bug on uefi-test-tools to provide entry point:
> +     * https://bugs.launchpad.net/qemu/+bug/1821884
> +     */
> +    if (!use_uefi) {
> +        test_smbios_entry_point(data);
> +        test_smbios_structs(data);
> +    }
>  
>      assert(!global_qtest);
>      qtest_quit(data->qts);
> 

