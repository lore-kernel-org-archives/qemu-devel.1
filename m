Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ADCC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 11:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1068521925
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 11:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1068521925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKLHq-0005Q8-8k
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 07:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKLGh-0004lb-Aa
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKLGe-0006Tf-Sx
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:45:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKLGe-0006T2-KO
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:45:32 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4EBC04627A
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 11:45:31 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id k4so10029204wru.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 04:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QKKvDqcNm8JF272IU03N/4cEE5uYgO8nCqnv1gKUb70=;
 b=KdNm7/FJIEODzN+bc5LEd13LVVQNiaqSbi/9OiJBLXx3/m7NVEhImtjZlNCFn5bd1Q
 yLJhiUc3yG8dJto9M1T0wpUVbzX2Hh7QggCTYhFy/EI9dHSU6a6Lh/4wV5tiovzEuLuV
 DRMaBTzOsbVGLWCRNgqe7vAnNAG2LqcRJqKsWlrI4ev+vVJZeAluBRRWNVCt5BK9+5+Q
 qspQ5lprLolSitzMVot3KtINOhaVcc2wXwAHT6jG/ev4zQRuAvYiRRfjePESjWeugP5c
 BJ7TzCs0bgczJO+5Go9yNSFNL9/vjL6KbBXRgr6Yn0pN/hZ/blcKYDYSA0yIecA0r7Mm
 Dfww==
X-Gm-Message-State: APjAAAXYpaM5yZrveGMSp31drto356z9GAMkqTbpHB3GIQqYv4cxXVng
 6cJF0Jg0eDqqyuyPl9lHqkZKlhX3p1l42wufEeANXgCNYqfGRocaIxKtrtGPHE/XOdZSicFKIpJ
 btk1AWrruw8KQdgo=
X-Received: by 2002:a1c:1f54:: with SMTP id f81mr19923540wmf.142.1571139928254; 
 Tue, 15 Oct 2019 04:45:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqycgHhvQLFLhpYXyWNlKaoRipWtgL6ZwwwRFwYdZhlzYGmjQDBQM/WCd08n7Y/qWHWioEaQZQ==
X-Received: by 2002:a1c:1f54:: with SMTP id f81mr19923509wmf.142.1571139928042; 
 Tue, 15 Oct 2019 04:45:28 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id v6sm42918944wma.24.2019.10.15.04.45.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2019 04:45:27 -0700 (PDT)
Subject: Re: [PATCH v9 15/15] MAINTAINERS: add microvm related files
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191015112346.45554-1-slp@redhat.com>
 <20191015112346.45554-16-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8ea3fa7c-82c7-72a6-7232-7ceab4f2f03f@redhat.com>
Date: Tue, 15 Oct 2019 13:45:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191015112346.45554-16-slp@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/19 1:23 PM, Sergio Lopez wrote:
> Add a new "Microvm" section under "X86 Machines" with the new files
> related to this machine type.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   MAINTAINERS | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe4dc51b08..9744f07727 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1275,6 +1275,16 @@ F: include/hw/timer/hpet.h
>   F: include/hw/timer/i8254*
>   F: include/hw/timer/mc146818rtc*
>   
> +Microvm

Since it is written "microvm" in the documentation, you can use this 
form here too, it won't be an exception:

$ egrep '^[a-z]' MAINTAINERS
i.MX25 PDK
i.MX31 (kzm)
nSeries
milkymist
an5206
mcf5208
petalogix_s3adsp1800
petalogix_ml605
or1k-sim
e500
mpc8544ds
sPAPR
virtex_ml507
sam460ex
sim
ppc4xx
vfio-ccw
vfio-ap
vhost
virtio
virtio-9p
virtio-blk
virtio-ccw
virtio-input
virtio-serial
virtio-rng
virtio-crypto
nvme
megasas
e1000x
e1000e
eepro100
ramfb
virtio-gpu
vhost-user-gpu
qtest
elf2dmp
i386 TCG target
iSCSI
blklogwrites
blkverify
bochs
cloop
dmg
parallels
qed
raw
qcow2
qcow
blkdebug
vpc
vvfat

> +M: Sergio Lopez <slp@redhat.com>
> +M: Paolo Bonzini <pbonzini@redhat.com>
> +S: Maintained
> +F: docs/microvm.rst
> +F: hw/i386/microvm.c
> +F: include/hw/i386/microvm.h
> +F: roms/qboot
> +F: pc-bios/bios-microvm.bin
> +
>   Machine core
>   M: Eduardo Habkost <ehabkost@redhat.com>
>   M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> 

