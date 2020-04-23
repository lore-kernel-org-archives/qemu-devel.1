Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FE6C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62E12076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r9p5K7sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62E12076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRg13-0003H6-O0
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRg09-00021o-3H
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRg05-0000gy-5Y
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:51:04 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jRg04-0000gZ-OA
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:51:00 -0400
Received: by mail-ot1-x344.google.com with SMTP id 72so7622051otu.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 10:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QBl/1uXw+Q2w6cFkx/zgJOnbYRA+7r+ZtVCu0o5uRxQ=;
 b=r9p5K7skW9BshD2lRFrJfNdhPg8sR0iCp8Lb7aHME0oDOKDoZ1gAngzORYFePjsJO0
 3ihpaXA69VQISGLP/+YWWe9vgPq0Z9dfD9VXm1lmb8IxeQTSBxKvbjeuQUiQPUsDFH/h
 UV4HWoem8CY1gMtba71umMU+TlDcHO/DwU4JaxvyEWUy6RF7VVIHYmyIEX0rsitkTgf2
 QscXqb1DU3xinJ1JZ8fKn9HaVvBd1Ck6zVfeB5He8Fh+zl0XGQpVtrvhhG8nl7EGq10h
 Hj9FdD6Gx5/yYEU/3R3wkZ9KpB/VR1y+DyJQEPbLcuX3qLfmSn4vQDOAaJ4yHfddYtVi
 IFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QBl/1uXw+Q2w6cFkx/zgJOnbYRA+7r+ZtVCu0o5uRxQ=;
 b=ZjyfA3FZ1KzYLpqeVo292QihpxcXjtQAfJht0Riwn+hByN8jZfHKh7zqCaMu3eEMbU
 ezrHEW80W2N0AnVc5VIMTkway8DULJfmxlbQkDsNH7j813X3fV/YQKHTW8S3WmuBAggP
 pvGLxsJAnykUAyDm4/+/3AZwo7umaLYThuLU5I20Z+a7coIW8IBDoOie5O4/SfU4JiEZ
 aRDlviV+QScNCEdV9u7UITTCNXrgSze+OA4ULHO+FUruY1MQ6hr+P2TST8gxcdO9htr+
 yefFYJ58+t8pwU+zYgCdhYvHUADLFARLg3kESGo+ZJzkM6gcix9Ki5ct2jsk28DFgXJS
 SnCw==
X-Gm-Message-State: AGi0PuY1GkDtj9kMB9B0tE2na/+E77vs1aW0BH2olqb2DZJmsmCRcOUs
 10suk60UoFdXBzRRwYaE2J41T7MS29XhC43/VslJUQ==
X-Google-Smtp-Source: APiQypIXpq2bnk3+QERWRoTO0+IY5IZEA71/iVVWjk01YgDtkWbykP9veAd9kj3tNvR9SSDN4cu4mgQ317Jj+JqCuws=
X-Received: by 2002:aca:3441:: with SMTP id b62mr2586894oia.146.1587664259273; 
 Thu, 23 Apr 2020 10:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
 <20200423171322.GJ1077680@redhat.com>
 <348064782.9653447.1587663408130.JavaMail.zimbra@redhat.com>
In-Reply-To: <348064782.9653447.1587663408130.JavaMail.zimbra@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2020 18:50:47 +0100
Message-ID: <CAFEAcA_mytLVYUNSOJMUZfSwWXER_x=EPvT0vd3txdTpMhwjPA@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Apr 2020 at 18:37, Cleber Rosa <crosa@redhat.com> wrote:
> We're already using the shared x86 runners, but with a different goal.  The
> goal of the "Gating CI" is indeed to expand on non-x86 environments.  We're
> in a "chicken and egg" kind of situation, because we'd like to prove that
> GitLab CI will allow QEMU to expand to very different runners and jobs, while
> not really having all that hardware setup and publicly available at this time.

We do have the S390 machine that IBM kindly made available to
the project -- that is not a personal or Linaro machine, so
there are no issues with giving you a login on that so you
can set it up as a CI runner. Drop me an email if you want
access to it.

thanks
-- PMM

