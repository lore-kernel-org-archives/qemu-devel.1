Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC16DC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B334021929
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B334021929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMQK-0006YV-UW
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iSMPZ-0005eJ-BL
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iSMPY-0006Uq-6o
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:35:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52656)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iSMPX-0006UT-Vd
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:35:52 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E140D5AFF8
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 14:35:50 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id 199so1303428wmb.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:35:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h9lWEEYjv6YG7HNBSk6dMj/MeCvWO6sLSN/9Uj3Boog=;
 b=YQRMboMWPbLPt0pM29CIgI6wMPvUx5SEPHx4Tbnao8rE+TwjY4PWuOPHi+wGVs2WO7
 feJeXFkxzfaGe93bZeQ+lHDoOfZqymhh8VbbKCQalyAokLyeUwEqv0rdJ1CGEOilv2DQ
 i2bNdgBNrZ5BhXQJutqnKjQ6groeBr3DbajfoU2u9V67f5zBJKZWJCQ+Tx8y7iyt2d9y
 EsRZp/PLFf2K2lQM9bcss2ChwnspOQ8h6QeTTly2kDKYaUM8/ZdS0vcOLXdyh8CjREh1
 t8lbnhoRyWh7eJkIIuEK7Lgb97zSsHriUg3nWaBohQKfI8B7LPiFL+f8VyHJYzOSTJQx
 b1Yg==
X-Gm-Message-State: APjAAAWxLz60YE1s+OPFYAZZIcYujr3XVO9DsZIJJvYUuffffT50beTm
 4Bj8eLlqQ1yU3aB2S22bnSGRQ2eZIGBYzOs9gh8+VY++uRngSnkdOlM5ZDzbL2bVNFYRvbDWI27
 Y6pF3/fDbllDsKAw=
X-Received: by 2002:a05:6000:350:: with SMTP id
 e16mr3224684wre.276.1573050949031; 
 Wed, 06 Nov 2019 06:35:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3SZDhe1Odz7hIJ+Z7e0SabkQgDobjRAMTwqWAdwInJQW2D3OQI5EHHsm/ZLcHdRBMrgBJ3Q==
X-Received: by 2002:a05:6000:350:: with SMTP id
 e16mr3224666wre.276.1573050948803; 
 Wed, 06 Nov 2019 06:35:48 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id z8sm19209083wrp.49.2019.11.06.06.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2019 06:35:48 -0800 (PST)
Subject: Re: [PATCH] numa: Add missing \n to error message
To: Laurent Vivier <laurent@vivier.eu>, Greg Kurz <groug@kaod.org>
References: <157304440026.351774.14607704217028190097.stgit@bahia.lan>
 <bb828956-28b3-9fe7-1d57-ceb723a32997@vivier.eu>
 <20191106151246.2bf44314@bahia.lan>
 <da6cc0c8-eb29-7b2f-e43a-631ab04f5ba9@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c3ea75b6-34c5-eca4-cc57-0a5d1b1d07c9@redhat.com>
Date: Wed, 6 Nov 2019 15:35:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <da6cc0c8-eb29-7b2f-e43a-631ab04f5ba9@vivier.eu>
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
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/19 3:20 PM, Laurent Vivier wrote:
> Le 06/11/2019 =C3=A0 15:12, Greg Kurz a =C3=A9crit=C2=A0:
>> On Wed, 6 Nov 2019 14:01:01 +0100
>> Laurent Vivier <laurent@vivier.eu> wrote:
>>
>>> Le 06/11/2019 =C3=A0 13:46, Greg Kurz a =C3=A9crit=C2=A0:
>>>> If memory allocation fails when using -mem-path, QEMU is supposed to=
 print
>>>> out a message to indicate that fallback to anonymous RAM is deprecat=
ed. This
>>>> is done with error_printf() which does output buffering. As a conseq=
uence,
>>>> the message is only printed at the next flush, eg. when quiting QEMU=
, and
>>>> it also lacks a trailing newline:
>>>>
>>>> qemu-system-ppc64: unable to map backing store for guest RAM: Cannot=
 allocate memory
>>>> qemu-system-ppc64: warning: falling back to regular RAM allocation
>>>> QEMU 4.1.50 monitor - type 'help' for more information
>>>> (qemu) q
>>>> This is deprecated. Make sure that -mem-path  specified path has suf=
ficient resources to allocate -m specified RAM amountgreg@boss02:~/Work/q=
emu/qemu-spapr$
>>>>
>>>> Add the missing \n to fix both issues.
>>>>
>>>> Fixes: cb79224b7e4b "deprecate -mem-path fallback to anonymous RAM"
>>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>>> ---
>>>>   hw/core/numa.c |    2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/core/numa.c b/hw/core/numa.c
>>>> index 038c96d4abc6..e3332a984f7c 100644
>>>> --- a/hw/core/numa.c
>>>> +++ b/hw/core/numa.c
>>>> @@ -503,7 +503,7 @@ static void allocate_system_memory_nonnuma(Memor=
yRegion *mr, Object *owner,
>>>>               warn_report("falling back to regular RAM allocation");
>>>>               error_printf("This is deprecated. Make sure that -mem-=
path "
>>>>                            " specified path has sufficient resources=
 to allocate"
>>>> -                         " -m specified RAM amount");
>>>> +                         " -m specified RAM amount\n");
>>>>               /* Legacy behavior: if allocation failed, fall back to
>>>>                * regular RAM allocation.
>>>>                */
>>>>
>>>>
>>>
>>> Why is this an error_printf() and not an error_report()?
>>>
>>
>> Because CODING_STYLE suggests to do so I guess:
>>
>> Reporting errors to the human user
>> ----------------------------------
>>
>> Do not use printf(), fprintf() or monitor_printf().  Instead, use
>> error_report() or error_vreport() from error-report.h.  This ensures t=
he
>> error is reported in the right place (current monitor or stderr), and =
in
>> a uniform format.
>>
>> Use error_printf() & friends to print additional information. <=3D=3D=3D
>>
>> error_report() prints the current location.  In certain common cases
>> like command line parsing, the current location is tracked
>> automatically.  To manipulate it manually, use the loc_``*``() from
>> error-report.h.
>=20
> So I guess it's to not report the current location and the binary name =
.
>=20
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


