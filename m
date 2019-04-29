Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88999C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544212063F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M0nzRpb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544212063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59142 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL865-0002vx-IR
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:21:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL857-0002bW-W6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL857-0001dm-5P
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:20:37 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hL855-0001Vb-HL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:20:36 -0400
Received: by mail-pg1-x543.google.com with SMTP id l18so5307130pgj.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=W9MxSaOYOq2OLKWa9RYljq2JgLPANqHdAOI1yXJcsIU=;
	b=M0nzRpb5R9ZRDxw4RM+irMQTijgV27g7vIWq/cHL3XvWO6/SjcFd86f2B2Ta73U7Xx
	/RKGZXmNdUdAl0xJWCyshuY4wHFkV8um5EO1VyoMBX4iNqZumULap0an3837Q+v478yQ
	s0nO1hJjJZF44EEZRKF7c+1Ppw9jr4Q72x3OHc2AFI1bjBlQOwPvNZTc7enfhXcxcRbL
	w5XkvYE1qla/jrW2IlCmrfaBgSbigmIByCJyITjSCt3ZcqkV9gD6eOCFUPOCFzv9Jgqp
	txsFJisSilzcObpy3coAbXV78zSZ0Cf9iunQDcO91W9tqmp16tjP8kMq4AXLTX5Tcui/
	7WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=W9MxSaOYOq2OLKWa9RYljq2JgLPANqHdAOI1yXJcsIU=;
	b=LSIIRD92u5T3tcprXi8a/6EeSBCpOJGEuDiwFMZwrBpAdiyyEVMAZEXlzuB1YAic/1
	FdP6omYIBmVKesQUmOTY94xJOQScqWLrduD3siMjFfDmyoG3Oi5hT3QRDH8znWX4lvif
	mQaJUu7oqAEh7Dv0D0EH8nET1s2WRAlX/MExeBdOxB4/wRoqs8ae0Ne3tMRDpVFehx7m
	UAkh85sqKCPK/+AnkbPH7R8xgvqs/rSCayg4W3234VA6yfNP55Pz6wRhV0r0YL4j/Wbp
	Zzsy0768CtkN4OK/DsTOtsQugqKv+YIiaFBQb8XZooNYHx27jBVR43ZQ3n5WULeQmUYG
	rVjw==
X-Gm-Message-State: APjAAAXkncdfLNpJnouICJY/bZuNmV3p5h3pD63WdxkG2FpgVHiClBNf
	nhx4s72Lp2cWxOj4q/WgdHdUp52VHSY=
X-Google-Smtp-Source: APXvYqxVuM2Q9nqq/3BKw3sGfoVRZuaNysDf9yPAZfuYYhDlvvAisAWsr8DDlHz+bxYVvM6YRgIo0g==
X-Received: by 2002:a63:ac12:: with SMTP id v18mr59961198pge.111.1556551230680;
	Mon, 29 Apr 2019 08:20:30 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	s9sm44791601pfe.183.2019.04.29.08.20.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 08:20:29 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-29-richard.henderson@linaro.org>
	<CAFEAcA8=Tq4txdRkv2x04ZaaHBUnc1DCvvXOwdjOZj4JiQNVgw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <84ca26c6-fe25-092c-2c18-5d5ecbcbd481@linaro.org>
Date: Mon, 29 Apr 2019 08:20:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8=Tq4txdRkv2x04ZaaHBUnc1DCvvXOwdjOZj4JiQNVgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 28/36] target/xtensa: Use
 env_cpu, env_archcpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429152016.w60pS5LIoTODa4CPRNv1B4RrmX1FJ59V3cXM-ft18eo@z>

On 4/29/19 7:36 AM, Peter Maydell wrote:
> On Thu, 28 Mar 2019 at 23:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> @@ -712,10 +707,15 @@ static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
>>  #define XTENSA_CSBASE_LBEG_OFF_MASK 0x00ff0000
>>  #define XTENSA_CSBASE_LBEG_OFF_SHIFT 16
>>
>> +typedef CPUXtensaState CPUArchState;
>> +typedef XtensaCPU ArchCPU;
>> +
>> +#include "exec/cpu-all.h"
> 
> Shouldn't this bit be in an earlier patch ?

The diff is just funny here.

As with cris, it's really moving the following function below
exec/cpu-all.h, so that env_archcpu is defined.


r~

