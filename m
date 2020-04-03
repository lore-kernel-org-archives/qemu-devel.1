Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC435C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8466F2082F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOJ3Vyob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8466F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKKBh-0001PC-L0
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 07:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKKAv-0000xe-ID
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKKAt-0003fa-Iq
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:07:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48358
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKKAt-0003ce-Eg
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585912065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y7+L5bWXlaisjGSV2469P+TkxrJgJahaRIkWyJKx4Is=;
 b=gOJ3VyobPoDJGi5nSVUNCGneL/jIx0otpMYFXZauJTl9n0Z00L7JY7bOk5Hfu1XEMVadQC
 l7LXG6tTM9kmY3hg6B6HwXNpzEI5E7jwob29RPBPj5xa2vH66hqmKOZZE76vZVn0iY7MmO
 uAig4uRDyLeMRXhlVlTONvq+0IAjSTE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-SElzwgBxOB2aLDomlX52BQ-1; Fri, 03 Apr 2020 07:07:40 -0400
X-MC-Unique: SElzwgBxOB2aLDomlX52BQ-1
Received: by mail-ed1-f69.google.com with SMTP id cm25so5148480edb.14
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 04:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y7+L5bWXlaisjGSV2469P+TkxrJgJahaRIkWyJKx4Is=;
 b=TEW9e++ojOV3JA9ysbquvfxPznGX+/tP9Fe5J1Um8s/siLxK9LAzaDTzqKIR4A2pKc
 7IRGLt9/E3Dv/jwCtNDt/DGT7VeVNnK0kqgzNHueRSccYf22/LGNyZztFt5tuYr+1GEb
 ran/YVMlsSCxZvAZj3U0hYFAvJ9H2dVVKMwDKGsgcb7wfFdvOLGhF/h5CaoRwO0iEsuI
 6cwLuXdG/0d9PfDrl9OT8Q5FdKU7jWCXxjM10Odm+0SlX0k/E/SnQnXOmsc85hWT7NBV
 9T5O82C4wNOk98BBCLjhoF2uWiI+DjzC6djKn8OLATdEOIKMOSzrekOd8BD0eE+GJtow
 fqag==
X-Gm-Message-State: AGi0PuYjsNvXFf1jzXNlWeVavGLFGYAHr/53+iLPnL6i1fu0KEi8gtKb
 65Dulc42zx/VjVGuFugpLX1A/KpzEl3mL4nLd30kRtcRMV5UpssKU2ur/PnSTlfxrXsa/xr4aE6
 YDDUmghZuzovdKnY=
X-Received: by 2002:a17:906:1f47:: with SMTP id
 d7mr7965809ejk.37.1585912059742; 
 Fri, 03 Apr 2020 04:07:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ4KbvAub+zY+GYC5rf4mHw6nk1OZnjY2A+Hb7Yy/IqAM2DjpDBDzQfhSoA2V2INOaRb7ldSQ==
X-Received: by 2002:a17:906:1f47:: with SMTP id
 d7mr7965774ejk.37.1585912059384; 
 Fri, 03 Apr 2020 04:07:39 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id v20sm1368424edr.85.2020.04.03.04.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 04:07:38 -0700 (PDT)
Subject: Re: Qemu doesn't detect hard drive
To: Peter Maydell <peter.maydell@linaro.org>,
 "Aijaz.Baig" <Aijaz.Baig@protonmail.com>
References: <XSF-9CLAGYMG1ivdwoihQBZm3XT2vWdKVqHtMLExgA1LJwkSeISDoKKVEJ3E3qhZaNvki44j2CdXdQ81ljytvtS0MGmXL3gFhO2kQmWA2Kk=@protonmail.com>
 <CAFEAcA_-aRethWOmzaKqft8yMg6dGUUwvf1kX36R4+R=yWS2RA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5c877825-dbf0-295e-20b7-6949e15be745@redhat.com>
Date: Fri, 3 Apr 2020 13:07:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_-aRethWOmzaKqft8yMg6dGUUwvf1kX36R4+R=yWS2RA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 9:39 AM, Peter Maydell wrote:
> On Fri, 3 Apr 2020 at 06:18, Aijaz.Baig <Aijaz.Baig@protonmail.com> wrote:
>> I would now like to add a hard disk for persistent storage and then transfer control from busybox initrd based rootfs over to the full fledged version offered with Linux. So I add it to the command line
>>
>> `sudo qemu-system-arm -m 1024M -M vexpress-a9 -D qemu.log -drive if=none,format=raw,file=disk.img -kernel buildroot-2019.02.5/output/images/zImage -dtb buildroot-2019.02.5/output/images/vexpress-v2p-ca9.dtb -append "console=ttyAMA0,115200 kgdboc=kbd,ttyAMA0,115200 ip=dhcp nokaslr" -initrd buildroot-2019.02.5/output/images/rootfs.cpio -nographic -net nic -net bridge,br=mybridge -s
> 
> This command line creates a "drive" object but doesn't plug it in to anything
> (it's like asking QEMU to model a board, with a hard drive sat next to it
> on the desk but no cable between them :-))

Should QEMU warn the user about unplugged drives?

Or is it an expected feature (these drives might be hot-plugged later?)

> 
> More generally, the vexpress-a9 board does not support hard disks.
> This is because the real hardware we're modelling here has no disk
> drive interfaces and no PCI or similar bus that you could plug a
> scsi controller into. The best it can do for storage is an SD card
> emulation, which works but the performance is not great.
> 
> thanks
> -- PMM
> 


