Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321FBC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E332E206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="i9R7WRPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E332E206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHOQ-0000Ey-Mr
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1idFiP-0002ph-V0
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1idFiN-0004Rk-S8
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:40:21 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:42634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1idFiJ-0004H1-W7; Fri, 06 Dec 2019 10:40:16 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 36ED296EF0;
 Fri,  6 Dec 2019 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575646813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LkE7SYCCqhtLN+sQUgbdWaSzdNEbRl8KD/D5Bb/y4UQ=;
 b=i9R7WRPkIyEU6u+LR6jGj5PMR/0Smq/CyvfXWd2gh0cKhGtb1Q2GV43MkwwWT5ikGGmH3I
 X9HzAqOVHSUJoHJzB+HhbKcrqONYqeTqgyToaPwse0OHADY/atH7a3TcEsR+qc742jPUSM
 CW6JeydkMowtoyAQ4aDd++UYM4FVQDE=
Subject: Re: [PATCH v5 09/13] docs/devel/reset.txt: add doc about Resettable
 interface
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-10-damien.hedde@greensocs.com>
 <CAFEAcA_4x+EvDS8Lc0xyPE1GHRh4+7dvJ6sxMPXZjkrZ_CgrHw@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <6e730df5-878e-369f-dd79-08dfb6e09082@greensocs.com>
Date: Fri, 6 Dec 2019 16:40:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_4x+EvDS8Lc0xyPE1GHRh4+7dvJ6sxMPXZjkrZ_CgrHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575646814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LkE7SYCCqhtLN+sQUgbdWaSzdNEbRl8KD/D5Bb/y4UQ=;
 b=VOH82BzNEyHsWBACjsBw+dpMN3NvW9nA7R5ucbUFKXUE1QES5J3T9yQSGa4aFGCy7L9hYF
 RIvF41tOocEJyddELByNhiyASgikgpbZOn1q9CP690QFbKM1iSgzKUi0VX55MDekzBjWCi
 LKgdSSc00pnEU1Y4qDiD1+5eT8mDxPc=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575646814; a=rsa-sha256; cv=none;
 b=oaG3ZgcD+ITNRtGCz+O9+FA6/pa581OSI35YXe5p1yu60HxT+jkzWWG0ZjsoG7XxqY7k9B
 hQjBO6J2YiCp4dHIPogwafP9OWLPuEZRC+XCWyp/Rs/R0MdcwMl2zgh/YkeQ7W/2mGxjPT
 ftV99nD4gwsiMPKf1lP+saI3aP8o2t8=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/29/19 8:00 PM, Peter Maydell wrote:
> On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> 
> Subject line still says ".txt".
> 
>> ---
>>
>> Should I add an entry into index.rst ?
> 
> Yes, please.
> 
> I have one substantive comment on this patch: in the
> MyDev example of implementing reset, you make the enter/hold/exit
> functions do the reset of the subclass and then call the
> myclass->parent_phases method. This feels to me like it's the
> wrong way round and the parent class should reset first. Does
> it make any difference to do it this way round?
> 

Not really, I'll update them to what you say.

--
Damien

