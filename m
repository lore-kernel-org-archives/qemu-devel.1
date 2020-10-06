Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCA1C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D52206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt1bkpc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D52206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPqrS-0005n1-Ab
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>)
 id 1kPqqX-0005Ko-No; Tue, 06 Oct 2020 13:33:53 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:41491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>)
 id 1kPqqW-0007TL-1S; Tue, 06 Oct 2020 13:33:53 -0400
Received: by mail-ed1-x541.google.com with SMTP id l24so14443540edj.8;
 Tue, 06 Oct 2020 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Uei1rIJa7Or3V2E+URLP6jV3aRThIaXwhLFaZDG2lGw=;
 b=Lt1bkpc+rhGHysBVwec0VVK133WquFpCa/3cfTsATF7AGpCGUPg5cPrKJEDCpWR+5V
 jC5zwzf0wlyZV3d9bhBAwNx6Ok5ZhrjmF//CpWlAbsoXU8Xxw9ELR4IDivrLaO43WlNx
 lzOr/MSM2ZuBAPqxSQlJH9lC4XuNykOlCpNBR+C4dIf5wWiEUaPVdv6u2aQ/+MaGYBlh
 9oj0KO6DifXKjoosFirKO+qTex+x5hrmhU7dH4rooqkdBuFpdtL5KyQZCIpqvw6Ts81D
 KzQC0cWt8i81Nup5f5P4UsmOJZVmROpSLuhGiYyJwZLCHOOLPuphYTRnQ+ohtx9CL0O2
 FU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Uei1rIJa7Or3V2E+URLP6jV3aRThIaXwhLFaZDG2lGw=;
 b=F5WmW8mD7/kkjJQydTih1QHoG35wl4mfDm9ZMtdgp2yPvkRG9J2WUXmW7sx/ZqJnEG
 FV9OJXcM61+vaXapX7MJXr7YRwdrNlC+SkrtZhgJPtb57inJ0CikIE4pMsKbIWn5nw6N
 Dl4S3rEaMiPzgW6ftiL4IwDLDiq7Um8f7OuHlMT4yJhT7GW4oMwJif4CAxjT53LToaYi
 GYndxuWSElPaIwYEsf87/Od0vU9qrE/CwLA93fdyqEeJoBnv7XO72wzhOZ9a2bsoZzDt
 MLYYDBpqQmq9u1wcPSSHBg9550G5o8DHmmwyVS/ah5oHeesCFAhRVyGqhCCHDCkQamoU
 Z3yA==
X-Gm-Message-State: AOAM5327UBEgMj7ueu4raGIJg4emwR3hzN3EDNyzH/s8Wj1xUpHKRFBw
 sRkCs17eGIvqFWVvPV61IB8=
X-Google-Smtp-Source: ABdhPJwTOWAuR0525siZkYZB0oOxC76JU9cysVbx8fXbyXU2utNtSuuxhFQvhIkqNuVjF+CvDrD0xA==
X-Received: by 2002:a50:ccc6:: with SMTP id b6mr6612392edj.329.1602005628753; 
 Tue, 06 Oct 2020 10:33:48 -0700 (PDT)
Received: from [192.168.175.34] ([185.81.136.21])
 by smtp.googlemail.com with ESMTPSA id k18sm2626367ejk.42.2020.10.06.10.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 10:33:47 -0700 (PDT)
Subject: Re: [PATCH v2 1/9] s390x/pci: Move header files to include/hw/s390x
To: Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
References: <1601669191-6731-1-git-send-email-mjrosato@linux.ibm.com>
 <1601669191-6731-2-git-send-email-mjrosato@linux.ibm.com>
 <20201006173259.1ec36597.cohuck@redhat.com>
 <e9f6c3e1-9341-b0d0-9fb2-b34ebd19bcba@linux.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFYBBMBAgBCAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAIZARYhBJyxjdr46EmtKvwWpK0ScMxN0CebBQJdweUY
 BQkP1h/pAAoJEK0ScMxN0CebqDsH/0YyfnXk+Dc++H37VCEKgRet2i1ATFzxRnifkvmdxha0
 V+PVptQ2fwSe+w3KxoFecD8W75nysmUjrU/FicW9yU5YRlGONPZjruG02/KzmhA5PzWJdYO3
 i/t0qRayvWIcX2qA/flsXEbmb/BbAFM05LQIdcOu74eiBFe5CBCOWBDJeneE1urIE0hSYxoh
 nCcG60ULrNj13ohZ4zAEluoY32qIo7/OPWmtR88cPrEbZT8k+RqgZbsotzaPT1/RlL74fL8k
 ofYfTgKAFH7eEy6fF2nzDp2GThVn+3sA62xtpSXUf/X1m75B40KOcq1EQbHypNTmBc1wt13e
 ibhPNEVX2am5AQ0EUa4sLwEIALITHfH3gciRNfQIe7awDTDvn6H3C6gDyCAnv5LiuLTLZiyK
 NZp3lNO3rPowyKrGT2RIDlumlqPgdeHzqEEX91YK0yk2vdFvwU04rJ4D+qRgdUPoeICLD1zo
 PwOv2FaY6Tf8dKYas1RHF5QU5yQNey8j7IYYoE2yGPn2PtBmvtmK4iLataUEvx0U385Zr+jf
 HscqwTiToryeDC8Io/9BsMvAssE5Yf5URS2nJ7LFOvc4njsQJPF1i9egBXaIloqv7p2hVCKJ
 Hl5UWIxitQ9QQIl6iU4LCpz8mVYTXwv48IAVpbUf7+ak9V9Kk3jCeQnlxCJBUHjUhoIzinbS
 JHPHtkkAEQEAAYkBPAQYAQIAJgIbDBYhBJyxjdr46EmtKvwWpK0ScMxN0CebBQJdweVIBQkP
 1iAZAAoJEK0ScMxN0CebGHUH/RtouOlWl6To97tQsTJUq/2YwmRpFOsvV0/zCX4fKBGAbeZi
 VaELSt2+3UEErA+n8HwbQmjJ6IrdhA9GustOpOyCcbLVSMwql/OlAwBtDzCcC8dTU4zcuY2a
 rGG2A8i5krU85G9r1wowVcWZBsdmW7/dKiNoadLQiig4bHNiSaV4ograas5efyEjqTxiY+yG
 hzPw5DK2kbp2co8iDF1vW0LWPeLFBinCgItcI9LvgHWaB3rwjOfvNpMn5m64SoQYHB8wbnid
 erAjOzkBzmqnfS1tAUr8mtESStEwrEmNv0ZoA6S0Wt+c9pyTr+BpG4OFlhj7ZI+Eh7zOrr33
 q9OBIdA=
Message-ID: <1c118c1d-8c9b-9b7b-d1ec-2080aaa1c1a3@twiddle.net>
Date: Tue, 6 Oct 2020 12:33:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e9f6c3e1-9341-b0d0-9fb2-b34ebd19bcba@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=rth7680@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 11:43 AM, Matthew Rosato wrote:
>> Looks good, but...
>>
>> <meta>Is there any way to coax out a more reviewable version of this
>> via git mv?</meta>
>>
> 
> I tried git mv, but a diff between the old patch and the new patch looks the
> same (other than the fact that I squashed the MAINTAINERS hit in)

git format-patch --find-renames[=<pct>]

Though I'm surprised it's not doing that by default.

r~

