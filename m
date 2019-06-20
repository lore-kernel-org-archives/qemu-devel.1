Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6FCC48BE2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFFA2084A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFFA2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44998 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdsvL-0000qh-Gh
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hdsjB-0006s8-Kw
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hdsac-0000gP-E4
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:38:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hdsac-0000fy-95
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:38:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so2143612wmj.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 01:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AVzMDdYzRYDa/9qlp6STaY1kE5yotYb5iPRUD7XaJqc=;
 b=rqR8sh/P4KdSmTUwGUfnXaqky1Mfc8tz+G03zvw7guybTGdKISgPWgphhIdgiIkCJ8
 FWwfyZc1WEfysh66OmfLFOsHYwzsipxulgVEu8zMb4V8Tk92p53cp2e8U85P5da0sJy8
 c88IIumAZV77izpngBe3JWhFLsR/zecoEUMTwoq6Ik1+q5mjPmhylytdzKcHCC+7liGz
 OECCZfPEPy+C35c/gVW8BmXWZ+fRhg9j1TlJOCvYGBEQKiz+YqB1X2ZoIQv/N2xa4V3C
 wuacKzJr6L6w4wjxAZIakHthUvS+ZStVwAO0opqJ1otXqTrIciBEzcED/F/GJU6kbiWx
 zyLA==
X-Gm-Message-State: APjAAAUxLYQ8E7xvAy4N45TFHxW8tE8zEon2lQJRZrvnMY97Y1jwNdB0
 KZo83t9Ozn1r+KhzdxQ5bPtbyA==
X-Google-Smtp-Source: APXvYqyMzbpHQGAhbxDdf/r8UXU8ncUbxEAoebSiExPcVkdjAf6fAFk56HcqBDfPItjwqRIMSbuO0Q==
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr1840462wmj.41.1561019917157;
 Thu, 20 Jun 2019 01:38:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab?
 ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
 by smtp.gmail.com with ESMTPSA id 90sm1769622wrn.97.2019.06.20.01.38.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 01:38:36 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-5-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6cca5383-fdd4-ab9b-d227-d2de1083d398@redhat.com>
Date: Thu, 20 Jun 2019 10:38:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619201050.19040-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 04/17] qapi: Split qom.json and qdev.json
 off misc.json
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
Cc: kwolf@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/06/19 22:10, Markus Armbruster wrote:
> Move commands device-list-properties, device_add, device-del, and
> event DEVICE_DELETED from misc.json to new qdev.json.  qdev.json
> remains uncovered by MAINTAINERS, like the rest of qdev.

qdev should be added to either QOM or machine core.  QOM would be fine
for me as the (newly,self)-appointed maintainer.

Paolo

