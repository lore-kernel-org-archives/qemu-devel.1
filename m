Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8392C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFF9214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFF9214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUYjN-0000kb-Oe
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iUYhd-0006uO-Tj
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iUYhc-0000e2-Lk
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:07:37 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:36491)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iUYhc-0000cJ-CE
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:07:36 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MjSLi-1i1Ig53boI-00kyC6; Tue, 12 Nov 2019 17:07:24 +0100
Subject: Re: [PATCH] linux-user: fix missing break
To: qemu-devel@nongnu.org
References: <20191112105055.32269-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ff8b25b3-95dd-8a6f-e92f-1df86cdb10f1@vivier.eu>
Date: Tue, 12 Nov 2019 17:07:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112105055.32269-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XbSIjgw+6mPTRteEh4Qfz9dwI2QU65XoSIu1QIzQpHFDsiLoElm
 ROCWPQpUugLT0k/0bK5H64b1bFgWcMbCg306J1X7qiCkgKcgWtTfo3Jg005oYMXNHRDhuh5
 JW9+TePUq30Jz88KI7L99cO3/6XSADRGGFYRCrEDM+tywj9swjqogjDAgAnkEtHsg3H0YOu
 CWwQB/0HUGJvXYkbppfqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9h//p1sKw70=:c/6LWzSJ5rJir9MTT8aqwk
 SQzW6I1EbGeWTkZk7yZWm6AJCPMkTG7QyqsJDmRdWl0lAYINhqEDuWbU2vxEhT5zmQv78EHsH
 16qqsgw7o0asgi6cQCyklMD31naW4/X0VQC9RvNwiHd+R3A3MyFKrEdySF3Hm5jH4xK0J7Xd8
 Wwjtb7ilSc3VgWj14cqcD4649NWpuWrMmdooOr+AEkyRLts2kUS1e0Swx691192zlOIn1PyAj
 IXyXqyTL2PYRk0BLKPfQpQ3xMUTm/0VzkLkrW6NoLdgZ4RSPoJwJUgKk0li1L/kfuvXXU4QsN
 SsoCGOE482J/ASjHj3urMRek13IoKG0/WY8xWrWjUUfLqtg0PYX9fnifnxtz84owM1TwFNa18
 9k3oHqeloM0uhgA+MbmW/MgedJcnobTx4+BYP+2B4taiw8jrl1jDbaSdgkkdOquNwJPw69rFs
 zP0byuGdo2NkfJ9fez1e/FWjxbh80UEVc7m6qqkcxpONpNtnsHReqGEn44acNL6SwYklcx+iW
 yN6g/Lc1B0rxMqt/7H7K3K2dqag7D9VbRMfEM2kGcshyPC1Jpj1kc8HMY8TMcp0ke8lPANK/J
 pKn16G+70/7aGrZe+kx3G4AWutWzedpjnHWxndvdBXs94rZYBUbRYD8AzC3t0a3b+fG1cFBCF
 KtqiHGkbZ3/a3rOU3s2iAog5pie/8t4PhWz8ElX8eER5VYoEo0qACpNXq/rMfwP12Rch0jXVX
 dVWHvpHG57FLrD3mo/lrpoBfHTHbeDW8K9wjGt6TAvEHUCVNiK2f/csv8iUnrRSaWYnuxuDZ9
 wiyApQ+kjY4Juc6RBj1sfLv9/9DX+502Ukq5/mrT3JTrw/6M9op6MFcBp44YECK34dvF1Vgby
 ZSxOV1+eJqv14b3W7SQA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
Cc: Josh Kunz <jkz@google.com>, Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/11/2019 à 11:50, Laurent Vivier a écrit :
> Reported by Coverity (CID 1407221)
> Fixes: a2d866827bd8 ("linux-user: Support for NETLINK socket options")
> cc: Josh Kunz <jkz@google.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ab9d933e53af..4e97bcf1e5a9 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2632,6 +2632,7 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
>          default:
>              goto unimplemented;
>          }
> +        break;
>  #endif /* SOL_NETLINK */
>      default:
>      unimplemented:
> 

Applied to my linux-user branch.

Thanks,
Laurent

