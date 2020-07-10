Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33077C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FDF20767
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPXQcbWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FDF20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtpj9-0005Gx-9s
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtpiZ-0004eU-Pa; Fri, 10 Jul 2020 05:53:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtpiY-0007H0-4r; Fri, 10 Jul 2020 05:53:19 -0400
Received: by mail-wr1-x443.google.com with SMTP id f7so5309226wrw.1;
 Fri, 10 Jul 2020 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vALe+/4SV7l9BcECU7uRDtzu+oiQ5M/MGBxUCa9Vn5Y=;
 b=MPXQcbWCrOyRkfaCNLG9IY9cnk7igUHITZLaU2bVm5+T+3PPbliczZnz3F5n7a2kRW
 0SBVCITg2/bPnOIMJGvc3waUyCsokElyk5uP9bpHlKe1suoeG22a4HVhTkDtOe39Yqyt
 UnYQP4mzWqwuHVEFLeVuQa91FKAED7nW/BmAu8tnQxhk6B+MAEBoTA2SiPGizr/NfkbA
 BRWjN7zoAdJJoVyLCJEA9ml/xJA4EfxOpY98z5AlxxckupV5jeZYpKPrRkziieXKRQJW
 GlTJU6VWeh6AG7TWmWN+ohTLST2zbXiIBJ+y/+cT547W6PrzzW0vERK6qj9BLrty2h7Y
 1SXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vALe+/4SV7l9BcECU7uRDtzu+oiQ5M/MGBxUCa9Vn5Y=;
 b=BxMQkktPywj/aGyT26CKG1+XE3dQNOT0sb/pbTYs1fLFKnk/DEi1WeeDsNF2QzWV6S
 CRcFg7iM86/YAyW0BqqHvU2EN28H6oc//wpebGNcHpeTYKdtMMoSRoxd+zU1uZQXDJqP
 cmYsl0U/AuXV9Dxmc4WJ6tnc1ulj1CxhQOGQxNx/KkKKhW0UE9dx++ahWztQGhKMxL29
 cLrnvv+1h6XYqYNwMw3wxwkGKwIBmmsBjDakSQw1NoEzUmJnbuDMbx3pnvi2rcO2ntM8
 cwK4IntRCmmmcnhAvBTFGbfQSI3UuqqifGnbROs5OEm2bDSv/gIHuzEJfua3z25M3wXF
 waDw==
X-Gm-Message-State: AOAM530JgDAuTpt2z2SzJ6jLcGREAd00b2265NUF0033/oYXimAj2IU+
 FUitQL52jeZe/t1wocYpxzM=
X-Google-Smtp-Source: ABdhPJzTbd4Q3Pv77CNXuZATdzi6ZM8ZZoATzIgqHAGVusn8Rg70hus8HXw4DxC0nZpP1niLq2zrCA==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr71318914wrm.40.1594374795559; 
 Fri, 10 Jul 2020 02:53:15 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 69sm9149693wma.16.2020.07.10.02.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 02:53:14 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] hw/i2c: Rename method names for consistency and
 add documentation
To: qemu-devel@nongnu.org
References: <20200705224154.16917-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c287bb80-7057-b5f9-5263-84b7a12790bb@amsat.org>
Date: Fri, 10 Jul 2020 11:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200705224154.16917-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Corey, this series is now fully reviewed :)

On 7/6/20 12:41 AM, Philippe Mathieu-Daudé wrote:
> In commit d88c42ff2c we added 2 methods: i2c_try_create_slave()
> and i2c_realize_and_unref().
> Markus noted their name could be improved for consistency [1],
> and Peter reported the lack of documentation [2]. Fix that now.
> 
> Since v1:
> - Addressed Markus review comments
> - Added Markus/Corey R-b tags
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg07060.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08997.html
> 
> $ git backport-diff -u -v1
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream patch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
> 
> 001/5:[----] [--] 'hw/i2c/aspeed_i2c: Simplify aspeed_i2c_get_bus()'
> 002/5:[0006] [FC] 'hw/i2c: Rename i2c_try_create_slave() as i2c_slave_new()'
> 003/5:[0004] [FC] 'hw/i2c: Rename i2c_realize_and_unref() as i2c_slave_realize_and_unref()'
> 004/5:[0006] [FC] 'hw/i2c: Rename i2c_create_slave() as i2c_slave_create_simple()'
> 005/5:[0012] [FC] 'hw/i2c: Document the I2C qdev helpers'

