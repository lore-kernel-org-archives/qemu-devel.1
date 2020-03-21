Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D1CC4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 18:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF70C20714
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 18:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF70C20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFiv0-0003a2-Ox
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 14:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jFitp-00039v-Ri
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 14:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jFito-0000UQ-4X
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 14:31:09 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:37894)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jFitn-0000SS-UT
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 14:31:08 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6554F747DF7;
 Sat, 21 Mar 2020 19:31:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4946E747DCF; Sat, 21 Mar 2020 19:31:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 47610747DFA;
 Sat, 21 Mar 2020 19:31:05 +0100 (CET)
Date: Sat, 21 Mar 2020 19:31:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: In tree configure errors since 6116aea9
In-Reply-To: <67cff836-d895-3a1c-1ead-13a0e14507d6@vivier.eu>
Message-ID: <alpine.BSF.2.22.395.2003211924410.70812@zero.eik.bme.hu>
References: <alpine.BSF.2.22.395.2003211825370.55214@zero.eik.bme.hu>
 <67cff836-d895-3a1c-1ead-13a0e14507d6@vivier.eu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-475633399-1584815465=:70812"
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

--3866299591-475633399-1584815465=:70812
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Mar 2020, Laurent Vivier wrote:
> Le 21/03/2020 =C3=A0 18:29, BALATON Zoltan a =C3=A9crit=C2=A0:
>> Hello,
>>
>> Since 6116aea99, or actually 4d6a835d (linux-user: introduce parameter=
s
>> to generate syscall_nr.h) but only next commit starts to enable it I g=
et
>> these errors when running configure in source tree:
>>
>> grep: ./.gitlab-ci.d: Is a directory
>> grep: ./scripts/qemu-guest-agent/fsfreeze-hook.d: Is a directory
>>
>> for each entry in that loop over arches. Could this be silenced?
>
> I didn't see that because I always do an out-of-tree build.

Isn't there a test for that or should there be one?

> Could you try this?
>
> --- a/configure
> +++ b/configure
> @@ -1911,6 +1911,7 @@ for arch in alpha hppa m68k xtensa sh4 microblaze
> arm ppc s390x sparc sparc64 \
>     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
>     # remove the dependency files
>     find . -name "*.d" \
> +           -type f \
>            -exec grep -q
> "${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
>            -exec rm {} \;
> done

This gets rid of the errors but seems to be much slower:

with 4d6a835d running my usual configure script:

real	0m5.968s
user	0m4.642s
sys	0m1.402s

with HEAD and above patch:

real	0m20.246s
user	0m14.143s
sys	0m6.152s

Given that configure is rerun when some files change if there's a way to=20
get at least the previous speed back might be better if possible.

Regards,
BALATON Zoltan
--3866299591-475633399-1584815465=:70812--

