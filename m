Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3D8CA9EC9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 07:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986F42080F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 07:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986F42080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQR7U-0003In-QJ
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 03:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iQR6T-0002n4-UQ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 03:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iQR6R-0004sS-Sn
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 03:12:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21127)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iQR6R-0004rk-I3
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 03:12:11 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA538C05A1D0
 for <qemu-devel@nongnu.org>; Fri,  1 Nov 2019 07:12:09 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id e14so4992238wrm.21
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 00:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WA1vESrvIPhM2QrlPBcUuI4r8yAeMDTNRb3gbnonuFE=;
 b=uMZhORHxr/Jiq9hZEnLA/VCi6CNjbVDItFKdlihUmf7k/yv/aIxoegrKesdq6UX2N8
 yNxEFay/OIYZ5Dx0KNTE5iKyrv4Ue0XHD8B9/KG0cfVeWBCzcwf6t6CULMdkq1+TysRT
 FsDGYYhoLaxg3XECT7DdcGEYsgH5VTDSoxQ+8eXxZCY4klPs+PrRrxL1OFGtWjQCgXqc
 2kSrltSbeQLD1kLVb+J0hT7ixqJFV//43/1bUXlDVS0exedqGMbagyrR6CDpg4WoQvla
 QvhDKuKd75LrFTNxyW2WXtobKhqS6G4sh1K5sOskSGQ4PUE1V+ampEpq99gbqxntbACE
 OlOw==
X-Gm-Message-State: APjAAAUFNd/iuRY1R1iSnh9MXzmmcHWgpziapx6t8SFdRF8ITKNM9+iO
 LmJTJjQRXWQQzhBDlz35kYPJNJhx47sRlRjq2mUVAzlHB4w7UqMSETeiDi5Q/X2bVVC1LC4WFlE
 YlCsC7E6fFcHpmKo=
X-Received: by 2002:a5d:4142:: with SMTP id c2mr8935696wrq.208.1572592328391; 
 Fri, 01 Nov 2019 00:12:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy35/3VjcyYrLmcKlddW9MbEYkHKm/A1FXEyHXfEtjDW2niOq8bxzojcQ7OnB+cm2Qxl1/sqA==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr8935661wrq.208.1572592328112; 
 Fri, 01 Nov 2019 00:12:08 -0700 (PDT)
Received: from [192.168.20.130] (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id g14sm6819224wro.33.2019.11.01.00.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2019 00:12:07 -0700 (PDT)
Subject: Re: [PULL 1/9] IDE: deprecate ide-drive
To: Markus Armbruster <armbru@redhat.com>
References: <20191031105904.12194-1-jsnow@redhat.com>
 <20191031105904.12194-2-jsnow@redhat.com>
 <c688f160-e10e-52d1-5a54-881dd86987d4@redhat.com>
 <87tv7ojgry.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e0b1dd14-6c52-687a-6d8a-f9bf02ef50ee@redhat.com>
Date: Fri, 1 Nov 2019 08:12:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87tv7ojgry.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/11/19 06:40, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 31/10/19 11:58, John Snow wrote:
>>> It's an old compatibility shim that just delegates to ide-cd or ide-hd.
>>> I'd like to refactor these some day, and getting rid of the super-object
>>> will make that easier.
>>>
>>> Either way, we don't need this.
>>
>> Good idea.  I will prepare a similar patch for scsi-disk, even though
>> technically we're already in soft freeze; it makes no sense to deprecate
>> only one of the two.
> 
> We still use scsi-disk for -drive if=scsi,... and for the desugaring of
> the usb-storage device, via scsi_bus_legacy_add_drive().  I figure you'd
> need to either wean them off scsi-disk or deprecate them, too.

Yes, it's enough to add a bool media_cdrom argument to
scsi_bus_legacy_add_drive.

Paolo

