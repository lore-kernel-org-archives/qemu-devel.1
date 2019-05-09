Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02620C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C059E2173C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyt432ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C059E2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57675 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOm1r-0001cf-NL
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 12:36:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOm0k-0000hB-4u
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOm0f-0005e4-SJ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:35:07 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:41755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOm0e-0005bZ-23
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:35:04 -0400
Received: by mail-lf1-x143.google.com with SMTP id d8so2023295lfb.8
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=2Jo0RfOgmc88CbzuY1HCHHYyoDETiRvFFT5b/tY5HLY=;
	b=lyt432maOlRUajqb32sy1rbfqfw9D/7iLuhIBceaWnwKHzUyJp6RWpfQeZsiBMmiZE
	rk8ktJJp2uH3EVCESCu7wFw/jouDZ6rDzhVVS6IZmJ8WGV7j6j5v7RzT381j+4TkXCW1
	3YlPtUhDaJmOPJT3C06VKBASFnA7PALT67enVF9BAuZlwpDxaxRPAQOqUmqJE2JBcYNJ
	cFSKM+mltmMec6E3b3Rf4AGptptnm1PbDSLb2lxO2MS75x3QEOV69UwGUcDfYVbygb3P
	/JpX37rDhGloZYVN6+CUjdp08MctoUWUMrhPs3DalkoMOGs2ohN6Hc+XxMeuyhU+EKPa
	0wiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=2Jo0RfOgmc88CbzuY1HCHHYyoDETiRvFFT5b/tY5HLY=;
	b=o0sa2nTn0n5clq/bk9Nof6UM6+lEy0MGi7Kc3CP91QoaBKbtMy+4yxxV5g40vLjmxu
	N/oPiknJSoPrz5+YUlzZF/Prl21DJdeNqSMRLycv581eW5OQXFb5ASIZh05GosT+d3Hi
	GqTZnRZ7g3Q5+1DwbZwnic1eE5VfB0KMr2UCwwSANa/YyoLVIgadTn1O+cd994V8kAOb
	lfITOeM9dP7CtZupWddu3utuBeHADnPVrrm6iQMeJmR0lW+Un1SvhBijvaqWu60HDYCq
	4lTaiToh8yokkf6ICRIHoOnMTRqtZq89DBRcZI9EwVG4M/i7H5PAcpw+DfYIdoXqheMC
	hEYg==
X-Gm-Message-State: APjAAAWMOK2pomYWgBIgtXCmo99QZZL0VgHZt6vTRr3rFlCsKZcdH9DY
	IeXALhKucRQFQdhVJoqK0ZLRpeCO4mkxVNlMiLg=
X-Google-Smtp-Source: APXvYqyLJ2ks1xCGBdI2eYuQACNgLbRxqiGgquUeQntUwSs1iizTbjNiqFS7yoeX1vZkfCts3dvmQOexc1jvzpfsBsc=
X-Received: by 2002:ac2:523a:: with SMTP id i26mr3006227lfl.118.1557419702247; 
	Thu, 09 May 2019 09:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
	<1557131596-25403-2-git-send-email-like.xu@linux.intel.com>
In-Reply-To: <1557131596-25403-2-git-send-email-like.xu@linux.intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 09:32:55 -0700
Message-ID: <CAKmqyKOLhB3fxMOMcjy82kYvHFzJ1MLKBbAuq6gABYt6jFpSnw@mail.gmail.com>
To: Like Xu <like.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v2 01/10] hw/boards: add struct CpuTopology
 to MachineState
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 6, 2019 at 1:34 AM Like Xu <like.xu@linux.intel.com> wrote:
>
> To remove usages of global smp variables arch by arch,
> a bisect friendly way is introduced to initialize struct
> CpuTopology with duplicate ones; no semantic changes.
>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair


> ---
>  include/hw/boards.h | 15 +++++++++++++++
>  vl.c                |  5 +++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 6f7916f..dc89c6d 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -231,6 +231,20 @@ typedef struct DeviceMemoryState {
>  } DeviceMemoryState;
>
>  /**
> + * CpuTopology:
> + * @cpus: the number of logical processors on the machine
> + * @cores: the number of cores in one package
> + * @threads: the number of threads in one core
> + * @max_cpus: the maximum number of logical processors on the machine
> + */
> +typedef struct CpuTopology {
> +    unsigned int cpus;
> +    unsigned int cores;
> +    unsigned int threads;
> +    unsigned int max_cpus;
> +} CpuTopology;
> +
> +/**
>   * MachineState:
>   */
>  struct MachineState {
> @@ -272,6 +286,7 @@ struct MachineState {
>      const char *cpu_type;
>      AccelState *accelerator;
>      CPUArchIdList *possible_cpus;
> +    CpuTopology smp;
>      struct NVDIMMState *nvdimms_state;
>  };
>
> diff --git a/vl.c b/vl.c
> index d9fea0a..43fd247 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4099,6 +4099,11 @@ int main(int argc, char **argv, char **envp)
>
>      smp_parse(qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
>
> +    current_machine->smp.cpus = smp_cpus;
> +    current_machine->smp.max_cpus = max_cpus;
> +    current_machine->smp.cores = smp_cores;
> +    current_machine->smp.threads = smp_threads;
> +
>      /* sanity-check smp_cpus and max_cpus against machine_class */
>      if (smp_cpus < machine_class->min_cpus) {
>          error_report("Invalid SMP CPUs %d. The min CPUs "
> --
> 1.8.3.1
>

