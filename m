Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URI_NOVOWEL,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F3C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD20206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C942LK1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD20206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHWur-0002n6-FB
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 13:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHWu6-0002DL-GG
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHWu4-0000e6-GE
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:34:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42577
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHWu3-0000dd-Sk
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570469675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLAFUPD86yGrE+0ppis00eKI1+NF+nN5nxNRr9Ij90k=;
 b=C942LK1T6R4O0l4aq0Z1lfjbRoRv2AavzVOGo2iNkeBj21evlPPlABczPGTaP3RXltBCwc
 2raCmXIg6FInr497qKOXiSoYx0i2UtR/SDNvTSJJDPx7SSaRONdNwT+39U/tic4XclX344
 CJzR30wu7/kOA8gUPL6eHRmJk2zEpGg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-SH9dHs-IPEyQ1MxM6ahWlg-1; Mon, 07 Oct 2019 13:34:32 -0400
Received: by mail-wm1-f72.google.com with SMTP id k67so113290wmf.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 10:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iRy6X9lfo+m49AK23/qEaFF7EhWqURa0ZWIL6vb4zc4=;
 b=MaovMrPsY3F7gIJXyIZmM4OGVALyQkLPqT9dKzbUzfbU2/tUpUt1ggPowSFmaEbvaC
 IJRqjvl2Th1eAz53xssDrE+1ik0dDG9R58HlhWvO3RhFk6QwoLU2Ujtl321J8cP39OIZ
 nhCTlGtX2pUIWTc+SsIo8wYqp9wsyFbAp0J2s/J2ur+PbEVEAgA8aJG27Ru/JTs3zFYR
 XR0GfR8DnwB4MNdKfCJti+CB1bODPmB7UY1JHoyaXN9nfZgYChvnR18/74gZtoEvK/QV
 D8yxOjP+yaa4Ier8EOQdA795NXBhD8st/vDr3RiqB9Y+wGqmMz68UUhdgnkObyG9Gm8f
 N5SA==
X-Gm-Message-State: APjAAAUuaSl8zemXHbP02N1+YmtdVNsEI24HWzf7cynKJL8him87Qzc6
 2E9EWCNiemHMJtao296J8Bi2jTxoJk7hjDzJymB7W7Dr70b5PaogQE/wZnbfthJHbrm51QvEiBp
 24ud5D2YQlxbl3yA=
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr22869201wrq.292.1570469670562; 
 Mon, 07 Oct 2019 10:34:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyvRvBbpN4//Ao7V5ZfN70Rci0L0v7RTwODogLHJxVGbE2tm4L2hiBxjXjoYeVOlrHYWhBD0g==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr22869187wrq.292.1570469670320; 
 Mon, 07 Oct 2019 10:34:30 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id h17sm283349wmb.33.2019.10.07.10.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2019 10:34:29 -0700 (PDT)
Subject: Re: [Qemu-devel] Bug#919921: qemu-user Linux ELF loader fails to
 handle pure BSS segments
To: Ben Hutchings <benh@debian.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, 919921@bugs.debian.org,
 Laurent Vivier <laurent@vivier.eu>
References: <154800690066.11444.6761064786302350654.reportbug@deadeye.wl.decadent.org.uk>
 <4caef357-e49b-2314-ee19-3ae31f8e4c30@msgid.tls.msk.ru>
 <d78c26dc-727c-b58b-9536-a715aa44da77@redhat.com>
 <0fd131fc-3802-dde3-e21c-6c3ea5a444e3@linaro.org>
 <0243ea3a388f77dd8002853310081af23a7d787b.camel@debian.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d1e974bc-513b-625e-0130-f88ba243dc41@redhat.com>
Date: Mon, 7 Oct 2019 19:34:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <0243ea3a388f77dd8002853310081af23a7d787b.camel@debian.org>
Content-Language: en-US
X-MC-Unique: SH9dHs-IPEyQ1MxM6ahWlg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Ben,

