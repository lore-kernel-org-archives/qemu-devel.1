Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49E5C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F14206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F14206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIx52-0003EH-QX
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIx37-0001GL-DB
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIx35-0002He-G1
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:41:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIx35-0002HS-AS
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:41:47 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 670D580F81
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 15:41:45 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id f4so809701wrj.12
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wzSjw+TwvNf0w3q7MUm61I3wM+qGMhSw568Qmtgqj/A=;
 b=FfuFybaJH6GYbaIcqiEbUU9XduJULf2PDhC825b1Ukja6PaVIfDtXM0LRqlj0jW7wF
 Pj+hCnuAZuEGgkW3F7ZKSfhJ46zHXaqaR7cIiT6oyucsHlngMbrrqjy79xxEQitarCC5
 3/A/m2Th2PM5etBHsNMbjqYSpu+NjKyrcl5JrKYtWRa8yJtwutZwDQyCBQ5/YoIH7qpN
 BbM3y+HFj/YcV6DyU6OSKEuujVLWqfmgwXfR49FPxr8iMGmYnohm4PLA2zb7eXC+ad4y
 nAJb9XzJHOF2MKRje+7776FpMJwj57S2KXwAxkzzgbQnUN/Re3JM+vwLN7XcOE6xxyet
 nw2A==
X-Gm-Message-State: APjAAAXVGVjTQvGvw5sGzre7MMSZUDDkbaDGEdTArjaA8FZNgc1zn0qr
 pBsN/TfBm/qtRImnpxKOTlcUkRsCcAJ24QTflC1m6uJrH13YE5KWEeFQMdhmNUGqOI7jmL2GEEZ
 G+Is5UeadCP/yhXo=
X-Received: by 2002:adf:fa92:: with SMTP id h18mr13726089wrr.220.1570808504156; 
 Fri, 11 Oct 2019 08:41:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz9rilgiv4xVs+U5DHxWYKH5TRjDVM5HgmKhHm1yvgjGnU5yp9R/O9pt2A+AuiCp8nTkLgxJg==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr13726079wrr.220.1570808504008; 
 Fri, 11 Oct 2019 08:41:44 -0700 (PDT)
Received: from [192.168.50.31] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id a13sm20595572wrf.73.2019.10.11.08.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 08:41:43 -0700 (PDT)
Subject: Re: [PATCH v30 0/8] QEMU AVR 8 bit cores
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20190902140134.74081-1-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1aeb25ea-9b95-b637-b191-93a115c8acca@redhat.com>
Date: Fri, 11 Oct 2019 17:41:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190902140134.74081-1-mrolnik@gmail.com>
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
Cc: dovgaluk@ispras.ru, thuth@redhat.com, richard.henderson@linaro.org,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/19 4:01 PM, Michael Rolnik wrote:
> Michael Rolnik (7):
>    target/avr: Add outward facing interfaces and core CPU logic
>    target/avr: Add instruction helpers
>    target/avr: Add instruction decoding
>    target/avr: Add instruction translation
[...]>   target/avr/Makefile.objs         |   33 +
>   target/avr/cpu-param.h           |   37 +
>   target/avr/cpu-qom.h             |   54 +
>   target/avr/cpu.c                 |  576 ++++++
>   target/avr/cpu.h                 |  254 +++
>   target/avr/gdbstub.c             |   85 +
>   target/avr/helper.c              |  354 ++++
>   target/avr/helper.h              |   29 +
>   target/avr/insn.decode           |  175 ++
>   target/avr/machine.c             |  121 ++
>   target/avr/translate.c           | 2888 ++++++++++++++++++++++++++++++

Hmmm I'm wondering, since the 32-bit arch is different, shouldn't we add 
this under target/avr8/ ?

