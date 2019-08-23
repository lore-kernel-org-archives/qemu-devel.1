Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2DDC41514
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367452339D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367452339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i19Qx-0001lI-5O
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 09:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i19PH-0000uR-QR
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i19PG-0002Jm-7j
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:15:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i19PG-0002JH-0B
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:15:06 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2D102A09D3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 13:15:04 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id m26so2975488wmc.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 06:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1bWQR+GTJVZ+EGI8+KybYEbLPBUZCRPQIaWtiXEj6DA=;
 b=Knxq7PsrWuk6UCQM+RyM63pztNMgIOIOScCbZ8B3c6qRYFeDwn51lrqWERxQ/5e+uX
 bi/uOKSZmPMgwhzRrM1wyoQhiRpT9L3emG6qeb1O+mO9cLx4zpaI1sOlZX/eRBN9YUze
 baEI9bOnnPNYUKB956IwYOVveCCFuRSI/JlmAZ/Fnhjqfh5D1ZdfdqnNAuZMBAzli0ul
 O6wh2fQH6wF38cW9P1k8NWBcMHSzJd23PME+nGRljvHCMSBdtxbIEOUg6F8PP8Lk0YGK
 WboEMo4JL5/KM+T1wPPyOOvKxhvUTYf3HmP3lpP8AvhDsU9RldxrtXKLpZsUXS6UghnU
 mDGw==
X-Gm-Message-State: APjAAAXPZQLdGmXu0sZHfjOZ/VwUVuq1Ii7GaXMQ4mqk6aprr9nritpY
 Lcv9c5Tf4a5h0ZuD8VtE1KMpPYcnsKqvLUOA3re2q0Wdb9Cp8UHErE+3jyDAomyf1Mf2G2J/lx0
 ONA43zRVmHdbtRbg=
X-Received: by 2002:adf:e390:: with SMTP id e16mr5395270wrm.153.1566566103493; 
 Fri, 23 Aug 2019 06:15:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwY8nLNXFZ2jefnDr0eeTY7FFjRHll505CEIglUUzCqz9Pjh7tpFNevyOCBNIEHFo5JXwOs9g==
X-Received: by 2002:adf:e390:: with SMTP id e16mr5395220wrm.153.1566566103138; 
 Fri, 23 Aug 2019 06:15:03 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id 2sm3315811wmz.16.2019.08.23.06.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2019 06:15:02 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
 <20190822114747.GS3267@redhat.com> <20190822163150.GA3332@work-vm>
 <9caf3a64-0841-dde6-3413-a77dc80e22bd@redhat.com>
 <20190822165045.GM3277@work-vm>
 <b9f98b17-49c4-a227-ab87-de4a6f42f089@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a9fdc89e-bc75-59c5-2e1a-12c50b3e92de@redhat.com>
Date: Fri, 23 Aug 2019 15:15:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b9f98b17-49c4-a227-ab87-de4a6f42f089@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] more automated/public CI for QEMU pullreqs
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/22/19 7:05 PM, Paolo Bonzini wrote:
> On 22/08/19 18:50, Dr. David Alan Gilbert wrote:
>> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>>> On 22/08/19 18:31, Dr. David Alan Gilbert wrote:
>>>>> With both these points in mind, I think it is  pretty hard sell to
>>>>> say we should write & maintain a custom CI system just for QEMU
>>>>> unless it is offering major compelling functionality we can't do
>>>>> without.
>>
>> (That was Dan's comment)
>>
>>> In theory I agree.
>>>
>>> In practice, the major compelling functionality is portability.  If i=
t
>>> is true that setting up runners is problematic even on aarch64, frank=
ly
>>> GitLab CI is dead on arrival.  If it is not true, then I'd be very ha=
ppy
>>> to use GitLab CI too.
>>
>> IMHO if for some weird reason Gitlab has problems on aarch64 then we
>> just need to get that fixed.
>=20
> I'm sure it's just some packaging or deployment issue.  But
> https://gitlab.com/gitlab-org/gitlab-runner/merge_requests/725 has been
> open for more than one year; the last two messages are:
>=20
> * 1 month ago: "I hope we will be able to merge it soon"
>=20
> * 3 weeks ago: "Today I tried use gitlab-runner on my arm64 box, howeve=
r
> it kept mysteriously failing"
>=20
> So the question is simply who does the work.

IIRC Samuel Ortiz told he was using GitLab with Aarch64 runners around
Nov 2018, but "compiling from source". Alex Benn=C3=A9e tried building it=
 on
our Packet server during early 2019.
Later an (unattended?) Ubuntu upgrade installed a package that does not
work anymore with current GitLab server. I noticed this few months ago,
built it again and tested it, then looked at what was wrong with the
upstream MR. The Aarch64 packaging succeed when cross-building on x86_64
host, but fails when building natively... Since part of it is "built or
tested in the cloud" and involving Go, I simply let a comment:
https://gitlab.com/gitlab-org/gitlab-runner/merge_requests/725#note_18347=
0145

So to confirm what Paolo said, GitLab runners work on Aarch64
(and we have it well tested), however there is a packaging issue,
so it does not work "out of the box".


Related to:

  Runner compiled with Go 1.8.7 seems to not work properly with
  multiarch support. Executing the binary built with Go 1.8.7
  results with an error [...]

There has been 1 recent fix for the go runner:
https://bugs.launchpad.net/qemu/+bug/1838946/comments/1

And there is an ongoing discussion about "patch to swap SIGRTMIN + 1
and SIGRTMAX - 1".

