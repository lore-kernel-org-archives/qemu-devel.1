Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1695C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF06020723
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKCvYhx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF06020723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdAF3-0001Is-RM
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 06:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdADn-0008BL-Al
 for qemu-devel@nongnu.org; Mon, 25 May 2020 06:20:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32784
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdADl-0006U4-Iz
 for qemu-devel@nongnu.org; Mon, 25 May 2020 06:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590402036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRfSNC2ss3HIXRt1DQWODzcZm5cBs0oerm7Xf2BMQvc=;
 b=SKCvYhx6yo0821TdA0dHaW0svqQTPRBy1vs0fYRWZCvxnFFst3Nb3YipivUQo7l3sfReTt
 GvWisRa0WXUzo/3osbe9g6BhtNvsMk+HDHKr+9KEA/7RRybJXykqYXxa2bnCmnW61hh+lK
 0lHDVzfGSDmQDyorVRm9o0boVqfh2SM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-h12viYhCMC2lNoaGV_pYAw-1; Mon, 25 May 2020 06:20:34 -0400
X-MC-Unique: h12viYhCMC2lNoaGV_pYAw-1
Received: by mail-ej1-f71.google.com with SMTP id qn27so6243828ejb.11
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 03:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JRfSNC2ss3HIXRt1DQWODzcZm5cBs0oerm7Xf2BMQvc=;
 b=AWtRLv4jtu5sS99cUMxaOTkbocZSxjgfA+VcAA1NL/lK+LPctHksXgGLTQ8T1Kw+/q
 3cwl+abl+zltmLwVTfV1uAK/LmhceHbdq4kBZA1i0MJUZ5LjX2kEwxj//+nRXsYDck3h
 plvoBJW9n7w8IN1NR6aR5ziBPPoGYYLSbYnV4QxXHVEmILmRxzExcFcmjca6BQ0xO132
 tXuEh1if9BG+DI1Nn0gNSYyqdQkR08ty9+lpuVnyhAlj4mhn9s6FcRNbku9BeLixGj2G
 VHOKhUiJQOV5d0BVhZTDnDE4SOUNenIm/SOPO45GL4cGkLk3pPP1GsY7zZ4PHO61EKqC
 Qz+Q==
X-Gm-Message-State: AOAM531BprL8AQP5jnCmTsGLRk6fm1mvDwuqnQiuys8XOANFTmNDZvhc
 00EvYamoGAea5GsKTZOobnokq/gMlhVHIzF3O0DSrGa7E411qE7vO/h5dQDzF8MjlobFXDEtf20
 vIyTwUn64s4dEZoA=
X-Received: by 2002:aa7:d39a:: with SMTP id x26mr13924175edq.207.1590402033135; 
 Mon, 25 May 2020 03:20:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNwbP/LQMpyhYdJQA8XtYTkL0MUYeSgkOMEblZiq1QIasG6dQW4eY/bg2rd+tlZv/EVawAwA==
X-Received: by 2002:aa7:d39a:: with SMTP id x26mr13924159edq.207.1590402032941; 
 Mon, 25 May 2020 03:20:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id w8sm15521648edu.15.2020.05.25.03.20.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 03:20:32 -0700 (PDT)
Subject: Re: [PATCH v6 1/3] memory: drop guest writes to read-only ram device
 regions
To: Yan Zhao <yan.y.zhao@intel.com>
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
 <20200430080946.31286-1-yan.y.zhao@intel.com>
 <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
 <9dd7f00b-1199-1097-80d4-1b700c0f28d6@redhat.com>
 <20200525011853.GB8867@joy-OptiPlex-7040>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f836eeb3-0655-2842-2e8a-b8a42710a765@redhat.com>
Date: Mon, 25 May 2020 12:20:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200525011853.GB8867@joy-OptiPlex-7040>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 Alex Williamson <alex.williamson@redhat.com>, xin.zeng@intel.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/05/20 03:18, Yan Zhao wrote:
> On Thu, May 21, 2020 at 04:38:47PM +0200, Paolo Bonzini wrote:
>> On 30/04/20 11:40, Peter Maydell wrote:
>>>> This does not "drop" a write to a r/o region -- it causes it to generate
>>>> whatever the guest architecture's equivalent of a bus error is (eg data
>>>> abort on Arm).
>>
>>
>>> More generally, this change seems a bit odd: currently we do not
>>> check the mr->readonly flag here, but in general guests don't get
>>> to write to ROM areas. Where is that check currently done
>>
>> Writes to ROM are directed to mr->ops unassigned_mem_ops.  Because _all_
>> ram-device reads and writes go through the ops, for ram-device we have
>> to stick the check for mr->readonly in the ops.
>>
>> On one hand, I was quite surprised to see that unassigned_mem_write does
>> not return MEMTX_ERROR now that I looked at it.
>>
>> On the other hand, we should use MEMTX_ERROR in patch 2 as well, if we
>> decide it's the way to go.
>>
>> (Sorry Yan for the late response).
>>
> hi Paolo,
> thanks for your reply and never mind :)
> 
> But there's one thing I just can't figure out the reason and eagerly need
> your guide.
> 
> why do we have to convert all .write operations to .write_with_attrs and
> return MEMTX_ERROR? because of the handling of writes to read-only region?

Not all of them, only those that need to return MEMTX_ERROR.  I would
like some guidance from Peter as to whether (or when) reads from ROMs
should return MEMTX_ERROR.  This way, we can use that information to
device  what the read-only ram-device regions should do.

Paolo


