Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59FEC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE8A216C8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="zEVfJHq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE8A216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqvXs-0008P9-Nn
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 04:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37352)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hqvXi-0007yt-PC
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hqvXf-00028O-HK
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:25:33 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:50668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hqvXZ-0001H6-A5; Fri, 26 Jul 2019 04:25:25 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 50B2696F52;
 Fri, 26 Jul 2019 08:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564129517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uhW//7NlF6/8uxZp9/haXV+K5W2WJaZQenevO7YlQs=;
 b=zEVfJHq0vxcOBY5OxuxL/n16bD1NMzkNWt1y2ptn4yLJIP5fABAOkhIu+1cWQete8sTu2c
 jqEwHb0cXtpct1LuyBiGjOoq6MtCS26aFBDBJgi/4BHBISMXZZPCABKgfTq8k6AUlv7/b5
 q/CFR0R4WQinLv5oOB2AU4T+o+d08oA=
To: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190725163710.11703-1-peter.maydell@linaro.org>
 <20190725163710.11703-2-peter.maydell@linaro.org>
 <20190725170228.GL2656@work-vm>
 <CAFEAcA9RQBz=t8F_nOTH9FZu_jKD0XVMJtPwmdnJBfnFR4G9oA@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <9631a4e2-80da-9369-038a-45f3b0399bc4@greensocs.com>
Date: Fri, 26 Jul 2019 10:25:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9RQBz=t8F_nOTH9FZu_jKD0XVMJtPwmdnJBfnFR4G9oA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564129518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uhW//7NlF6/8uxZp9/haXV+K5W2WJaZQenevO7YlQs=;
 b=ARfkxlVVu+UQcCGqXwKWtS5w4Q0Fu2Unx6kKZh2bTpejR498TJwEO+dorcwA7RtMqx+9w4
 88Am0TeXJfIvuovqL5yJ4tW7TAzQHefUk+O8U8fFpPZZcafp+qTvFaEMtIZR/WZ/x5Marx
 8/xpRPebX9r5MOMH0DH/cLDTcUuyVzI=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564129518; a=rsa-sha256; cv=none;
 b=FO77mzVqNdj/4ViDHbOWdCPPQPoKVQPFaqDEALlPhkDZiEa4ASd06GQifyDw+HBAlKNzeC
 KH6RqqvLjMk0vNTFAjNBCCUQ24rv0YMDTPpoBV3HaGqBH2D+M8tBhayq1V7PldY9jDaal0
 TcM5exGH2DsqehlnrGUPsJ/Wn4y68ow=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH for-4.1? 1/2] stellaris_input: Fix vmstate
 description of buttons field
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/25/19 7:59 PM, Peter Maydell wrote:
> On Thu, 25 Jul 2019 at 18:02, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
>>
>> * Peter Maydell (peter.maydell@linaro.org) wrote:
>>> gamepad_state::buttons is a pointer to an array of structs,
>>> not an array of structs, so should be declared in the vmstate
>>> with VMSTATE_STRUCT_VARRAY_POINTER_INT32; otherwise we
>>> corrupt memory on incoming migration.
>>>
>>> We bump the vmstate version field as the easiest way to
>>> deal with the migration break, since migration wouldn't have
>>> worked reliably before anyway.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

> As an aside, I'm surprised also the macro doesn't complain
> that we said the num_buttons field is int32 but it's really "int"...
> arguably a different kind of missing type check.

We would need to compile on a host with int size not being 32bit to
catch this kind of problem I think.

--
Damien

