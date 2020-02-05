Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6104C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 19:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9286620730
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 19:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTxoO5XQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9286620730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izQ7p-0008EX-QU
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 14:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izQ76-0007cd-Cy
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 14:13:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izQ75-0006Ey-5b
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 14:13:28 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izQ70-0005mg-SV; Wed, 05 Feb 2020 14:13:23 -0500
Received: by mail-wm1-x341.google.com with SMTP id g1so3687538wmh.4;
 Wed, 05 Feb 2020 11:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yTIyRlHSro7zUF/ki3mXbJaQaoeJCNT7pAeMjShe0vg=;
 b=ZTxoO5XQetWPMBh0E385GeSKQyW/ucjCG9M//rJ9ETQsc0zRYYV+gsh/rEnu2BY/C2
 dKzbHaHQ6Si4nWjFCt1TOIcaW0lA4FWEv+DYwPhShs9GOC2jy8UY1tvCFUBJNqLHVl2h
 O+jBDqcsWD39/Dt6DcXWvXPbD0Zp7720D+shC4fZadtpm0YsVH1uFqNzl7iC/DDQUR/v
 SMkon8Fk4Ao6PMUTIP7zdk39gRxdZizqMYWIYvbys7A4vGxsBv7LOTAzzkgSC620GmVV
 54d8sfTMe5edTprVyfFyIhMHBhsorVCK7m8y8Y+57BOYswYJe2IPuvctGHEiCY8R4tEL
 Q8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=yTIyRlHSro7zUF/ki3mXbJaQaoeJCNT7pAeMjShe0vg=;
 b=cys1FEZo6IJ49abhBgGMNT9tlBXIPk1HgMG6u7nlZBSyfzNIKWDzXVpGgIWS5zcpvL
 fZm2zlb4fnjRWDvvdqg0GGCqbtzQlRY7dA5A/8kc8gPWpVXwUwT14o+A53RPWWM5ariL
 a7WDlgPyjAmeFS/iV5//WyGtlQKDOGSOiWQbnXfp3KTwtivAqQRs59il8C8SFs4q8t74
 63hGbotP2nz4tcsyxpasIUPucJ3XBLBdzuDCz01ogdfNheK3FjaBrm7REPhE0VOdbUVI
 mMvf3Ga6vYldX2TJDnR1FfPQurR86hSXSBjQBhK30hPiYQJQ4EaOIuTDHkKg4zqJokkT
 Bo1Q==
X-Gm-Message-State: APjAAAUV0gOtxfb9wcl/+fe4MfiMGQwaoY9cBTdDnUKhlDFC65Cop4WQ
 hqi/+vPIxDr4JmG9c1yQzOo=
X-Google-Smtp-Source: APXvYqxXOXvZZwgWMiCOHFCxzVUA7OJM5pyqwZlGQwSbRXY+BVHrf3o9FTqR8CVQSW2mTf8JQ+9tZA==
X-Received: by 2002:a7b:cd14:: with SMTP id f20mr7147062wmj.43.1580930001565; 
 Wed, 05 Feb 2020 11:13:21 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id q130sm698917wme.19.2020.02.05.11.13.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2020 11:13:20 -0800 (PST)
Subject: Re: [PATCH for-5.0 3/4] Remove the core bluetooth code
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191120091014.16883-1-thuth@redhat.com>
 <20191120091014.16883-4-thuth@redhat.com>
 <7a775153-f18d-e766-1d8f-33607f5fa05b@amsat.org>
 <2396dfd4-6c85-d17a-b358-bd058c757f14@redhat.com>
 <CAAdtpL7vPCQ8k91nvBWc_NLrmhu6OPVprUSL8uzi_v6HMiSrnw@mail.gmail.com>
 <CAL1e-=gd-ymYd3_cods8BAtwbQeJFodmnmsNo-gLx381rXHKxQ@mail.gmail.com>
 <20200205175115.GT2221087@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <3585192d-a0c1-4116-bec9-4816d498ca3d@amsat.org>
Date: Wed, 5 Feb 2020 20:13:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205175115.GT2221087@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 6:51 PM, Daniel P. Berrangé wrote:
> On Wed, Feb 05, 2020 at 06:40:31PM +0100, Aleksandar Markovic wrote:
>> On Sat, Feb 1, 2020 at 7:53 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>
>>>>>> @@ -1151,10 +1150,6 @@ for opt do
>>>>>>    ;;
>>>>>>    --enable-brlapi) brlapi="yes"
>>>>>>    ;;
>>>>>> -  --disable-bluez) bluez="no"
>>>>>> -  ;;
>>>>>> -  --enable-bluez) bluez="yes"
>>>>>> -  ;;
>>>>>
>>>>> Now than I'm bisecting over this commit, I realize removing this
>>>>> option was not a good idea, we should have done like commit
>>>>> cb6414dfec8 or 315d3184525:
>>>>>
>>>>>   @@ -886,10 +885,6 @@ for opt do
>>>>>   -  --disable-uuid) uuid="no"
>>>>>   -  ;;
>>>>>   -  --enable-uuid) uuid="yes"
>>>>>   -  ;;
>>>>>   ...
>>>>>   +  --enable-uuid|--disable-uuid)
>>>>>   +      echo "$0: $opt is obsolete, UUID support is always built" >&2
>>>>>   +  ;;
>>>>
>>>> Looks trivial ... so if it bugs you, just send a patch?
>>>
>>> I thought about it but this won't fix much, it is too late now.
>>>
>>> I simply wanted to share this bugged me so we try to avoid doing the
>>> same mistake again.
>>>
>>
>> I vote for addition of a change similar to what Philippe described.
>>
>> Furthermore, it looks to me the correct way would be to now do full
>> deprecation of --enable-bluez and --disable-bluez. This means adding
>> this to documentation (not related to bluetooth devices support), not
>> only a change in "configure". This also means that only after two next
>> full cycles these options could be removed.
>>
>> True, this could have been done together with bluetooth devices
>> support deprecation (and in that case we could have deleted these
>> options right away), but it wasn't. Users don't have a crystal ball to
>> know that we assumed that --enable-bluez and --disable-bluez were part
>> of bluetooth devices support, and could rightfully complain about an
>> abrupt elimination of a compile time option.
> 
> The deprecation policy is primarily intended for notifying of changes
> to QEMU's stable interfaces ( CLI, HMP, QMP) which affect behaviour
> and usage of QEMU at runtime & are liable to break apps managing
> QEMU.
> 
> Changes to build time options have no strong reason to be subjected to
> the deprecation process. If we remove an option at build time the effect
> is noticed immediately and the solution is straightforward (stop passing
> the option). We have added / removed configure options at will with little
> negative feedback historically. We'll have far biggest changes coming to
> the build system in future too, with the introduction of meson.

I understand your point when looking forward (when distribution upgrade,
it is easy to adapt).
However this is still an issue when looking backward when running
bisection to find regressions.

> I don't think we want to constrain & complicate our work in modernizing
> the build system by declaring that any changes to it must go through
> deprecation.
> 
> Regards,
> Daniel
> 

