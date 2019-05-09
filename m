Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C971C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3820621019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gky7vZ7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3820621019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmGl-0003kp-IF
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 12:51:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOmFa-00031h-7y
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOmFZ-0005do-2s
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:50:30 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:46291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOmFY-0005bm-RV
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:50:29 -0400
Received: by mail-lf1-x143.google.com with SMTP id k18so2040199lfj.13
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=QLkoJBmMBkp5An6UVjaIx2AS5nabhWn0cjocNITXH50=;
	b=gky7vZ7nqV0YP5b0RNhUiwsiaEkP/pAhrUWPkXlrRDEAGNsOSfSL7Obw7sM/3CA7vh
	XftbdQve243lWWD4JPfUIPbmv/S5O29poR3xsi2Mm6h2VceFImxeISEHnnCIJIoiWLkY
	siPG+bgtnrweDcqhW33TQrk8dyJ6mOOxRqLfer+ib9CAhBtBRw0waDacglZVNN1Uutsx
	b00WeVUj3VuCWr38tPgcTcDORg3VtZH9CJHHFlzG4PQfiCMyBlR7OFMHcUGett/Yrd18
	eAO+3C/lEMx8gM8lDRfzycO8F983zAPNLikDNFTpEFKj/LerG5aVgvQCBPpuu7ti5qkW
	wykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=QLkoJBmMBkp5An6UVjaIx2AS5nabhWn0cjocNITXH50=;
	b=DIMjZC7NX+gaEWcoxKYe5lUti+SfxYDs83v6L7CZLNS/gLjEs8CTe3l4GcUIoV/qx1
	G+3B3P5vgk0JktGDXcbzl8vlud6/2QUbUQjoBP4+I2WOH0ZXuaqL1iPxRAq+pOz2qdQO
	ecv9Prq3hO/uJPldDquSaHD41VlutsfCzwBmV4f09dENabeHQNlak211HmiwIXDR/mVN
	aj2sCsqdvEBWli3g9sbXGzrrcmR8663/i6TUq6OIH4w5Oeh+hv5tdWId65ctjzFtB6zt
	AGEe+WbLs9GwEZ2lhh39RgBx7Q24CDH5iUHRZXZ8uTKtEZti/zx8CmAApIqWHnby/Ts3
	NlHw==
X-Gm-Message-State: APjAAAX1MsVB0nVwtrDe8IV4yZ3oh6pgKgPmvtdFqDvxTZUxt4dATLei
	eBJiSp9PD6aFCqtm8EkK1Nr8sGEvcc6BH9zdxTY=
X-Google-Smtp-Source: APXvYqxjDykj4sqzeIL7VmJEY8bP+iu+CUTDHLRH25i+4JY7/YD00c/NGOzeHjqJ1YGVa92NPEMK21KXatCxLaeeXMM=
X-Received: by 2002:a19:4a04:: with SMTP id x4mr3024874lfa.124.1557420627561; 
	Thu, 09 May 2019 09:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
	<1557131596-25403-11-git-send-email-like.xu@linux.intel.com>
In-Reply-To: <1557131596-25403-11-git-send-email-like.xu@linux.intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 09:48:20 -0700
Message-ID: <CAKmqyKOSWUD7X9FXL5FRGRnw7gLdcYiah=_W7dBKW=4wrM_yHQ@mail.gmail.com>
To: Like Xu <like.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v2 10/10] cpu/topology: replace smp global
 variables with smp machine properties
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

