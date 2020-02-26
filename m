Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BCBC4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C923120732
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nr34XaMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C923120732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sVi-0001ja-1e
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 03:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6sPL-0006ZH-SE
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6sPK-0008W6-K3
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:51:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56831
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6sPK-0008Us-Ej
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582707066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQpZlTFOpCQdcAfmaVjhCvGpQBYYpPhdmTp1WoVfG9Y=;
 b=Nr34XaMIylP8pIqrBzKwxCUSkwFi6JWhnbH8pennb6bTRhkPqjqSohYj4wV6x/wCFfNywF
 F4dtGt9KcIDhDsomcfWAI2jnbxEv0qdMXxYQWDI8ETEXe9u6cc/PjkLcuKGmoU8xYLQbk1
 a1wKAjbsjNiIyEqn3B05B/0JcejZg0E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-gIXmF9k_Md-wOQvh5_B9hw-1; Wed, 26 Feb 2020 03:51:04 -0500
X-MC-Unique: gIXmF9k_Md-wOQvh5_B9hw-1
Received: by mail-wm1-f72.google.com with SMTP id p2so442822wmi.8
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 00:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Erw3p9ZDh3qQ0G03wAN100FaGTX0pQtWBoXwxb6hOoc=;
 b=fRT7MdTnDj2eGSJuW2R1D4811ftnfvcEiW7m151c30gRLLQb3IRupA3KOpIqlAU8pT
 nIWrm8WThacwqZaE/nifoU+9Rw8vqjnVwecNk2QXFH7DBVFLeqSC/lBU8I2GeOFt6/2K
 4yGO+hTmkWesE84rD8+xcFftsgYY4gLlMTax1esIYN5GX3vDggC6MluemH33mOgqpEDV
 Z1Hg5EF3g3uKhCk3G0A8egr59etCXsvxCHBB5NrDp4P81Agj6+3JT1cdt8G9Kog+K+kX
 4qcyQC39Lb7vrMpbw3ApbYsw/jXJZX8DmtzYgu59TROjhko2muqwz3C6V0+d/o29fDRw
 eOgg==
X-Gm-Message-State: APjAAAXCwM4PaKGn10+pT4FBiYiNDg9JmsGexkqXIgLnx7398g+lpIH9
 0KGgtcl2Bj7xvsfMvswhgU9S20ccKFLrrbl9UgYFVVdOUopUZQOy7TXU0kEMtw9joRl/Cx6i9fl
 6iAqqKzgY226jluo=
X-Received: by 2002:a7b:c109:: with SMTP id w9mr4122382wmi.14.1582707063002;
 Wed, 26 Feb 2020 00:51:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwv5/UML2h5UyHyqalu7CncLN+RMN8Uuj73kpJ0mlRsPQfgQBSDxP5VZ+fJU20NePATDFSOlQ==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr4122353wmi.14.1582707062761;
 Wed, 26 Feb 2020 00:51:02 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id u62sm2051825wmu.17.2020.02.26.00.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 00:51:02 -0800 (PST)
Subject: Re: Sudden slowdown of ARM emulation in master
To: Peter Maydell <peter.maydell@linaro.org>
References: <CAPan3Wq-MVwcJQELP8n+g33CR7tsiGXQ698gA177nd2my9hWCw@mail.gmail.com>
 <CAFEAcA_azGqyzbxegpK8ch_bums6Wtd=U7cNxvM=bAJ-Ld2DDA@mail.gmail.com>
 <ffa87cab-e85c-c381-289a-fdf1ef07b45a@redhat.com>
 <CAFEAcA-32ddJW0ULWzGDDwLcvPGnXOatRHy73Agh0NRajfnRCQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <99625cab-71ff-a925-fbed-28120f046f0c@redhat.com>
Date: Wed, 26 Feb 2020 09:51:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-32ddJW0ULWzGDDwLcvPGnXOatRHy73Agh0NRajfnRCQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 9:48 AM, Peter Maydell wrote:
> On Wed, 26 Feb 2020 at 08:44, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> On 2/26/20 9:41 AM, Peter Maydell wrote:
>>> On Tue, 25 Feb 2020 at 23:08, Niek Linnenbank <nieklinnenbank@gmail.com=
> wrote:
>>>
>>>> Just now I was working on some small fixes for the cubieboard machine =
and rebasing my Allwinner H3 branches.
>>>> While doing some testing, I noticed that suddenly the machines were mu=
ch slower than before.
>>>> I only see this happening when I rebase to this commit:
>>>>      ca6155c0f2bd39b4b4162533be401c98bd960820 ("Merge tag 'patchew/202=
00219160953.13771-1-imammedo@redhat.com' of https://github.com/patchew-proj=
ect/qemu into HEAD")
>>>
>>> Yeah, I noticed a slowdown yesterday as well, but haven't tracked it do=
wn
>>> as yet. The first thing would be to do a git bisect to try to narrow
>>> down what commit caused it.
>>
>> My guess: biggest chunk of memory is the DRAM, registered as "fast RAM"
>> by QEMU, but the SoCs provide SRAM which is supposed to be faster. Not
>> anymore with QEMU. And Linux try to use the SRAM when possible.
>=20
> Doesn't sound very likely to me: generally Linux doesn't use random small
> lumps of SRAM, it just goes for whatever the dtb says is the main RAM,
> usually DRAM. And I thought that all RAM blocks within QEMU performed
> the same?
>=20
>  From the commit that Howard tracked down as the cause it looks like
> an ordering-of-actions issue in vl.c where something that was assuming
> memory-size-related stuff was set up is now running before those
> variables/fields are set correctly rather than after ?

Yes, I just saw Howard's email and was going to reply to my own "I'm=20
probably wrong since the mac99 machine doesn't use SRAM".


