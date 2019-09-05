Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB9FC3A5AA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F124C21883
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F124C21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5p7m-0002I2-Sd
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5p4a-0000cV-3i
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5p4Y-0004Ra-TP
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:33:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5p4Y-0004Qs-Lj
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:33:02 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 92AF387648
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 10:33:01 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id b9so794143wrt.5
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 03:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9RMBRmu5TY7gCeyRrb25rDg7vQUUMtC7fHf/hUJINyM=;
 b=UXPtL7Y62p7okI7JEkJS3GDVisyKUfdDt5tHJSnFnzE5nxdfFRCh/flh226NQ8TzLm
 yngLR0IJoYZRqecM40V1RScFCppOhaq5pQbZQKkBkNYXdVPNkvmhi2OilwVwMPp1NsNy
 Ygk9YRbFbJyOB+XKU5TSmZFSp1ul4PDjW4jFTySYlppZ8zBSxWwqxI8e7dR9Aplu9fme
 6hq8jVPjXhCN/ISBRFT2++zLrzIGtJ1VdF0s2VjOwmOsKv/63eh9WeY1Fo1f+YtEESiP
 1iBp0+EV5nE0wM4FwZwPvbAxLrix5OFZfqpUrSOOuhmcyOMUMbvYVscgFfh9t4XxrWb/
 8Lcg==
X-Gm-Message-State: APjAAAX52PJqgwzP0nR1PVF4cqLxkj6z2rDzWtbqlE2KRIyb/ECJDfmZ
 T+uvL0wdz3SpGqTZg+npfMMVLxLk55xSxvzUkq+Z7lXps6qznMXdrHr2asnK5aRcHy05ktOS+Hz
 eTRZzYuxFnXXyr/c=
X-Received: by 2002:a1c:540c:: with SMTP id i12mr2530399wmb.90.1567679580356; 
 Thu, 05 Sep 2019 03:33:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxhe4WgJIwZfZyaF7zkbH99qu4TdD0KCCJyh//WhdrzkJ85nXOi6Gd4IH4rqIab6m1wTzWZnw==
X-Received: by 2002:a1c:540c:: with SMTP id i12mr2530389wmb.90.1567679580181; 
 Thu, 05 Sep 2019 03:33:00 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id m62sm2952897wmm.35.2019.09.05.03.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2019 03:32:59 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-42-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <52e5767e-df13-9a94-e1c2-3798af3090c8@redhat.com>
Date: Thu, 5 Sep 2019 12:32:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-42-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 41/42] tests/docker: --disable-libssh on
 ubuntu1804 builds
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/19 10:30 PM, Alex Benn=C3=A9e wrote:
> Currently this stops the mega:
>=20
>   make docker-test-build
>=20
> from working. Once the source is patched to deal with the case this
> workaround can be removed.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/ubuntu1804.docker | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/=
dockerfiles/ubuntu1804.docker
> index 44bbf0f77ae..883f9bcf31c 100644
> --- a/tests/docker/dockerfiles/ubuntu1804.docker
> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
> @@ -56,3 +56,6 @@ RUN apt-get update && \
>      DEBIAN_FRONTEND=3Dnoninteractive apt-get -y install $PACKAGES
>  RUN dpkg -l $PACKAGES | sort > /packages.txt
>  ENV FEATURES clang pyyaml sdl2
> +
> +# https://bugs.launchpad.net/qemu/+bug/1838763
> +ENV QEMU_CONFIGURE_OPTS --disable-libssh
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

