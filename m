Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED18C43219
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 17:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE17F2077B
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 17:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE17F2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34328 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKQir-0002zk-AA
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 13:02:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKQgU-0001bV-51
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKQgT-0002rj-6V
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:00:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKQgT-0002pu-05
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:00:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so8935471wra.12
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 10:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=4MMZbCOceoRfsUE7YPRzsz/S0z7Vlei1eTZVNJsL0c0=;
	b=s8mRO6o/pdzlarAXj7mD9YnUsrPGrQYdfcx43UbLW3HQ6DCkurHWU2yBnI0dN0ZvQL
	s3zEa3b9H0eWLnr3cn1HiAKfIcZZ7tzwWa3lezYA77WOPAezhBnNLqVOB8GnRlp2j6Yd
	DLHgVxvjIDxiGQLjPhYxd/5HB6PZUW/byHTvJXpzbWV140bPn2ToAirlgbiRYD13hcPs
	w8gXzwVDKh1Rd0Kf2ewXwIZz/qj1QVenwpXX2XE3A74KSRCXH8Vcjy+1uYIoufFj1+UB
	jqRQi2sKtF58klEUOONn6YlQUCEq9S098/Fcx2vm4sfOGE61+7mCjEzbh09Syro7/Y1R
	E71Q==
X-Gm-Message-State: APjAAAUOFgh6fyCCoWrxWRiBJch2wR75BMeBbUUqzvL+hdnzsL2b9Jee
	RGSQk5jMFNttIbY8PNY5bBPPtQ==
X-Google-Smtp-Source: APXvYqywplDZU5L5OGMTOkYDEnbMfS23J1oPW6LtCqtcUmIV1qwzx+YU4lfOK6VgSL6CvhdRtp+wyg==
X-Received: by 2002:adf:b458:: with SMTP id v24mr36688601wrd.46.1556384415573; 
	Sat, 27 Apr 2019 10:00:15 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	p2sm20599833wru.73.2019.04.27.10.00.14
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sat, 27 Apr 2019 10:00:14 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190427165504.29846-1-philmd@redhat.com>
	<20190427165504.29846-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c6a685b1-b8a6-9479-45ef-26243bebe77b@redhat.com>
Date: Sat, 27 Apr 2019 19:00:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190427165504.29846-3-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/acpi: Always build the acpi/core.o
 file
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
Cc: Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427170012.FONzckrx9bhhFRDJ2_RV-BsBka-J_jI02duIW1QSyhk@z>

On 4/27/19 6:55 PM, Philippe Mathieu-Daudé wrote:
> The 'core' ACPI functions are not X86-specific.
> Let this file be built unconditionally, this will allow
> us to use ACPI on non-X86 architectures.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/acpi/Makefile.objs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index c86edfbed90..09c810ac556 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -1,4 +1,5 @@
> -common-obj-$(CONFIG_ACPI_X86) += core.o piix4.o pcihp.o
> +common-obj-$(CONFIG_ACPI) += core.o

Sorry, sent from wrong branch :S

Please consider reviewing with this snippet applied on top:

-- >8 --
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-$(CONFIG_ACPI) += core.o
+common-obj-y += core.o
---

I'll respin after getting some review comments.

> +common-obj-$(CONFIG_ACPI_X86) += piix4.o pcihp.o
>  common-obj-$(CONFIG_ACPI_X86_ICH) += ich9.o tco.o
>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu_hotplug.o
>  common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
> 

