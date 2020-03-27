Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB33C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9793C206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuMPQO8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9793C206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmkH-0005jF-Pp
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jHmiK-00048t-B5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jHmiI-00036s-H9
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:59:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jHmiI-00034Z-Cy
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585306785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufk87yFbYGigKRJxSoyKOY6KK/kdyJ9F3P/wisvwEWk=;
 b=UuMPQO8qJGamB2Ea7NF8vjZ1aLmsEhi7ql9ZpoV3zObbAwwNrYOk7tsIfLwH95lU75Zwo7
 pChz1mZU/o6cwxDzBi8WVG+M/gKCYO3zg2SDaxuQQG9rfc0UNdrm9RDG/0q2PFAYqRVbs9
 67WVK8yedzfDKAnf33i+2PF5qthHqoU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-9W3uQXaCOYWY7PU16wxUnQ-1; Fri, 27 Mar 2020 06:59:41 -0400
X-MC-Unique: 9W3uQXaCOYWY7PU16wxUnQ-1
Received: by mail-wr1-f71.google.com with SMTP id e10so4371141wru.6
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 03:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/5j0vpi/k/KBX4hp7wthhv/dqFG9FJFACIbg+p3cWT8=;
 b=l++Cd9Y/8idqAo9NqUU6H4vOgb6mE3w4k8TRQK3PU8iYqqHRPx+naZ1xicVgLCNZ01
 JTJDAFsyIhzvMG4s3iMn1ClMrXYjVXNfWO4qPbborxcGfiWvsdslrFC+dsKX5wpbO+B9
 k8c8Mtgmh9bmnsY/c53APEFVbmAvROYwP7uSFLFT6utOhhgCznYKkMX5Z/JIOPP7v94s
 Nfe4rIzU12TPbjqb13YqLHvHkMlkm43bMXKeY0bEaqYQXFm5TZAgAvX+jJXzJBQ0hxd1
 pnkC+wQ5xbrAAPhgZfoQwz/MpdLeuhA2s6p1l3qAiba2DuRJg2ElaeZPMt/F9avPxRqY
 ksSQ==
X-Gm-Message-State: ANhLgQ26vmmTDBn6Wyb/hk4cSeLvk0F6RY9joI+DFvRHSHXadsqU7k9c
 XOcVGypkDMx27vdwvWaFrl9+3SSMasMzNMNdMgnt0k1pB4Oh+67K4RGl69iCIErh/tpAUF9JjtN
 bObKstIThZQ8pFhE=
X-Received: by 2002:a7b:cd88:: with SMTP id y8mr4538145wmj.129.1585306780099; 
 Fri, 27 Mar 2020 03:59:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv3UWRBzdztatBxMolVV/7xyeH33P2jfkZoKWU8uh8iEL4C5F9lUaOGg3xCM05p2z3IEEp44Q==
X-Received: by 2002:a7b:cd88:: with SMTP id y8mr4538129wmj.129.1585306779839; 
 Fri, 27 Mar 2020 03:59:39 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id i19sm7727579wmb.44.2020.03.27.03.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 03:59:39 -0700 (PDT)
Subject: Re: [PATCH v8 00/74] per-CPU locks
To: "Emilio G. Cota" <cota@braap.org>, Robert Foley
 <robert.foley@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20200327051457.GA2815@t420>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8686a3e1-1a57-bfd3-11ec-b84d656bb0a0@redhat.com>
Date: Fri, 27 Mar 2020 11:59:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200327051457.GA2815@t420>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, peter.puhov@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 6:14 AM, Emilio G. Cota wrote:
> (Apologies if I missed some Cc's; I was not Cc'ed in patch 0
>   so I'm blindly crafting a reply.)
>=20
> On Thu, Mar 26, 2020 at 15:30:43 -0400, Robert Foley wrote:
>> This is a continuation of the series created by Emilio Cota.
>> We are picking up this patch set with the goal to apply
>> any fixes or updates needed to get this accepted.
>=20
> Thanks for picking this up!
>=20
>> Listed below are the changes for this version of the patch,
>> aside from the merge related changes.
>>
>> Changes for V8:
>> - Fixed issue where in rr mode we could destroy the BQL twice.
>=20
> I remember doing little to no testing in record-replay mode, so
> there should be more bugs hiding in there :-)
>=20
>> - Found/fixed bug that had been hit in testing previously during
>> the last consideration of this patch.
>>   We reproduced the issue hit in the qtest: bios-tables-test.
>>   The issue was introduced by dropping the BQL, and found us
>>   (very rarely) missing the condition variable wakeup in
>>   qemu_tcg_rr_cpu_thread_fn().
>=20
> Aah, this one:
>    https://patchwork.kernel.org/patch/10838149/#22516931
> How did you identify the problem? Was it code inspection or using a tool
> like rr? I remember this being hard to reproduce reliably.
>=20
> On a related note, I've done some work to get QEMU-system to work
> under thread sanitizer, since tsan now supports our longjmp-based
> coroutines (hurrah!). My idea was to integrate tsan in QEMU (i.e.
> bring tsan warnings to 0) before (re)trying to merge the
> per-CPU lock patchset; this would minimize the potential for
> regressions, which from my personal viewpoint seems like a reasonable
> thing to do especially now that I have little time to work on QEMU.
>=20
> If there's interest in doing the tsan work first, then I'd be
> happy to send to the list as soon as this weekend the changes that
> I have so far [1].

I'm pretty sure Marc-Andr=E9 is interested (and also Stefan maybe), so=20
Cc'ing them.

>=20
> Thanks,
> =09=09Emilio
>=20
> [1] WIP branch: https://github.com/cota/qemu/commits/tsan
>=20


