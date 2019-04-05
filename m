Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9DEC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107FD217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107FD217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKuT-0007GE-8C
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 05:13:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKls-0008LQ-Ql
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKaD-0004q4-7B
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:52:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCKaC-0004n8-FB
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:52:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so6283441wml.1
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 01:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=CbaB+VLZudGHmQsRAXY6xZlIUfCGnrw1SqTS11zjfzg=;
	b=pWzAWArqpfbdC78n1IOQc3c6bWdjNYbl83+Btk/tFyVkVGPDXFVWILGE0TtyTqGUce
	Akw5Fxxo99OrqzWyk/qm8Ay0CNx+MCULRPSrdEx0PLDEKgJlTWjk21xNyrd/giosSNjk
	r3BduKoNnjngTdyVCdyrtvqCdZi5YOONFIFswauahb988SyoaD0NMMDmRQAbjA7EQiwU
	/zWJPJze+dDFftZwthyoozvQdSLYZDSW+Nr049kTK+wxNn0k+b0AcZAlWC+nHn1jAaca
	17byucgIWUOd9ywDt5G2FbdihZTKhpWqnwHVq+o303N9g9G3NGu2rnG/fzyIyaMNRMSJ
	45Nw==
X-Gm-Message-State: APjAAAUZ/VKE4c/mccsZHOVT4rLU8asKWwNhCgI/RF5hI2y2KOZS8Hyn
	wyG2Zt19OWqZht9gd43fc1OKzQ==
X-Google-Smtp-Source: APXvYqzg+SBRZU4ErMUCl4a2beMzqWccELc3rLzq3JJ8bzK8wlPgmF9XECXmaH2mDm2PJ4gULrdOlw==
X-Received: by 2002:a1c:3104:: with SMTP id x4mr6743002wmx.23.1554454339421;
	Fri, 05 Apr 2019 01:52:19 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	w10sm11883391wrv.8.2019.04.05.01.52.18
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 01:52:18 -0700 (PDT)
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <155445151931.302073.18436485925081597460.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <942570eb-9057-7424-4cca-5ba4336344c2@redhat.com>
Date: Fri, 5 Apr 2019 10:52:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155445151931.302073.18436485925081597460.stgit@bahia.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 1/2] target/ppc/trace-events: Fix trivial
 typo
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
	Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
	qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405085218.Qylp6dUn0MwVs6HuRMuEaSiWqay0-QjY6gZojyD4QKk@z>

On 4/5/19 10:05 AM, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  target/ppc/trace-events |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/trace-events b/target/ppc/trace-events
> index 3858f97dff54..ed4d57c6d9c1 100644
> --- a/target/ppc/trace-events
> +++ b/target/ppc/trace-events
> @@ -1,5 +1,5 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>  
>  # kvm.c
> -kvm_failed_spr_set(int str, const char *msg) "Warning: Unable to set SPR %d to KVM: %s"
> -kvm_failed_spr_get(int str, const char *msg) "Warning: Unable to retrieve SPR %d from KVM: %s"
> +kvm_failed_spr_set(int spr, const char *msg) "Warning: Unable to set SPR %d to KVM: %s"
> +kvm_failed_spr_get(int spr, const char *msg) "Warning: Unable to retrieve SPR %d from KVM: %s"
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

