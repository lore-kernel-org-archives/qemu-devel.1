Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006E1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCDA524655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0e8nI26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDA524655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42803 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGps-00025x-Na
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iuGnc-0000Nq-76
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iuGna-0003gp-Nh
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:16:03 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iuGna-0003g8-GT
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:16:02 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so7383684wmb.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 06:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4vO+yaUc8q6iat2N0cNnM3x/5wU/K46MLWfvk54lEnY=;
 b=F0e8nI26tV0+PrKlRLh5Ior6ECwugCF89BsyrsDsqviUdPicu6BYqhy7y3uWSLf1bh
 vMm6c8t0mpXnU8FeHLGRsczh6IsJjqg391SJAV1BEmBCa/qg5P/NGCuBwLoT8LFO7t+m
 oY+p7YhUpo0CJ9Y/8ETjLgUh1RXYsC6/lC8u2QSmfQB3s5+gPjhjZuPUpYTXvxYwqgXC
 Hfgzi7FJXap3FGNNCRxHOYfVt2+S5O3K8hmODAP+1MZKq0PZ7p+P0dO6n36wwtWpsgyr
 1FFECB5STfh2lMA/G3zdy4nB8uE95cR294WqrtXt9IRTM6I//Zlpa3Se0O6RZDOzLkrG
 3+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4vO+yaUc8q6iat2N0cNnM3x/5wU/K46MLWfvk54lEnY=;
 b=j4rqcR0ZFvokFHoLPJrZ4ILJbR9j4sjDTMQM5TLh6R7KxkY+dt1chUXksLb4GNlWQ1
 GQlO1CFMYp3o84n4c+jJhM98cRh7es+BzIf8WPY3+PDJQfmMzUhDIFN5DCt+TrJqEqWc
 pcPYZSm5mCampmGzfBCcHrIG8er/+hPoCwiYtjjflml5VfvS2bd6kFSzd0JIXbbtHYCb
 uWypHBXDuRg6lQjTqiWSRuMIU5f90UFqs8uok0//BitemNRNfNodACDC19jlf+RvmsUP
 IeS2x6nrTRqiWmxkVd6ZARbXRTe72c+X27cMZzGHVKLnLHowtAQeOZJWzxn9BX+j3+NP
 z8Nw==
X-Gm-Message-State: APjAAAV09+XDkhOR/AyAf5QnabUJLazjUmpjxOU3euEq71xk+pWlbfGl
 gSkHIutJPsWpOB3f94D3J9Brgg==
X-Google-Smtp-Source: APXvYqzZbJhniunCbW3iNpxCGfDgHo6VoleAX3J51Zd24Up+iVh+LNrk6PrWWLaIpiLIme6sBra1hg==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr3187098wmj.37.1579702561281;
 Wed, 22 Jan 2020 06:16:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z133sm2161029wmb.7.2020.01.22.06.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 06:16:00 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 266861FF87;
 Wed, 22 Jan 2020 14:15:59 +0000 (GMT)
References: <20200122102223.20036-1-alex.bennee@linaro.org>
 <f4d6b334-1a4f-78be-c0d1-f53cf2e288d6@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v1 0/3] current testing/next queue
In-reply-to: <f4d6b334-1a4f-78be-c0d1-f53cf2e288d6@redhat.com>
Date: Wed, 22 Jan 2020 14:15:59 +0000
Message-ID: <87pnfbzie8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 richard.henderson@linaro.org, f4bug@amsat.org, qemu-devel@nongnu.org,
 cota@braap.org, stefanha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Wainer dos Santos Moschetta <wainersm@redhat.com> writes:

> Hi Alex,
>
> On 1/22/20 8:22 AM, Alex Benn=C3=A9e wrote:
>> Hi,
>>
>> There isn't much in my queue at the moment. The move of the various
>> compilers to buster fixes one of the shippable problems. I have a
>> longer series cooking to support multiarch docker builds which I'll
>> try and get posted by the end of this week.
>
> Do you mind to pick this up too? ->
>
> [PATCH 0/1] travis.yml: Missing genisoimage package
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg669898.html

Sure - queued.

>
> - Wainer
>
>
>>
>> Alex Benn=C3=A9e (2):
>>    tests/docker: move most cross compilers to buster base
>>    tests/docker: better handle symlinked libs
>>
>> Thomas Huth (1):
>>    gitlab-ci: Refresh the list of iotests
>>
>>   .gitlab-ci.yml                                   | 12 ++++++------
>>   tests/docker/Makefile.include                    | 16 ++++++++--------
>>   tests/docker/docker.py                           |  3 ++-
>>   tests/docker/dockerfiles/debian-amd64.docker     |  2 +-
>>   .../docker/dockerfiles/debian-armel-cross.docker |  2 +-
>>   .../docker/dockerfiles/debian-armhf-cross.docker |  2 +-
>>   .../dockerfiles/debian-mips64el-cross.docker     |  2 +-
>>   .../dockerfiles/debian-mipsel-cross.docker       |  2 +-
>>   .../dockerfiles/debian-ppc64el-cross.docker      |  2 +-
>>   .../docker/dockerfiles/debian-s390x-cross.docker |  2 +-
>>   10 files changed, 23 insertions(+), 22 deletions(-)
>>


--=20
Alex Benn=C3=A9e

