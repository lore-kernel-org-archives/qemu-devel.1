Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37775C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B34B21019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B34B21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7leQ-00056C-27
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 15:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7lcs-0004Hk-KZ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7lcq-0006id-6p
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:16:30 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:47261)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7lco-0006g9-PX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:16:27 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MqqLB-1iTIr82cfx-00mvzh; Tue, 10 Sep 2019 21:15:59 +0200
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1567601968-26946-9-git-send-email-aleksandar.markovic@rt-rk.com>
 <2d5e7f28-7fa4-7637-c512-b443848eb61b@vivier.eu>
 <CAL1e-=id9tL4-6eLgkd2SQ2W-5yU6Zp7WgVj0YFJ83wdG1qG6w@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e507ebca-3a19-579c-6cd7-26b08832799e@vivier.eu>
Date: Tue, 10 Sep 2019 21:15:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=id9tL4-6eLgkd2SQ2W-5yU6Zp7WgVj0YFJ83wdG1qG6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:H3wWXjxE3dirsAyZuLVwrWWfURkoGthdjNaJoPaItWKY5NEh7Pf
 zWeOklkHLClVJsmFE0B8h//VjvKHxynTvi9XBgSoYPCxf4OG6rPMq5K5fr658z25/AIWk/b
 SVj+TAQqEUFikcPx7PL2ERYdcVszLaaS8DVcDbngqruwtHSLLihlKiIixLfFo2EFs373PRV
 PlPXdzfWDrzFJHP8bG5Jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BjHSQ1w+9gw=:OlHi4wquHuqCMoCAy05p6+
 FRBnQFpqAY80bbT0QHOOXTC6zgEQDFZ0BsKbc6Dg/nItqVcLMs8la6iQoBxxCb0Usk7jFjdZQ
 2b6FbdLgoZPFHBM7G2ovbOUQ/jayCmwD/xw+85NDA58OMiC1qKpq6vwBfkTZpy/alhbCwPIOe
 nOJYdugbv4SNEKKTE/rRHT50AESP9dTz7Mg4KB5RKdzAAEDJSZQvdcFm5XofpJIxHZ/Yg68jY
 LUSadpx8ClRUv5zoelIV7NOXF0rI4abZkBiTjj9GEKqsTD73P6wvUsfB8wqr2pzsltTLhlL7D
 Is0418gPTYGGiAf9sjXJjuPpJhNXHLB4tEHOdx6rA1MwVG3lev2A0kZoVN4QIBXmfRCz5QDlR
 KZLi3WBNL8+gql+1A1+U3wLsy7bhTNjqQPBrQ92ZgI01iJNX4nywbd8OljEr0L1BAa5ZlKf+0
 bNtua8P7sxfj7ajbCYHcr8kvWFHyxfuWJr/+sISJUD20j2DX9iQ4Y2fns+s3Y6Ock7BNKz/8I
 PMA9OxBJyY4xjmllj4sRCjB1+0g8FILYuCNWIs5EoHPUZE8Lg8qXHdoSfMUOFgC9v5GRU+Nup
 g0AcfP0zvXJNCnqd/8m+fZ8BSJIyjtb2ocpLvFVEi915RM5W65ZYTbgfYFZJPXsJA7RwuVqiM
 xCb7R8LAsCTLu2Mp8wRDCo2jKv4rqBr+InxJ6iPLmOWLffTMsmvC7uN8LXrFdiRrDstu/zRhV
 VjyyejMAMw7ObhCH0PVtH47y31VyM+CGRP37J8MWTPdA7rrDflTWkPNed81BFlSg1trc54C08
 QUx8SFOzxq4z4BEHIJafJgqwDQBnsefvatPbcPWpH+HP1I0D8s=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: Re: [Qemu-devel] [PATCH v6 8/8] linux-user: Add support for
 FDSETEMSGTRESH, FDSETMAXERRS, and FDGETMAXERRS ioctls
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/09/2019 à 20:59, Aleksandar Markovic a écrit :
> 
> 06.09.2019. 12.47, "Laurent Vivier" <laurent@vivier.eu
> <mailto:laurent@vivier.eu>> је написао/ла:
>>
>> Le 04/09/2019 à 14:59, Aleksandar Markovic a écrit :
>> > From: Aleksandar Markovic <amarkovic@wavecomp.com
> <mailto:amarkovic@wavecomp.com>>
>> >
>> > FDSETEMSGTRESH, FDSETMAXERRS, and FDGETMAXERRS ioctls are commands
>> > for controlling error reporting of a floppy drive.
>> >
>> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com
> <mailto:amarkovic@wavecomp.com>>
>> > ---
>> >  linux-user/ioctls.h        |  2 ++
>> >  linux-user/syscall_defs.h  | 19 +++++++++++++++++++
>> >  linux-user/syscall_types.h |  7 +++++++
>> >  3 files changed, 28 insertions(+)
>> >
>> > diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
>> > index 622874b..0c75d03 100644
>> > --- a/linux-user/ioctls.h
>> > +++ b/linux-user/ioctls.h
>> > @@ -118,6 +118,8 @@
>> >       IOCTL(FDFMTTRK, IOC_W, MK_PTR(MK_STRUCT(STRUCT_format_descr)))
>> >       IOCTL(FDFMTEND, 0, TYPE_NULL)
>> >       IOCTL(FDFLUSH, 0, TYPE_NULL)
>> > +     IOCTL(FDSETMAXERRS, IOC_W,
> MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
>> > +     IOCTL(FDGETMAXERRS, IOC_R,
> MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
>>
>> where is FDSETEMSGTRESH?
>>
>> >       IOCTL(FDRESET, 0, TYPE_NULL)
>> >       IOCTL(FDRAWCMD, 0, TYPE_NULL)
>> >       IOCTL(FDTWADDLE, 0, TYPE_NULL)
>> > diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
>> > index 834a085..7c5b614 100644
>> > --- a/linux-user/syscall_defs.h
>> > +++ b/linux-user/syscall_defs.h
>> > @@ -890,12 +890,31 @@ struct target_pollfd {
>> > 
>> >  /* From <linux/fd.h> */
>> > 
>> > +struct target_floppy_max_errors {
>> > +    abi_uint        abort;
>> > +    abi_uint        read_track;
>> > +    abi_uint        reset;
>> > +    abi_uint        recal;
>> > +    abi_uint        reporting;
>> > +};
>>
>> You don't need this, you can use floppy_max_errors from <linux/fd.h>.
>>
>> But you can define it if you want because it is used to know the size of
>> the target structure (and if alignment or data types differ it can
>> mismatch. With "int" it's not the case).
>>
> 
> Laurent, thanks for the review, I'll correct this in the next version.
> 
> Just a follow-up question:
> 
> If the structure of related to a (not-yet-supported in QEMU) ioctl was:
> 
> struct hd_geometry {
>       unsigned char heads;
>       unsigned char sectors;
>       unsigned short cylinders;
>       unsigned long start;
> };
> 
> ... would "target_hd_geometry" be needed, or not?

In this case I think it is needed:
"unsigned long start" can be needed to be aligned on 64bit on some 64bit
architectures whereas on other it can be needed to be aligned on 32bit
or 16bit (m68k). So host and guest can behave differently.

Thanks,
Laurent


