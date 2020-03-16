Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9F6C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD542051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBpgknPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD542051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDmWr-0002M8-Qf
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 05:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDlLY-00014a-K6
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDlLW-0000KG-Fr
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:43:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59107
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDlLW-0000B1-9S
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584348217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zPvIA+2J8s7ebTzWw+fggxLmYO38801mD0qGZYq4pY=;
 b=VBpgknPMLSAZ46bnXkjBM7v6mmTZoceksumGTV78mpNuZxdWDKp87xRf7KisxplvtJdwn7
 BStul8/M1xcUBqx8xWAbqZEtj+Fqf/2a62pHWvxvnSWoHdtavQ/Aue4eLBkARZUpipHyFj
 dwoYPO1qovlc9T1rGJFSWRugJH7wSO4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-tD2SVBwdN5-uSODa3jJRVA-1; Mon, 16 Mar 2020 04:43:36 -0400
X-MC-Unique: tD2SVBwdN5-uSODa3jJRVA-1
Received: by mail-wr1-f69.google.com with SMTP id t10so2380723wrp.15
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 01:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3zPvIA+2J8s7ebTzWw+fggxLmYO38801mD0qGZYq4pY=;
 b=kwMm67KD2TMGvhH6SWoUjgRZX8oCs+zl8dBvdcB8dfkH7dtuVRYUUVKADzUCoHULw9
 bJ6TLSENQfUQfKrhd3buqkXHgJCm1g02cumpYOtpsCEL2RGc0rkqYGUxWqCKv9r1DLpw
 VkkR834JJi7VSE018kvU+sjGAjxvD059u5BfEXPgXc8TD3Lo+Pmf6DZfL4NnAQrYm2+/
 KxDQIYUX17CI4rl1T13FS6SsLMtRS7kE11WOCZ+sFS+AfgCU0/0w3tscsIol6Te7LDWb
 43AR4yojQZO6HZlLYuTVZEOdfEl5yQIcOrxdHLIf6YT85Ud6UALmaitvABYs3CeBrdKU
 2aXg==
X-Gm-Message-State: ANhLgQ0KFNiQnsItUmR6tMP8a0P5M+36lYAafxV2b7x2+MYgGNviI5T1
 WA+h+U5Z6OPGNRSwXAuafJHC/2lylSay1IQfYH398Zqd4WGN5yYRvrNLfmByLXT9n00l3wZAL3J
 HPuK66oND8yeG5s4=
X-Received: by 2002:adf:f2cf:: with SMTP id d15mr34199563wrp.397.1584348215313; 
 Mon, 16 Mar 2020 01:43:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuY6yPqVwVGX9jniE0pudgrt28voaxYXQFX0MDHyPjhTByxjtfj0okfoEYUcqKyeExUo0KBPw==
X-Received: by 2002:adf:f2cf:: with SMTP id d15mr34199528wrp.397.1584348215063; 
 Mon, 16 Mar 2020 01:43:35 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.82.39])
 by smtp.gmail.com with ESMTPSA id q11sm551599wrp.53.2020.03.16.01.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 01:43:34 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
To: Markus Armbruster <armbru@redhat.com>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 <871rq08tn9.fsf@dusky.pond.sub.org>
 <eca27715-554d-2c2e-5e58-ffd01abb654c@ilande.co.uk>
 <e1ae65dd-f9cd-b0ee-0ea6-f3c2b010fdab@redhat.com>
 <87tv2p8y5j.fsf@dusky.pond.sub.org>
 <3f512e33-5875-eee4-bbe8-61e7b313743d@redhat.com>
 <87mu8g3kgj.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd83fe53-6541-b04d-04d9-76ddd29e2b99@redhat.com>
Date: Mon, 16 Mar 2020 09:43:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87mu8g3kgj.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pan Nengyuan <pannengyuan@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/03/20 07:03, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 15/03/20 15:56, Markus Armbruster wrote:
>>>>
>>>> The question is why they are not, i.e. where does the above reasoning break.
>>> I don't know.  But let's for the sake of the argument assume this
>>> actually worked.  Asking for help in the monitor then *still* has side
>>> effects visible in the time span between .instance_init() and
>>> finalization.
>>>
>>> Why is that harmless?
>>
>> I don't really have an answer, but if that is a problem we could change
>> "info qtree" to skip non-realized devices.
> 
> Can we convince ourselves that "info qtree" is the *only* way to observe
> these side effects?

There is of course qom-get/qom-set, but those _should_ show this side
effect.

If we decide that "info qtree" should only show devices visible to the
guest (as opposed to all objects that have been created), then "show
only realized devices" is not even a hack but the correct implementation
of the concept.

Paolo

> If yes, a hack to ignore unrealized devices "fixes" the problem.
> 
> If no, it sweeps it under the rug.


