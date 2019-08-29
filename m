Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD9EC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C97205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C97205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3MkZ-0002To-7g
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3MjT-0001pJ-I6
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3MjR-000104-9u
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:53:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3MjR-0000zX-2J
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:53:05 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 41E78C0546FB
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 15:53:04 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id z2so2317517wrt.6
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 08:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OUFDHUEqdKHtLDOBIw9hB1gvUgY3H+3B4ol7hcRpdRU=;
 b=Txq1ACAzYW0tTLpu1+p6L3lXHekjQdO6Cmt0LJ+wtFYJVEmc96y0/p1hAXoCiFZJrK
 XRCuSNqNqIk/609iaCcJgZDac3ZDKfV3lRCOPjkmRDiCvqCoLCTgikFWBkSz/VhH5aT1
 szxoUR5F0FZ2ptX3fsGgS+rDBOzxf+Pzq6D14YQ1RgYkcg4oVrjGRzoTU0BQGdfpEaQf
 3CXD07/uM01WC3iSQ4MQixQKTheR1Nv1W0vYcXwdCeuiVdlJYwUeubHpuP2EBTpMf/oB
 SHiX/2lIOIGwF5bdNhjIQ2PgYN3TXXQ9GpJ05mby3OPWblLz3VsTj10ICfTzl5ehTR35
 pkDg==
X-Gm-Message-State: APjAAAX3tQ08oNJycd5MigLP/G46I8dqGAQoGuA2JlFFAmPkb+IURGw6
 lYFN+xBYVQfBxwjPNBUzU4ZZEsaz1eYAhY6xmpBlAIG3McpwBynwCahRmJvky/IfDncKa/aizI1
 EKtUr5nuw0Q0hf/4=
X-Received: by 2002:a1c:b6d4:: with SMTP id
 g203mr12409038wmf.100.1567093982931; 
 Thu, 29 Aug 2019 08:53:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw3bzSJ+KZRatMUTei7TTiXca899Q5RNpUJxtIUOJCZOrA4WYvtgalTlnIpsT9V7xs3O0Kc/g==
X-Received: by 2002:a1c:b6d4:: with SMTP id
 g203mr12409008wmf.100.1567093982723; 
 Thu, 29 Aug 2019 08:53:02 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id r65sm4823555wmr.9.2019.08.29.08.53.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 08:53:02 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Samuel Thibault <samuel.thibault@gnu.org>, slirp@lists.freedesktop.org,
 Petr Matousek <pmatouse@redhat.com>, Vishnu Dev TJ <vishnudevtj@gmail.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>
References: <20190822144134.23521-1-philmd@redhat.com>
 <20190822144134.23521-2-philmd@redhat.com>
 <20190822183313.pptfwjsnrpdi6tfp@function>
 <14216968-a066-6abf-1952-3cff3aa3eee3@redhat.com>
 <20190825225403.vwg2fhfff6i7gnwd@function>
 <a032c557-7f1e-c710-f25a-e42200f0cf91@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f7ce663c-0235-3585-f324-9bc74bc3b383@redhat.com>
Date: Thu, 29 Aug 2019 17:53:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a032c557-7f1e-c710-f25a-e42200f0cf91@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Slirp] [PATCH 1/2] Do not reassemble fragments
 pointing outside of the original payload
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 5:43 PM, Philippe Mathieu-Daud=E9 wrote:
> On 8/26/19 12:54 AM, Samuel Thibault wrote:
>> Philippe Mathieu-Daud=E9, le ven. 23 ao=FBt 2019 17:15:32 +0200, a ecr=
it:
>>>> Did you make your test with commit 126c04acbabd ("Fix heap overflow =
in
>>>> ip_reass on big packet input") applied?
>>>
>>> Yes, unfortunately it doesn't fix the issue.
>>
>> Ok.
>>
>> Could you try the attached patch?  There was a use-after-free.  Withou=
t
>> it, I can indeed crash qemu with the given exploit.  With it I don't
>> seem to be able to crash it (trying in a loop for several minutes).
[...]
>=20
> Note 2: We miss some Makefile rules in QEMU with the libslirp split.
>=20
> Checkouting branches in the slirp/ directory doesn't trigger recompilin=
g
> the slirp object, and even if I force the creation of the libslirp.a
> archive, the QEMU binaries are not linked again with the refreshed arch=
ive.

And I hit the same issue after applying your patch =3D)

So, using a clean workspace, I can not reproduce the null deref anymore.

If you send a proper patch, feel free to add:

Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Thanks!

Phil.

