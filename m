Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A77C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FE4207D0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FE4207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYV1-0004DG-Tm
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jtYTg-0003MC-PB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:28:48 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jtYTe-0002Nr-Qc
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:28:48 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1McYTD-1kTiZi3PcD-00cyRz; Thu, 09 Jul 2020 17:28:36 +0200
Subject: Re: [PULL 11/12] linux-user: Add strace support for printing
 arguments of ioctl()
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200704162545.311133-1-laurent@vivier.eu>
 <20200704162545.311133-12-laurent@vivier.eu>
 <CAFEAcA-AYy_ixjHsX+OYN=Vx-63qdeEDY-cTit7A7wHLMiq_xA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8ca4bf38-b783-7a0c-06c0-44dc46d284ac@vivier.eu>
Date: Thu, 9 Jul 2020 17:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-AYy_ixjHsX+OYN=Vx-63qdeEDY-cTit7A7wHLMiq_xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tqVawsNNOYoRLMQb4pW+5+RA3bSs/mAmeFejp9OuxQkCYDgvo+s
 MLU5BV9edFpag3zfAu/2c2ErkV5jWLLA4nr3bBtnpQywNX6oaXrzAS8ORuUdUGNh+aTWSCE
 //bBvxhz3lLkheOiAs5skagp1edNkhvQLeSlDTUxkv/QO1an5gcSYesMQfm6DNHQ0d6uROi
 z9CICIcYSXo6ATYPwCDFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jr5cFMZWfTo=:U0uYwfbYTwBmB1xuAnQYnd
 JYQad63LMwS0vsYPIZ4fyNQyuVF505VSimnUSw+bLyxprP8PWUpLaiz781e3RAFMPBZlQd9xy
 5M6lyziGK62KIuHv+lwf5ckMYlQ1+JHlgD+WRvhszZ3wPSqiBDXR3Ofr5R5VG59CLjO5p4QE/
 cGX2YzcKMDxTiU0YfViWMD9VAT8jLxmOMutBQlYI77E0+26dB9f8DVBiyGfnZFnzX0VzGX0zw
 do8nCHlYZQqMnh+4An+LvQkE7s+96i2VswqXVwSWzUGoyEdFUJEj7FyqvTaqD3EDVDJb2zCB3
 HoailUuaqDs66Lq9bx+M8dTKE2n2ZOB4mo2JRoI/MKpxJ6+5U6xKu1smz4p5ct9p3GHWzhE0T
 tx7leENPn8/BV8nGZ/gJ5Za0fLOaSVTBT1C/gWVAQrWoVndg+FfkyzEYHYJsE9y9HsjBeJN8s
 sJSAidA+z8HQyGZ13x5asc2ya+6ZkKo8F82+qrmQsEKamLUlD/flj5T0zVmX9k5fAShp7vbOg
 pt9BpwHIseR9B2KkYFv0TUZkPh+TAbaApASb0LXUnLD88FnKi5PpAmaAYfJw5LBc492sTdM+2
 U4cYN0etWVhQOqDx9c0GFBTC/5MHYBQOcA+wVQW6ZHkhfb/noTJwqL1JTp18itcrAMqHQ1U1z
 7E+fNdOhAcZOaGR5b6WWUCprxeSHVc9Af+QbyM+7CyyxCkVjFqwcA0AhW6wRbkkJpEDhvGURq
 rD4ezhqrrtIMY/Zf2gnZp69z1Z+p+rVQ0L/dYP/4dDvEyhUh7Rff2W94Vr4cLOrxrpt5oqnNH
 pl4HIpLivTTOt7VAGraPgKFu4cx1QxMY8ll53qAI1N45kZc+4gdlU4tZzU12Xyu0RhcvC/7
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:28:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/07/2020 à 17:20, Peter Maydell a écrit :
> On Sat, 4 Jul 2020 at 17:36, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> From: Filip Bozuta <Filip.Bozuta@syrmia.com>
>>
>> This patch implements functionality for strace argument printing for ioctls.
> 
> Hi; Coverity points out some issues in this change:
> 
> 
>> +#ifdef TARGET_NR_ioctl
>> +static void
>> +print_syscall_ret_ioctl(const struct syscallname *name, abi_long ret,
>> +                        abi_long arg0, abi_long arg1, abi_long arg2,
>> +                        abi_long arg3, abi_long arg4, abi_long arg5)
>> +{
>> +    print_syscall_err(ret);
>> +
>> +    if (ret >= 0) {
>> +        qemu_log(TARGET_ABI_FMT_ld, ret);
>> +
>> +        const IOCTLEntry *ie;
>> +        const argtype *arg_type;
>> +        void *argptr;
>> +        int target_size;
>> +
>> +        for (ie = ioctl_entries; ie->target_cmd != 0; ie++) {
>> +            if (ie->target_cmd == arg1) {
>> +                break;
>> +            }
>> +        }
>> +
>> +        if (ie->target_cmd == arg1 &&
>> +           (ie->access == IOC_R || ie->access == IOC_RW)) {
>> +            arg_type = ie->arg_type;
>> +            qemu_log(" (");
>> +            arg_type++;
>> +            target_size = thunk_type_size(arg_type, 0);
>> +            argptr = lock_user(VERIFY_READ, arg2, target_size, 1);
> 
> Here we fail to check that lock_user() didn't return NULL...
> 
>> +            thunk_print(argptr, arg_type);
> 
> ...which would cause a segfault in thunk_print().
> This is CID 1430271.
> 
>> +            unlock_user(argptr, arg2, target_size);
>> +            qemu_log(")");
>> +        }
>> +    }
>> +    qemu_log("\n");
>> +}
>> +#endif
> 
>> +#ifdef TARGET_NR_ioctl
>> +static void
>> +print_ioctl(const struct syscallname *name,
>> +            abi_long arg0, abi_long arg1, abi_long arg2,
>> +            abi_long arg3, abi_long arg4, abi_long arg5)
>> +{
> 
>> +            case TYPE_PTR:
>> +                switch (ie->access) {
>> +                case IOC_R:
>> +                    print_pointer(arg2, 1);
>> +                    break;
>> +                case IOC_W:
>> +                case IOC_RW:
>> +                    arg_type++;
>> +                    target_size = thunk_type_size(arg_type, 0);
>> +                    argptr = lock_user(VERIFY_READ, arg2, target_size, 1);
>> +                    thunk_print(argptr, arg_type);
> 
> Similarly here we need to check that lock_user didn't fail.
> This is CID 1430272.
> 
>> +                    unlock_user(argptr, arg2, target_size);
>> +                    break;
>> +                }
>> +                break;
>> +            default:
>> +                g_assert_not_reached();
>> +            }
>> +        }
>> +    }
>> +    print_syscall_epilogue(name);
>> +}

Thank you Peter.

I fix that.

Laurent


