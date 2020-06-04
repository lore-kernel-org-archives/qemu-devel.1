Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D01C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0111120772
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYCtXpVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0111120772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgqHk-0005nu-Ap
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgqGD-0004EY-5t
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:50:21 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgqGB-0008V3-6O
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:50:20 -0400
Received: by mail-wm1-x342.google.com with SMTP id d128so5714216wmc.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2mmg02xANAbYgTOopUt8lnE2g3Io64kIiL778nabnUI=;
 b=IYCtXpVxUqDn2a1b4I0ux57YxB7UbK2LYaIxl9jSfOwwuAu3eJtd87gmbCJm/gLpG5
 RcoFaTanQdeqz0CXQ22U99no+CJDacYi7JR1lmkpUDKwBvWyiZhqFyORFw6gb85k60gN
 +sBi3bZg0DZd7T0gseS7h2wNKyVQzz9KTQW96ra2EwgflriCrEsN+Vu4EfyOsPM8017H
 wmYizrOzGLrEAUDu4rPVuxiD/rw89OKuDNfdwHsqSpf/+kY2egilQ1iRhp/DrDs18MnV
 vbiekGTk3a6DCbg0dhiRuWzZyh/KGXKw+1QSdnFPReaCILzPEWdx/ycGVeWI+Nw+GU6+
 03sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2mmg02xANAbYgTOopUt8lnE2g3Io64kIiL778nabnUI=;
 b=FL1rsGx3u/iUzpEZlnS6NkfyEdHeWAF8pevJfZbMjwYysz34YVleB9Ccb9DUvlCgPf
 9MS39p2pxg8zD6BHgul050hFGfiTwR+KGood809l5d5kvSdTIFtZnembOCXP78vXEJ7k
 /yXD8S6hAPvu5STWVHciW4zfAaHF+xsfr8Dls3ZU5rtrVYwe3raHB9YhJfzKT78zLtoH
 lrf72W9Bqv7t0sj8iSMEU+Px12EmFngo5HOH8mLoBmXUrWET6U9ccHXTmpVCg+zUHqR3
 f+8DXKPjVrgRv+Yb8Tkb5MB3ytOoMcGRjX+F+J7yHLWF9oidH75En0zB5CDdCx367yAU
 b1rg==
X-Gm-Message-State: AOAM531kTQh7xrt2En2rXqnd7p+5SYP4QteCVPGlN6ZGENvBEUPangV6
 XIgDD58bpbAP3xu8rPZZ8bKAo9k3rzI=
X-Google-Smtp-Source: ABdhPJwR/R1nTRhAGLafvgtO1pfeGtWtip9wl4pzc9Brfe7Vgke0V86TnhazINq2NnsCiukEXpN84A==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr4118906wmq.106.1591278616980; 
 Thu, 04 Jun 2020 06:50:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 128sm7999057wme.39.2020.06.04.06.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 06:50:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9136A1FF7E;
 Thu,  4 Jun 2020 14:50:14 +0100 (BST)
References: <20200604111323.7458-1-alex.bennee@linaro.org>
 <20200604071504-mutt-send-email-mst@kernel.org>
 <87ftbb59vm.fsf@linaro.org>
 <0cce5904-fe53-d7ff-93b7-095cded2caf3@redhat.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
In-reply-to: <0cce5904-fe53-d7ff-93b7-095cded2caf3@redhat.com>
Date: Thu, 04 Jun 2020 14:50:14 +0100
Message-ID: <87a71j54a1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 6/4/20 1:49 PM, Alex Benn=C3=A9e wrote:
>>=20
>> Michael S. Tsirkin <mst@redhat.com> writes:
>>=20
>>> On Thu, Jun 04, 2020 at 12:13:23PM +0100, Alex Benn=C3=83=C2=A9e wrote:
>>>> The purpose of vhost_section is to identify RAM regions that need to
>>>> be made available to a vhost client. However when running under TCG
>>>> all RAM sections have DIRTY_MEMORY_CODE set which leads to problems
>>>> down the line. The original comment implies VGA regions are a problem
>>>> but doesn't explain why vhost has a problem with it.
>>>>
>>>> Re-factor the code so:
>>>>
>>>>   - steps are clearer to follow
>>>>   - reason for rejection is recorded in the trace point
>>>>   - we allow DIRTY_MEMORY_CODE when TCG is enabled
>>>>
>>>> Signed-off-by: Alex Benn=C3=83=C2=A9e <alex.bennee@linaro.org>
>>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>>> ---
>>>>  hw/virtio/vhost.c | 46 ++++++++++++++++++++++++++++++++--------------
>>>>  1 file changed, 32 insertions(+), 14 deletions(-)
> [...]
>>>> +
>>>> +    if (memory_region_is_ram(section->mr) && !memory_region_is_rom(se=
ction->mr)) {
>>>> +        uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(secti=
on->mr);
>>>> +        uint8_t handled_dirty;
>>>>=20=20
>>>> -    if (result && dev->vhost_ops->vhost_backend_mem_section_filter) {
>>>> -        result &=3D
>>>> -            dev->vhost_ops->vhost_backend_mem_section_filter(dev, sec=
tion);
>>>> +        /*
>>>> +         * Vhost doesn't handle any block which is doing dirty-tracki=
ng other
>>>> +         * than migration; this typically fires on VGA areas. However
>>>> +         * for TCG we also do dirty code page tracking which shouldn't
>>>> +         * get in the way.
>>>> +         */
>>>> +        handled_dirty =3D (1 << DIRTY_MEMORY_MIGRATION);
>>>> +        if (tcg_enabled()) {
>>>> +            handled_dirty |=3D (1 << DIRTY_MEMORY_CODE);
>>>> +        }
>>>
>>> So DIRTY_MEMORY_CODE is only set by TCG right? Thus I'm guessing
>>> we can just allow this unconditionally.
>>=20
>> Which actually makes the test:
>>=20
>>   if (dirty_mask & DIRTY_MEMORY_VGA) {
>
> Eh? Shouldn't this be "if (dirty_mask & (1 << DIRTY_MEMORY_VGA))"?

Yeah - that's what I meant... I've left it as the other form in v2
though.

>
>>      .. fail ..
>>   }
>>=20
>> which is more in line with the comment although wouldn't fail if we
>> added additional DIRTY_MEMORY flags. This leads to the question what
>> exactly is it about DIRTY tracking that vhost doesn't like. Is it really
>> only avoiding having virtqueue in video RAM? Does this ever actually
>> happen?
>>=20
>> I assume boards with unified memory models where video ram is shared
>> with system ram just end up partitioning the memory regions?
>>=20


--=20
Alex Benn=C3=A9e

