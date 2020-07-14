Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746AFC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36AAB22203
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsnsmrDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AAB22203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvJ8P-0000cm-F3
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 07:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvJ7U-0008Px-RJ; Tue, 14 Jul 2020 07:29:09 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvJ7T-0008Rb-6r; Tue, 14 Jul 2020 07:29:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id q15so4869986wmj.2;
 Tue, 14 Jul 2020 04:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=skKYFyg+MpB+wZl4jmCFcPrZA9lj4AMb/KzPUfhJiTA=;
 b=JsnsmrDn/K8RxS1/vulBcJnVSQnQF6+VAgnjsa74fRM/EamCQlfvjHEjyuPzRnBMZ4
 Yg/s4uTehedyAyjhYqhXhA0iIZaOVlm6saeydVJOLmo7F5db5MQWtEtXXujpw3B/lkag
 Q4P8dIDbE5hfnhVrNh4bXt3tviTbPekubN8b8IKRNl1ejQcJ0s8XDXei4fRZNmp1qniD
 MLiDX9NDUBpjc4HDtu/fD7ws83CtOnueJH90yW8MhBmHW7Gm/j6LVF/hJKIC/B74MuLB
 8+moXJla4KDHNljwjx1o6lfcdv1axMPB1+QyWjFQFHMELAwfu5c4TNUOTH0lYl/vLl+X
 0tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=skKYFyg+MpB+wZl4jmCFcPrZA9lj4AMb/KzPUfhJiTA=;
 b=n6+Vx93LUHtwLluYHyhUfji9usZNp+4EDkmFjeTm1D1a4yGP1bP8n+ETDlOnanR6lN
 6rSafQ1xk4XzgMmDhZdpgKh21Zat7uk+bWzZy8n6znBgkqP6IA5W5J6Ga6IJjuxta4OW
 JIDS7WBBoHtjr8Sdm1VELKI9gXKGqXta5R0M0xPhFY/EJyTRG3/kpdfuqI/6FfsFgOFF
 Bln+L5F4jetA1p0vvo94ojk4kamjASGPQfSX2LnG+Fx28McT7MwCNL0M7Gz4BjyfOAHE
 iAfDwoMkW72LMj2wBruCsJMe5RVEYOVst+Uncmlav7IYUsfZjibJS6376m4lnpKCUpgx
 iejQ==
X-Gm-Message-State: AOAM5322PT7GRS9J6RVRRSFys5FEte1QNgLUC0hEZ81Zux7RP/s++Uvf
 QuJkFXeJHtppcoxnVvlhlUmHg7xzrpM=
X-Google-Smtp-Source: ABdhPJx4I77w2Xp416tvA6bEQmtOSeLdZhK2ZtnkX+ut7HDMTaMT7UJxmy452nzuy7HSotblIAqAXw==
X-Received: by 2002:a1c:7313:: with SMTP id d19mr3636768wmb.147.1594726144717; 
 Tue, 14 Jul 2020 04:29:04 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id g14sm29076004wrm.93.2020.07.14.04.29.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 04:29:03 -0700 (PDT)
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: Markus Armbruster <armbru@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-11-hskinnemoen@google.com>
 <109d52ed-65bf-0fcc-98f1-47b7a6671d0b@kaod.org>
 <CAFQmdRZcygskP3iwss01-Jz67yjAP_JENXjWM2Bp8U=DRzxR0Q@mail.gmail.com>
 <875zaq78xq.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <19733456-a672-595d-e721-e0ef26d7f665@amsat.org>
Date: Tue, 14 Jul 2020 13:29:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <875zaq78xq.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+ qemu-block experts.

On 7/14/20 11:16 AM, Markus Armbruster wrote:
> Havard Skinnemoen <hskinnemoen@google.com> writes:
> 
>> On Mon, Jul 13, 2020 at 7:57 AM Cédric Le Goater <clg@kaod.org> wrote:
>>>
>>> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
>>>> This allows these NPCM7xx-based boards to boot from a flash image, e.g.
>>>> one built with OpenBMC. For example like this:
>>>>
>>>> IMAGE=${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
>>>> qemu-system-arm -machine quanta-gsj -nographic \
>>>>       -bios ~/qemu/bootrom/npcm7xx_bootrom.bin \
>>>>       -drive file=${IMAGE},if=mtd,bus=0,unit=0,format=raw,snapshot=on
>>>>
>>>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
>>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>>
>>> May be we don't need to create the flash object if dinfo is NULL.
>>
>> It's soldered on the board, so you can't really boot the board without
>> it. But if you think it's better to remove it altogether if we don't
>> have an image to load into it, I can do that.
> 
> If a device is a fixed part of the physical board, it should be a fixed
> part of the virtual board, too.

We agree so far but ... how to do it?

I never used this API, does that makes sense?

    if (!dinfo) {
        QemuOpts *opts;

        opts = qemu_opts_create(NULL, "spi-flash", 1, &error_abort);
        qdict_put_str(opts, "format", "null-co");
        qdict_put_int(opts, BLOCK_OPT_SIZE, 64 * MiB);
        qdict_put_bool(opts, NULL_OPT_ZEROES, false); // XXX

        dinfo = drive_new(opts, IF_MTD, &error_abort);
        qemu_opts_del(opts);
    }

We should probably add a public helper for that.

'XXX' because NOR flashes erase content is when hardware bit
is set, so it would be more useful to return -1/0xff... rather
than zeroes.

