Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F54AC4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395F4218AF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395F4218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Npv-0003Xp-Ac
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i7Nov-0002f5-3Q
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i7Not-0001md-KE
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:51:20 -0400
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:37000)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i7Not-0001lP-DE
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:51:19 -0400
Received: from player718.ha.ovh.net (unknown [10.109.146.5])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 55BD22053E8
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 19:51:17 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player718.ha.ovh.net (Postfix) with ESMTPSA id 7499098A5332;
 Mon,  9 Sep 2019 17:51:08 +0000 (UTC)
Date: Mon, 9 Sep 2019 19:51:07 +0200
From: Greg Kurz <groug@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190909195107.7c899b6e@bahia.lan>
In-Reply-To: <CAFEAcA_zvtxxsr1ZJEqA9R9GMZvo7D229FP85mUaRhbWei-Acw@mail.gmail.com>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
 <20190821072542.23090-21-david@gibson.dropbear.id.au>
 <CAFEAcA_zvtxxsr1ZJEqA9R9GMZvo7D229FP85mUaRhbWei-Acw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10453980636562561297
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudekiedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.33.109
Subject: Re: [Qemu-devel] [PULL 20/42] spapr: initial implementation for
 H_TPM_COMM/spapr-tpm-proxy
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Sep 2019 18:23:20 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 21 Aug 2019 at 08:26, David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> > From: Michael Roth <mdroth@linux.vnet.ibm.com>
> >
> > This implements the H_TPM_COMM hypercall, which is used by an
> > Ultravisor to pass TPM commands directly to the host's TPM device, or
> > a TPM Resource Manager associated with the device.
> >
> > This also introduces a new virtual device, spapr-tpm-proxy, which
> > is used to configure the host TPM path to be used to service
> > requests sent by H_TPM_COMM hcalls, for example:
> >
> >   -device spapr-tpm-proxy,id=tpmp0,host-path=/dev/tpmrm0
> >
> > By default, no spapr-tpm-proxy will be created, and hcalls will return
> > H_FUNCTION.
> >
> > The full specification for this hypercall can be found in
> > docs/specs/ppc-spapr-uv-hcalls.txt
> >
> > Since SVM-related hcalls like H_TPM_COMM use a reserved range of
> > 0xEF00-0xEF80, we introduce a separate hcall table here to handle
> > them.
> >
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com
> > Message-Id: <20190717205842.17827-3-mdroth@linux.vnet.ibm.com>
> > [dwg: Corrected #include for upstream change]
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Hi; Coverity reports an issue in this change (CID 1405304):
> 
> > +static ssize_t tpm_execute(SpaprTpmProxy *tpm_proxy, target_ulong *args)
> > +{
> > +    uint64_t data_in = ppc64_phys_to_real(args[1]);
> > +    target_ulong data_in_size = args[2];
> > +    uint64_t data_out = ppc64_phys_to_real(args[3]);
> > +    target_ulong data_out_size = args[4];
> > +    uint8_t buf_in[TPM_SPAPR_BUFSIZE];
> > +    uint8_t buf_out[TPM_SPAPR_BUFSIZE];
> > +    ssize_t ret;
> > +
> > +    trace_spapr_tpm_execute(data_in, data_in_size, data_out, data_out_size);
> > +
> > +    if (data_in_size > TPM_SPAPR_BUFSIZE) {
> > +        error_report("invalid TPM input buffer size: " TARGET_FMT_lu,
> > +                     data_in_size);
> > +        return H_P3;
> > +    }
> > +
> > +    if (data_out_size < TPM_SPAPR_BUFSIZE) {
> > +        error_report("invalid TPM output buffer size: " TARGET_FMT_lu,
> > +                     data_out_size);
> > +        return H_P5;
> > +    }
> > +
> > +    if (tpm_proxy->host_fd == -1) {
> > +        tpm_proxy->host_fd = open(tpm_proxy->host_path, O_RDWR);
> > +        if (tpm_proxy->host_fd == -1) {
> > +            error_report("failed to open TPM device %s: %d",
> > +                         tpm_proxy->host_path, errno);
> > +            return H_RESOURCE;
> > +        }
> > +    }
> > +
> > +    cpu_physical_memory_read(data_in, buf_in, data_in_size);
> > +
> > +    do {
> > +        ret = write(tpm_proxy->host_fd, buf_in, data_in_size);
> > +        if (ret > 0) {
> > +            data_in_size -= ret;
> > +        }
> > +    } while ((ret >= 0 && data_in_size > 0) || (ret == -1 && errno == EINTR));
> > +
> > +    if (ret == -1) {
> > +        error_report("failed to write to TPM device %s: %d",
> > +                     tpm_proxy->host_path, errno);
> > +        return H_RESOURCE;
> > +    }
> > +
> > +    do {
> > +        ret = read(tpm_proxy->host_fd, buf_out, data_out_size);
> > +    } while (ret == 0 || (ret == -1 && errno == EINTR));
> > +
> > +    if (ret == -1) {
> > +        error_report("failed to read from TPM device %s: %d",
> > +                     tpm_proxy->host_path, errno);
> 
> The tpm_execute() function can unconditionally dereference
> tpm_proxy->host_path, implying it can never be NULL...
> 
> > +        return H_RESOURCE;
> > +    }
> > +
> > +    cpu_physical_memory_write(data_out, buf_out, ret);
> > +    args[0] = ret;
> > +
> > +    return H_SUCCESS;
> > +}
> > +
> > +static target_ulong h_tpm_comm(PowerPCCPU *cpu,
> > +                               SpaprMachineState *spapr,
> > +                               target_ulong opcode,
> > +                               target_ulong *args)
> > +{
> > +    target_ulong op = args[0];
> > +    SpaprTpmProxy *tpm_proxy = spapr->tpm_proxy;
> > +
> > +    if (!tpm_proxy) {
> > +        error_report("TPM proxy not available");
> > +        return H_FUNCTION;
> > +    }
> > +
> > +    trace_spapr_h_tpm_comm(tpm_proxy->host_path ?: "null", op);
> 
> ...but in this tracing at the callsite we check for whether
> it is NULL or not, implying that it can be NULL.
> 

And we have this in the device realize function:

static void spapr_tpm_proxy_realize(DeviceState *d, Error **errp)
{
    SpaprTpmProxy *tpm_proxy = SPAPR_TPM_PROXY(d);

    if (tpm_proxy->host_path == NULL) {
        error_setg(errp, "must specify 'host-path' option for device");
        return;
    }
[...]
}

so we can safely assume host_path is never NULL. I guess the fix is to
stop checking tpm_proxy->host_path in the trace callsite above.

> > +
> > +    switch (op) {
> > +    case TPM_COMM_OP_EXECUTE:
> > +        return tpm_execute(tpm_proxy, args);
> > +    case TPM_COMM_OP_CLOSE_SESSION:
> > +        spapr_tpm_proxy_reset(tpm_proxy);
> > +        return H_SUCCESS;
> > +    default:
> > +        return H_PARAMETER;
> > +    }
> > +}
> 
> Coverity isn't happy about the possible use-after-NULL-check.
> 
> thanks
> -- PMM


