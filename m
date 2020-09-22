Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61895C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:42:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BCB2085B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLFH5u3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BCB2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKdsD-0001vN-TO
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKdop-0005Hq-55
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:38:35 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKdon-0008AC-6m
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:38:34 -0400
Received: by mail-wm1-x341.google.com with SMTP id z9so2431443wmk.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dRHyt9qMeda9KwS8V8qbvE8Y4ARojDzhm5yCJq9xKoE=;
 b=QLFH5u3a57ByzkqnptfQ47BAbywavEMH3F1vCiRd9ueQxZ5mstHFItw7luNOtUEfnQ
 i7+4YqvxS4P3Uqs/Qo7ULW61fEVCAteo9ZxWwxbfjJyvT8jHUZualUYH8Ndr1EPrO99r
 Z7XCYsm9t4wwllgdpN8RRwhhM6uCjCQz3/SiCn7YN1ZTK8cfWZFAjoq5NYl2ABLAuUrs
 sAVMt5MNfS0CuPJiU5Dg9f0DclCdoKmduE/xbRX47WVBr3SiI1gju+jMKU5L8iudozYa
 YFIVYNA6V9biHecYmn+Rxjv04h1VVH0MR8L6Uw5NVsDmdxPduFL0G0RrD5yn0G3n5iMY
 FYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dRHyt9qMeda9KwS8V8qbvE8Y4ARojDzhm5yCJq9xKoE=;
 b=WlE4Pgf7zxjO3Nj9zzRjBOZjrmNSM52FTaWBKDnX0lvT/k5Jh+MC8/Qqclv0oup1/G
 IJF3NQL3FSXPFi/GLlRyuJQOot7sWEZY+OaxlcBpqFzsNQhIO0rRjOW0gvVQ09L+Wuhe
 kYo7ZLn01lGo+WEs/XDc6bYFbJLzqnv0ljHKZsKIUJNiJvzT0AcCpUZFzw/6CRcc/fyk
 U/QngigKAAUWSxhKcRWG1o2W9BfR26PUuUqsrcn3yk0raO7vYXnAXjPCoAcYO17G2oeo
 PVs5cV5XnP3LxkwG7+IjwulxrvlVWpzsksaLBoQv7nxWSjAMf3QJTK//0Ico2o4BCYwQ
 f9CQ==
X-Gm-Message-State: AOAM531A6qGa12sd4koOPq66YJsP6UiNp0Ck9DGU0FeJ9L8mS4ml299h
 KlTBpuAfYhpUod/6WQPR9xXqVM+pJFwYZA==
X-Google-Smtp-Source: ABdhPJymwVxm43cTHkGfI9wvWM7tJt3ZyiVWJQScVfRhhDyfrmzn5IRAOvTMVg242e/8YD8RGgTZlQ==
X-Received: by 2002:a1c:bdd4:: with SMTP id n203mr3279587wmf.119.1600763910919; 
 Tue, 22 Sep 2020 01:38:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 10sm3351861wmi.37.2020.09.22.01.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 01:38:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 620CB1FF7E;
 Tue, 22 Sep 2020 09:38:28 +0100 (BST)
References: <20200921174320.46062-1-thuth@redhat.com>
 <87r1qvngsg.fsf@linaro.org>
 <4b78dd56-c94d-5720-4f57-ac251526f461@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/7] Do not support Debian 9 and Python 3.5 anymore
In-reply-to: <4b78dd56-c94d-5720-4f57-ac251526f461@redhat.com>
Date: Tue, 22 Sep 2020 09:38:28 +0100
Message-ID: <874knqnr3v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?utf-8?Q?Daniel_P_=2E?= =?utf-8?Q?_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 21/09/2020 20.09, Alex Benn=C3=A9e wrote:
>>=20
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> Debian 9 is EOL now, and according to our support policy, we do not
>>> support it anymore. Let's switch the corresponding CI builds to
>>> either Fedora (for a more recent version of the MinGW compilers) or
>>> Debian 10 instead.
>>>
>>> Together with the Travis patch series that I recently posted ("Update
>>> Travis from Xenial to Bionic and Focal"), our CI should now be free of
>>> distros that we do not support anymore. And all supported build systems
>>> now use at least Python 3.6, so we can drop the support for Python 3.5.
>>>
>>> Based-on: <20200918103430.297167-1-thuth@redhat.com>
>>=20
>> I'm inclined to take all of these but I'll take all the CI based ones
>> now and add the 3.6 bump if there is more review/acks for it.
>
> Thanks! ... but I just noticed that I missed to send out the patch that
> removes the Python 3.5 job in .travis.yml. I just sent it out now, title
> is "[PATCH 7/6] travis.yml: Drop the Python 3.5 build" ... please make
> sure to also queue it if you include the patch that bumps the Python
> version.

I too noticed on my test run, will include it in the re-spin.

>
>  Thomas


--=20
Alex Benn=C3=A9e

