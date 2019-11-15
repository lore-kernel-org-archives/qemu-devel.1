Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33DEC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 20:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4B4206D9
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 20:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4sXRDDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4B4206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVhzX-0007YL-OT
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 15:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iVhye-00071I-BC
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:13:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iVhyd-0005YE-8o
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:13:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41366
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iVhyd-0005Xy-5E
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573848834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcWiT6IJUFWyy7j3i2JUztrqelJ43IUFT+I9NhbDR4E=;
 b=I4sXRDDf//X/ROlWSA0EzUyMu/5/kIzBTcRE2qSuY1Wgn3YsfxkfX8nvxLaAEGq5T3/m4D
 hURZRoG2ZoKH49vF9i+slWu2o3ciVHb83xWmKSa5u1F8jMf6DTlb1xdO0eKHgq9CPSI6EX
 YY6Zhy3MFGB8MDFW54l2nnZUenXnfzY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-r51JeLjuND6vZ9qye3Uzew-1; Fri, 15 Nov 2019 15:13:52 -0500
Received: by mail-wm1-f69.google.com with SMTP id g14so7810816wmk.9
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 12:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jSk6MSXrMTuD+6d5TS7RieuJpLzq0JDmRMZu+Z7y0h0=;
 b=NiuHfxx1bhg0lid25k5x/kQw9rpOtLxl4FjJ3bqWsMfjw1W9Y5k0z30IvKcHhCwznh
 3vV6tmMTo11UcdYPYFJm7fK6idpwJSwGFmUuzrhpMArHHWTlo+FihL5elMYVbxQdAd6r
 3O1en+OGYVcHYb6zlvGXS8pcqBkhrI2xxKEJ8jpD7RpWqhmoV/A8cFGgLM+9YgFlIrSs
 JuvgQgkBagnR9ElXZRi80hQ6KRBk+8wwAaaDlrgCACnxfuI8+PaHM9bSRg/UJgM7cFsb
 2FNlcD/uSugK79uBxQ15QaLsk/qcHOJP47DoDZe8hBY/3VuIQMCVUYFtzv6bpvnIDy0W
 wQ3g==
X-Gm-Message-State: APjAAAXEyd1KLN4JHMdkJyaLSw0Jd2sAGVNJRe2a20NxWPAgLGaD4Dhh
 noRJdxebkRi+XgqrLfQIdZJ/znH6NVcyi6P8QshRtWXYR36MF7hNg75gEgYQX9szv0n3PFvHr+l
 Bap1q+SCiSb722yk=
X-Received: by 2002:a05:600c:20e:: with SMTP id
 14mr16118017wmi.107.1573848831806; 
 Fri, 15 Nov 2019 12:13:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpmZMuk+wogRHZyQ34PuF10K0SX1ugSWWfcbFH6Yhea1AOdZ9mSThEPA6TO848Wo5FGXKefw==
X-Received: by 2002:a05:600c:20e:: with SMTP id
 14mr16117987wmi.107.1573848831641; 
 Fri, 15 Nov 2019 12:13:51 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id a15sm3045352wrx.81.2019.11.15.12.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2019 12:13:51 -0800 (PST)
Subject: Re: [PATCH v1 0/1] hw/arm: versal: Add the CRP as unimplemented
To: qemu-devel@nongnu.org, no-reply@patchew.org, edgar.iglesias@gmail.com
References: <157384151968.4715.3538455192633139890@37313f22b938>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f524f24a-1655-5234-4b67-0830c84fa262@redhat.com>
Date: Fri, 15 Nov 2019 21:13:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157384151968.4715.3538455192633139890@37313f22b938>
Content-Language: en-US
X-MC-Unique: r51JeLjuND6vZ9qye3Uzew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, edgar.iglesias@xilinx.com,
 sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com,
 sstabellini@kernel.org, qemu-arm@nongnu.org, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/15/19 7:12 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20191115154734.26449-1-edgar.iglesi=
as@gmail.com/
> =20
> This series failed the docker-quick@centos7 build test. Please find the t=
esting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
[...]
> The full log is available at
> http://patchew.org/logs/20191115154734.26449-1-edgar.iglesias@gmail.com/t=
esting.docker-quick@centos7/?type=3Dmessage.

Unrelated error:

 From https://github.com/patchew-project/qemu
  * [new tag]=20
patchew/20191115154734.26449-1-edgar.iglesias@gmail.com ->=20
patchew/20191115154734.26449-1-edgar.iglesias@gmail.com
fatal: failed to write ref-pack file
fatal: The remote end hung up unexpectedly


