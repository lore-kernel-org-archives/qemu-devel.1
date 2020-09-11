Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A9CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F903221EF
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F903221EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGd57-0004Wy-K1
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 03:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGd4P-0003xF-QL; Fri, 11 Sep 2020 03:02:05 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGd4N-0006O0-RE; Fri, 11 Sep 2020 03:02:05 -0400
Received: from [192.168.100.1] ([82.252.148.206]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MHG4c-1kL0mk3g2a-00DKlQ; Fri, 11 Sep 2020 09:01:43 +0200
Subject: Re: elf2dmp: Fix memory leak on main() error paths
To: Thomas Huth <thuth@redhat.com>, AlexChen <alex.chen@huawei.com>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>
References: <5F463659.8080101@huawei.com>
 <c9a661c3-7a86-8ae7-6304-6110d0bfb461@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7467ade8-25c8-509c-f766-1af6bce3a729@vivier.eu>
Date: Fri, 11 Sep 2020 09:01:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c9a661c3-7a86-8ae7-6304-6110d0bfb461@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/MO0KaQef5SeKR9Z3AJzptBjJPyCtpdsu9AS2M6mzx/kTL6PS6p
 2tkYIteb8GnwL4FzlA5FqzXZK2v4gwUp1d/DcjLUqrYaN5VLffYOc8RnV2YRgqgn4Jw3i2M
 seGVJwhN8g+ApGM33y3X+aJLy2i2BClcnZO/3thFST6S9hZSEbAsIWG4/YA0MhnnDk8pFDn
 YmlGG+i0+qZIc/OvYqEUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6FbZLTQ/cwk=:RcH+NoafOIQtDRzkmLEF4i
 tQt3PYdXGrLsyvN9D9Zcxlyd+ElfNmJL0F6+2YuMcROGeM+4+GWOjyngmGWAlNmLshS2Sk4uL
 7WUl6oAhybU+l9JmCQEoEwbcBJ8d+HbQ47Lp5WYNC8YFxSGEUbbJaE6eo5sRZQIZogF/bLN3t
 hrOehRdkbTxlgifUHpsGF34ki9m0F1L4VwFU0ZsH8wUzbwtfl9bcdH5j0BDfEsv392Hmno/Cn
 71pC/e0q1UKvQgzwsIXVsGzFW9IRKelFnMyTL5tQ1wZ86DoWV9lrcHAl3idTV9k7BbLoBJrxJ
 j5YJnIQV9aswI2SbAYjOQNqhaTfsn2ih5h6/19+hYOrT8TL+gC2PgCooM1de2DnKg3Dv+3FTl
 lysTxgt9XmxxxVTJyxQ8CrJQwmoLEMBDOoQSjNZiBqqgLe3SFZAYBnSjeLQHUI64/Tm8M5Fbw
 zaK+RghG6OLjleqk+PVQbcxlgzf+pffOtlrKSg/HZd2hjRpYS8GupgfWlXBSKNZy0uRI0KH+z
 6Q6BcuJq8UqQa8GQ0DQjo4/ButLMhwLsHtD/7cw5OU7dd/ntYTUwwSRFVXl6i76X+3MQwfZUV
 MtTRz9Cyd3c5fQY1gcEqiOFb68r4AbF3ZEMC9qJGGbeH3Uo476KQC6O7535VIPZQ86xAUZZDN
 zilfzAQm/oWaqdwTid13NtjFYxBuwuIDz+iaBEU7TZNRd75ncU7sv47qM/Up7RMPfEeMiZNSf
 B7h+xzuFVSyTBbqjjMoy6M0Kiq6U4N/ewMkbZAtKgaFnNRtPfYF7nLJrm3cYJOCwFSfbF60k/
 WuuSd2NGbon8PUGqDRdSmN3AqDiJ5wJ7mNgShEbUaKq7/gjndLu/yRUfW1MuVGrTROCoSIE
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:01:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.576,
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
Cc: zhengchuan@huawei.com, QEMU Trivial <qemu-trivial@nongnu.org>,
 zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 11/09/2020 à 06:18, Thomas Huth a écrit :
> On 26/08/2020 12.15, AlexChen wrote:
>> From: AlexChen <alex.chen@huawei.com>
>>
>> The 'kdgb' is allocating memory in get_kdbg(), but it is not freed
>> in both fill_header() and fill_context() failed branches, fix it.
>>
>> Signed-off-by: AlexChen <alex.chen@huawei.com>
>> ---
>>  contrib/elf2dmp/main.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
>> index 9a2dbc2902..ac746e49e0 100644
>> --- a/contrib/elf2dmp/main.c
>> +++ b/contrib/elf2dmp/main.c
>> @@ -568,12 +568,12 @@ int main(int argc, char *argv[])
>>      if (fill_header(&header, &ps, &vs, KdDebuggerDataBlock, kdbg,
>>              KdVersionBlock, qemu_elf.state_nr)) {
>>          err = 1;
>> -        goto out_pdb;
>> +        goto out_kdbg;
>>      }
>>
>>      if (fill_context(kdbg, &vs, &qemu_elf)) {
>>          err = 1;
>> -        goto out_pdb;
>> +        goto out_kdbg;
>>      }
>>
>>      if (write_dump(&ps, &header, argv[2])) {
>>
> 
> I think this could go via qemu-trivial (now on CC:).
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

