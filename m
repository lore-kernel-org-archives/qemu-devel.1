Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0502DC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47A620661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPhRD2SQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47A620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT1NR-0007zI-Tf
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT1MX-0006lY-8N
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT1MV-00064N-TK
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:51:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48201
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jT1MV-0005uu-CA
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587984702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9dh7cLR/zgFOQ5FRPwzLi0I51zHslhnKQ+rHhofmkg=;
 b=QPhRD2SQ81AoB8Ff3S9uWxugNUOc2suvI0hYff4iG1DcpLn/gogPN50C/Cd1JWVguwRUL9
 Cn8L6+NF0ZkXy6LpG05B6pn4CwrV12nfeff3FTLnqh5Lop2jiXkyf0rfdfWM+Mf72MrRfe
 BdRP+OJ+85upKPH8peDBi+WxiN1t8VE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-G0WHmQ9vPU-42fDRsJvCiw-1; Mon, 27 Apr 2020 06:51:40 -0400
X-MC-Unique: G0WHmQ9vPU-42fDRsJvCiw-1
Received: by mail-wm1-f71.google.com with SMTP id q5so6994922wmc.9
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 03:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mY7XgdYHh+IFXT9oOEYVvyJcaJ4HWfpd+UZ/8rR8kXk=;
 b=gU++O83KqNhEJJha5jKBRNDNpVkjdIKySrAf3nbfdULSaftctohaT6WMVCo7NNOi4x
 JFPPVE6hh5GBsFIOe/IkSKG/7awJEpL05GcW7XjLRYafeLYZ3tneIPSoJ4CEgSwWU0XT
 f0NL+Gj+UOv6iMwNxnz7yd3e9DiqQ8JidfCoUZQu6vbKss+Ar6AGoPXa9qZHrhNGmTWH
 WhzM4lVGOb540zoORqYjgWomw6zPt3DQsOno/8RiHsUCjMn8u3M+OFZrDWs4haJ+XzFn
 fAIF3JD4+VynJF4uaCTp5wXQ7KeaIAoggET1A6HaDAm6wD6X3whxplJ+AZ+95uNpnegk
 6XHA==
X-Gm-Message-State: AGi0PuakbVnvnQlVIgiXK03dXEYU9X8iecr6mdFUlAnnMIQquzR9RpaD
 84JOc0kQfDxSXiE+OnnaR2xtP78ML4iEhfa/Hu50IzpwfmhLGTq/U1jawqhSexJPwAZ6U9pUq6e
 QRWFjsu0rBE/X37s=
X-Received: by 2002:adf:f004:: with SMTP id j4mr26271042wro.123.1587984699192; 
 Mon, 27 Apr 2020 03:51:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypJo+tJFLp5kAM8/X78ApLe1tGaGvhzZkXROSbCrQdHb+INSOO1iXwADF2CEov3NmxjGz6DsHA==
X-Received: by 2002:adf:f004:: with SMTP id j4mr26271018wro.123.1587984698961; 
 Mon, 27 Apr 2020 03:51:38 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id k9sm21766933wrd.17.2020.04.27.03.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 03:51:38 -0700 (PDT)
Subject: Re: [PATCH 0/5] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
 <20200423171322.GJ1077680@redhat.com>
 <69e77a6e-8db8-f617-bfe6-1c8f39ec81b4@redhat.com>
 <20200427011210.745db351@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <05670290-5ba0-8be0-624b-da1c95f3e820@redhat.com>
Date: Mon, 27 Apr 2020 12:51:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200427011210.745db351@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 7:12 AM, Cleber Rosa wrote:
> On Thu, 23 Apr 2020 23:28:21 +0200
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
[...]
>> In some cases custom runners are acceptable. These runners won't be
>> "gating" but can post informative log and status.
>>
>=20
> Well, I have the feeling that some people maintaining those runners
> will *not* want to have them as "informational" only.  If they invest a
> good amount of time on them, I believe they'll want to reap the
> benefits such as other not breaking the code they rely on.  If their
> system is not gating, they lose that and may find breakage that CI did
> not catch.  Again, I don't think "easily accessible" hardware should be
> the only criteria for gating/non-gating status.
>=20
> For instance, would you consider, say, a "Raspberry Pi 4 Model
> B", running KVM jobs to be a reproducible runner?  Would you blame a
> developer that breaks a Gating CI job on such a platform and says that
> he can not reproduce it?

I'm not sure I understood the problem, as I'd answer "yes" but I guess=20
you expect me to say "no"?

[...]
>> Now the problem is GitLab runner is not natively available on the
>> architectures listed in this mail, so custom setup is required. A
>> dumb script running ssh to a machine also works (tested) but lot of
>> manual tuning/maintenance expected.
>>
>=20
> That's where I'm trying to help.  I built and tested the gitlab-runner
> for a number of non-supported environments, and I expect to build
> further on that (say contributing code or feedback back to GitLab so
> they become official builds?).

Good luck with that, it took more that 2 years to GitLab to officially=20
support AMD64:
https://gitlab.com/gitlab-org/gitlab-runner/-/merge_requests/725

Hopefully the first non-x86 user was the hardest one who had to do all=20
the bad work, and next architecture might get supported quicker...

>=20
> Cheers,
> - Cleber.
>=20


