Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4676C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766CA2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766CA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLjN-0000DG-51
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBLNi-0005h9-U4
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBLNd-0001yX-6V
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:03:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBLNZ-0001vN-8K
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:03:31 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B10AC049E36
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 16:03:23 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id f11so2439887wrt.18
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 09:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IEq6ZJW21f8AqWQkDCj+9mJuatGwG8DNkqvKQmdqPsc=;
 b=R7Td4q1U0UrDPpC9nXMn3k8BZ9s1N8YamX9GJjdBulZyXP3UJZsuZtH1KxflRAUdgS
 8SK3X0ITsc0VHMGhwaBBjdQQv5zDruPBMIiizT151y2pDqP/uon+ylzUNj3Xtfdbjgya
 /AcjYgd7WEoVj1X9AOVTy9SllVWZ3OvkuwmU3GTA8lZazJYus2phgDWehEa35SJbeicE
 yMLvO4Rd7dRkcWbItZ9MBPe+tQdjyaHdHAyqEdqNcRx4ADcca0omzBeMHUZCllKMQLaX
 rQ864g92lICEkRngOjrILZaYtfGy3dkJU5PGO2yAnWFvTm9O0pE37nXNtEtberqlAG39
 nbQw==
X-Gm-Message-State: APjAAAUr6i0KfyQHCIFiAogZs+VBB4u+u8XjSrB8af73Adb3LHSMTtkA
 IEQSoc86X4BfRPtcc6hSUIGkbJnKCSSLiHBJbOai2ZaPXzG7KeIkXR2zw4JcCKd+H57YFqAGNxo
 Q6MzxXijQ4QULv0Q=
X-Received: by 2002:a1c:f317:: with SMTP id q23mr3968473wmq.33.1568995402410; 
 Fri, 20 Sep 2019 09:03:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw4tFXayaeS/jGc9BwscxqwbqzW8hpegXRi3f1qIaUE3PsbQrr5D2+T1+FjVeBey6vgATYzbA==
X-Received: by 2002:a1c:f317:: with SMTP id q23mr3968456wmq.33.1568995402251; 
 Fri, 20 Sep 2019 09:03:22 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id m18sm3609097wrg.97.2019.09.20.09.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 09:03:21 -0700 (PDT)
Subject: Re: [PATCH] memory: Replace DEBUG_UNASSIGNED printf calls by trace
 events
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20190920141248.12887-1-philmd@redhat.com>
 <CAFEAcA981SOP7UqgXYcTt1s29TfiUwxWc9GoJd+m+BO4WHrz_g@mail.gmail.com>
 <f817b9a4-272e-c4c0-a4c4-5b5ebd7fd917@redhat.com>
 <CAFEAcA9KAc4viUy1X6f=f9Xm=_+H_JDJh1+USOHyPG76v5f_jw@mail.gmail.com>
 <a4c4f869-710d-930d-54f3-d43882cbb869@redhat.com>
 <e6169704-2af8-95e7-d64d-9de8b5768cdc@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d15786aa-6bb0-19a7-1969-14cc37f8d889@redhat.com>
Date: Fri, 20 Sep 2019 18:03:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e6169704-2af8-95e7-d64d-9de8b5768cdc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Desnogues <laurent.desnogues@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Daniel and Llu=C3=ADs,

On 9/20/19 5:01 PM, Eric Blake wrote:
> On 9/20/19 9:39 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
>>>> I thought I read a comment about it between Eric/Stefan but I can't =
find
>>>> it, maybe I dreamed it. (Cc'ed Eric).
>=20
> Not from me.  But looking at scripts/tracetool/format/log_stap.py, I
> suspect the dtrace via stap backend cannot support it.
>=20
> Researching further,
>=20
> https://sourceware.org/systemtap/langref.pdf
>=20
> section 9.2 printf, states:
>=20
> "The printf formatting directives are similar to those of C, except tha=
t
> they are fully checked for type by the translator."
>=20
> and does NOT list handling for '*' under precision or width.
>=20

Thanks for checking this.

>>>
>>> If my grep is correct we currently use the syntax already in
>>> gt64120_read, gt64120_write, pflash_io_read, pflash_io_write,
>>> pflash_data_read and pflash_data_write trace events.
>>
>> If you use 'git blame' you'll notice I added all of them, so better
>> let's get a proper confirmation from Stefan :)
>>
>> I plan to use them more, I find them helpful to directly see the acces=
s
>> size looking at the value width.
>=20
> You'll probably have to revert that, or else teach the various backend
> generators how to dumb-down a format string containing it when coupled
> with a backend that doesn't support it natively.

OK, I'll see what is doable with the backend generators, else revert/fix
the trace events already introduced :(

Regards,

Phil.

