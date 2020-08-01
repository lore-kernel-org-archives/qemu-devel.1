Return-Path: <SRS0=xT3E=BL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6BFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 13:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FB0208A9
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 13:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Yz4q8YsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FB0208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1rM9-0006Wl-3c
	for qemu-devel@archiver.kernel.org; Sat, 01 Aug 2020 09:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k1rJ4-0005N3-F1
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 09:12:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:37241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k1rJ2-0003pF-Cq
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 09:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596287510;
 bh=mgJrx+RfUTfEX6RxCK8PTkbM4tIg6daq9WGPksyeePo=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Yz4q8YsFdQpG9YX448kPtFgrVHOYctPbCORylXett/uRjHKbYfADT17E+r6HcIOky
 1vdFyWVQdgQmizSr1eENdzeucmAMuCC3ua2H9YQpzRE+Gr3FdBGYoePK72GTdwpy3H
 v7vnJTdoIuuxTOI5/aNoTQODDyvqGUYixA0scxE0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.162.176]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fIW-1k90yC0HzG-007AQ5; Sat, 01
 Aug 2020 15:11:50 +0200
Subject: Re: [PATCH 1/4] hw/hppa: Sync hppa_hardware.h file with SeaBIOS
 sources
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200727214608.32710-1-deller@gmx.de>
 <20200727214608.32710-2-deller@gmx.de>
 <7a559501-3a8a-f778-6058-5407043bd1f7@amsat.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <ef18d47f-f37c-b93a-6921-c77d191ed7fc@gmx.de>
Date: Sat, 1 Aug 2020 15:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7a559501-3a8a-f778-6058-5407043bd1f7@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GSWDLjK6vAgQTbeGkT6X89wZHlAgEuh8UQAjhsizKdM1SGrkjgj
 pS24mN3gEC5CDZvCYbb+07e/pRAVJIdCxtb3o2AEHHF7m9tRBIU2+SDAGtH1RfeTgpXudMK
 IrA1g/WiWwXYlZ3FMKo3QhZN5uegAZBKVr1JugkO3kvw9UOW3i7e7a4BdU8ymv3Cc/s+d+J
 fEcnTngSQUTzQTWfsoWgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7da54BY1onk=:c3Cq5XLd4mE9jqTFvdQ3q3
 k0+7yTTTZBMKQfpfrCjJvexhpCr6eVWKoc05G40mexal7gjQjJWSmVKjZvnnZt7yhJtTr44+G
 qvTaP3sN12AkMbMKrpxdaX7xzJX375FVTXupQp8qH91q8mg7PC/Rw4ErBYQImMC120o9nevSr
 EVzZEBmG8Z6kMw1ARx6pbvBbNt7uubHjcOeO/0O8AYvCIQTH7RcmFIhTmGyPHu1J6Y/91vUWE
 j6zL7XZa8SaPVmLnwQ3nTorwV9qTXoK/xU1ewSCgHjCBz1yk67ObI/iwvW7O01bWs8Oj9yfDl
 7vLeeJMqhEy/I2PK8Z6vnGgryfvdxIEd/AYMUI7mETfi8ckfUZWMBMJmlKZ6nigKHSkKEIeOd
 rva/ZmeSdnCt6lQZ6A3yrnjBk7GOhlkCMl3aMEo4WOdoifhm3isuWglsnu2M5nAJ5zKPYpAQ4
 NlW9YQEW+vJFdM6ee3/rvEPm7rkUl88SMC4cefl7nlyo0bdrznzUPz34ia+0zu37cUrMdQIt8
 Wuj6jf9GSN/MSlouvgnOfGAhIaRv1ZHFnb5RfBJZsnZG3/BKhNBHeo+jTqbOQvsElcGp3uycV
 sTOdNfjpL6/NCgKGdtN5kJd/XaPdq0af2SwxWyKRr7QNzJy1VGfEvJSISud1BXbJl6qW23ozv
 RFg0LPWftW0MXlbKl3SVtzuaDhwi9Uh3d0htqNwCrnhTK/F/fqb87qaLa2eeoci7ssoSn0HVL
 uvPn80jTJKYmufRreCfzGYixJxYgerCqn5aL4LlAk0+C4eOOYrHlnsvAN2sRksKGIQThxmYHp
 eeCz7bCw4lY/nWo8+g+fX6TB2UorlZVi75NZ0Nt58de0Q59tIaaTlkbPvSg3kfizj5JjIEbwX
 OfrUcHyKzhnIhN29QnrckAqq8v8eanIPoq0zcrMiT+SU/kJUn941PodjigMhj9qQWIDzEBc3s
 hwhpfJeaax5+08u0rh/fpzm/atz5XBTk8rjv6xyHfsipIInaZP3IRHlMDFdutKx16mwIfWZGj
 Q3PC+q/MQY3iZrx2rEfMEqjUUqYXvTmOUh/FezBPJo+xgLdByIkL79zmuLBTVZVlrc2tGeiJg
 YWrf/d8l0tB/vu4tZPaCPVqf+exeeJYUzTNC+3FFKTQjnyucm/Zty/s/qjWsvYrZo/DnET2ZP
 8O5pi25Nxw3vj8PR/pydZ0q1sVEabOE2Z6hdxuFdZDpPcf1ZpLGYFUMN19G6wHKAjitFsWsL3
 uzbbeVHie7j5i3Svz
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/01 09:10:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29.07.20 20:21, Philippe Mathieu-Daud=C3=A9 wrote:
> On 7/27/20 11:46 PM, Helge Deller wrote:
>> The hppa_hardware.h file is shared with SeaBIOS. Sync it.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>>  hw/hppa/hppa_hardware.h | 6 ++++++
>>  hw/hppa/lasi.c          | 2 --
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
>> index 4a2fe2df60..cdb7fa6240 100644
>> --- a/hw/hppa/hppa_hardware.h
>> +++ b/hw/hppa/hppa_hardware.h
>> @@ -17,6 +17,7 @@
>>  #define LASI_UART_HPA   0xffd05000
>>  #define LASI_SCSI_HPA   0xffd06000
>>  #define LASI_LAN_HPA    0xffd07000
>> +#define LASI_RTC_HPA    0xffd09000
>
> I find the line you are removing cleaner:
> -#define LASI_RTC_HPA    (LASI_HPA + 0x9000)

