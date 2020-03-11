Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4F4C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 18:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2692206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 18:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vnxby9AY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2692206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC6C7-0005Ug-7h
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 14:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jC6BR-0004jc-5P
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jC6BN-0008K7-9C
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:34:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29208
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jC6BL-0008Hw-GH
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583951654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6I8fxhNhQuFHrz6KQQUHTR15bwD9cGA69kO92MzQB70=;
 b=Vnxby9AYhMEaRPqK+69RM4wwXXRzspogKKHnOJlyyEZJ0sLPDpBt93kSVsLSobv8rA4XBM
 vZZ34/ZqcisZSN/QFIdMgq3e6s0lxipIm2Oz6siUVESjLBm4pT5Ze2MG8feCjxH/fVDACX
 AC82C/KTU+oo1kTAaTSjCcaQLxtnUWU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-ycWMqPJLOoOaexswZVEoUA-1; Wed, 11 Mar 2020 14:34:12 -0400
X-MC-Unique: ycWMqPJLOoOaexswZVEoUA-1
Received: by mail-wm1-f69.google.com with SMTP id n188so1222782wmf.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 11:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XvV+3SElXV11Sk48xv2qeHLHTUHhTzX1pg1uWRHmOkc=;
 b=jlZgb258GPpKq/dBQ0N0AF9XWCbUeql72jorko7eRa/pUcklAn6c1+g58f2tyNKd3G
 sjLHQDVUgu7YGI8RYoXou+WobTVPm80PmUYIHMrV1+qzib1XLBBuViWixPmdebr8Keo+
 NYd88QRvDURPXofiN8+5/wml/WQezqqQ4W5rCKOj9TVDWdNaSADu7eyyqWmKN1CA347n
 9BshI8IO8op+lSMTcK8lq5rpVz+JHY8V9kE+9Z6lx9rYOPSOFVsU/Kv0TL/6ryvxmuap
 pded7Exigt4z1XXURA9AgTt+e1jznydLJ/as/qOnYXJdsWx6NGEzWHq92VKeci7XhCn2
 Zxgw==
X-Gm-Message-State: ANhLgQ0IADa0JpzswQsUctIcbAqpcy+3WVTqT2tIZlY3PeTqInjWwLld
 BVj/TIqLUj5/eFtAwyw8tqm2ZrQPhtQnV/fI07X+qJlvJPytR7X4lAqvFjftU22sRm9USZkvbfN
 Y3FQmDwCqRvM/A7U=
X-Received: by 2002:a5d:6408:: with SMTP id z8mr5801014wru.122.1583951651424; 
 Wed, 11 Mar 2020 11:34:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vshgaHCrIlWtKu3Wpg+fB01gj5sgBAVWHwJXt60DsfTsWPUiykkZbPI+f/oGa91Xp5J4LDINg==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr5800995wru.122.1583951651198; 
 Wed, 11 Mar 2020 11:34:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4887:2313:c0bc:e3a8?
 ([2001:b07:6468:f312:4887:2313:c0bc:e3a8])
 by smtp.gmail.com with ESMTPSA id g5sm4736114wrr.57.2020.03.11.11.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 11:34:10 -0700 (PDT)
Subject: Re: [PATCH] mem-prealloc: initialize cond and mutex(Internet mail)
To: =?UTF-8?B?YmF1ZXJjaGVuKOmZiOiSmeiSmSk=?= <bauerchen@tencent.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20200306085014.120669-1-borntraeger@de.ibm.com>
 <20200309110331.3ef650a9@redhat.com>
 <13a05c3e-e374-8411-952d-05f4312ad6c0@redhat.com>
 <d37b122a-1980-32f3-6c06-89e5ef2a4807@de.ibm.com>
 <4976eaee60934e458e105bebe20d4d18@tencent.com>
 <20200309141914.0b9ad42f@Igors-MacBook-Pro>
 <d656861cb19e4f468da5fe2db80e060e@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a60b2bf8-5016-f0cc-217a-d9d0296e711b@redhat.com>
Date: Wed, 11 Mar 2020 19:34:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d656861cb19e4f468da5fe2db80e060e@tencent.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 mhartmay <mhartmay@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/03/20 08:06, bauerchen(=E9=99=88=E8=92=99=E8=92=99) wrote:
> oh ,yes.Thanks
> I want to know if I submit a new fixed patch or just a patch fixed
> current problem??=C2=A0
> if a new fixed patch, maybe need a revert ?

Sorry I missed this message.  I have already sent a fixed patch, thanks!

Paolo

> ------------------------------------------------------------------------
> bauerchen(=E9=99=88=E8=92=99=E8=92=99)
>=20
>     =C2=A0
>     *From:*=C2=A0Igor Mammedov <mailto:imammedo@redhat.com>
>     *Date:*=C2=A02020-03-09=C2=A021:19
>     *To:*=C2=A0bauerchen(=E9=99=88=E8=92=99=E8=92=99) <mailto:bauerchen@t=
encent.com>
>     *CC:*=C2=A0borntraeger <mailto:borntraeger@de.ibm.com>; pbonzini
>     <mailto:pbonzini@redhat.com>; qemu-devel
>     <mailto:qemu-devel@nongnu.org>; qemu-s390x
>     <mailto:qemu-s390x@nongnu.org>; mhartmay <mailto:mhartmay@linux.ibm.c=
om>
>     *Subject:*=C2=A0Re: [PATCH] mem-prealloc: initialize cond and
>     mutex(Internet mail)
>     On Mon, 9 Mar 2020 11:16:10 +0000
>     bauerchen(=E9=99=88=E8=92=99=E8=92=99) <bauerchen@tencent.com> wrote:
>     =C2=A0
>     > Thanks, =C2=A0in fact,do_touch_pages is called just when vm starts =
up,
>     but using init flag and Gonce maybe more elegant !
>     > if needed,I can submit a new patch !
>     > thanks very much!
>     =C2=A0
>     it's called from os_mem_prealloc() -> touch_all_pages() which is call=
ed
>     at least once per an instance of hotsmem backend. So if several backe=
nds
>     are used then it should be called several times.
>     The same applies when a hostmem backend is added during runtime
>     (hotplug)
>     =C2=A0
>     =C2=A0
>=20


