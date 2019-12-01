Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78CCC432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 18:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A5620833
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 18:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bI6hQaQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A5620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibTa8-00062Y-HK
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 13:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ibTZ3-0005WL-FI
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 13:03:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ibTYz-0008EH-Sf
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 13:03:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31418
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ibTYy-0008Cg-Gw
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 13:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575223394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U9Dc7pc1rXLPpT+g+Ql2+dvXyThDerzR9UdzwRm55Lg=;
 b=bI6hQaQ3c27mN/AGCTc5Wbi7OZOCEfVMHX59TJ5YCW+VzAjhXzn1YGwS1s1QysI41nrfdS
 h3TU3/Pb1dfTimbzNZJdky8S0BZNRFvXKKF1vpGScrXtSgQuDUu+kv+pD159oQdB9Iuz1j
 tn3dlJ0gRuu5gnJv4lJQPCfKhK8agK4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-JcS7rceVPXKpymE5RlRHEQ-1; Sun, 01 Dec 2019 13:03:13 -0500
Received: by mail-lf1-f72.google.com with SMTP id q13so6488121lfc.10
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 10:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NWh8+Qx4BKUIijNeY+Y02aroyDAr136Q0nwgkI20Yfs=;
 b=g+hTGQ6T3FLAPMOt1fVM5J0O+SsOBxanZNVLXb9PKMq5Y1fMG0IsBuNr74V+XQ7WFq
 rs0cWmipqI8hAB5MEw2g/etcCUg0Q+nIIBJzjiUzeJdY9Xyq6IYo89tjqwESipPhGI3V
 Dzj15a5pE+HmhOnODOBvsAAsVzjLVwDVwkQnRXSG7tHiUZGXuwK9Yj1dX2PTBtgh/YhS
 utOU6jm7dQ0TTprBQNNLVe7kPR2HzWVOdlKKJ1EeARsBU9pfZitUcfawjpp1+655Qbmc
 s89xbC8D3792+fIc7i+q4hOTxbBxsv58Lhn4kQOWQdKkOohOnMom3+g14/PppgGmghRX
 PNUg==
X-Gm-Message-State: APjAAAWPOxvW+cVVoCc+lABQCM33M1ovH/R2FQHHFf2/WZDgn/kZ47ZB
 bpygc38C89TDBCW+czQ+ckXM4srIR6MWX/2LUpgu21fY+m0SAlZVyRXEjaKJsbaeCSH99a2IMTk
 wnZdD6FdINiXsWxE=
X-Received: by 2002:a05:6000:160d:: with SMTP id
 u13mr9216023wrb.22.1575223391593; 
 Sun, 01 Dec 2019 10:03:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgnCHSIabCJB1Z9aH6A9xYWm+Jn3PbWhAWz1ZkfJfeOXbGymvvQBNVevJyDC+kI4OWaBJ/qw==
X-Received: by 2002:a05:6000:160d:: with SMTP id
 u13mr9215984wrb.22.1575223391289; 
 Sun, 01 Dec 2019 10:03:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:182e:24f0:527c:1bc7?
 ([2001:b07:6468:f312:182e:24f0:527c:1bc7])
 by smtp.gmail.com with ESMTPSA id r15sm9579189wmh.21.2019.12.01.10.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 10:03:10 -0800 (PST)
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128161021.GA14595@habkost.net>
 <fb122bbe-3fc4-e3cd-899a-c3538237203a@redhat.com>
 <20191129202137.GI14595@habkost.net>
 <CAJ+F1CL1s450gUmGK9hzSgk4Y3XSNTzdt2OdU6z65y1hKGjxeQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0a63a6e8-6b44-ce5c-b244-edf8022121c6@redhat.com>
Date: Sun, 1 Dec 2019 19:03:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL1s450gUmGK9hzSgk4Y3XSNTzdt2OdU6z65y1hKGjxeQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: JcS7rceVPXKpymE5RlRHEQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/12/19 16:40, Marc-Andr=C3=A9 Lureau wrote:
>>> The original idea was to always support one NUMA node, so that you coul=
d
>>> do "-numa node,memdev=3D..." to specify a memory backend with -object.
>>> However, this is not possible anymore since
>>>
>>>     if (!mc->cpu_index_to_instance_props ||
>>>         !mc->get_default_cpu_node_id) {
>>>         error_setg(errp, "NUMA is not supported by this machine-type");
>>>         return;
>>>     }
>>>
>>> has been added to hw/core/numa.c.
>>>
>>> Therefore, I think instead of -mem-shared we should add a "-m
>>> memdev=3D..." option.  This option:
>>>
>>> * would be mutually exclusive with both -mem-path
>>>
>>> * would be handled from allocate_system_memory_nonnuma.
>>>
>>> * could be mutually exclusive "-numa node", or could just be mutually
>>> exclusive with "-numa node,memdev=3D..." (the logical conclusion of tha=
t
>>> however would be an undeprecation of "-numa node,mem=3D...", so that ha=
s
>>> to be taken into account as well).
>> I completely agree we could do this.  I just think this misses
>> completely the point of this series, because usability of:
>>
>>   -object memory-backend-file,...,share=3Don,id=3Dmem -m ...,memdev=3Dme=
m
>>
>> is not much better than the usability of:
>>
>>   -object memory-backend-file,...,share=3Don,id=3Dmem -numa node,memdev=
=3Dmem
>>
> +1
> Perhaps when all RAM allocation will occur through memory-backend,
> "-mem-shared" could be simply an alias to "-global
> memory-backend.shared=3Don"

Yes, this is the point.  There are two parts in this series:

(1) allowing use of vhost-user on non-NUMA machines

(2) providing syntactic sugar for it

I have no problem with -mem-shared for (2), but it should just be
syntactic sugar for (1).  It's okay if -mem-shared is a global variable
rather than an alias for -global; the important part is not to add any
feature that is not available from the QOM-style command line options.

Paolo