Yes, but at least temporarily it should be consistent inside
the header file.

> "Offset in the LASI memory region".
>
> Anyway not a blocker.

Ok, thanks!

Helge


> Having these values sorted would help.
>
>>  #define LASI_LPT_HPA    0xffd02000
>>  #define LASI_AUDIO_HPA  0xffd04000
>>  #define LASI_PS2KBD_HPA 0xffd08000
>> @@ -37,10 +38,15 @@
>>  #define PORT_PCI_CMD    (PCI_HPA + DINO_PCI_ADDR)
>>  #define PORT_PCI_DATA   (PCI_HPA + DINO_CONFIG_DATA)
>>
>> +/* QEMU fw_cfg interface port */
>> +#define QEMU_FW_CFG_IO_BASE     (MEMORY_HPA + 0x80)
>> +
>>  #define PORT_SERIAL1    (DINO_UART_HPA + 0x800)
>>  #define PORT_SERIAL2    (LASI_UART_HPA + 0x800)
>>
>>  #define HPPA_MAX_CPUS   8       /* max. number of SMP CPUs */
>>  #define CPU_CLOCK_MHZ   250     /* emulate a 250 MHz CPU */
>>
>> +#define CPU_HPA_CR_REG  7       /* store CPU HPA in cr7 (SeaBIOS inter=
nal) */
>> +
>>  #endif
>> diff --git a/hw/hppa/lasi.c b/hw/hppa/lasi.c
>> index 19974034f3..ffcbb988b8 100644
>> --- a/hw/hppa/lasi.c
>> +++ b/hw/hppa/lasi.c
>> @@ -54,8 +54,6 @@
>>  #define LASI_CHIP(obj) \
>>      OBJECT_CHECK(LasiState, (obj), TYPE_LASI_CHIP)
>>
>> -#define LASI_RTC_HPA    (LASI_HPA + 0x9000)
>> -
>>  typedef struct LasiState {
>>      PCIHostState parent_obj;
>>
>> --
>> 2.21.3
>>
>>
>


