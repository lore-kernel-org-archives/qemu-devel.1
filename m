Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF448C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3039220809
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgpWtk03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3039220809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6vH-00024S-0V
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX6MB-0000km-0g
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:32:31 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:42026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX6M9-0001yF-DN
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:32:30 -0400
Received: by mail-ed1-x535.google.com with SMTP id v19so10279743edx.9
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=55eyuk42pE0LCxXjckrKgBEEyBU4OQQsjW8M+YVDNtI=;
 b=ZgpWtk03XcGWI3LJmox6frTtNbuBqsuKYDvvScWYFsMIbjb2Dt8aTCknk2EtPm7Med
 QlaITMsHAXAhGxdY5KRR0CB/9AyrAMnyg5WhuXlQcpfJ6g9WX8kfX19+5B/0HS3UOMO1
 zDh8jwCO2lvZH+68ph7qyNf827LeGrSftFP/qYM0/YT066DBWS9UpwFFrV573SXG5Vlp
 UzlTK4B1z4QU8pYfaNlOC1os8gyl2iwkXJI6MHB4knt1Y0LkKDCSXz3ArQyFo6AdNJvf
 hXqwoSCcAxEM+dszHSzrXfQb9dLggeMfNoxdJ2Nbw39dI7d2iSdVjBoRZx9sjtXHErsV
 k3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=55eyuk42pE0LCxXjckrKgBEEyBU4OQQsjW8M+YVDNtI=;
 b=Rd9FodTK4ksRDu0I553oWvCy+3UiXYJNexyVkVh1ktSQapQh0tAu+077zLcZzwN+UF
 Ks1Mr4ghRmQmCs9wpPzTZN9g5gUAHTHQyeqjWQ/ptqSXbf8zodMM0xzwTZjA3/4nZ1hj
 qo3R1CN1XBZDWQMWWvDBOadv2lAO/moH3ITbF7GJOaEsmro9XfnJX9LOLhCkHnwhpZbR
 uNxwV39TGVQLijJPphR8nIsRtU5+R3UWAJO6iA1wR5m+FLmhsVRMHuJJ/RNocFTZHLMU
 8ldPIkvrROygE0yq5850rHEyuDPy4P+G74+hquZWG6rq1vZj0YgCvVC5JJgyexs5o4vi
 YU6g==
X-Gm-Message-State: AOAM532sGJKQKCWp8rmuAFgGT5vFD/ugLd402eEKrkWw2BpwIQY04NJW
 sCVNHH2AvEZ3gjPOsEYdrsL7pIW5puNDZtZRt/IXCA==
X-Google-Smtp-Source: ABdhPJySmrPcHjoryvF2Ptz63oqHlPyHrltApcUmAz0Mht7ixB2ztTINX932S+hGWoJJlPDCsHWgXmjdEnD/ZdO4Mtw=
X-Received: by 2002:aa7:d699:: with SMTP id d25mr8936039edr.44.1603733547775; 
 Mon, 26 Oct 2020 10:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201026172219.GA5733@habkost.net>
In-Reply-To: <20201026172219.GA5733@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 17:32:16 +0000
Message-ID: <CAFEAcA96=ng8_SsVq0V3O8nvJkSFc+FZBATXmhok+hj1vOeELQ@mail.gmail.com>
Subject: Re: Dynamic instance properties in TYPE_ARM_CPU
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 17:22, Eduardo Habkost <ehabkost@redhat.com> wrote:
> I've been trying to clean up the qdev property code (to bridge
> the gaps between qdev and QOM, and between QOM and QAPI), and
> I've noticed that TYPE_ARM_CPU is the only remaining user of
> qdev_property_add_static().
>
> qdev_property_add_static() has a misleading name: it won't
> register a static property.  It is actually a hack to use a
> static Property variable (defined using DEFINE_PROP*), but
> register it as a dynamic instance property.
>
> Dynamic instance properties make introspection hard.  What can we
> do to get rid of them in TYPE_ARM_CPU?

I'm in principle in favour of this because the Arm handling
of this is a bit odd and it would make sense to bring it
into line with how other parts of QEMU work. (Do other CPU
architectures just provide the properties on all CPUs?)

> Can we just register all the properties unconditionally, and
> error out on realize if the requested CPU configuration is
> incompatible with the available CPU features?

I think you would probably also need to check for and
adjust board/SoC code which assumes that presence of a
property implies that it's OK to set it, eg this in virt.c:

        if (object_property_find(cpuobj, "reset-cbar")) {
            object_property_set_int(cpuobj, "reset-cbar",
                                    vms->memmap[VIRT_CPUPERIPHS].base,
                                    &error_abort);
        }

or which uses presence-of-property as its check for
"does the CPU support this feature", eg this;
                /*
                 * The property exists only if MemTag is supported.
                 * If it is, we must allocate the ram to back that up.
                 */
                if (!object_property_find(cpuobj, "tag-memory")) {
                    error_report("MTE requested, but not supported "
                                 "by the guest CPU");
                    exit(1);
                }

> The following properties are registered as dynamic instance
> properties at arm_cpu_post_init():
> "cntfrq", "reset-cbar", "reset-hivecs", "rvbar", "has_el2",
> "has_el3", "cfgend", "vfp", "neon", "dsp", "has-mpu",
> "pmsav7-dregion", "secure-memory", "pmu", "idau", "init-svtor",
> "tag-memory", "secure-tag-memory".

thanks
-- PMM

