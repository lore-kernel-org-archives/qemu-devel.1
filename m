Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037C1C76195
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 23:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A7221019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 23:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlgQvZsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A7221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoFZl-0004iA-0D
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 19:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hoFZb-0004IX-0R
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 19:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hoFZZ-0005eI-Tt
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 19:12:26 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hoFZZ-0005cX-LC; Thu, 18 Jul 2019 19:12:25 -0400
Received: by mail-pg1-x542.google.com with SMTP id o13so13546885pgp.12;
 Thu, 18 Jul 2019 16:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=xn9RkSJGX6yRqrisuG3RfzBrN6ycPBNkd+uWxqXR7CM=;
 b=YlgQvZsCAUCJkLoIDhamwC+Fz0A9cDMcA/daeSi54Zm/Fyn7N7/dqW6WRk4U1GUSIv
 zqNEwU9ZK1NUXXojrundQmm5lmec/KHlZUdJ/q/D4dHTYyzFc4ZucFP3OLGft902q/Ew
 LOLAikYNqvh5WP5SxWujKCEsMtS2oR8H6ISed6VckvGzePtngfOcW3fJh3JV6CX2Vtoh
 ViL1w2n+m069wFDuRVDA7pW5U8p6//31h7lQ8RQyue7RCZtq1+MPo/u1jAPe2/JnQhbd
 H3/w309EDDRQJkGUQ4kUoX/WFDfgnF53IV9eZc+o2k57F4hpjlmfcKIBnootqL85BAzu
 klYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=xn9RkSJGX6yRqrisuG3RfzBrN6ycPBNkd+uWxqXR7CM=;
 b=KuDIhYyZ/vN35sf7vCtqevrWiY3K8B5Vzvw29Q0C2Q2CSVB4SxYL7niwIcBCeR48gu
 D8tvkfGjfcR6nNVIMBbWc8BdCXaKP6vNSOpnpkMaVFmAjxDMyLqmQ/sVbRoFS8afhPyp
 fVoSEkpbXmZ7v8IExl0Kg4t+MX39i2+yZ6LjXbxxdhV1gqbk5dDAXYc5K+nIXyICzvAH
 6J2uMIs46P9jT9y01TBu1No9CjT5WZMqvueWiTR1fE4gy4lgpaiWBkc86NYriXZPbdh8
 LE7Hp4dUtMloCK+UoDEuKtxWLjB40czx9U40TMPq6sFd/j+k1Cu3wfaBW2A102Evt20G
 jdXA==
X-Gm-Message-State: APjAAAULSADafQDSlweHl1p7qaRu+Sa7o6t9F1SzLFdyGB4fuoccO9f9
 MItxfz+StYAs3xuEDrWEYeA=
X-Google-Smtp-Source: APXvYqw+Vh0X4uCSX6AIdeLC+ZCsPIVr2EDnsZKp0qOtzpC9jXsxE5TXE8lq/pMZm2/X0O4gKenobg==
X-Received: by 2002:a17:90a:26a1:: with SMTP id
 m30mr54963596pje.59.1563491544452; 
 Thu, 18 Jul 2019 16:12:24 -0700 (PDT)
Received: from localhost (61-68-63-89.tpgi.com.au. [61.68.63.89])
 by smtp.gmail.com with ESMTPSA id g11sm14815036pgu.11.2019.07.18.16.12.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 18 Jul 2019 16:12:22 -0700 (PDT)
Date: Fri, 19 Jul 2019 09:12:16 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Greg Kurz <groug@kaod.org>
References: <20190718034214.14948-1-npiggin@gmail.com>
 <20190718034214.14948-2-npiggin@gmail.com>
 <20190718121322.663cb5ec@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190718121322.663cb5ec@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563491322.dlreynwzv6.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v6 1/4] spapr: Implement dispatch tracking
 for tcg
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz's on July 18, 2019 8:13 pm:
> On Thu, 18 Jul 2019 13:42:11 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>> Implement cpu_exec_enter/exit on ppc which calls into new methods of
>> the same name in PPCVirtualHypervisorClass. These are used by spapr
>> to implement the splpar VPA dispatch counter initially.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>> Changes since v5:
>> - Move 'prod' into next patch.
>> - Use uint32_t type for dispatch counter.
>> - Add guest error message for incorrect dispatch counter.
>> - Conditionally compile away if CONFIG_USER_ONLY
>> - Small cleanups
>>=20
>> Changes since v4:
>> - Store to VPA on the way out as well.
>> - Increment the dispatch counter directly in the VPA, which means it wil=
l
>>   migrate with guest memory the same as KVM.
>> - Prod need not be migrated, add a comment.
>>=20
>>  hw/ppc/spapr.c                  | 52 +++++++++++++++++++++++++++++++++
>>  hw/ppc/spapr_hcall.c            |  5 ----
>>  include/hw/ppc/spapr.h          |  7 +++++
>>  target/ppc/cpu.h                |  4 +++
>>  target/ppc/translate_init.inc.c | 27 +++++++++++++++++
>>  5 files changed, 90 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 821f0d4a49..3e5678d467 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -4302,6 +4302,54 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id)
>>      return NULL;
>>  }
>> =20
>> +#ifndef CONFIG_USER_ONLY
>=20
> This file is for system emulation only, no need to guard here.
>=20
> This is minor and rest looks good.
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks for all the reviews Greg (and others), they made significant=20
improvements. David I'm not sure how you like to work with merging
patches, but if you can add the Reviewed-by tags and this issue, then
I won't have to resend.

Or if you prefer I can fix it up and send to you privately to reduce
list spam.

Thanks,
Nick
=

