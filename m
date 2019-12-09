Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A134AC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4A42073D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5Zzy5hV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4A42073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieGV7-0005JW-K4
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 05:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ieGUV-0004rv-5Q
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:42:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ieGUU-0003Jm-8q
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:42:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46381
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ieGUU-0003JY-5m
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575888129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faWikn8ZwvgnT1S5A6OW/eAq3CswZxBEGN2w96rdV+o=;
 b=O5Zzy5hVDREyvRnNdiU2my6hgcMrQyk5Zf3+6NV2S3I9qhx+0GGuHKbG6MBbfUjFIFZ4Pp
 rBFFsdu6OF9xUWSqETMKribAdwKFbEg2YoIrp+14OI86VSoKeUNnFWCv06uuIR3Jlrs+0d
 IwD7fwakOxo71F//rqpfZ7+0s2XCd9A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-q0t-nnB5PsWH8aCqm5Ojzg-1; Mon, 09 Dec 2019 05:42:00 -0500
Received: by mail-wr1-f71.google.com with SMTP id f1so5359469wre.14
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 02:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AOGg0FupmGSBGT96UmLkohViFxNYvdwXFb83majsKxk=;
 b=GIXM1GT7fUGh3rHeoNBR8B2K0v/ax0RHvYS3bdR9C8gHWO9hZ5JfJx/UVXsMkxmk4z
 xzWA1au6x3nzjKbU3QQ6NsUSni3lmP8WnBzXSHwcG5loYChl06TplDSRkcmeOEYj3m7q
 KSSLB6obyyieH2emRJmZqqeSslQrW2os4WaolOAuvBgfssYjJ9sH1L/Maoc21gLNGql0
 7VjIarjBSaB9/wAazuhoSTqdIkDRpMSakh+DuAIXMJVBj+Oy0qs4kieb5R3j6L+Zm9tO
 uIkg88iPb7snl4tkw/fY7n8f2qjeqSRkCeUK5Q3BaydrWRSOfLtw7GPFfF+mQxPPY87B
 8meA==
X-Gm-Message-State: APjAAAWe5T1DvIN4abpTQTYpgUWegts1hxfRW6r3RVVede5qSgUUWsBX
 MjRfHDhu1pjsu2rYr4yz/59uoGi49/KiR29waeH/1vQLj9CRQxiWmaFr7gd/6QsNwebcYHVXRZ0
 b2lYG+AHhneOP0og=
X-Received: by 2002:a1c:740b:: with SMTP id p11mr23167406wmc.78.1575888119519; 
 Mon, 09 Dec 2019 02:41:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0Pr9r4MAVP0uz9FUqFcrZaLxD7X5ZsPiOgOV7Kdp+D1GHhsBLypdcVa4XI8GG9pCRaFxg8g==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr23167375wmc.78.1575888119292; 
 Mon, 09 Dec 2019 02:41:59 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id b185sm14349018wme.36.2019.12.09.02.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 02:41:58 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH-for-5.0 v3 6/6] hw/pci-host: Add Kconfig entry
 to select the IGD Passthrough Host Bridge
To: "Durrant, Paul" <pdurrant@amazon.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191209095002.32194-1-philmd@redhat.com>
 <20191209095002.32194-7-philmd@redhat.com>
 <3f1702b0765841b19328366af11fd3ed@EX13D32EUC003.ant.amazon.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <083d0d7f-766d-9e72-5395-b4e82858ef4d@redhat.com>
Date: Mon, 9 Dec 2019 11:42:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3f1702b0765841b19328366af11fd3ed@EX13D32EUC003.ant.amazon.com>
Content-Language: en-US
X-MC-Unique: q0t-nnB5PsWH8aCqm5Ojzg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/12/19 11:10, Durrant, Paul wrote:
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> v3: Only default with Xen (Alex Williamson)
>>
>> I did not used 'depends on XEN' as suggested by Alex but
>> 'default y if XEN', so one can build XEN without this feature
>> (for example, on other ARCH than X86).

I think what you want is achieved by

=09default y
=09depends on XEN && PC_I440FX

?


