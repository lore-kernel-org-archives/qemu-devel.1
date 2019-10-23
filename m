Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A3ACA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2EF2064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="seQU58Sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2EF2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNE1c-0008H9-Nx
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNDXw-0005OQ-6E
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNDXu-0003BO-30
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:07:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:51530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNDXt-00039f-6x
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:07:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id q70so13360738wme.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 03:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Z6lK17UQmr8eYfSUfvewTyfTNhH4uVDKwgkN/WXk0n0=;
 b=seQU58Sgeet0hvCg3bW/RlctHhpWbIa2/VEJaLLSywYyJAw8Di7K8OPyGCkhwpY47Q
 Jgsf0xXgknsl7YdH8bPtlto85ZeBGiAJM8ZPmVScFrr0DXJVoKwt7yAg8T4UI7fyJB3I
 YlrTTciArqZ1HiP+cMsElQCSkmMXIU1+MRnDMHzNI55pLnoDyhPpYY5BZYmRjCkGb/58
 SvAMRpDctDq6A0/WVzdykB20Pftd8BiMkoh8H88xDSb5s/9la60T4HQSzImL4OlB522B
 RNtiCTWEXwNWkmWJWtjUdSLUlW8+kdF5fRcO0q3Huz4NjopvZqERZTfr6NBi0HAR0BgX
 gSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Z6lK17UQmr8eYfSUfvewTyfTNhH4uVDKwgkN/WXk0n0=;
 b=bXw6IzGhcAaU5FNzD9XaTdX6QZZ4kvojddJJ3j36MAjbpskYJspPDv2asA9GLbMmQg
 02y4HYDB/4wjVWZ1yg9aO/0OAXBy2swt7VCJ5nEgDsG54J9EoMebTJ6kVc6jGlGlXBH5
 R+y5Gi1jAX1qui8FtZNO4phKNkbbdEFH2DCgv99nGGJTciN+fFRHUohPwORo9H0VZNIg
 WECmVoyCpYFrQHQB9c3GLtrVGot4Pc3iDRnbJMv55zdP38pQcIht2Ra1EAzjC33/MEtv
 Exxi1F1ohUlrvuKKZfo9daQs7tYOdBr5QbWaHGvkNmlvG9JvD0OfMW0DRm2a719eeQ0b
 1Y1w==
X-Gm-Message-State: APjAAAUU8OowW/6oSoF3k0h1RxR0tO6eFB658DZj5e4UH62vktqgNuAW
 jVtDIV0cGGkpJVJ8hTz8QScyMQ==
X-Google-Smtp-Source: APXvYqxtsJ/YIrEhbdQuKgbAaqbtVsUQ6ZkcE1vpSFgsM6Qu84nsU4Hk+chb2o2v9rI1DzI4Y3mVBg==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr7406606wmj.6.1571825231010;
 Wed, 23 Oct 2019 03:07:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o1sm17962595wmc.38.2019.10.23.03.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 03:07:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8F1B71FF87;
 Wed, 23 Oct 2019 11:07:09 +0100 (BST)
References: <20191022191704.6134-1-alex.bennee@linaro.org>
 <20191022191704.6134-8-alex.bennee@linaro.org>
 <2020367759.8121043.1571815677935.JavaMail.zimbra@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH  v1 07/19] cirrus.yml: reduce scope of MacOS build
In-reply-to: <2020367759.8121043.1571815677935.JavaMail.zimbra@redhat.com>
Date: Wed, 23 Oct 2019 11:07:09 +0100
Message-ID: <87y2xbvkqa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: fam@euphon.net, berrange@redhat.com, pbonzini@redhat.com,
 stefanb@linux.vnet.ibm.com, richard henderson <richard.henderson@linaro.org>,
 f4bug@amsat.org, qemu-devel@nongnu.org, cota@braap.org, stefanha@redhat.com,
 marcandre lureau <marcandre.lureau@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> ----- Original Message -----
>> From: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
>> Sent: Tuesday, October 22, 2019 9:16:52 PM
>>
>> The MacOS build can time out on Cirrus running to almost an hour.
>> Reduce the scope to the historical MacOS architectures much the same
>> way we do on Travis.
>
> Oh, really? For me, the builds on Cirrus-CI work reasonable fast and
> almost always finish within 20 minutes, e.g.:

It seems to be an intermittent thing:

  https://cirrus-ci.com/github/stsquad/qemu

but looking again maybe it's only the xcode build that is reliably long...

>
> https://cirrus-ci.com/build/4976412120842240
>
> Also the last macos_task from the official QEMU mirror on github finished=
 within 15 minutes:
>
> https://github.com/qemu/qemu/runs/269964092
>
> ... so was your issue maybe just a temporary dropout?
>
>  Thomas


--
Alex Benn=C3=A9e

