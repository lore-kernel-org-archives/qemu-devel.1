Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86F6C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C0320645
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C0320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFEy-0002bL-KC
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 05:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37877)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiFE3-00020i-8X
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiFE1-0004Zy-8W
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:37:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiFDy-0004XI-Jz
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:37:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so16968675wrm.8
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 02:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Q8RWJYyCw3CbRKDqKY7Vc9QfleR2sokn3SYWdrd5hk=;
 b=Ib436UOzfYyrOBH3SuYmtldZHRzNKoa6KObaUJIcgDZa6RN+Ss77RTmMuSLaLRfxQU
 7K2gAO1X51VT4k9gvct/rRKPMRVEuAhGo4rAYNwgn0fxE6YhL/X0hwWZ5Cg4Zxqu/EHS
 3PcoMQMa0JqBJSvS8o6bXemoinNs//MLRLsHutnEmJa/wn+kKNaVkoQqNeHJCwHbsQ2v
 X6ilYC7b50xLkiZ3AH99JzDMVpNiOO1FX7AfHi/7ZzJxXOk/e7m8P326bfGhdwY+3wfC
 sPpMbDLdvLOazXzhTblM0PmIXfUAM1BxVTRZxfFo8gE/BNZ7RgaWCgcRKVNa3ttR/dDO
 8s3w==
X-Gm-Message-State: APjAAAU8rk+CK/hscsn/Pm8iBbMLEyeyUspL5S//9EB7nOCEU/Tv8vrl
 UeyJzo9j5pp+FhZCIs85tveDmg==
X-Google-Smtp-Source: APXvYqyU+yRZgB24icv2aoJHZDnYxuWzzFwkyoaGCc8B4ml2tRj8SLH8vGpniPKDdKrMO82kg6jcTw==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr2848183wrw.113.1562060228839; 
 Tue, 02 Jul 2019 02:37:08 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id j16sm2781671wrt.88.2019.07.02.02.37.07
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 02:37:08 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
References: <20190702001301.4768-1-philmd@redhat.com>
 <20190702001301.4768-6-philmd@redhat.com>
 <5163b3e4-f68e-dc6b-3fcc-e7927ebc58e7@redhat.com>
 <CAFEAcA_n3BpZuBPFS8y90XaOwzAo-tuKpO24_apz+9yzpxUxHQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <633b88d8-88d0-3fa0-ff25-63935d8806fe@redhat.com>
Date: Tue, 2 Jul 2019 11:37:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_n3BpZuBPFS8y90XaOwzAo-tuKpO24_apz+9yzpxUxHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 5/9] hw/block/pflash_cfi01: Add the
 DeviceReset() handler
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc <qemu-ppc@nongnu.org>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/19 11:23 AM, Peter Maydell wrote:
> On Tue, 2 Jul 2019 at 04:16, John Snow <jsnow@redhat.com> wrote:
>> Does reset always get called as part of realize, really?
>>
>> Or are we just trusting that the device is probably going to get reset
>> by the guest during bringup?
> 
> Reset is not called "as part of realize", but it is guaranteed
> to be called after realize and before we try to run the guest,
> as long as the device is in the qbus tree. Things are in the
> qbus tree if either:
>  * they're plugged into something already in the tree (eg
>    pci devices, scsi disks)
>  * they're a sysbus device (which is automatically plugged into
>    the 'main system bus' which is effectively the root of the
>    qbus tree)
> 
> In this case TYPE_PFLASH_CFI01 is a subclass of TYPE_SYS_BUS_DEVICE,
> so it will always be reset as part of system reset.
> 
> (the main things which don't get automatically reset are direct
> subclasses of TYPE_DEVICE, notably CPU objects.)

Thanks for the clarification!

I will update the commit description paraphrasing Peter:

  The TYPE_DEVICE interface provides a DeviceReset handler.
  This pflash device is a subclass of TYPE_SYS_BUS_DEVICE (which
  is a subclass of TYPE_DEVICE).
  SYS_BUS devices are automatically plugged into the 'main system
  bus', which is the root of the qbus tree.
  Devices in the qbus tree are guaranteed to have their reset()
  handler called after realize() and before we try to run the guest.

  To avoid incoherent states when the machine resets (see but report
  below), factor out the reset code into pflash_cfi01_system_reset,
  and register the method as a device reset callback.

John, Laszlo, is that OK with you?

Thanks,

Phil.

