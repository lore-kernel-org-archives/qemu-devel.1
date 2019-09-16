Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC30C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71ECE21852
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ECE21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9u7I-0002y2-Po
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i9u3M-0007NW-JD
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i9u3H-0007Ly-N1
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:40:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i9u3F-0007Kf-Rm
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:40:34 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD985AC5FB
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 16:40:31 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id f10so6358wmh.8
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 09:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hp88/jYfopVLaRKQBQq+rATdj7uGp2fkopDhNKun2DM=;
 b=A3d7uQPwk0di5dZ0FrdGIwVM5evjFntc+js5ifJqfxXAc8mIUkp56TM699uTps6NDA
 QNdB76uaC/TomIiSockIK9YrdI8uah7MipSB0bBNxVtCERtD6cN9jcyQg07kh/ycWDti
 yYLBcoBGPkaoZvouWDehyvfeQJfQFZ69N9hijsT2hhm5l0BtJs4AbbcV9FaEvChfukKB
 UQt6z2HhJUopo8dRiQyBnk5oC0w561yOtpT28zMduVzZIhi4D43UWl8irOjXOVaBa4js
 WSNsP1YtgZq+j0r2G1uGuJgtIelE5effDu9BNvBjILKMDeyVFCtHbPKwTYRG/ac6kGe4
 jXIw==
X-Gm-Message-State: APjAAAXIhevPGX6TTk+xAn5C7w2OFQ/yoTYQ1FZRUDwtUyyddvjlAWoD
 14Y0X0yUC0JDpO/HGExCG+5dwPEESYsS7SoBoxIi32l3oyDH4Cbb4dsuILHIGFpc4ROOH9gOJAE
 CkaoccFHvx4+hOKo=
X-Received: by 2002:adf:de03:: with SMTP id b3mr566120wrm.14.1568652030502;
 Mon, 16 Sep 2019 09:40:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRZKJIr/wDz87h7fgBmbSdWjJZ3VbUhvodGrITyfKLPfxDQXkabyYSB4jJIgwdLQf1E51ebw==
X-Received: by 2002:adf:de03:: with SMTP id b3mr566105wrm.14.1568652030354;
 Mon, 16 Sep 2019 09:40:30 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id t8sm16165419wrx.76.2019.09.16.09.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2019 09:40:29 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190916095121.29506-1-philmd@redhat.com>
 <20190916095121.29506-2-philmd@redhat.com>
 <097f47ce-60a6-109f-e210-0844efed6a32@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d86629a7-510c-5a33-36f3-f33284e1ba5e@redhat.com>
Date: Mon, 16 Sep 2019 18:40:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <097f47ce-60a6-109f-e210-0844efed6a32@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] trace: Remove trailing newline in
 events
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 6:36 PM, Eric Blake wrote:
> On 9/16/19 4:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> While the tracing frawework does not forbid trailing newline in
>=20
> framework
>=20
>> events format string, using them lead to confuse output.
>> It is the responsibility of the backend to properly end an event
>> line.
>=20
> Why just trailing newline? Should we not forbid ALL use of newline in a
> trace message?

I thought about it and forgot to add a comment when respining.
Yes, I think this is the right thing to enforce.
However it requires more cleanup, affecting more subsystems, so I'd
rather keep it for a follow-up series.

>>
>> Some of our formats have trailing newlines, remove them.
>>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---

