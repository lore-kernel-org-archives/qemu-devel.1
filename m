Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E81C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF44206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fs6rfIvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF44206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTLtT-0005gC-Mp
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 04:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTLqM-0003bO-Hv
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTLm1-0005bC-Ug
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:40:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38317
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jTLLH-0007Ki-KC
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588061506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2WSghkShCxIWYjkzOczpfaiRkm/PcShyED4aIyEyoY=;
 b=Fs6rfIvTzfnk5ZQz6Jc+tVlt4DVCApgXm3L6y8nIh6ymAAvm+VH7XFnPsT7grvN75yP8Vi
 T9sD1Z2HqvMQLY1Pf8NHFAz/s2Y2VZA4Ldfk6dkmQqMBugbZ8CZuYNsd79qwJdNZqGlJuW
 SW0T55IbmWKCO4mNUALUHovx6vrTpSk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-cksdQLPiMqWNQzCABarZGQ-1; Tue, 28 Apr 2020 04:11:42 -0400
X-MC-Unique: cksdQLPiMqWNQzCABarZGQ-1
Received: by mail-ej1-f72.google.com with SMTP id q25so12531058ejz.21
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 01:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QvoQ9kzrgNjLHac1nVVG5bQDC/ypENCAVc25EKXxS04=;
 b=Kom3q1cOpD7BCKFrv8ywMdBsbBt6x/ZnGBRrp7+iYiwqVyku8vJR4WufSFgp7fHvXy
 pJLjeJD+UDHEV7KjYT5R4Y69H+mxa5zGjcr/8Y/dsYEHGVRBaX6YzFPAsaSkxDvhpaV6
 MP2gKJBD3OXBmU/EZpwhuoDi7D6fEiQG3exGj3jXo//UX73+8c9X0VP/IsLzhHrIk1ve
 XY+dsCQSRQQP+Z5ow0R+Kmt+EkGJD0q7b4dPrduMGSGPaHPthUchqPfU82acjd026i6D
 u2Q+6/Sli/qgDfQ3P8DFiLAoH8zxClOL27DQm6K15feDfwKIMiYg9ww63388L0HjQq3q
 xx7g==
X-Gm-Message-State: AGi0PuZKUc1nAGNr7aTGGnioW66KCGQz/gxekZYl/a43syCXMaRTiS9q
 tJ7oSsW4LQagisZcZHySOAZp4eLJct7o4TrgsYrm/ZYeKhoRlxkLTI2bjoX06d6QLZbOIYS/K0j
 MhQKN+zijmvS0I+4=
X-Received: by 2002:a17:906:7e5a:: with SMTP id
 z26mr24334169ejr.168.1588061501285; 
 Tue, 28 Apr 2020 01:11:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypLUt9EByc1fI8snnCHvWmtDHt5d+/cXGv7+S+RsBIweKmNhlnLPNl/DMpBzmIOUhM9YN78hVQ==
X-Received: by 2002:a17:906:7e5a:: with SMTP id
 z26mr24334148ejr.168.1588061500994; 
 Tue, 28 Apr 2020 01:11:40 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id e16sm390193eja.58.2020.04.28.01.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2020 01:11:40 -0700 (PDT)
Subject: Re: [PATCH v2] [Qemu-devel] target/i386: HAX: Enable ROM/ROM device
 memory region support
To: Colin Xu <colin.xu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <1585538712-28300-1-git-send-email-hang.yuan@linux.intel.com>
 <54b6f6c0-6419-2bc2-c915-9c7a83ab8dea@intel.com>
 <alpine.LNX.2.22.419.2004281043520.5289@coxu-arch-shz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <74454205-5a9b-29af-5b7f-44a3d22fc4e9@redhat.com>
Date: Tue, 28 Apr 2020 10:11:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.22.419.2004281043520.5289@coxu-arch-shz>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: "hang.yuan@linux.intel.com" <hang.yuan@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wang,
 Wenchao" <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 4:45 AM, Colin Xu wrote:
>=20
> Hi Paolo,
>=20
> Would you please queue this one?
> --=20
> Best Regards,
> Colin Xu
>=20
> On Mon, 30 Mar 2020, Colin Xu wrote:
>=20
>> Looks good to me.
>>
>> Reviewed-by: Colin Xu <colin.xu@intel.com>
>>
>> On 2020-03-30 11:25, hang.yuan@linux.intel.com wrote:
>>> From: Hang Yuan <hang.yuan@linux.intel.com>
>>>
>>> Add ROM and ROM device memory region support in HAX. Their memory=20
>>> region is
>>> read only and write access will generate EPT violation. The violation=
=20
>>> will be
>>> handled in the HAX kernel with the following patch.

"will be"? This patch is 10 months old.

>>>
>>> https://github.com/intel/haxm/commit/33ceea09a1655fca12c47f1e112b1d2693=
57ff28=20
>>>
>>>
>>> v2: fix coding style problems

^ This line goes ...

>>>
>>> Signed-off-by: Hang Yuan <hang.yuan@linux.intel.com>
>>> ---

... here after the '---'.

>>> =A0 target/i386/hax-mem.c | 11 ++++-------
>>> =A0 1 file changed, 4 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
>>> index 6bb5a24917..a8bfd37977 100644
>>> --- a/target/i386/hax-mem.c
>>> +++ b/target/i386/hax-mem.c
>>> @@ -175,13 +175,10 @@ static void=20
>>> hax_process_section(MemoryRegionSection *section, uint8_t flags)
>>> =A0=A0=A0=A0=A0 uint64_t host_va;
>>> =A0=A0=A0=A0=A0 uint32_t max_mapping_size;
>>>
>>> -=A0=A0=A0 /* We only care about RAM and ROM regions */
>>> -=A0=A0=A0 if (!memory_region_is_ram(mr)) {
>>> -=A0=A0=A0=A0=A0=A0=A0 if (memory_region_is_romd(mr)) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* HAXM kernel module does not suppo=
rt ROMD yet=A0 */
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 warn_report("Ignoring ROMD region 0x=
%016" PRIx64=20
>>> "->0x%016" PRIx64,
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
start_pa, start_pa + size);

Don't you need to check for some kmod version before removing this check?

>>> -=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0 /* We only care about RAM/ROM regions and ROM device */
>>> +=A0=A0=A0 if (memory_region_is_rom(mr) || (memory_region_is_romd(mr)))=
 {

Redundant parenthesis.

>>> +=A0=A0=A0=A0=A0=A0=A0 flags |=3D HAX_RAM_INFO_ROM;
>>> +=A0=A0=A0 } else if (!memory_region_is_ram(mr)) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
>>> =A0=A0=A0=A0=A0 }

If you move the 'if (RAM) return' first, the code becomes easier to review.

>>>
>>
>> --=20
>> Best Regards,
>> Colin Xu
>>
>>
>>
>=20


