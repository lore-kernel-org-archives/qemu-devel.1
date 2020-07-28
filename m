Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CEAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60912070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbb5LC3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60912070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0R8E-0004mG-3T
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0R7U-00049T-Mc
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:02:20 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0R7R-0006Hl-NQ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:02:20 -0400
Received: by mail-oi1-x241.google.com with SMTP id k22so17750383oib.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sTlza4Av+fjTMBRgPOAc9Q/orGf6ADMDhCa1XX1AjRM=;
 b=cbb5LC3IL/CA0zARdZ+qyIf9FGvX4/E0IeI0GPFS/EkQoGMOSAggJRV5suHfY0PDMf
 Jkul5tD2Y4vQZVfOoO2ppk49To0DWbCzpQ1wQ1xWPQA0iM/o3s/dTAAxoTFJc6WTmlzO
 OvX06gbRMgVIEWDTY8kZ15O59oomQFQB5tEzT26/gaJ3htPMXPW1Togt8W0k8enIU5ki
 t3Wc0mpC+JF9Cf0ma2cI68+XDD77LdPzwVUBuQwXKTxRD8zyyvFZK+s4/IEOcIRKcVeA
 PKQO2aZbIGmn/NelmrnK2mxflSeiKo37J8KD+gKV/FACw9N6XbHy3tZUpcuqKAbOAQwp
 EF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sTlza4Av+fjTMBRgPOAc9Q/orGf6ADMDhCa1XX1AjRM=;
 b=mHAZHeYDOVnvRTGZgK5sEpzube2cV0lsKaW4pKB+Ae4itwlaqEcflGQouNjdmEl+mK
 I1c3hCQh/Mabq40mnSyDsbiF3dkn23UFcsf9IqOVUu2qJNCMdEDaB/p4gstHLdTcTro6
 1E97OVV1lOT8iuIKQ5Ghd2UBJWbX+3fDDzwz9QXNyIiyGvdZjCM/IPy3bMC88L7r2vRJ
 CUyx1O2UBSBMHC2jYXcTVb8MMgqvA10IsPdggHXJOXD03+RCKlrprO6IXHjYno5XnpYJ
 QUjVpCDW8je0cGle7uTXgqC2enWkihda6r5M/x5yzET/x6CLEmNji/YRU4euVgnvDFRm
 IOwg==
X-Gm-Message-State: AOAM532hAeZHMGQd8YcVmV99k02w0Pg3sb0ASVSlCFikCZ8cjBU/kqNh
 AzNLxa0o7Ebew0Emfvt5lyjh2ni23nlAKL1Eq7mHAnBG
X-Google-Smtp-Source: ABdhPJygJ6841spn951OS7vwcvUHmy7XVpAnSXgDmkwvG8SC9KZsX8N+htWzeRNkxw710LdqUSJWZd4aWR01gZSNHyk=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr3806485oia.163.1595948536217; 
 Tue, 28 Jul 2020 08:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200716154114.10838-1-peter.maydell@linaro.org>
In-Reply-To: <20200716154114.10838-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 16:02:05 +0100
Message-ID: <CAFEAcA9k7uN8VWoDCfevfLeQ9En3kEwZyz=4mHOSWB8eyzBFaQ@mail.gmail.com>
Subject: Re: [PATCH] osdep.h: Add doc comment for qemu_get_thread_id()
To: QEMU Developers <qemu-devel@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping? I've cc'd a few new people who might have a view on the
"should the QMP documentation define what a thread-id is?"
question below the --- fold...

On Thu, 16 Jul 2020 at 16:41, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Add a documentation comment for qemu_get_thread_id(): since this
> is rather host-OS-specific it's useful if people writing the
> implementation and people thinking of using the function know
> what the purpose and limitations are.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Based on conversation with Dan on IRC, and prompted by the recent
> patch to add OpenBSD support.
>
> Q: should we document exactly what the thread-id value is for
> each host platform in the QMP documentation ? Somebody writing
> a management layer app should ideally not have to grovel through
> the application to figure out what they should do with the
> integer value they get back from query-cpus...
>
>  include/qemu/osdep.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 4841b5c6b5f..8279f72e5ed 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -515,6 +515,20 @@ bool qemu_has_ofd_lock(void);
>
>  bool qemu_write_pidfile(const char *pidfile, Error **errp);
>
> +/**
> + * qemu_get_thread_id: Return OS-specific ID of current thread
> + *
> + * This function returns an OS-specific identifier of the
> + * current thread. This will be used for the "thread-id" field in
> + * the response to the QMP query-cpus and query-iothreads commands.
> + * The intention is that a VM management layer application can then
> + * use it to tie specific QEMU vCPU and IO threads to specific host
> + * CPUs using whatever the host OS's CPU affinity setting API is.
> + * New implementations of this function for new host OSes should
> + * return the most sensible integer ID that works for that purpose.
> + *
> + * This function should not be used for anything else inside QEMU.
> + */
>  int qemu_get_thread_id(void);
>
>  #ifndef CONFIG_IOVEC
> --
> 2.20.1

thanks
-- PMM

