Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91756C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F012082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F012082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFwx-0002nl-M0
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46543)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hiFwB-0002HH-Iv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hiFwA-0006Zr-IT
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:22:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hiFwA-0006Z8-BK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:22:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so17110625wru.10
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DeL9ECSolqSxFTXdCm212DxoxGMYV1GoHAve77Ot5Ns=;
 b=R5Xmm795DzkRjvMA5mpS6rSCH4ZskMe4U86KrW2Cx+78BKKkC8P3uPmpXLxIy0aClq
 6TbcrevoCAmCT4ZxOcrddbB8LH5eRhNWnDRk2mmMDNtNJzJVfdtVC+P+lS8YHyv4hm9o
 YHRTugUBHMZhCjLIlKRolKkW0LLkdv1ryeP72VwnHaLh+EC5ffgYIU00EwZ5ukQJLu8M
 wJtJapDPDUv7ypjRvgk4PuhPbc+erEBalxvosLtqzK0/d5Y+/yzw0lMpE4GICdhOE7Lc
 td8jRZXJhXCqT1/6+vTcUJ7TrAss2DujAQVD9CanDEc0qhqpriqFO47EfQNoNtQYrIcs
 u4Bg==
X-Gm-Message-State: APjAAAWczxUKieYbNJ9zq/dwNEaq4RygOQsKetAa2BvL8DqnFFZopNOt
 8TJFJF2yqVHK4HHJWdQTpwY+4A==
X-Google-Smtp-Source: APXvYqxckCk9IEPdn5L7RDe/dvPvBhWQ/OOsxEUWOWF/0HPnrKlYWxhZDHy+DhtYuA7UkZBuTzJbwg==
X-Received: by 2002:adf:cc92:: with SMTP id p18mr19063641wrj.260.1562062976953; 
 Tue, 02 Jul 2019 03:22:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:68f6:70ea:5bb4:f73?
 ([2001:b07:6468:f312:68f6:70ea:5bb4:f73])
 by smtp.gmail.com with ESMTPSA id q20sm18978437wra.36.2019.07.02.03.22.55
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 03:22:56 -0700 (PDT)
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Alistair Francis <alistair23@gmail.com>
References: <97104495f5c945d25315aff1bd618e1a7bacf34c.1561589072.git.alistair.francis@wdc.com>
 <1bd3ffcd-3f91-ecb9-2315-da7125f1dcdd@redhat.com>
 <CAKmqyKPeo4XXVy3onoM4W14N5Nj7CFWX=JpDT-JQQRUPw5CQ3Q@mail.gmail.com>
 <4428dc80-9ace-3bb0-a497-e3d416199bfd@redhat.com>
 <CAKmqyKMRSJTMxZ5c-yyuownYF8vJLYrzr92cE4rkiTdP7tmUzg@mail.gmail.com>
 <CY1PR04MB22682B84C1ABA7FB10752465EDF90@CY1PR04MB2268.namprd04.prod.outlook.com>
 <79c9e21f-06b1-6255-97af-95c08b354c8a@redhat.com>
 <CY1PR04MB22683409CB203BF5042697FBEDF80@CY1PR04MB2268.namprd04.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a741004-fc88-f31a-2abf-70f4a9b0d5a9@redhat.com>
Date: Tue, 2 Jul 2019 12:22:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CY1PR04MB22683409CB203BF5042697FBEDF80@CY1PR04MB2268.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
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

On 02/07/19 08:44, Shinichiro Kawasaki wrote:
> On 7/1/19 8:56 PM, Paolo Bonzini wrote:
>> On 01/07/19 12:14, Shinichiro Kawasaki wrote:
>>> I observe four of them listed below in sense data,
>>> when I ran basic operations to the zoned storage from the guest via scsi-block.
>>>
>>>       21h 04h: UNALIGNED WRITE COMMAND
>>>       21h 05h: WRITE BOUNDARY VIOLATION
>>>       21h 06h: ATTEMPT TO READ INVALID DATA
>>>       55h 0Eh: INSUFFICIENT ZONE RESOURCES
>>>
>>> These ASCs can be reported for write or read commands due to unexpected zone
>>> status or write pointer status. Reporting these ASCs to the guest, the user
>>> applications can handle them to manage zone/write pointer status, or help the
>>> user application developers to understand the failure reason and fix bugs.
>>>
>>> I took a look in scsi_sense_to_errno() and learned that ASCs are grouped in
>>> errnos. To report the ASCs above to the guest, is it good to add them in EINVAL
>>> group defined in scsi_sense_to_errno()? The ASCs are reported with sense key
>>> ILLEGAL_REQUEST or DATA_PROTECT, then I think it fits in the function.
>>
>> The grouping by errno is historical and pretty much broken.  It should
>> be possible to change it to return just a bool.
> 
> The errno grouping of scsi_sense_to_errno() is used not only by scsi-disk but 
> also by block/iscsi for error reporting. Can we avoid errno grouping for iscsi also?

No, but we can do something like

    if (scsi_sense_buf_is_guest_recoverable(r->req.sense,
sizeof(r->req.sense))) {
        /* These errors are handled by guest. */
        sdc->update_sense(&r->req);
        scsi_req_complete(&r->req, *r->status);
        return true;
    }
    error = scsi_sense_buf_to_errno(r->req.sense, sizeof(r->req.sense));

This way there's generally no need to shoehorn ASC codes into errno.  I
still have to test my changes, but I hope to send something within a
couple of days.

Paolo

