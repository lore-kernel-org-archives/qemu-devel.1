Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6124C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93CA82074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6/y6B41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CA82074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYux-0004D5-Rl
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYtq-0002hb-42; Tue, 09 Jun 2020 03:42:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYtp-0000cA-6p; Tue, 09 Jun 2020 03:42:21 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so20109036wru.0;
 Tue, 09 Jun 2020 00:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FjQKd7DqIqJWbaTyIFT4KcmgiVR0pp9EmiIfsTPjyYo=;
 b=T6/y6B41JPOvxeS9Pt8gW6bAGDBVrNAs6Az8s3Famdps8f6HwnHo+qHKI9zMvKk5DB
 zSuB8TlSmDZjgHLTEP1zA+d/DJjTO8ZgGh41Phi8cOprtZzj3KpPoGHFkh/LVK+9/5ye
 hCXJL+6ogHfRwBSHGWSScfYrVEfub/l6C29bMggnZeeho97qR+V2f/s01bar8+dwEicV
 oYwg2awybQblRXpSx4363k+uBTXpYDrLRiVeVCruCj+ThMuddx8Oh8zQgrsRML7rPRE/
 NsJpIwbUZ+jAhyRY0Q/mlUWfaLNyxThh40FnlY/4gMNdhLfWA2wFa7+WFaVPwpIALfL/
 h7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FjQKd7DqIqJWbaTyIFT4KcmgiVR0pp9EmiIfsTPjyYo=;
 b=uJEErBmXpFV0/Ap/PvJoMBZBAQSMIiA7G+KzeqLrjSyBnv+NdW0y8/mpDH+AndBnzq
 +3E7kfT0GRmNohsN55Fo2dMnDDRyRe3YXOJ/J3dwbARCAtbY28X4BPC5bc7SvRGZw/wQ
 j43RlU4Sdy7uyVq6dEA1BQOnavTjHW9DMRNjddvPTvpRgcfUa28Ww2tOQkv1R5Swkj+H
 e3xm5mlUcXh+XpNoXh3llWVJqnL0eRMBE7ubRKpDKDZ1IhUwUUfm5KMXwp84jF+7HZ0Z
 pki9ijPJi4aJooJ7jbezzYAwlgI48Y2QtKZpXZesoOpf29IbodqUwcieU/bEUJMgZM37
 pQmw==
X-Gm-Message-State: AOAM532pWikqLjl/ax47O2QtdtUZcZoSrsh0/zKHcqQbpHxTN8m5TsSd
 t/cUs6EE/qllH4G2JC1r68Y=
X-Google-Smtp-Source: ABdhPJzzHrM4U46heXA/3oCDc5rULLpKzPLa7Ja9JohWlWmApNMlnu+Tb13MU1ss2/YO21RGR8gXlw==
X-Received: by 2002:adf:9205:: with SMTP id 5mr2799942wrj.232.1591688538853;
 Tue, 09 Jun 2020 00:42:18 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id x186sm2010030wmg.8.2020.06.09.00.42.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 00:42:18 -0700 (PDT)
Subject: Re: [PATCH v2 02/24] display/xlnx_dp: Fix to realize "i2c-ddc" and
 "aux-to-i2c-bridge"
To: Markus Armbruster <armbru@redhat.com>
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-3-armbru@redhat.com>
 <a64bd91c-58b5-1438-a401-5d6c04441c67@amsat.org>
 <87tuzkssri.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <18c2da69-7d2b-59cb-619f-0f2d06cdedf4@amsat.org>
Date: Tue, 9 Jun 2020 09:42:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87tuzkssri.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 ehabkost@redhat.com, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, pbonzini@redhat.com,
 KONRAD Frederic <fred.konrad@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 7:38 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> On 5/28/20 1:04 PM, Markus Armbruster wrote:
>>> xlnx_dp_init() creates these two devices, but they're never realized.
>>> Affects machine xlnx-zcu102.
>>>
>>> In theory, a device becomes real only on realize.  In practice, the
>>> transition from unreal to real is a fuzzy one.  The work to make a
>>> device real can be spread between realize methods (fine),
>>> instance_init methods (wrong), and board code wiring up the device
>>> (fine as long as it effectively happens on realize).  Depending on
>>> what exactly is done where, a device can work even when we neglect to
>>> realize it.
>>>
>>> These two appear to work.  Nevertheless, it's a clear misuse of the
>>> interface.  Even when it works today (more or less by chance), it can
>>> break tomorrow.
>>>
>>> Fix by realizing them in xlnx_dp_realize().
>>>
>>> Fixes: 58ac482a66de09a7590f705e53fc6a3fb8a055e8
>>> Cc: KONRAD Frederic <fred.konrad@greensocs.com>
>>> Cc: Alistair Francis <alistair@alistair23.me>
>>> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>> Cc: qemu-arm@nongnu.org
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>  hw/display/xlnx_dp.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
>>> index 3e5fb44e06..bdc229a51e 100644
>>> --- a/hw/display/xlnx_dp.c
>>> +++ b/hw/display/xlnx_dp.c
>>> @@ -1264,9 +1264,13 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
>>>      DisplaySurface *surface;
>>>      struct audsettings as;
>>>  
>>> +    qdev_init_nofail(DEVICE(s->aux_bus->bridge));
>>
>> Eh??? Why not realize the bridge in aux_init_bus()?
> 
> Because then aux_init_bus() is no longer "init", but "init and realize".
> Instead: "[PATCH v2 32/58] auxbus: New aux_bus_realize(), pairing with
> aux_bus_init()".  Okay?

It would be easier to follow having aux_bus_realize() introduced first,
then used it directly here. Anyway it is reviewed so I don't have a
problem if this patch goes as it. Thanks.

> 
>>> +
>>>      qdev_init_nofail(DEVICE(s->dpcd));
>>>      aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
>>>  
>>> +    qdev_init_nofail(DEVICE(s->edid));
>>
>> This one is OK.
>>
>>> +
>>>      s->console = graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
>>>      surface = qemu_console_surface(s->console);
>>>      xlnx_dpdma_set_host_data_location(s->dpdma, DP_GRAPHIC_DMA_CHANNEL,
>>>
> 
> 

