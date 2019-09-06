Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EACAC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 09:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CDE206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 09:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CDE206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Asp-0001Bh-30
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 05:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i6As4-0000kd-9q
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 05:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i6As2-0007nT-9S
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 05:49:35 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48985)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i6As1-0007k4-VV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 05:49:34 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MiZkX-1ibx752rWJ-00fkWl; Fri, 06 Sep 2019 11:49:00 +0200
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1564597178-24649-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1564597178-24649-13-git-send-email-aleksandar.markovic@rt-rk.com>
 <BN6PR2201MB1251C91F80B6BCFDFB76AAEFC6DF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f3ef4654-027e-dc06-6747-6930a05d5bce@vivier.eu>
Date: Fri, 6 Sep 2019 11:48:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251C91F80B6BCFDFB76AAEFC6DF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Qre4AUtUaLnsILlakdd1Ca+6O3g2AIoLRWoCyFvnF3C/PL3AgbV
 ucyc+uzqU/szPwJqmBl4dIEIk81UZfAGcQG39b5rHCSq4L1g3cpWqRvl5r+3dKaW2sr6ZIU
 sOyjya2RYx6X92tlEMOoDa6heYzbCbhEQ1ys1kX8ct5jMru6cgRC4HE8nEyg3sPgbN72PLF
 fEhkBVSzWleXx0r8xHGvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9y42rHVWsmY=:ZZpHE8XzPxP6lcHFmEEnfQ
 RUO+o/LXQENFBAiBr79GDTkRd9ZDXpcNjDYMW2OlTNbMnnQRI/6wUbUJTOHfoXtm9zQ8rnK0y
 f31qJAPLFwg7a7CPVXuLCc0Uvd6/BALUGdiewnd00sVguL1DdlffM7wAhFaxaN75Yw9wxypph
 BZCZAF6XcxhkbM3IDA+d+pi7zOxRa3MrC3CxJ45v4cJ3odcy65y7iHn56Mz/d6gvmGV+WPRPP
 Ax9S9XuCJbR3hxfNtwoEIlgcdaJbfylfX9GMmOR6+Lb34yipUsgHcq/hA7z7EmEINO8B4LVFh
 rDSzWij87XQfj97culI/IsuexF7lK+XEbY4JEYpDxQhUKPQhD9F6h0F7MSih33JjOIb9/9X+O
 FQQ4aK46Ceb2Zmv5aJ+6T8IrwzoZcOC7oka59ljTx9aNypOS0gnxWFgR0ZurfHSIk+4AlMgVL
 9sFWoikBKQ5aYtdfyHehfoTCpg5EYp5I7kzn0+BwhaDn776SbZHqT6eGkd6ukyUuLMfsKzoTb
 +NBqjmmKwL6Dq1vE1NvQkrPfDGvX1VBnKuqAgFwgn6Y09Zq/8lwlBenCgr6xXDpvzlSaRT8eM
 4e/t1Fkg99lws0cJebZwkS7E6iz9c9M2D8mdQp8WJpfCUwg+CYjB3llExVaxtSEXT4IkHa6Pv
 2D0N7LhACMPum5SsV/6WBHNGztZowXuTTZSMVQQeAfxahB+kzKD8poZIczRaaHGdhSgDtsW65
 4p/EbSDDsTfBzyUW/Bb09EoZfxGxNkAk9yxaCf7O176kMQ3Ss9blO95UFFrcOfGbPvy/XNIeL
 Oa6NT3joRre4KDNxJs5U5VdjQI+2gSP8/6WygL9BRhgqBPH2ns=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [EXTERNAL][PATCH for 4.2 v4 12/12] linux-user: Add
 support for semtimedop() syscall
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 31/07/2019 à 20:22, Aleksandar Markovic a écrit :
>> From: Aleksandar Rikalo <arikalo@wavecomp.com>
>>
>> Add support for semtimedop() emulation. It is based on invocation
>> of safe_semtimedop().
> 
> Hi, Laurent,
> 
> Aleksandar R. is considering submitting this part too:
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b5bc6e4..0e56b8d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -4194,6 +4194,17 @@ static abi_long do_ipc(CPUArchState *cpu_env,
>      case IPCOP_shmctl:
>          ret = do_shmctl(first, second, ptr);
>          break;
> +#ifdef __NR_ipc
> +    case IPCOP_semtimedop: {
> +        struct sembuf sops[nsops];
> +        if (target_to_host_sembuf(first, ptr, second)) {
> +            ret = -TARGET_EFAULT;
> +        } else {
> +            ret = get_errno(safe_ipc(IPCOP_semtimedop, first, second, 0, sops, 0));
> +        }
> +        break;
> +    }
> +#endif

You should do something like that:

    case IPCOP_semtimedop
        ret = do_semtimedop( ... );
        break;

Thanks,
Laurent



