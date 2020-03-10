Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED82C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E5620675
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBw4d8GV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E5620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBf8t-0001xf-Nl
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBf7p-0001V9-En
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBf7n-0003oO-BM
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:40:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBf7n-0003j7-2g
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:40:47 -0400
Received: by mail-wr1-x444.google.com with SMTP id r15so10873849wrx.6
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3c0cJvcAMctTZuD5Yu/ZuAhVdLo0yyDCDdEEtCcYzO4=;
 b=jBw4d8GVaxRFJCna973Wu3JqHtgcpg1jqU/D/y4QeyQdJeHy+JBOusd4tAv1V7GR+W
 +Te5zDL/t7URVtfy2uadcVJ/mGcSPcdnlqw4jCq8pQ+I1fTV7M9fNAk1eEY3VP4YvKUL
 SVWhfk6A4Zi8v9xr8BIgQpWsgYLjweL8FI+VEidVrRssSyIC9Fwe1QRyIBZH8xL1VrWV
 FUYz1AJ6J0BeUwidjhTM8IPKZsxwBiNJgw1z823F+OAoB8iQjLBkknrm3UG8zRHNb9Cl
 uA2MFubXK4b3TIlvHyAX2b/7vWg/eXmngq1mBSFJ07CQx7rFhtog0Wiur4NR6u1damya
 uL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3c0cJvcAMctTZuD5Yu/ZuAhVdLo0yyDCDdEEtCcYzO4=;
 b=TDksMy1zQd3Kl2VrVhEPfenL3F989g+AZJnI1Rb6I1tUZBSu9O65DpkMEf9FQDKeW/
 vzPJhWN9zyBhPzG0y3Gwo4n6AYBhXOl2gdtEFOvWCPAKh74KKSoZbsouCLl8Pmn2Z2XG
 Mfy4aIWc/z86XkZTTv4oZsxXWAl8nDp5AarYQ1idZJj+o/cR+gicdU3hiq/anvew9580
 K3m044io+u5PU4CM8rsEyhJCjNb2m9ECvZtdFOAKqOUV/Jqp/YcGheRLu6j40nSBSFTO
 Lud9LxOsRE5hd9bezqF2hecxt9+nCCBWmg5iKkEX9QPuprkY70I5izZRUVOPBqYdtVy+
 2rFQ==
X-Gm-Message-State: ANhLgQ0HK7xhkQXVeMavAgJObCqB05jaKO/7oMcy8fdB3003gDYJr9E3
 VGtL9nE1WiU8eLrGld4zqG//wg==
X-Google-Smtp-Source: ADFU+vs6t+umDuH+X/+hXJagpC508IOpolepb0POCkvCZppiGegdyip4QPv89j643XnD5GRnisIpOw==
X-Received: by 2002:adf:df8f:: with SMTP id z15mr27188185wrl.184.1583847641000; 
 Tue, 10 Mar 2020 06:40:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c3sm15567902wrw.95.2020.03.10.06.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 06:40:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D0E9B1FF7E;
 Tue, 10 Mar 2020 13:40:38 +0000 (GMT)
References: <20200310083218.26355-1-kraxel@redhat.com>
 <20200310083218.26355-4-kraxel@redhat.com> <87lfo8ijfg.fsf@linaro.org>
 <20200310120232.6lor5opu7iykqgcr@sirius.home.kraxel.org>
 <87imjcies8.fsf@linaro.org>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 3/4] tests/vm: update FreeBSD to 12.1
In-reply-to: <87imjcies8.fsf@linaro.org>
Date: Tue, 10 Mar 2020 13:40:38 +0000
Message-ID: <87ftegiazt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Fam Zheng <fam@euphon.net>, Kamil Rytarowski <kamil@netbsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Gerd Hoffmann <kraxel@redhat.com> writes:
>
>>> > -    link =3D "https://download.freebsd.org/ftp/releases/ISO-IMAGES/1=
2.0/FreeBSD-12.0-RELEASE-amd64-disc1.iso.xz"
>>> > -    csum =3D "1d40015bea89d05b8bd13e2ed80c40b522a9ec1abd8e7c8b80954f=
b485fb99db"
>>> > +    link =3D "https://download.freebsd.org/ftp/releases/ISO-IMAGES/1=
2.1/FreeBSD-12.1-RELEASE-amd64-disc1.iso.xz"
>>> > +    csum =3D "7394c3f60a1e236e7bd3a05809cf43ae39a3b8e5d42d782004cf2f=
26b1cfcd88"
>>
>>> Warning: Permanently added '[127.0.0.1]:39533' (ECDSA) to the list of k=
nown hosts.
>>> Bootstrapping pkg from
>>> pkg+http://pkg.FreeBSD.org/FreeBSD:12:amd64/quarterly, please wait...
>>> Verifying signature with trusted certificate
>>> pkg.freebsd.org.2013102301... done
>>> Installing pkg-1.12.0_1...
>>> Newer FreeBSD version for package pkg:
>>> To ignore this error set IGNORE_OSVERSION=3Dyes
>>> - package: 1201000
>>              ^^^^
>> 12.1 package
>>
>>> - running kernel: 1200086
>>                     ^^^^
>> 12.0 running
>>
>> I saw that too, but only *without* the patch.  The upgrade to 12.1 fixes
>> that.
>
> Hmm I wonder if the cached assets got confused? It certainly re-ran the
> install rather than skipping straight to running the test.

OK I'm an idiot... I hadn't correctly updated the branch on my test
machine:

  git fetch origin; and git checkout testing/next; and git reset --hard git=
hub/testing/next

vs

  git fetch github; and git checkout testing/next; and git reset --hard git=
hub/testing/next

>
>> We might consider setting IGNORE_OSVERSION=3Dyes, so this doesn't happen
>> again after FreeBSD 12.2 release.  Not sure whenever that can have
>> unwanted side effects though, like packages not working properly.
>>
>> Any advise from the bsd guys?
>>
>> cheers,
>>   Gerd


--=20
Alex Benn=C3=A9e

