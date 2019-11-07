Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED734C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04FE2178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04FE2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSm7N-0003vK-EM
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 13:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iSm5C-0002hs-N0
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:00:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iSm5B-0005Qn-9x
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:00:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48950)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iSm5B-0005OJ-1b
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:00:33 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C7E2A51146
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 18:00:30 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id l3so1491468wrx.21
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 10:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XcSWEuLkg+pWnqHNgl6pW8noSA+3bcWaF87j0rdtyZ4=;
 b=E27BDU7TyGoZke7xbYJMwVNqFXJgZakwkITepg1xsqTNbpBgZXvo+NuZlpH0FKJYra
 kcMrevKupZJOgPGO2TYbQZ69RDVDW92pjwsvGGn5YRPxjC70fMDcm0eN7MdF6AS96A4X
 9/KWA46s2r9j8yWEN80pgaJS1b5fVtNyPN/r3T4jhp2sAvuM2+QgCNCYZUdbqOv7i1Sg
 JOgfX+WiNqJJxQBBXEEN40HXMzH9vqwk+pn9Ab3nfytKpqhRDVkAndBQooKC0EhRoXOa
 qHSI6cQm7iAWJ71kAoSb9TowG5W28Nxz0ugbJCVmARr9qcCDOZ/INgEH+j19hh+q1OqY
 yB8A==
X-Gm-Message-State: APjAAAWiFuRsfMrX6IVTDoJgo584O+2SxXCtmwfIIXuZa3b+SvSCN23b
 BbIPzSMyz8wc/8e+l9W6kNKmYu6mBLOdBBoxjsBHo/Clu7yFwB4ajA4KCQAhKeEzp4c56TDUb1A
 poC94xBO+oJsic90=
X-Received: by 2002:adf:fa07:: with SMTP id m7mr3992112wrr.108.1573149629474; 
 Thu, 07 Nov 2019 10:00:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwqnucKGpXwmxX0646MvkTlSQlpINJcVgYtCzzgP0JwfKPMkQtYpXmh8ag8SnnW0UZ+qYSC3A==
X-Received: by 2002:adf:fa07:: with SMTP id m7mr3992088wrr.108.1573149629273; 
 Thu, 07 Nov 2019 10:00:29 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id c15sm2485067wmb.45.2019.11.07.10.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2019 10:00:28 -0800 (PST)
Subject: Re: [PATCH 0/2] Acceptance test: update kernel used on m68k/q800 test
To: Laurent Vivier <laurent@vivier.eu>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <20191028181643.5143-12-laurent@vivier.eu>
 <20191029232320.12419-1-crosa@redhat.com>
 <19097f6f-28a8-12ee-6761-da0f34735910@redhat.com>
 <1209928652.10986630.1573144690743.JavaMail.zimbra@redhat.com>
 <bb0c5db0-899e-c5a6-caa3-add8bf64f780@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <77a6200c-7f53-4305-1aad-4574f0faa904@redhat.com>
Date: Thu, 7 Nov 2019 19:00:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <bb0c5db0-899e-c5a6-caa3-add8bf64f780@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/7/19 6:18 PM, Laurent Vivier wrote:
> Le 07/11/2019 =C3=A0 17:38, Cleber Rosa a =C3=A9crit=C2=A0:
>> ----- Original Message -----
>>> From: "Eric Blake" <eblake@redhat.com>
>>> To: "Cleber Rosa" <crosa@redhat.com>, qemu-devel@nongnu.org
>>> Cc: "Peter Maydell" <peter.maydell@linaro.org>, "Eduardo Habkost" <eh=
abkost@redhat.com>, "Philippe Mathieu-Daud=C3=A9"
>>> <f4bug@amsat.org>, "Wainer dos Santos Moschetta" <wainersm@redhat.com=
>, "Laurent Vivier" <laurent@vivier.eu>,
>>> "Willian Rampazzo" <wrampazz@redhat.com>, "Philippe Mathieu-Daud=C3=A9=
" <philmd@redhat.com>
>>> Sent: Thursday, November 7, 2019 10:43:08 AM
>>> Subject: Re: [PATCH 0/2] Acceptance test: update kernel used on m68k/=
q800 test
>>>
>>> On 10/29/19 6:23 PM, Cleber Rosa wrote:
>>>> The boot_linux_console.py:BootLinuxConsole.test_m68k_q800 was very
>>>> recently merged, but between its last review and now, the Kernel
>>>> package used went missing.
>>>>
>>>
>>> meta-question: Why was this series posted in-reply-to the pull reques=
t,
>>> rather than as a new top-level thread? I nearly missed it because I
>>> don't expect to see unreviewed patches buried in threading like that.
>>> My workflow would have been to post the series in isolation, then
>>> manually reply to the pull request to mention the message-id of the
>>> related series proposed as a followup.
>>>
>>
>> Hi Eric,
>>
>> That was my attempt to signal that it was a fix to something which had=
 *just*
>> being merged as part of that pull request (though now caused by it).
>>
>> I basically did not know how to act properly, so I thank you for the w=
orkflow
>> suggestion.  I'll certainly follow it next time.
>=20
> IMHO, you should send your series and then replies to the pull request
> to tell you have sent your series that fixes the patch in the pull
> request, or vice-versa.
>=20
> But your series has been queued by Alex, so there is no problem...

I prepared a different fix around the same time, but closed my laptop=20
before the patch was sent and noticed the next day:
https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg08120.html

Laurent, are you OK with the new kernel being tested?