On 10/7/19 7:29 PM, Ben Hutchings wrote:
> On Tue, 2019-01-22 at 21:31 -0800, Richard Henderson wrote:
>> On 1/22/19 1:39 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi Ben,
>>>
>>> On 1/22/19 6:43 AM, Michael Tokarev wrote:
>>>> Forwarding to qemu-devel@
>>>> http://bugs.debian.org/919921
>>>>
>>>> Thanks!
>>>>
>>>> 20.01.2019 20:55, Ben Hutchings wrote:
>>>>> Package: qemu-user
>>>>> Version: 1:3.1+dfsg-2
>>>>> Severity: normal
>>>>> Tags: patch
>>>>>
>>>>> I've been building and testing klibc across many architectures using
>>>>> qemu-user, and I found that qemu-user fails to load a few programs on
>>>>> a few architectures, reporting an EINVAL error code.  Here's the
>>>>> "readelf -l" output for one such program:
>>>>>
>>>>>       Elf file type is EXEC (Executable file)
>>>>>       Entry point 0x10000100
>>>>>       There are 5 program headers, starting at offset 52
>>>>>            Program Headers:
>>>>>         Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz
>>>>> Flg Align
>>>>>         PHDR           0x000034 0x10000034 0x10000034 0x000a0 0x000a0
>>>>> R   0x4
>>>>>         INTERP         0x0000d4 0x100000d4 0x100000d4 0x0002a 0x0002a
>>>>> R   0x1
>>>>>             [Requesting program interpreter:
>>>>> /lib/klibc-R7FVdnsTBUFpWPgCV6FR07b-mf8.so]
>>>>>         LOAD           0x000000 0x10000000 0x10000000 0x002f8 0x002f8=
 R
>>>>> E 0x10000
>>>>>         LOAD           0x010000 0x10020000 0x10020000 0x00000 0x08000
>>>>> RW  0x10000
>>>>>         GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000
>>>>> RWE 0x10
>>>>>             Section to Segment mapping:
>>>>>         Segment Sections...
>>>>>          00
>>>>>          01     .interp
>>>>>          02     .interp .text .rodata .eh_frame
>>>>>          03     .bss
>>>>>          04
>>>>>
>>>>> The unusual feature of this program, and all the others that failed,
>>>>> is that there is a LOAD segment with a file-size of 0 (i.e.  only BSS=
,
>>>>> no initialised data).  load_elf_image() will try to mmap() initialise=
d
>>>>> data for this section even though there is none and a length of 0 is
>>>>> invalid.
>>>>>
>>>>> The change that seems to fix this is to skip the mmap() in this case:
>=20
> Is there a reason why my fix can't be applied?  Do I need to open a bug
> report in Launchpad for this?

Simply send your patch formally to qemu-devel@nongnu.org.

>>>>> --- a/linux-user/elfload.c
>>>>> +++ b/linux-user/elfload.c
>>>>> @@ -2316,11 +2316,13 @@ static void load_elf_image(const char *i
>>>>>                vaddr_ps =3D TARGET_ELF_PAGESTART(vaddr);
>>>>>                vaddr_len =3D TARGET_ELF_PAGELENGTH(eppnt->p_filesz +
>>>>> vaddr_po);
>>>>>    -            error =3D target_mmap(vaddr_ps, vaddr_len,
>>>>> -                                elf_prot, MAP_PRIVATE | MAP_FIXED,
>>>>> -                                image_fd, eppnt->p_offset - vaddr_po=
);
>>>>> -            if (error =3D=3D -1) {
>>>>> -                goto exit_perror;
>>>>> +            if (vaddr_len !=3D 0) {
>>>
>>> This is probably not the good fix, since now your process doesn't have
>>> anything mapped to use his BSS :)
>>
>> Not true.  The mapping happens in zero_bss.
>>
>>> What about this fix instead, using the segment memory size rather than
>>> the file size:
>>>
>>> -- >8 --
>>> @@ -2314,7 +2314,7 @@ static void load_elf_image(const char *image_name=
,
>>> int image_fd,
>>>               vaddr =3D load_bias + eppnt->p_vaddr;
>>>               vaddr_po =3D TARGET_ELF_PAGEOFFSET(vaddr);
>>>               vaddr_ps =3D TARGET_ELF_PAGESTART(vaddr);
>>> -            vaddr_len =3D TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vadd=
r_po);
>>> +            vaddr_len =3D TARGET_ELF_PAGELENGTH(eppnt->p_memsz + vaddr=
_po);
>>>
>>>               error =3D target_mmap(vaddr_ps, vaddr_len,
>>>                                   elf_prot, MAP_PRIVATE | MAP_FIXED,
>>
>> No, there's only filesz bytes in the file.  I'd expect zero_bss to map o=
ver the
>> extra that you just mapped, but it doesn't help.
>>
>>
>> r~


