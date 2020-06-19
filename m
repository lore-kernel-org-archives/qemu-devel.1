Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28118C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E516421D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBDm7hCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E516421D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmIV3-0000tv-6f
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmIUL-0000QS-0W
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:59:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21431
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmIUI-0004zy-L3
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592578764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zkEPXXVb2uQc1CQ0d4NrOJpMxWbJnfObQscqAlNTRak=;
 b=TBDm7hCtBhOPJbnlUVm5lv1bau3lHGmcpcam3PCg+7C4/D7rKnIe3APAfYANhMD2sORZuM
 qJEfPv2jxgpCpZSTPVxNg4donQ51XMHv3RYRANfyMofSGYEY366zyViDeSDe0tfCDKUwXr
 HSgcUVPp4XrmNtnhckWCcicDocJzhrk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-wmFAYI-lOFKPNkjrynFuhA-1; Fri, 19 Jun 2020 10:59:23 -0400
X-MC-Unique: wmFAYI-lOFKPNkjrynFuhA-1
Received: by mail-wm1-f71.google.com with SMTP id v24so4067217wmh.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 07:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Li43D/GxwfC5KjJjrb/5440gG3IN0LqUncP145w/BCM=;
 b=DH+CXPsbisy4vbLhLIprWJWeXIFaerzJaVi7i2PQYn153Drlrp3GkaiFTdOnNn2bkc
 LWQho/sdw6409kZS20MjVTsik4olNEBSfHBGgQ8UAyA15i6yxbVu1rWaHb2ktqDKayC+
 jsvkOG2Azne+ZUPJnDsTwIJXCrgITVhR3iSU6dYIDzVdhhtC8FZkQqv8s7yDRVgpNyQ4
 S7VMsBIZSXcOfhsZWe4XUzNEsNdZAUiPzRUzvtGL5n8NHlYc7y4WcWEMdmtprMLY85sz
 IlZfRsu5WcEFTIaFNBak1bnMN7pNBY1aKc6UrkQkbHxZODDjUsSvc2VEXqV3AqD+JiSv
 /Xnw==
X-Gm-Message-State: AOAM533TO/TUExdtfuM4e/W3snrI0Il37PFmOX8YCxR/XIpAublXx7lV
 IpgFPYSB2ayf2UqGI4qHjJM0McDCaY571smGD99f79vmUcImgE0U5iz2bjfHdpHN9iohqtIKpmR
 q+ufEJsox3GqaCP4=
X-Received: by 2002:adf:9dd0:: with SMTP id q16mr4809000wre.410.1592578761797; 
 Fri, 19 Jun 2020 07:59:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyx0FUPnrLJVuEzfEDSVrxCSYniHX7/RiqaTJtMS55yrtHjGaVNlbZOxIykokiBERo2YoWFgg==
X-Received: by 2002:adf:9dd0:: with SMTP id q16mr4808982wre.410.1592578761579; 
 Fri, 19 Jun 2020 07:59:21 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id h7sm7421915wml.24.2020.06.19.07.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 07:59:21 -0700 (PDT)
Subject: Re: how to build QEMU with the peripheral device modules
To: casmac <climber.cui@qq.com>, qemu-devel <qemu-devel@nongnu.org>
References: <tencent_2BB56CF9C4F3AA4DBB9D8A50C3BFBDCA720A@qq.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <00d27d39-e82d-103c-eac8-01313e3b365f@redhat.com>
Date: Fri, 19 Jun 2020 16:59:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <tencent_2BB56CF9C4F3AA4DBB9D8A50C3BFBDCA720A@qq.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Hi,

On 6/19/20 3:24 PM, casmac wrote:
> Hi All,
>    I am trying to add a DMA peripheral module. In hw/dma directory, a
> file  ti_dma.c is added.
>    Also, in hw/dma/kconfig, I added the following lines:
> config TI_DMA
> bool

You need some device that 'selects' your device.

You can select it by default:

  config TI_DMA
      bool
      default y

You can enforce the selection on a target. For example to add it
to all the ARM machines, in default-configs/arm-softmmu.mak add:

CONFIG_TI_DMA=y

The best is to only select it when required. For example if you
need it on all machines using a TI OMAP SoC, then you'd select it
in the OMAP section of hw/arm/Kconfig:

  config OMAP
      bool
      select FRAMEBUFFER
      select I2C
      select ECC
      select NAND
      select PFLASH_CFI01
      select SD
      select SERIAL
      select TI_DMA

You should have enough to adapt to your needs.

Regards,

Phil.

>    In hw/dma/makefile.ojb, added one line:
> common-obj-$(CONFIG_TI_DMA) += ti_dma.o
>    However, ti_dma.c is not compiled as the QEMU project is built. Some
> directories(eg. block, cpu...) under hw will be compiled though. 
>    The makefile.obj seems to show that the DMA module would be built
> along with  others:
> devices-dirs-y = core/
> ifeq ($(CONFIG_SOFTMMU), y)
> devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call
> land,$(CONFIG_VIRTFS),$(CONFIG_XEN))) += 9pfs/
> devices-dirs-y += acpi/
> devices-dirs-y += adc/
> devices-dirs-y += audio/
> devices-dirs-y += block/
> devices-dirs-y += bt/
> devices-dirs-y += char/
> devices-dirs-y += cpu/
> devices-dirs-y += display/
> devices-dirs-y += dma/
> devices-dirs-y += gpio/
> ......
>     I am not sure what is missing here. Any advise would be appreciated.
> Thanks.
> 
> xiaolei