On Mon, May 6, 2019 at 1:35 AM Like Xu <like.xu@linux.intel.com> wrote:
>
> At the end of this smp refactoring series, the global ones are removed
> and only smp machine properties are fully applied and enabled.
>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  vl.c | 53 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 26 insertions(+), 27 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index 34f05b2..a3e426c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -162,10 +162,6 @@ static Chardev **serial_hds;
>  Chardev *parallel_hds[MAX_PARALLEL_PORTS];
>  int win2k_install_hack = 0;
>  int singlestep = 0;
> -int smp_cpus;
> -unsigned int max_cpus;
> -int smp_cores = 1;
> -int smp_threads = 1;
>  int acpi_enabled = 1;
>  int no_hpet = 0;
>  int fd_bootchk = 1;
> @@ -1282,8 +1278,9 @@ static void smp_parse(QemuOpts *opts)
>                  sockets = sockets > 0 ? sockets : 1;
>                  cpus = cores * threads * sockets;
>              } else {
> -                max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> -                sockets = max_cpus / (cores * threads);
> +                current_machine->smp.max_cpus =
> +                        qemu_opt_get_number(opts, "maxcpus", cpus);
> +                sockets = current_machine->smp.max_cpus / (cores * threads);
>              }
>          } else if (cores == 0) {
>              threads = threads > 0 ? threads : 1;
> @@ -1300,34 +1297,37 @@ static void smp_parse(QemuOpts *opts)
>              exit(1);
>          }
>
> -        max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> +        current_machine->smp.max_cpus =
> +                qemu_opt_get_number(opts, "maxcpus", cpus);
>
> -        if (max_cpus < cpus) {
> +        if (current_machine->smp.max_cpus < cpus) {
>              error_report("maxcpus must be equal to or greater than smp");
>              exit(1);
>          }
>
> -        if (sockets * cores * threads > max_cpus) {
> +        if (sockets * cores * threads > current_machine->smp.max_cpus) {
>              error_report("cpu topology: "
>                           "sockets (%u) * cores (%u) * threads (%u) > "
>                           "maxcpus (%u)",
> -                         sockets, cores, threads, max_cpus);
> +                         sockets, cores, threads,
> +                         current_machine->smp.max_cpus);
>              exit(1);
>          }
>
> -        if (sockets * cores * threads != max_cpus) {
> +        if (sockets * cores * threads != current_machine->smp.max_cpus) {
>              warn_report("Invalid CPU topology deprecated: "
>                          "sockets (%u) * cores (%u) * threads (%u) "
>                          "!= maxcpus (%u)",
> -                        sockets, cores, threads, max_cpus);
> +                        sockets, cores, threads,
> +                        current_machine->smp.max_cpus);
>          }
>
> -        smp_cpus = cpus;
> -        smp_cores = cores;
> -        smp_threads = threads;
> +        current_machine->smp.cpus = cpus;
> +        current_machine->smp.cores = cores;
> +        current_machine->smp.threads = threads;
>      }
>
> -    if (smp_cpus > 1) {
> +    if (current_machine->smp.cpus > 1) {
>          Error *blocker = NULL;
>          error_setg(&blocker, QERR_REPLAY_NOT_SUPPORTED, "smp");
>          replay_add_blocker(blocker);
> @@ -4094,26 +4094,25 @@ int main(int argc, char **argv, char **envp)
>      machine_class->default_cpus = machine_class->default_cpus ?: 1;
>
>      /* default to machine_class->default_cpus */
> -    smp_cpus = machine_class->default_cpus;
> -    max_cpus = machine_class->default_cpus;
> +    current_machine->smp.cpus = machine_class->default_cpus;
> +    current_machine->smp.max_cpus = machine_class->default_cpus;
> +    current_machine->smp.cores = 1;
> +    current_machine->smp.threads = 1;
>
>      smp_parse(qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
>
> -    current_machine->smp.cpus = smp_cpus;
> -    current_machine->smp.max_cpus = max_cpus;
> -    current_machine->smp.cores = smp_cores;
> -    current_machine->smp.threads = smp_threads;
> -
>      /* sanity-check smp_cpus and max_cpus against machine_class */
> -    if (smp_cpus < machine_class->min_cpus) {
> +    if (current_machine->smp.cpus < machine_class->min_cpus) {
>          error_report("Invalid SMP CPUs %d. The min CPUs "
> -                     "supported by machine '%s' is %d", smp_cpus,
> +                     "supported by machine '%s' is %d",
> +                     current_machine->smp.cpus,
>                       machine_class->name, machine_class->min_cpus);
>          exit(1);
>      }
> -    if (max_cpus > machine_class->max_cpus) {
> +    if (current_machine->smp.max_cpus > machine_class->max_cpus) {
>          error_report("Invalid SMP CPUs %d. The max CPUs "
> -                     "supported by machine '%s' is %d", max_cpus,
> +                     "supported by machine '%s' is %d",
> +                     current_machine->smp.max_cpus,
>                       machine_class->name, machine_class->max_cpus);
>          exit(1);
>      }
> --
> 1.8.3.1
>

