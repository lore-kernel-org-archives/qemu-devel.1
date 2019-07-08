Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58870C606BD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 17:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D4620693
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 17:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin.edu header.i=@oberlin.edu header.b="kn8vkCfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D4620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkX3C-0000Fm-BB
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 13:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56332)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stephen.checkoway@oberlin.edu>) id 1hkX0b-0007Zf-TO
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 13:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stephen.checkoway@oberlin.edu>) id 1hkX0Z-0006w4-AR
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 13:00:57 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:43498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
 id 1hkX0Z-0006sI-2T
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 13:00:55 -0400
Received: by mail-io1-xd44.google.com with SMTP id k20so36818280ios.10
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oberlin.edu; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=r5PspHPHKhzPUlD+t/b0NIdyINQGbCGRIUtmVTzM6Ko=;
 b=kn8vkCfuNVNUYb569n21S8ks6MFZ7SjYAMrNaQa5oQ+CCU0kVBTl2gmJZ65jSPU/kb
 EELOhDjgGkJtVd9Gksqtn7Q+R+I0lNKyC/0uoLqLvsRSXJ+Rjy+Oi7fjSk/s7AB9uZnV
 coIVLbStsjCvrDXEczaX9xiIh8nfetgVbneYH0CFDIw1eqMVYnRC/FleKigFujbpW+/W
 9r/NGZhfCXdb68b6nziEUdOcRzErx12Mp4M+YjJMeJH5oVEXAcumH/GuYjQwiBI4Nh29
 NrF6YlJGf4QuxmZAy9/moJFACRBgx9PxsnFnWU81ICPY3dq/E6Is4P66poSJQ4fQoki2
 Fueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=r5PspHPHKhzPUlD+t/b0NIdyINQGbCGRIUtmVTzM6Ko=;
 b=R7UsRtfJi39zyqesjYICzrDXZYRUDzRWRn3o/i/Qy18MwFkUQtolmkqzZCKJKP75fw
 k/n5WJRG1e1xGEZUfUl5eiaL3jt14DYF9DiwF5tvtwM9lquoK4e0D123hSoMn/4rDTJJ
 gTk6jp4o72wESYLuXQ7H57RgfSkiBwncFyaI30v1zpLsdrL29CAfycZu5ZB9d76IUZEc
 riiCHbryauCDlU3wJUMpDMTxIbKFWeAy7zOsX35zEtIB0q3MiO32/phKN9WZQQBlonPW
 oj+A/7ZmONNHmfAKDDFhBNEK9FBakLsXPneYWKCXL82osdF1UJCv3Ls9ZnUs2vGvMIDu
 FejQ==
X-Gm-Message-State: APjAAAUbAV6Q8BngquVBc9P2IX7OIQpexEqwiS/z79KOLD0Z68944qNT
 oCgdVenmX+naecdDOF4O2Mn4Vw==
X-Google-Smtp-Source: APXvYqzS/zj3egNhYUJrQZxG45S3Ri5BGkv7J66rbJzKbkaK9by7xU+Qrsu0+L7wv4sgEMvxo+ErBw==
X-Received: by 2002:a5e:8e42:: with SMTP id r2mr19187187ioo.305.1562605249091; 
 Mon, 08 Jul 2019 10:00:49 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
 by smtp.gmail.com with ESMTPSA id
 t19sm15562509iog.41.2019.07.08.10.00.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jul 2019 10:00:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <9cf78fb6-e56c-8ebc-3158-34cdf8fa70e6@redhat.com>
Date: Mon, 8 Jul 2019 13:00:47 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <FA5364E5-4AE9-4BFB-ACA2-BEA50B7BB0D4@oberlin.edu>
References: <20190702005912.15905-1-philmd@redhat.com>
 <20190702005912.15905-28-philmd@redhat.com>
 <C6F80CB3-2D5D-4EE0-A085-DDA8AA334279@oberlin.edu>
 <05be219a-4af9-f939-3abe-6137f5a7deba@redhat.com>
 <3D8F6CD2-6C74-469C-83C1-3DF0A458B757@oberlin.edu>
 <e8d65586-63b0-0c43-a043-efd4a59b3834@redhat.com>
 <9cf78fb6-e56c-8ebc-3158-34cdf8fa70e6@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [PULL 27/27] hw/block/pflash_cfi02: Reduce I/O
 accesses to 16-bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:sPAPR" <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jul 4, 2019, at 08:45, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> Cc'ing PPC/taihu_405ep and ARM/Digic4 maintainers.
>=20
> On 7/3/19 6:36 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 7/3/19 6:20 PM, Stephen Checkoway wrote:
>>>> On Jul 3, 2019, at 12:02, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>>>> On 7/3/19 5:52 PM, Stephen Checkoway wrote:
>>>>>=20
>>>>>=20
>>>>>> On Jul 1, 2019, at 20:59, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>>>>>>=20
>>>>>> Parallel NOR flashes are limited to 16-bit bus accesses.
>>>>>=20
>>>>> I don't think this is correct. The CFI spec defines an x32 =
interface for parallel NOR. CFI addresses 0x28 and 0x29 specify the =
interface and value 3 is x32 and value 5 is x16/x32.
>>>>>=20
>>>>> Here's an example of an x32 device =
<https://www.mouser.com/datasheet/2/100/002-00948_29CD032J_S29CD016J_S29CL=
032J_S29CL016J_3-1316792.pdf>.
>>>>=20
>>>> OK, I was not aware of these.
>>>>=20
>>>> QEMU never CFI-announced itself as x32 capable:
>>>>=20
>>>>   /* Flash device interface (8 & 16 bits) */
>>>>   pfl->cfi_table[0x28] =3D 0x02;
>>>>   pfl->cfi_table[0x29] =3D 0x00;
>>>>=20
>>>> So while the commit description is incorrect, the code is safe with =
the
>>>> current device model.
>>>>=20
>>>> I am not comfortable keeping untested 32-bit mode.
>>>> Were you using it?
>>>=20
>>> I'm not using it. I did have some code to set these CFI values based =
on the parameters used to control the interleaving =
<https://github.com/stevecheckoway/qemu/commit/f9a79a6e18b2c7c5a05e344ff55=
4a7d980a56042#diff-d33881bd0ef099e2f46ebd4797c653bcR599>.
>>>=20
>>> In general, a better testing harness would be nice though.
>>=20
>> We can revert it if it helps you.
>=20
> So after further analysis, there are not guest visible changes, =
because
> 32-bit accesses are still valid (.valid.max_access_size =3D 4) but now
> they are processed as two 16-bit accesses, shifted by
> access_with_adjusted_size().
> Well, I haven't checked (yet) when the guest and the flash are in
> different endianess, and I wish we don't use that.
>=20
> Now I see 2 different guests "registering" the flash in 32-bit access:
>=20
> - PPC/taihu_405ep
>=20
>  The CFI id matches the S29AL008J that is a 1MB in x16, while the code
>  QEMU forces it to be 2MB, and checking Linux it expects a 4MB flash
>  there, Yay \o/
>=20
> - ARM/Digic4
>=20
>  While the comment says "Samsung K8P3215UQB 64M Bit (4Mx16)", this
>  flash is 32Mb (2MB). Also note the CFI id does not match the comment.
>  Again, Yay.
>=20
> Anyway, better safe than sorry, so I'll revert.
>=20
> Thanks for following and catching this,

Great, thanks!

--=20
Stephen Checkoway






