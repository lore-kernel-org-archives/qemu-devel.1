Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78013C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 07:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D0322CBC
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 07:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="NtU/tbff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D0322CBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqYRF-0005mz-Fe
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 03:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33064)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hqYR3-0005EZ-Ts
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 03:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hqYR2-0001Zb-S2
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 03:45:09 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hqYQv-0001Uk-TA; Thu, 25 Jul 2019 03:45:03 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id B712396F50;
 Thu, 25 Jul 2019 07:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564040691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6E/dhIJltMKsvvszGWl2drzWPRH6NjYDH3AC7WIXk1U=;
 b=NtU/tbffUUgcGbYu9EZMw8S155Now5/AlBRQVsgT6+CNyGymse6o9jk9+aIuX/KNm7PZQM
 S7ijCDk1Almlqh4CdLGiT+l0lOOvLSPDphcOtXd4H8FxjeOjx065T/y0y4X4U0BGyQGOas
 ntjv0fdKsUo6y8PtgGH7FWymL6EZBuw=
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190724143553.21557-1-damien.hedde@greensocs.com>
 <543de194-b4e9-de7b-3dab-55fcc0976bc2@redhat.com>
 <20190724163812.GJ2717@work-vm>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <e66cc73d-d185-c52a-b9fd-5081f960f0d8@greensocs.com>
Date: Thu, 25 Jul 2019 09:44:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190724163812.GJ2717@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564040692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6E/dhIJltMKsvvszGWl2drzWPRH6NjYDH3AC7WIXk1U=;
 b=6c6srf0CoY3WfJDYWdB8b7IrxUe89Ygx6OoJPzmRpuTQbO0S0wywb2LhuThD28G21VzmFq
 lDR4I5GTeXdc7HV3BwWHJtvgPKfW3lwumQnciMphKpiFxPHcwYtG6iST6hqKcHdeSxSHpr
 uh3w3qZX2z8ptS7jrdiETKB1W+/nBao=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564040692; a=rsa-sha256; cv=none;
 b=ObpsSoqfbcOkU/9u9ly0hbZonvK4yHIgAChYkhPkYWMAQPUtfJBpYbTGG5dQ/Tnt0MffSB
 Gn850GXSxyiKsiIt7XJhrf2JWlhcFkHnAhJ2ulwKfEIyKHwEuCXkE0F1/p5l0nn9E8nw3x
 VQudHCdYjkQBeCzZ0M6HaOEzrVi1yxM=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH for 4.1?] pl330: fix vmstate description
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/24/19 6:38 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
>> On 7/24/19 4:35 PM, Damien Hedde wrote:
>>> Fix the pl330 main and queue vmstate description.
>>> There were missing POINTER flags causing crashes during
>>> incoming migration because:
>>> + PL330State chan field is a pointer to an array
>>> + PL330Queue queue field is a pointer to an array
>>>
>>> Also bump corresponding vmsd version numbers.
>>>
>>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>>> ---
>>>
>>> I found this while working on reset with xilinx-zynq machine.
>>>
>>> I'm not sure what's the vmsd version policy in such cases (for
>>> backward compatibility). I've simply bumped them since migration
>>> was not working anyway (vmstate_load_state was erasing critical part
>>> of PL330State and causing segfaults while loading following fields).
>>
>> I still not understand versioning and migration
>=20
> Incrementing the version (and minimum) is the right thing
> to do if you conclude the old one was hopelessly broken.
> Migration to and from old qemu breaks, but who cares since it was toast
> anyway.
> As far as I can tell pl330 is only on our zynq and exynos models
> so wont break our versioned 'virt' type.
> So from a migration point of view:

Since switching from VARRAY to VARRAY_POINTER does not change the size
of what's migrated, it should be possible to accept migration from old
qemu if we can ignore the data in such cases and default to something
(but what ? put the pl330 in reset state ?)

Thanks,
Damien

