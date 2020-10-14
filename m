Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18A4C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B670208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sv6ZIxC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B670208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSers-0000L6-1D
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSeqg-0007l2-UN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:21:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSeqf-0005Ie-CE
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:21:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id n15so3377930wrq.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 04:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BYhlbrwzPEAEvAK7KZFybMpVy1uhyb7xGaHz0is+b+Y=;
 b=sv6ZIxC3VCJk2AdQanOZ+T2WMzF0R3f0X6EGFhIucmmMFXFtGn5P9hOUBr9E2huiRK
 EcUbU0+x+Ngc/T/N3RHQfTXzx8a1Np3wn0yDCz+MPJuZN+ryqUL2tI4ezK2yYRATes4z
 Ff0SebYxHNKHnQaL02a1th/BmNos+hptAkCXPb5mhQXHk56uYFBDVkH7nYlfpNfhAuTc
 N2BY/JjhKhBp3GZ8SDllmiZBMrmH7t6waqNJX34k861YS3KsNJPXuy3nkwWR1Bf3w45K
 ctC8ID50hbmH6whxnJadwWkhlQG6rpRs8377W2xG/aR/oZjYykDABSZYO2McN5K8mrcn
 QzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BYhlbrwzPEAEvAK7KZFybMpVy1uhyb7xGaHz0is+b+Y=;
 b=rNZyzb2JEsLbZ6zfcxyLZqOxENN6i2naeHrpcD0XJTYKuKeQ9Lr6VNzfX8XaCkRFWb
 9WwtmuNp2sI2fCsBybQY7z//CKIYHe/kJCMpdrRJ0GruTXaZYSSbUHnvPBZ7CUYvyQp6
 bzchOjvBsbpK+Am7K3W3H1AawUXtvYVFOSAPG9bq2pwO/N7Hq3SFH+NH0ajXiohpZTv3
 hPrLN/1/b9juWl5txQz7Mq/OftyIDizbyGRqObxnZbBaeWM+AFgmaeo0vTekW6Mb0hH9
 cm4UpMNjzw42uXXwS3ldKo1c+ywcSuZNWyaUNgf74PR0dwvVhnxR2lJ3XKEs1OASGEbn
 H+NA==
X-Gm-Message-State: AOAM532JpzDAf71Kvi8IYdbNyRkWF61kGNrIznZQ2ekASuIB1pAm9ASY
 rnm9XmRO2B3Kug/pRXO7poQxDwzDky0=
X-Google-Smtp-Source: ABdhPJynIjIRVMcmDOJqCgshybUW5QW3OGNPkgZJs1TwNLv9lwvRBtbzEoc/jHbyVvKAE5ie0n9TJw==
X-Received: by 2002:adf:bbca:: with SMTP id z10mr5280156wrg.403.1602674495496; 
 Wed, 14 Oct 2020 04:21:35 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id q6sm3395549wma.0.2020.10.14.04.21.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 04:21:34 -0700 (PDT)
Subject: Re: [RFC v1 0/2] tcg-cpus: split into 3 tcg variants
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
References: <20201014073605.6155-1-cfontana@suse.de>
 <87pn5lxgge.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <18216283-1175-4460-3c65-023c9fb796bf@amsat.org>
Date: Wed, 14 Oct 2020 13:21:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87pn5lxgge.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 12:14 PM, Alex Bennée wrote:
> 
> Claudio Fontana <cfontana@suse.de> writes:
> 
>> The purpose of this series is to split the tcg-cpus into
>> 3 variants:
>>
>> tcg_cpus_mttcg    (multithreaded tcg vcpus)
>> tcg_cpus_rr       (single threaded round robin vcpus)
>> tcg_cpus_icount   (same as RR, but using icount)
> 
> I've no objection to the cosmetic clean-up but I assume the 3 modes will
> still be available in TCG enabled binaries.

Yes, I think so too, no point in disabling some.
However it seems to me it is now easier to review
for a newcomer.

Code easily understandable/reviewable is easier to
maintain and less bug prone :)

Phil.

