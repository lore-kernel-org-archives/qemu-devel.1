Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB80C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC03206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC03206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6tY-0003jH-Ud
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kD6sF-0001ne-7m
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:02:59 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kD6s9-0002bP-96
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:02:58 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MnJdC-1kuArk22FA-00jMIr; Tue, 01 Sep 2020 16:02:48 +0200
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200831110716.536808-1-laurent@vivier.eu>
 <CAFEAcA88ZzORi0FYKevoGkoRAoUHuT=-GXKuYjvx-uBCNJBeyg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PULL 0/8] Linux user for 5.2 patches
Message-ID: <e5c66f3d-9234-f5cc-0dad-18f1a2ba4490@vivier.eu>
Date: Tue, 1 Sep 2020 16:02:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA88ZzORi0FYKevoGkoRAoUHuT=-GXKuYjvx-uBCNJBeyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:W5+uzWbP3P+6Qxg51fIEtgvA12Lh+v+A2RloQls1Hu/mSxTmX+I
 vSkyZ9u3PriMNIALz/T7kqUdSZd09VqbTstUFQQje4BJB925Ui0dnMfFddVRbAtTNJObrx0
 k3FBHp+5UqCLwDJiNw0dmhUfh7gn/lBq/JVV8I/0iJC/g02tEkwXFm484aML4uoASxYInGW
 QHtg032ewXmuMVklXQ0HQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KEFJQp9zDZM=:6Rfo87QOVdna3tkxXtsi8H
 SNmd8GFjTR/SgB7xJT4EmHTrjjlCr55PNXlDqelrs6qLGuwgPX0nFRdsVZXgXhdeMMiSJW2mq
 8SD50DhoRureDmBUbaSQ6DQZ/ry0kf0VNa6SrJWyRa6L9xvJLcq8ijo1WxZxdTzNuZd1VrUHR
 vA0nkNnJxKofigBS6KNHd80f2R3LTuipx0jd9p92C4csnAbPCZmBxR1vY2HG8zzZVCZIU5neI
 9ISRyEAFTHQBTZTmSTsiJTIpSq05ktuxV45g6iW/j+Zcn9EO6+Zm48X1/OYLwU60Jx8ynootf
 4TD9LsVvuOtDDObZCEgb7x9tXbSDkGuxIMobbz4yzVaIWQprLAqtD9ZI8F2gr8hKpUVMEXLD6
 Us7rbgr+L5jLsjI2LFmo2WFgTcpSMVcsu1NamZbpTjq4CBV/dsuHTI8yL5jkuVGoAAQ/pO/Sh
 +nDBx1nqnVeAHPnWWH8Q8h5vMceWr9jt59s2MEzcfHFJktT7USJBxXtfOKrwf1l2fEbM2iHKr
 vkYn+wXOV/m2XRTr/eiM0TMKhQ6RAwbgXopO8ueWv5aZoE+n/iNHAclYm6Z5JvuFXeuAVnSgZ
 6k5M513RtUWKRb7MrV8bYGeycwUA0z2j7Q2mCPFpcYXeD1wATlE9XbNyXGrsslF697nPWcc4m
 hyf297u3XA6Q+pNMDXmnIMTKqydg1piktQA/ycvX4FMuuRiy3S6PqjkQYV2NoG3t7Ssb5LfLh
 6v3YAP5Ud0lI15mqqJFbGnCqHVdkRKQvxDAGd9GGC22YRkWhfCtBEJExhjck7qfWXdQGaj08M
 Ri2S0ZHIySepH87LyiN+Xb2ShCBV6vzCBulfXci17o6qpQMb30yTByOO/S8Nnr/CvWBj0lA
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:02:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 01/09/2020 à 15:06, Peter Maydell a écrit :
> On Mon, 31 Aug 2020 at 12:08, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit 39335fab59e11cfda9b7cf63929825db2dd3a3e0:
>>
>>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pull-=
>> request' into staging (2020-08-28 22:30:11 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request
>>
>> for you to fetch changes up to d6676fc62a52e020df32abf927c2e7183781a2e3:
>>
>>   linux-user: Add support for btrfs ioctls used to scrub a filesystem (2020-0=
>> 8-29 10:14:52 +0200)
>>
>> ----------------------------------------------------------------
>> Add btrfs support
> 
> Fails to build with clang, I'm afraid:
> 
> In file included from ../../linux-user/syscall.c:4561:
> ../../linux-user/syscall_types.h:485:33: error: implicit conversion
> from enumeration type 'enum btrfs_dev_stat_values' to different
> enumeration type 'argtype' (aka 'enum argtype')
> [-Werror,-Wenum-conversion]
>        MK_ARRAY(TYPE_ULONGLONG, BTRFS_DEV_STAT_VALUES_MAX), /* values */
>        ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/petmay01/linaro/qemu-for-merges/include/exec/user/thunk.h:45:42:
> note: expanded from macro 'MK_ARRAY'
> #define MK_ARRAY(type, size) TYPE_ARRAY, size, type
>                                          ^~~~
> ../../linux-user/syscall.c:4559:79: note: expanded from macro 'STRUCT'
> #define STRUCT(name, ...) static const argtype struct_ ## name ##
> _def[] = {  __VA_ARGS__, TYPE_NULL };
> 
>     ~  ^~~~~~~~~~~
> 1 error generated.
> 

Thank you Peter.

I think the fix might be to introduce a new patch to cast "size" to
"unsigned int" in:

    #define MK_ARRAY(type, size) TYPE_ARRAY, size, type

as size in the case of btrfs is BTRFS_DEV_STAT_VALUES_MAX that is
defined as an enum of btrfs_dev_stat_values, and MK_ARRAY() values are
put in an array of argtype enum.

Laurent

