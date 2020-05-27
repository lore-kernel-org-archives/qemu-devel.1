Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D11C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95932088E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95932088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdyqR-00071b-1V
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 12:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jdypt-0006bf-Fc
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:23:21 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jdyps-0007DT-Fz
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:23:21 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M2w4S-1jah363I7g-003KQP; Wed, 27 May 2020 18:23:12 +0200
To: Sid Manning <sidneym@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <BYAPR02MB55094915935E2B24286CB519BEA70@BYAPR02MB5509.namprd02.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: linux-user - time64 question
Message-ID: <4f339841-ace9-9499-64f1-6586c9f25690@vivier.eu>
Date: Wed, 27 May 2020 18:23:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB55094915935E2B24286CB519BEA70@BYAPR02MB5509.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZMonfgHXC+wWaSDfPu+JUiHpP9iGK+P+rOt3n9xeaQ4MxWCDIR3
 UDOahHj4aecj39inZxRq6P4yuF0K2qCTpKt/CcFFq6j4crnljg1NVLuY83fOlM7BEB5efEP
 mJdMnYLUHkLWzuIhBKiiaphBgwqVIvM0ngZns4JckhG5VwMZJRNxrF4vUUYpvjGkeYowlhb
 nnXhVaXrL1A825zOAQhbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7XvCRLAR/yA=:YWmaquhJnOP39u3Q2OfKZF
 KV+jmjtXHIOw24VZvKQbW6Sh733XrOmMKa9r6wGxBc/iz6UNjG7/MK0T+wydjpHYXbVp6/nvm
 lj5PBy7rQsTsa2xVeZVe01L2YOeIumv8xXrnnXr/web6DD7M6lJAPtVBsHQRcwgH2XzA/BjTJ
 tKusiF9wiFzHNxKAOm6cMJijNaPlMV9CYpp1o2IfZzcxUFlqrzsb8RyUG4pISbjM3JAweNnQQ
 xN8ClU2WxAkx+zV9wZDGzQB9EdkcWqj+c3cGhDkczZo0w+VHs1zCIoG77ELKEn0NdhzaqHGPF
 RE0Twr48NYEKq2KOfYfNIfcOCw+MpwTQ5eW3y4tlZhvYePpbTM+caxczh4Ng58zFh+u8HmxWq
 rC2CYEI4BJCd9ttl7rMU0sWFIOXQqp8TJex8JMz9BTq7BsoGFWSaUO1dxxPfAZltnELEVs+6w
 xy6W6frAlaT6cY6lS+xPacN3Rv1wMtlZNB99WA92yq13BaqCZRy2DXhmwZiHGyCkltPsflVUT
 5HvB2Os3vOwypj05v4z3XPmu1TWVkE86QDyJJXIO4lNEpfkWLPE9odylkCeDLIGfuXa+fo3k/
 RbDnGngw9Q4E3ss256RN3T2Dfpu2uDWsJ45N5BpIAihMh1RJkHq58BvbaUElJHG7DFmkQRDKB
 ATjvko+Mtx8nY++4wTUfB4r6N6VgEoQ33j7Afz2acvSFtFx9m2N0dz6sx74bojwso5dcarne2
 RkYXucrf54ei1TwVmwFaMcova92E1LOiOzI8ZCMs70XHGWx8WpmwOZwhR5dJ9/AQqsRfKm9W6
 pCa9g/yKClGjKTWCSRqOzSRDw7tLmVy7of5P7iyGoxDBaHqL2mlG4inxsa+/0Q0ZSEzdwxq
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 12:23:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 05/05/2020 à 23:38, Sid Manning a écrit :
> I’m looking at a testcase failure when my target uses 64bit time in
> msg.h (struct msqid_ds).  I’ve been able to get around this but changing
> target_msqid_ds like so:
> 
> 
> @@ -3900,18 +3901,9 @@ static inline abi_long do_semop(int semid,
> abi_long ptr,
> unsigned nsops)
>  struct target_msqid_ds
>  {
>      struct target_ipc_perm msg_perm;
> -    abi_ulong msg_stime;
> -#if TARGET_ABI_BITS == 32
> -    abi_ulong __unused1;
> -#endif
> -    abi_ulong msg_rtime;
> -#if TARGET_ABI_BITS == 32
> -    abi_ulong __unused2;
> -#endif
> -    abi_ulong msg_ctime;
> -#if TARGET_ABI_BITS == 32
> -    abi_ulong __unused3;
> -#endif
> +    abi_ullong msg_stime;
> +    abi_ullong msg_rtime;
> +    abi_ullong msg_ctime;
>      abi_ulong __msg_cbytes;
>      abi_ulong msg_qnum;
>      abi_ulong msg_qbytes;
> 
> It seems like either should have worked but I get garbage back in some
> of the elements below msg_time fields without the change.
> 
> If time_t is 64bits then it seems like stime/rtime/ctime should be
> abi_ullong.
> 
> My target is Hexagon and the TARGET_ABI_BITS is 32.

The structure has been changed into the kernel for the y2038 and the
change has not been reflected into qemu (and it needs).

See kernel commit:

c2ab975c30f0 ("y2038: ipc: Report long times to user space")

Thanks,
Laurent

