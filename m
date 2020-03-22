Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DDEC4332E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 11:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085ED20719
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 11:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085ED20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFyzL-0004Yg-GU
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 07:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jFyyj-00047J-V5
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 07:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jFyyi-0000wB-7q
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 07:41:17 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:43246)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jFyyi-0000un-1S
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 07:41:16 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DBF7D747EAB;
 Sun, 22 Mar 2020 12:41:13 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B756A747EA3; Sun, 22 Mar 2020 12:41:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B5BD2747EA2;
 Sun, 22 Mar 2020 12:41:13 +0100 (CET)
Date: Sun, 22 Mar 2020 12:41:13 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: In tree configure errors since 6116aea9
In-Reply-To: <cb6d1bee-a488-df1d-dcad-182ac3237265@vivier.eu>
Message-ID: <alpine.BSF.2.22.395.2003221240090.9583@zero.eik.bme.hu>
References: <alpine.BSF.2.22.395.2003211825370.55214@zero.eik.bme.hu>
 <67cff836-d895-3a1c-1ead-13a0e14507d6@vivier.eu>
 <alpine.BSF.2.22.395.2003211924410.70812@zero.eik.bme.hu>
 <cb6d1bee-a488-df1d-dcad-182ac3237265@vivier.eu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-584201039-1584877273=:9583"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-584201039-1584877273=:9583
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Mar 2020, Laurent Vivier wrote:
> Le 21/03/2020 =C3=A0 19:31, BALATON Zoltan a =C3=A9crit=C2=A0:
>> On Sat, 21 Mar 2020, Laurent Vivier wrote:
>>> Le 21/03/2020 =C3=A0 18:29, BALATON Zoltan a =C3=A9crit=C2=A0:
>>>> Hello,
>>>>
>>>> Since 6116aea99, or actually 4d6a835d (linux-user: introduce paramet=
ers
>>>> to generate syscall_nr.h) but only next commit starts to enable it I=
 get
>>>> these errors when running configure in source tree:
>>>>
>>>> grep: ./.gitlab-ci.d: Is a directory
>>>> grep: ./scripts/qemu-guest-agent/fsfreeze-hook.d: Is a directory
>>>>
>>>> for each entry in that loop over arches. Could this be silenced?
>>>
>>> I didn't see that because I always do an out-of-tree build.
>>
>> Isn't there a test for that or should there be one?
>>
>>> Could you try this?
>>>
>>> --- a/configure
>>> +++ b/configure
>>> @@ -1911,6 +1911,7 @@ for arch in alpha hppa m68k xtensa sh4 microbla=
ze
>>> arm ppc s390x sparc sparc64 \
>>> =C2=A0=C2=A0=C2=A0 rm -f "${source_path}/linux-user/${arch}/syscall_n=
r.h"
>>> =C2=A0=C2=A0=C2=A0 # remove the dependency files
>>> =C2=A0=C2=A0=C2=A0 find . -name "*.d" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -type f=
 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -exec gr=
ep -q
>>> "${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -exec rm=
 {} \;
>>> done
>>
>> This gets rid of the errors but seems to be much slower:
>>
>> with 4d6a835d running my usual configure script:
>>
>> real=C2=A0=C2=A0=C2=A0 0m5.968s
>> user=C2=A0=C2=A0=C2=A0 0m4.642s
>> sys=C2=A0=C2=A0=C2=A0 0m1.402s
>>
>> with HEAD and above patch:
>>
>> real=C2=A0=C2=A0=C2=A0 0m20.246s
>> user=C2=A0=C2=A0=C2=A0 0m14.143s
>> sys=C2=A0=C2=A0=C2=A0 0m6.152s
>>
>> Given that configure is rerun when some files change if there's a way =
to
>> get at least the previous speed back might be better if possible.
>>
>> Regards,
>> BALATON Zoltan
>
> Could you try this:
>
> --- a/configure
> +++ b/configure
> @@ -1910,9 +1910,9 @@ for arch in alpha hppa m68k xtensa sh4 microblaze
> arm ppc s390x sparc sparc64 \
>     # remove the file if it has been generated in the source directory
>     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
>     # remove the dependency files
> -    find . -name "*.d" \
> -           -exec grep -q
> "${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
> -           -exec rm {} \;
> +    test -d ${arch}-linux-user && find ${arch}-linux-user -type f -nam=
e
> "*.d" \
> +         -exec grep -q "${source_path}/linux-user/${arch}/syscall_nr.h=
"
> {} \; \
> +         -exec rm {} \;
> done

This is better, runs in 6-8 seconds. Thanks.

Regards,
BALATON Zoltan
--3866299591-584201039-1584877273=:9583--

