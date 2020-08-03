Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817F0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BF320738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wk/3fq0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BF320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2YhH-0000fR-C9
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2Ygf-0000F7-Ug
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:31:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2Yge-0006bZ-B9
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:31:25 -0400
Received: by mail-wr1-x436.google.com with SMTP id 88so33839004wrh.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 04:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+zdISvL0meyBz552Fbf+BUu1qz/BTBm425Mipq59Dqo=;
 b=Wk/3fq0H1HYVdwW/K64P50YGP94ELJ1w1st4fVgUhVjq0NvrPl9nJxRcZs41DVlFFS
 kTcg3du23k0te5kFlY0igWcHps8AWOl/n15kGzDzMf0yoOrUUHTCghDAx9lJAB69nHD0
 oIdrut1yN+lRMffrCviqsdNZU1xafijb4CDFt8f5oHXARgPHiqtR0uq4c20e3SSprU63
 I6C2GPwfPpL7bMzpu6Czzr8n63egRZgstzpzvLDsQAKRoXVb1VSM4YO6VjwarLtWlNlW
 Wx75/iN9bb6W4PB85wKwSLYfNVhv/2qBT/07qoa4SnaS/nMIp9qqaIxOy+LfdQ5Qh2/7
 xYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+zdISvL0meyBz552Fbf+BUu1qz/BTBm425Mipq59Dqo=;
 b=Nwnfw9QfjxEV7BJhTTlXJ2p/pHi3XNzwCAP8Yb1eHE+DDv0vc73WotWNfKpL+NjuOz
 4qubq6evcp9RleUXtb/v6eTaaOdXcqgSKQXhSbC0QpFrKy6QOBNDD9N763+zqy9rYrDe
 M5+uOsbFYUPANTXt1HoqOoLwNw7PeWztV02m9F6er5gXDW9s2LZ+X69GYC6buHSMsvtO
 NJB5wmNgACJF+U8ImKjYcYlXu1zdl1OeJn/MM01/QTyY1YP+RoTxrctC7/xXP34KJpbz
 IQ6YWgYry4NzCBiTZ0WR9iZs4paSyesdmzd4A55YJ4g3zM/zdPZ2dYm0u95m3I7UQjPV
 1CMA==
X-Gm-Message-State: AOAM532UaynIznGkdbGrIfv0q90XVxjf3na2UUv7MueZqpnrumkjBoOS
 Sqx7KoYAQrNOPljl9mlylQKkGA==
X-Google-Smtp-Source: ABdhPJzcAJvgswsU/okCnC0IzfNCX/bGddaUyCBvnQMB8yE4+d/jXjxVoOuqghkREvZsCJdaWMkwVA==
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr15124451wrn.10.1596454282367; 
 Mon, 03 Aug 2020 04:31:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x4sm28314220wru.81.2020.08.03.04.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 04:31:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1CF7A1FF7E;
 Mon,  3 Aug 2020 12:31:20 +0100 (BST)
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-76-frank.chang@sifive.com>
 <684f11b4-eb62-601a-1664-afaeca4b1711@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC v2 75/76] target/riscv: gdb: support vector registers for
 rv64
In-reply-to: <684f11b4-eb62-601a-1664-afaeca4b1711@linaro.org>
Date: Mon, 03 Aug 2020 12:31:20 +0100
Message-ID: <878sewneyf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 frank.chang@sifive.com, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Hsiangkai Wang <kai.wang@sifive.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
>> +    if (env->misa & RVV) {
>> +        /* TODO: support vlen other than 128, 256, 512 bits. */
>> +        const char *vector_xml_name =3D NULL;
>> +        switch (cpu->cfg.vlen) {
>> +        case 128:
>> +            vector_xml_name =3D "riscv-64bit-vector-128b.xml";
>> +            break;
>> +        case 256:
>> +            vector_xml_name =3D "riscv-64bit-vector-256b.xml";
>> +            break;
>> +        case 512:
>> +            vector_xml_name =3D "riscv-64bit-vector-512b.xml";
>> +            break;
>> +        default:
>> +            vector_xml_name =3D NULL;
>> +            break;
>> +        }
>
> I guess this is ok as-is, but consider mirroring
> arm_gen_dynamic_svereg_xml().

Longer term I would personally prefer us centralising the dynamic
building of XML to a gdbstub utility function. The eventual long term aim
would be for guests to register(!) their set of additional registers
with the central core code in a more useful form so we can also expose
them to the plugins system which will most likely not want to inflict
XML on the plugins ;-)


--=20
Alex Benn=C3=A9e

