Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE66C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 14:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D602084B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 14:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D602084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgV2E-00065I-UD
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 10:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42460)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgUya-0003nH-Mi
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 10:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgUyY-0003Wf-TM
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 10:02:12 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57797)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hgUyY-0003Qs-KC
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 10:02:10 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MBll6-1hqQ4T1tYS-00C8fU; Thu, 27 Jun 2019 16:01:37 +0200
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1560953834-29584-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1560953834-29584-4-git-send-email-aleksandar.markovic@rt-rk.com>
 <75367706-a29d-605e-a3b4-0aa483b521c4@vivier.eu>
 <BN6PR2201MB12510D08346C1EBF5BACB709C6FD0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f2c277a0-5d7d-ae39-7ba9-c1fab4cf79f8@vivier.eu>
Date: Thu, 27 Jun 2019 16:01:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB12510D08346C1EBF5BACB709C6FD0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kbSKYbqXKYo2netGmGgrfhO6vIT/pIIOqlIousmMABBNwXYP8c5
 TLe0hIaLUbYMsvvKs8h1lsSrrYIfhEdO9gJBSdGYjy5XdLnGcqlgaHEqjpTnwd6mapVnoHF
 9v4SEbOT5Vsk6vOEzMCBzMhRgmkgjXtlHRRBYU614Vj0nDTzz3GhfynXScpRB9HdM24f5dF
 Hy8cjNkaQEwm+8clA3b4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZfG36jBR6D0=:Q0j0HdBlw0LQLZmxj2EizZ
 3of+Fvew1v8hX9Nl3Jer31hLziqjE/iOsfXdg46HK54TQgNZvU+eQZSVDCATNxz5JuALXnNc4
 uxvIzbCWfSDrBOi/jnklAFmdjhqDT5pbNl/LKv2fJpOILCCsQM5aLnqao0mYReXu6YyH2PMLt
 BcEwhzzABywoBLqJ7BBJnP8MBzGjWKBubIMXbuWrdLEf3U/6g8rrEyYJ4a/fij1eSy0FjoTnJ
 qDgNJOLL5cKx0sv2N8K3G3yxPFRAlKSfLEyQCGOv8QqMv9YhWOUJ2+JE5ho0Z5zeAaEGDCLJB
 qMOu4+b4LC8jgCp95qJZNbtR54VXja+CseEsy01oZhTkS64fCC5Z7p0zXh/zs2FgfATwI67dL
 d8wb/RXbT94WfE9T+585fGhstsNVYT3zdl1CgwFoKzQ0PSRW10muNEn4IhK4c0diUZJHZIN5A
 lcosWByPasg2w0xhIUb928uVGqSf8SqfHU1V+Jtm7vvdd5A8FTNI7jo0NGFpdIcfYlspRaRzu
 uWYCZn8JXeIJj/lMN/ensf24ysY7ld86dn8P0Cz8ssrrZ5wHgv8Dzp1xDhwL6pZxlMbZeH5uN
 fX6CRSvzbS8C6JF5Xu0ReLI7NK2eI9bneAxcCZ0FIoHIUWv5f9fEuRXSFBWN8HB/LYZ3kmISF
 1319SjuozIwVD1tHO3St7XTUsJY5NRmon+UV1V7PpvhDJMnBPIPFTZqvUiJMwsZ+quInjk0nX
 72txtt0nA8vwKcgS0WAVnh7475KkakvR8t4uMhe+c8qwDePU241S5+QXY54=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [PATCH v12 3/5] linux-user: Add support for
 translation of statx() syscall
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Jim Wilson <jimw@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 27/06/2019 à 15:18, Aleksandar Markovic a écrit :
>> From: Laurent Vivier <laurent@vivier.eu>
>>
>>> @@ -10173,6 +10225,88 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long > arg1,
>>>              ret = host_to_target_stat64(cpu_env, arg3, &st);
>>>          return ret;
>>>  #endif
>>> +#if defined(TARGET_NR_statx)
>>> +    case TARGET_NR_statx:
>>> +        {
>>> +            struct target_statx *target_stx;
>>> +            int dirfd = arg1;
>>> +            int flags = arg3;
>>> +
>>> +            p = lock_user_string(arg2);
>>> +            if (p == NULL) {
>>> +                return -TARGET_EFAULT;
>>> +            }
>>> +#if defined(__NR_statx)
>>> +            {
>>> +                /*
>>> +                 * It is assumed that struct statx is architecture independent.
>>> +                 */
>>> +                struct target_statx host_stx;
>>> +                int mask = arg4;
>>> +
>>> +                ret = get_errno(statx(dirfd, p, flags, mask, &host_stx));
>>> +                if (!is_error(ret)) {
>>> +                    if (host_to_target_statx(&host_stx, arg5) != 0) {
>>> +                        unlock_user(p, arg2, 0);
>>> +                        return -TARGET_EFAULT;
>>> +                    }
>>> +                }
>>> +
>>> +                if (ret != -TARGET_ENOSYS) {
>>> +                    unlock_user(p, arg2, 0);
>>> +                    return ret;
>>> +                }
>>> +            }
>>> +#endif
>>> +            if (*((char *)p) == 0) {
>>> +                /*
>>> +                 * By file descriptor
>>> +                 */
>>> +                if (flags & AT_EMPTY_PATH) {
>>> +                    unlock_user(p, arg2, 0);
>>> +                    return -TARGET_ENOENT;
>>> +                }
>>> +                ret = get_errno(fstat(dirfd, &st));
>>> +            } else if (*((char *)p) == '/') {
>>> +                /*
>>> +                 * By absolute pathname
>>> +                 */
>>> +                ret = get_errno(stat(path(p), &st));
>>> +            } else {
>>> +                /*
>>> +                 * By pathname relative to the current working directory
>>> +                 * (if 'dirfd' is AT_FDCWD) or relative to the directory
>>> +                 * referred to by the file descriptor 'dirfd'.
>>> +                 */
>>> +                 ret = get_errno(fstatat(dirfd, path(p), &st, flags));
>>> +            }
>>> +            unlock_user(p, arg2, 0);
>>
>> Could you explain why we can't use fstatat() for the two previous cases
>> "(*((char *)p) == 0)" and "(*((char *)p) == '/')"?
>>
> 
> Man page on fstatat (http://man7.org/linux/man-pages/man2/stat.2.html)
> says:
> 
>    AT_EMPTY_PATH (since Linux 2.6.39)
>           If pathname is an empty string, operate on the file referred
>           to by dirfd (which may have been obtained using the open(2)
>           O_PATH flag).  In this case, dirfd can refer to any type of
>           file, not just a directory, and the behavior of fstatat() is
>           similar to that of fstat().  If dirfd is AT_FDCWD, the call
>           operates on the current working directory.  This flag is
>           Linux-specific; define _GNU_SOURCE to obtain its definition.
> 
> So it looks the branch "if (*((char *)p) == 0)" can be handled by
> fstatat().
> 
> Also, the man page says:
> 
>    If pathname is absolute, then dirfd is ignored.
> 
> So, it looks the case "else if (*((char *)p) == '/')" can also be
> handled by fstatat().
> 
> Very similar descriptions of the cases above can be found in
> the man page for statx
> (http://man7.org/linux/man-pages/man2/statx.2.html).
> 
> The whole string of if statements after "#endif" above should be now,
> in my opinion:
> 
>         ret = get_errno(fstatat(dirfd, path(p), &st, flags));
>         unlock_user(p, arg2, 0);
> 
> ... and I will submit the patch with such code, if noone objects.
> 

I agree.

Thanks,
Laurent


