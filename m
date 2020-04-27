Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544C5C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E67D206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Omamm6Ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E67D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT42r-0004VR-9r
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 09:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT41w-0003fl-RD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT41w-0002ju-7T
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:42:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31647
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jT41v-0002ji-QA
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587994958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvSeiVVqd/sEGBLUnoY8BbRMj946cbQIXsGMLNMCtEk=;
 b=Omamm6Ss96V6x1qu6vuts+ZmDz3S5L3NZs8fVGBsq62BGK/aOSf+NlSdtHrmmU8uMTTaEX
 HR9LJcA7YBrbUKuZ3wwJ8XoufTNBf2mBYikBTU878deF9WjnSIAsa/S8aArtGpd4m78GhD
 NSzOFyQwgWSk/Y/yTE8uJz1v5qu9s0w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-ktaXrPyXN_OWDNxulziksg-1; Mon, 27 Apr 2020 09:42:33 -0400
X-MC-Unique: ktaXrPyXN_OWDNxulziksg-1
Received: by mail-wr1-f70.google.com with SMTP id f2so10546005wrm.9
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 06:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UtByCpDNwUVBuGQ4R+gmfYaCRFf2axRfzhr30hDKwJw=;
 b=XsS7qMyp+Qb3kUKqn+0N1mu9GbkdJfhHSqIeKIAAiiXIcs5+wmGhaUY8pzSVbLGe1o
 VSzMlwUC/JZRV3fZhq5dV8eiFGqIiBK2OONsHqUrQ++y/Xv8f+7zw8mYoghe0V3mfCpO
 cJ8TaF//Qa60uugFA4v1D2/Kueqs+46YbRFbrJ3Kdv5p3OP0zhvVAVcXwOyOxtuQeteL
 kJl8MAzZ0MxZjKCl3bci6e9ezikkpgnSKw72j5yUIHakwzoAdSC4Opiht6FQgT2117mF
 FAxG/9olpwynGzCq459jGAX7v/joClhJrYJYb0lK2L9hmnEVUdsX6r4ti3gYf2L/jndg
 vz/g==
X-Gm-Message-State: AGi0PuaLRpCEWzbnAD10YWC7pgatFTyzUmYQzwdR2HlmROjoKFlaVItu
 IRkK+HqePZYgZRvRmMqko08zattBqyY9uZTNV+bbk0Ihm3dGDbaKoBIba+KjJSKZ4cVviGK936y
 4aqCl2nP3R0XVRNs=
X-Received: by 2002:adf:fecd:: with SMTP id q13mr29088906wrs.12.1587994951745; 
 Mon, 27 Apr 2020 06:42:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypIuV/xNkL6yKx4F7Cn6ONRsjIlB/bzIP1UFqqCx6SZpeg84XF5SrNKPSaXDOBqz58cnGB+h1Q==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr29088890wrs.12.1587994951535; 
 Mon, 27 Apr 2020 06:42:31 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id 19sm15483634wmo.3.2020.04.27.06.42.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 06:42:30 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] target/arm: Restrict TCG cpus to TCG accel
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200423073358.27155-1-philmd@redhat.com>
 <CAFEAcA8j7y2VbM1U0Df-TEjS6Kh-iBGXA8Vg1ZrD5Ff6=WthjA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <25cbb189-19d2-5514-306f-51d176b61c39@redhat.com>
Date: Mon, 27 Apr 2020 15:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8j7y2VbM1U0Df-TEjS6Kh-iBGXA8Vg1ZrD5Ff6=WthjA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:05:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 3:04 PM, Peter Maydell wrote:
> On Thu, 23 Apr 2020 at 08:34, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> These are the uncontroversial patches from "Support disabling
>> TCG on ARM (part 2)"
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg689168.html
>>
>> The other patches are blocked by the "accel: Allow targets to
>> use Kconfig" series:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg689024.html
>>
>> All patches reviewed.
>>
>> Since v1:
>> - Dropped 'Make set_feature() available for other files' patch
>>    which fails to build with KVM only, see:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg03843.html
>>
>> Many thanks to Richard Henderson for his patience!
>>
>> Regards,
>>
>> Phil.
>>
>> Philippe Mathieu-Daud=C3=A9 (4):
>>    target/arm: Restric the Address Translate write operation to TCG acce=
l
>>    target/arm/cpu: Use ARRAY_SIZE() to iterate over ARMCPUInfo[]
>>    target/arm/cpu: Update coding style to make checkpatch.pl happy
>>    target/arm: Restrict TCG cpus to TCG accel
>>
>> Thomas Huth (1):
>>    target/arm: Make cpu_register() available for other files
>=20
>=20
> Patch 5 doesn't compile, because it moves code out from
> cpu.c to cpu_tcg.c, where it no longer has access to the
> file-local set_feature() function:
>=20
>    CC      arm-softmmu/target/arm/cpu_tcg.o
> /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/cpu_tcg.c:47:5:
> error: implicit declaration of function 'set_feature' is invalid in
> C99
>        [-Werror,-Wimplicit-function-declaration]
>      set_feature(&cpu->env, ARM_FEATURE_V5);
>      ^
> [etc]

*Sigh* sorry for that, I'm still unsure what's the cleaner change to=20
deal with the different set_feature() KVM prototype:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg697523.html

>=20
> I've applied patches 1-4 to target-arm.next.

Thanks for this!

>=20
>=20
> thanks
> -- PMM
>=20


