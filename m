Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52E7C55185
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 10:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9759720714
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 10:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9759720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSHg0-00085O-N8
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 06:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jSHf4-0007G5-P9
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jSHf4-000078-1i
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:03:50 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:37315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jSHf3-0008LA-DN
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:03:49 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MOzGc-1jpSr00l6i-00PMlQ; Sat, 25 Apr 2020 12:03:46 +0200
To: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org
References: <20200424210422.GB26282@ls3530.fritz.box>
 <c9f3644e-21c8-600b-4bf6-d55e6c52153f@vivier.eu>
 <2703086a-d283-e780-a427-ce84ed31f852@gmx.de>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: Drop unnecessary check in signalfd4 syscall
Message-ID: <67496bb6-1734-ff27-c734-aa01a7a670a4@vivier.eu>
Date: Sat, 25 Apr 2020 12:03:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2703086a-d283-e780-a427-ce84ed31f852@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gLi+2IMBQugke/IUZdY3B6e74aFb6nR+Ishv7Umu6vBeX4cPTMK
 freT6Rzr6KfBkUjNJ92/rpgJdgOnAnzjgsWIRIR2NrVeGXH0jDqqc4k5snij/6VNZDuU1Eh
 v25/N9jlcseRP0XfDo6HrZCWsVglsf/UkSAzWJM6p8ISWBzSwWGH8Fvxo1wA6yO4kX5Nz83
 Gz3KqAbgV+2ARoTFfR9JA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oWw3X3fEd3c=:pVvHigRsdepn0E7mK35GFg
 FSKjJgkdks3qJRL/wD8XkTZfoZLBgndBXf8DuaNkJ46SjaLkOODq7R/Hvf9CbkhO6E8Y3bpWX
 UWdcD2sy8Xfvdhc3gFqBm4KW61kaVXcphoU5JeG2qfpxByRKL6vXNfncilnF+sfS6t+tRhngQ
 2UUa+dttcCYC6nIEzwCEIXgAqPPMS7xaODTunH/IosXPwO+iTvPORyc2f4g4vbTROihwDmQRX
 0Fipkm62IpcTQ/Vyrj4/20AfGwWoMOmoV7bzCZalqIUpPVekP81Hmkr2Xcw8raKiRjn+kq1i0
 cK8KaPVl3yvDhlPa3MFgfKt1enEHK3s3vCeGSd03Pi2sMQ+J7SWPmeAXWkAksCijrLaW9fwsq
 Qzr9JPGpUWf9sWj7xYPluNfqPZg1BCfy1+nxZiuMG+/OETq53vd1hrRHAXmeT+uWXcrlUudlv
 94Qg/PDl+DWLwZt/N5ngw6lYCEE9LcSWGmWVAHQZZEHqZvZI/jOZO6P7nFz2Vcr7B6MbSCed5
 ixnv1FCbalz44QswOdHo+dYfvGoYJwGtmj6Q/5difp7Wbf5lKVY2k8wSM5D5IVyZiF7uHjaEv
 mSzAKy7lYj5yl7o2jImhXp8vOZgMmdwzIxucKf5A/PzC68jVXO+ni2O+FnJIotceZn7kg9GbQ
 cwgy4AhQsf2+Bx5N7ayvoFD0jJ8VBs9us/SM8YjkGys/StVqqf4CDsoCWvVZqPW67jOuEwDbp
 MHM082ZEO+b8yboEzwhfCSNcoiHkcy+sL2H573STOi5AU7OsYu537v3frBIhUXuNIUKZ32xUx
 BswBhwddUjwvKUfbxQrvtvjht8dIhTWwCn422qX9DzDkmMRLs80aYZZPPTGNk27mtgp1uri
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 04:27:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/04/2020 à 11:24, Helge Deller a écrit :
> On 25.04.20 10:39, Laurent Vivier wrote:
>> Le 24/04/2020 à 23:04, Helge Deller a écrit :
>>> The signalfd4() syscall takes optional O_NONBLOCK and O_CLOEXEC fcntl
>>> flags.  If the user gave any other invalid flags, the host syscall will
>>> return correct error codes, so simply drop the extra check here.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> index 05f03919ff..ebf0d38321 100644
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -7176,9 +7176,6 @@ static abi_long do_signalfd4(int fd, abi_long mask, int flags)
>>>      sigset_t host_mask;
>>>      abi_long ret;
>>>
>>> -    if (flags & ~(TARGET_O_NONBLOCK | TARGET_O_CLOEXEC)) {
>>> -        return -TARGET_EINVAL;
>>> -    }
>>>      if (!lock_user_struct(VERIFY_READ, target_mask, mask, 1)) {
>>>          return -TARGET_EFAULT;
>>>      }
>>>
>>
>> Perhaps we want to trigger the TARGET_EINVAL before the TARGET_EFAULT if
>> we have both cases?
>>
>> But I've checked the kernel, and the kernel does a copy_from_user()
>> before checking the flags, but it returns EINVAL rather than EFAULT.
> 
> That's not the full picture, since the kernel is not consistent here!
> In the compat-case (32bit userspace on 64bit kernel) it returns correctly
> EINVAL and EFAULT:
>         if (sigsetsize != sizeof(compat_sigset_t))
>                 return -EINVAL;
>         if (get_compat_sigset(&mask, user_mask))
>                 return -EFAULT;
> while in the non-compat case it returns EINVAL only:
>         if (sizemask != sizeof(sigset_t) ||
>             copy_from_user(&mask, user_mask, sizeof(mask)))
>                 return -EINVAL;
> 
> I think the kernel should be fixed here...
> 
>> We can remove the flags checking but we should also change TARGET_EFAULT
>> by TARGET_EINVAL.
> 
> According to the different behaviour of the kernel mentioned above
> you won't get it correct either way.

If we refer to manpage, EFAULT is not one of possible errors.

Thanks,
Laurent

