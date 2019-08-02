Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB8CC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 07:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA4932086A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 07:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="icEkShbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4932086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htSLj-0002o4-Vg
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 03:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34238)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1htSLK-0002Ik-Ra
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 03:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1htSLJ-00052J-TE
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 03:51:14 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:44074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1htSLH-00050w-Kr; Fri, 02 Aug 2019 03:51:12 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 3B83096F50;
 Fri,  2 Aug 2019 07:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564732269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5JXYGFw0SrkNdhYWhkbF5nQDgnrRl/1ad5g55DAqfU=;
 b=icEkShbJ+BtVXi+xWe8U3asaCRCoqwSEpDsW86i7/d6OvOXfc814QgE0bX2yrR5MXEA9xb
 fhYJAwVhXRWkbH99S+zVO7ioLv1eYjpLwREspIOtDrWi+wrP9yps6ty35jpYYQbUya/Uj8
 SE2IZYYz7kwWlFRmgOoQ9sybtYrJOHo=
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190801105742.20036-1-peter.maydell@linaro.org>
 <af347b17-b524-1075-d462-2b0e6eef41a5@greensocs.com>
 <CAFEAcA87XdDJH5TO-AiDfSqudmwzuY0yoa0H60objxXp3Bh9LA@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <569b96b1-e11a-59c5-4f67-1da2d592b8fc@greensocs.com>
Date: Fri, 2 Aug 2019 09:51:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA87XdDJH5TO-AiDfSqudmwzuY0yoa0H60objxXp3Bh9LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564732269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5JXYGFw0SrkNdhYWhkbF5nQDgnrRl/1ad5g55DAqfU=;
 b=CCX5KgZFNQ5uuMfb0M85LyFvy6KHZd1IzKZxczqavDzp5VaGuTooZh4HAni4ziQzSVRhjn
 bwOE21kFDyZam0K7iFpvnIDknLJpCMQmNqYOsElt5B6d7v0av6h2ZOcag4TUix4snqBNlZ
 vcGdo6fX8YeoqXSPeF2rFptWczsQtWU=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564732269; a=rsa-sha256; cv=none;
 b=iaKoeFsU6/PNB5qBJi81Pzop+eWfGeZV6fqYBIkCz9LPSgQTQSlr3XxL6JfbIWjR+6wZMM
 NXwY/lLpCYLHAjheINP9130n0RdxrAYnfR+Z8XvA9RQv1QG4JQThknIKbMpbk7YELcSiZp
 WyhzIDHIgZJhveRIF7uu5DEbk/OeT/c=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH for-4.1] target/arm: Avoid bogus NSACR
 traps on M-profile without Security Extension
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 8/1/19 4:38 PM, Peter Maydell wrote:
> On Thu, 1 Aug 2019 at 15:20, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>>
>> On 8/1/19 12:57 PM, Peter Maydell wrote:
>>> In Arm v8.0 M-profile CPUs without the Security Extension and also in
>>> v7M CPUs, there is no NSACR register. However, the code we have to handle
>>> the FPU does not always check whether the ARM_FEATURE_M_SECURITY bit
>>> is set before testing whether env->v7m.nsacr permits access to the
>>> FPU. This means that for a CPU with an FPU but without the Security
>>> Extension we would always take a bogus fault when trying to stack
>>> the FPU registers on an exception entry.
>>>
>>> We could fix this by adding extra feature bit checks for all uses,
>>> but it is simpler to just make the internal value of nsacr 0x3ff
>>
>> s/0x3ff/0xcff/ I think, given you put 0xcff after and in the code
> 
> Yes, 0xcff is correct and the commit message is wrong. (Bits 8 and 9
> of the NSACR are RES0 in all situations.)
> 

Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

