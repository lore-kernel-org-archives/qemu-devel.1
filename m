Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1FFC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 16:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB1B207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 16:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFumm5PG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB1B207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5ui9-0002rq-BA
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 12:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5uhK-0002JJ-Ld
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 12:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5uhJ-0000Cg-2b
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 12:33:26 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37609)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5uhI-0000Bk-R4
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 12:33:25 -0400
Received: by mail-wm1-x342.google.com with SMTP id r195so3865180wme.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aEZvbzosqY3Q6Hbja7X8KBDdVqNhMYVMoNI8EHOHasM=;
 b=sFumm5PGlT4QYvj7OM9gXpcgqwUz0mAl9aQO0TpUOM8zQO7Rq9fi1wCKzxey1upZjK
 3OBD1Meia3QSL1NsHc6XiRorp1+oF0ssAb+ruVEFjxFsSCE6MemeZt61Is/1bSNEYBAK
 J1H47bSjk0FS9HG24Y8wML2NafT9VIFNQb//AhjaF8i/ZLQ8jLhH9c+AeugREIesa52s
 QAP9E3A0JzJoeCTTR4PVEAd5PRHVKR99Q6wNvynLdKygD27YJrTaUZn5H9SWwgNEd/13
 aJ9az1xMFR+a/ySg/v3JFlqqFtEPBniFzXVh7VqHWQ425XTFBOqxeP6uQ6QKW8kk3ghZ
 eiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aEZvbzosqY3Q6Hbja7X8KBDdVqNhMYVMoNI8EHOHasM=;
 b=G9qPIdEud03O04UEzPzswB93lGrh3MnxSj4ZjExzDldjCbDO3wneUaefvc/R3EvHzL
 i4tPuegmI+qfn0qOZHenaJQh/JorebH4pklcREcaI4zlcl1JYdaSv3Ok6aQpucNN2pqN
 YBs6Eifd+QG1uGmxzV0o4HKdZC91KWupFLYbQY1wr/UV7Z3QoWWIrxN/gAsKe3hT2XY4
 8vO8WLz82oyr6a2bpTFI/Sx+UbM0hF4XbAtuMahJvoYWjuBtyA+260j8TF5OfrLq//AN
 SppUNap9YgPhyXNJ3QeJPiDLdMRj4PjRT0rHv3nwCEBCv25QkQU2+AAiv0ftaRDlflle
 0sBg==
X-Gm-Message-State: APjAAAVTAWaev/Q8QlZKpWVQOWaC1xwyQf5Wf5HoP5Pjx1CkyMfsZjiA
 y3797MmGTHl+XdpC08jgqdh3EA==
X-Google-Smtp-Source: APXvYqysuvhk1Q/FcwQY3efQLNKxKk5eND9Kf5bWfNbEENqHrvDYI7aCiTYSMBqByFWP9tT6DQoZnw==
X-Received: by 2002:a7b:c752:: with SMTP id w18mr3552054wmk.129.1567701202724; 
 Thu, 05 Sep 2019 09:33:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g185sm6018378wme.10.2019.09.05.09.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 09:33:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A8F61FF87;
 Thu,  5 Sep 2019 17:33:21 +0100 (BST)
References: <20190713143311.17620-1-marcandre.lureau@redhat.com>
 <7ba6e0be-fd12-4f21-0fb8-bf9071cb2062@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hildenbrand <david@redhat.com>
In-reply-to: <7ba6e0be-fd12-4f21-0fb8-bf9071cb2062@redhat.com>
Date: Thu, 05 Sep 2019 17:33:21 +0100
Message-ID: <8736ha8zzi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 0/6] tests/docker: add podman support
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
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathi?= =?utf-8?Q?eu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> On 13.07.19 16:33, Marc-Andr=C3=A9 Lureau wrote:
>> Hi,
>>
>> podman allows to run containers in a similar fashion as docker, but
>> without daemon or root privileges. Thank you podman!
>>
>> There is a weird issue with getaddrinfo(), that I reported upstream
>> https://github.com/containers/libpod/issues/3535. For now, it is
>> worked around with extra socket_check_protocol_support() checks.
>>
>> thanks
>>
>> v3:
>> - add --run-as-current-user, suggest by Paolo
>> - move podman user tweaks to docker.py
>> - rebasing
>>
>> v2:
>> - add socket_check_protocol_support() to test-char
>> - keep TAP harness happy when socket_check_protocol_support() fails
>> - removed bad AI_ADDRCONFIG patch
>> - rebased
>>
>> Marc-Andr=C3=A9 Lureau (6):
>>   docker.py: add --run-as-current-user
>>   docker.py: add podman support
>>   tests/docker: add podman support
>>   tests: specify the address family when checking bind
>>   test-char: skip tcp tests if ipv4 check failed
>>   test: skip tests if socket_check_protocol_support() failed
>>
>>  Makefile                       |  2 +-
>>  tests/Makefile.include         |  2 +-
>>  tests/docker/Makefile.include  | 10 +++++--
>>  tests/docker/docker.py         | 53 ++++++++++++++++++++++++++++++----
>>  tests/socket-helpers.c         | 17 ++++++++---
>>  tests/socket-helpers.h         | 11 -------
>>  tests/test-char.c              | 19 +++++++++---
>>  tests/test-io-channel-socket.c |  4 ++-
>>  tests/test-util-sockets.c      |  4 ++-
>>  9 files changed, 91 insertions(+), 31 deletions(-)
>>
>
> Most probably not related to this series. I assume I am once again doing
> something very wrong (although this used to work). I am on Fedora 30 -
> hope somebody can help me:
>
> t460s: ~/git/qemu mvc $ docker run hello-world
>
> Hello from Docker!
> This message shows that your installation appears to be working correctly.
> [...]
>
> t460s: ~/git/qemu mvc $ tests/docker/docker.py probe
> no
>
> t460s: ~/git/qemu mvc $ ./configure --target-list=3Di386-softmmu,...
> [...]
> docker            no
> [...]
>
> So docker is working but the configure script says I don't have docker.
> What am I missing? (I only want to run tcg tests)

See:

  Subject: [PATCH  v1 02/42] configure: clean-up container cross compile de=
tect
  Date: Wed,  4 Sep 2019 21:29:33 +0100
  Message-Id: <20190904203013.9028-3-alex.bennee@linaro.org>
  In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>

But there are other fixes in that series to make it work with check-tcg
better.

--
Alex Benn=C3=A9e

