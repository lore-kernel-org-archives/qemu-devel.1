Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DB3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B87720684
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B87720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO1D7-00054D-01
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 11:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iO0zv-0001EH-Ai
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iO0zt-0000zY-3z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:55:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iO0zs-0000yx-S2
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:55:25 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B226C5945B
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 14:55:23 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a6so1325131wru.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=75+26rWKZ1KlI2ccIXe4P/R79RU0HhjUf9r3r3iLciQ=;
 b=SdjxAmzcLPeitwxV4jr4vM05dr0vWpUUaA1xtY1u7RwPYZ7xxrj68loAl1Osh/xHTC
 6DUxGEBFrEwqxz7mpRZwUVZVfffyAqxpIIw2ntUpTTWyz3ZIZvly/qtiHkZx50aPFbuz
 6lBGavsgml5KjoVsq3eaUOeSJsK6UfMPeuHLFZq8JcekKbIEsn+/Jszog9H7fIapxwqu
 sLsJkk7q7Mnn0p0ZazEiAPZ1kDQIj5VkUajExtQGL+LxlXX+KtueeYmJC49szKMz1rtY
 EWwAdxphrgh8On7XTDcWiO0jaFvNnKUn9xociDOeX//kmfe+z60+LuB5ObO1bw4AjMb4
 cj9w==
X-Gm-Message-State: APjAAAU6EctNS6oZs6spDcqgPQr5eYbI5I0/cqBSlZUXRFyZ8zFfzjQL
 D+5z2uG/ezkr2ri2SMVFsZrntIQZgyM8PFlDPvdfhgeObB6WogqOEFl7UsGEq6S44+e8yV45BVB
 M+7hNyTfDXZRyrcs=
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr3590305wrn.334.1572015322365; 
 Fri, 25 Oct 2019 07:55:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxGihPA5ErIPGjj+S601lLMWEbVT1fuCxylnQiCTodK79yWH09jIXxqCVTGMQ4xPfsCJA9HCw==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr3590282wrn.334.1572015322203; 
 Fri, 25 Oct 2019 07:55:22 -0700 (PDT)
Received: from [192.168.43.238] (51.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.51])
 by smtp.gmail.com with ESMTPSA id p126sm2406646wme.0.2019.10.25.07.55.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2019 07:55:21 -0700 (PDT)
Subject: Re: [PATCH v14 1/9] esp: add pseudo-DMA as used by Macintosh
To: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <20191022111738.20803-1-laurent@vivier.eu>
 <20191022111738.20803-2-laurent@vivier.eu>
 <6dd7dbbb-dc48-7705-3865-e8a7bed75394@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0f308a0d-f73b-29a1-0177-49a6e0a1eda9@redhat.com>
Date: Fri, 25 Oct 2019 16:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <6dd7dbbb-dc48-7705-3865-e8a7bed75394@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/19 4:01 PM, Paolo Bonzini wrote:
> On 22/10/19 13:17, Laurent Vivier wrote:
>> +        if (s->dma_memory_read) {
>> +            s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen], len);
>> +        } else {
>> +            set_pdma(s, CMD, s->cmdlen, len);
>> +            s->pdma_cb = do_dma_pdma_cb;
>> +            esp_raise_drq(s);
>> +            return;
>> +        }
>> +        trace_esp_handle_ti_cmd(s->cmdlen);
>> +        s->ti_size = 0;
>> +        s->cmdlen = 0;
>> +        s->do_cmd = 0;
>> +        do_cmd(s, s->cmdbuf);
>>           return;
> 
> Can you explain these lines after s->dma_memory_read?  I suppose they
> are related to
> 
>> -    }
>> -    if (s->do_cmd) {
>> +    } else if (s->do_cmd) {
> 
> If so, it would be nice to make those a separate patch.  Otherwise seems
> okay.

Third reviewer asking, so it seems worthwhile.

