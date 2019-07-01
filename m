Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DE8C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DD12133D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DD12133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuwb-0006Kw-D9
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50873)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hhuvc-0005Q8-Os
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hhuvb-00042D-M0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:57:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hhuvb-0003jb-Fd
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:56:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so13513845wrt.6
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 04:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1prs6nYZxnp5WxLp38dpboqHifPO9o7LOrGZmf3rrVU=;
 b=JE6Vn+mQoVKeLUKNBohlThEVyB37wCUg7537GdDdI8FmnGwhVJl0YBQoZdHo3mgPRP
 adCu0E+VeocPRTU3lxQ6yoss7w4pkEOG12KckEg1vI5k4OvZ2PGNe4ThSQ4I5ltoAuP9
 5hcNasUyfCsKCgjwX3LWqgl/GCKGixvrRR8iq1fnICuyEn8bqt7cLQF5qu8PbTIBE1dL
 CB8IVT6SWqJ9A8RMr0zYmB95bx0GzfPqeFVQHKKokTTqnOj5ijjoNBy3MKzLaKtsvqBg
 CC9EJ06HnYtfAVaay1e2CiFAV/Xa1PrJxc5CQfjebOCUFV/Y2n2ww8EFCy9vbfJ7unFT
 8r/A==
X-Gm-Message-State: APjAAAWlDY5eR9v9vovlQNkfctye2uF89pBDl7v0vRDk6VKVDWWxSMp4
 UaW8DVVeXYRfqzCYyTf2GLYTbg==
X-Google-Smtp-Source: APXvYqwlN95Og8Uwd28Jx/ayXVn+sUq+HfeG0ijBvcrZgWKm41OlXrt3PQ9KxKGic4ZblkCd3vDE2Q==
X-Received: by 2002:adf:c706:: with SMTP id k6mr6003460wrg.40.1561982193885;
 Mon, 01 Jul 2019 04:56:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d4d:4830:bcdf:9bf9?
 ([2001:b07:6468:f312:5d4d:4830:bcdf:9bf9])
 by smtp.gmail.com with ESMTPSA id x16sm9833194wmj.4.2019.07.01.04.56.33
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 04:56:33 -0700 (PDT)
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Alistair Francis <alistair23@gmail.com>
References: <97104495f5c945d25315aff1bd618e1a7bacf34c.1561589072.git.alistair.francis@wdc.com>
 <1bd3ffcd-3f91-ecb9-2315-da7125f1dcdd@redhat.com>
 <CAKmqyKPeo4XXVy3onoM4W14N5Nj7CFWX=JpDT-JQQRUPw5CQ3Q@mail.gmail.com>
 <4428dc80-9ace-3bb0-a497-e3d416199bfd@redhat.com>
 <CAKmqyKMRSJTMxZ5c-yyuownYF8vJLYrzr92cE4rkiTdP7tmUzg@mail.gmail.com>
 <CY1PR04MB22682B84C1ABA7FB10752465EDF90@CY1PR04MB2268.namprd04.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <79c9e21f-06b1-6255-97af-95c08b354c8a@redhat.com>
Date: Mon, 1 Jul 2019 13:56:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CY1PR04MB22682B84C1ABA7FB10752465EDF90@CY1PR04MB2268.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v1 1/1] hw/scsi: Report errors and sense to
 guests through scsi-block
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/19 12:14, Shinichiro Kawasaki wrote:
> I observe four of them listed below in sense data, 
> when I ran basic operations to the zoned storage from the guest via scsi-block.
> 
>      21h 04h: UNALIGNED WRITE COMMAND
>      21h 05h: WRITE BOUNDARY VIOLATION
>      21h 06h: ATTEMPT TO READ INVALID DATA
>      55h 0Eh: INSUFFICIENT ZONE RESOURCES
> 
> These ASCs can be reported for write or read commands due to unexpected zone
> status or write pointer status. Reporting these ASCs to the guest, the user
> applications can handle them to manage zone/write pointer status, or help the
> user application developers to understand the failure reason and fix bugs.
> 
> I took a look in scsi_sense_to_errno() and learned that ASCs are grouped in 
> errnos. To report the ASCs above to the guest, is it good to add them in EINVAL 
> group defined in scsi_sense_to_errno()? The ASCs are reported with sense key 
> ILLEGAL_REQUEST or DATA_PROTECT, then I think it fits in the function.

The grouping by errno is historical and pretty much broken.  It should
be possible to change it to return just a bool.

Paolo

