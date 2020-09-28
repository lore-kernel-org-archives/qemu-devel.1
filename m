Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4CBC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C3B207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="LYV1nXtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C3B207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMop5-0005CK-5X
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 04:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien.hedde@greensocs.com>)
 id 1kMomT-000316-C3
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:45:09 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:39598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien.hedde@greensocs.com>)
 id 1kMomR-000716-HD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:45:08 -0400
Received: from [172.16.11.103] (unknown [172.16.11.103])
 by beetle.greensocs.com (Postfix) with ESMTPSA id E4CA921C3A;
 Mon, 28 Sep 2020 08:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1601282705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zvmd+9MFsza4wqZ1fI0GTSE3KfEuSScmfs1gO4a6hF4=;
 b=LYV1nXtuatt4IbSV6Dh9LNt8bNVcWRYPTGgS5GVFiyogq8Lw9arXWDKPjQgVSHExqw8hcb
 MImMPIZ52g9PmRD8uEFXB23XCv3dwWjOvfjm+Ddlz3Y5lGv6koofFeP4mIdSfnxoDjYUr/
 LeJwHc4/nCAfxgz9U4IecV/0hB1QR9o=
Subject: Re: [PATCH 2/3] qdev-monitor: Display frequencies scaled to SI unit
To: Luc Michel <luc@lmichel.fr>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
References: <20200927090820.61859-1-f4bug@amsat.org>
 <20200927090820.61859-3-f4bug@amsat.org>
 <20200928075210.u6vh4py7vtozpbyw@sekoia-pc.home.lmichel.fr>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <e54f19ec-6062-4848-757a-2d279d335d90@greensocs.com>
Date: Mon, 28 Sep 2020 10:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928075210.u6vh4py7vtozpbyw@sekoia-pc.home.lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=damien.hedde@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 04:38:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.011,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>, qemu-devel@nongnu.org,
 Tyrone Ting <kfting@nuvoton.com>, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/28/20 9:52 AM, Luc Michel wrote:
> On 11:08 Sun 27 Sep     , Philippe Mathieu-Daudé wrote:
>> Since commit 9f2ff99c7f2 ("qdev-monitor: print the device's clock
>> with info qtree") we can display the clock frequencies in the
>> monitor. Use the recently introduced freq_to_str() to display
>> the frequencies using the closest SI unit (human friendlier).
>>
>> Before:
>>
>>   (qemu) info qtree
>>   [...]
>>   dev: xilinx,zynq_slcr, id ""
>>     clock-in "ps_clk" freq_hz=3.333333e+07
>>     mmio 00000000f8000000/0000000000001000
>>
>> After:
>>
>>   dev: xilinx,zynq_slcr, id ""
>>     clock-in "ps_clk" freq_hz=33.3 MHz
>>     mmio 00000000f8000000/0000000000001000
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Reviewed-by: Luc Michel <luc@lmichel.fr>

Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
> 
>> ---
>>  qdev-monitor.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>> index e9b7228480d..a0301cfca81 100644
>> --- a/qdev-monitor.c
>> +++ b/qdev-monitor.c
>> @@ -747,11 +747,13 @@ static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
>>          }
>>      }
>>      QLIST_FOREACH(ncl, &dev->clocks, node) {
>> -        qdev_printf("clock-%s%s \"%s\" freq_hz=%e\n",
>> +        g_autofree char *freq = NULL;
>> +
>> +        freq = freq_to_str(clock_get_hz(ncl->clock));
>> +        qdev_printf("clock-%s%s \"%s\" freq_hz=%s\n",
>>                      ncl->output ? "out" : "in",
>>                      ncl->alias ? " (alias)" : "",
>> -                    ncl->name,
>> -                    CLOCK_PERIOD_TO_HZ(1.0 * clock_get(ncl->clock)));
>> +                    ncl->name, freq);
>>      }
>>      class = object_get_class(OBJECT(dev));
>>      do {
>> -- 
>> 2.26.2
>>

