Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001D7C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A6321848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A6321848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0vg7-0001iZ-RH
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 18:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0ver-0000cC-Mg
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0vep-0001F0-Rx
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:34:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0vep-0001Cw-Eb
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:34:15 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A67C6550BB
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 22:34:13 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id a2so3869727wrs.8
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 15:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vh/voO0naPsXCAhLgL+kzbjomLZf/kcT43Mi9Q5rUmY=;
 b=V28JSbXnNHu9frUDH1I2kp6XMFaPFIJpPZbip5i4Li855p0lUXtztIP3oWSggdTa/t
 Ph78K588LwWwLJLeUj4TY5NAJbYp17/Ua2NZ52NLMl9YVV96O3NIHiuox/Yb2p5r68+B
 3mU1DUS7h8VLBQQ9qxNqVcLiwpCr9r98XIoMhCFZdZIrVu8JHwgsn3HPwJd+cuvqBdwC
 HDJWC6dX60S6uGKmtr0Af03KicMuMMVC6WptqYIke/7S5w2U1G5BgoV6HSmZjY8kGKSe
 C9RZiDgaBIuIImSE9TqmVC5rLQZavWWpXHMl34oVmpInin1w/gjw1Kp//sFK+r1hGgb4
 xw2g==
X-Gm-Message-State: APjAAAWooroJFS62w27FxuaFFQyst85VgS5AuTaxSlbK+Om9EsqNC+pf
 7gic3GdU3n58rpy/tvNrJFgHZPucx1pjDfi+vnbLX8lBytsEQGBNRM3Ef3L5MOLa2950NFPNmQx
 YebugvHTSJZYy6WM=
X-Received: by 2002:a1c:9950:: with SMTP id b77mr1324482wme.46.1566513252364; 
 Thu, 22 Aug 2019 15:34:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxnOGWp4/2fjcrhQKJ1S8A9WYdb24B6nmNjPEPttKZV5pd3tbgScsxFJWY4SyVZbF/PWk4Yvg==
X-Received: by 2002:a1c:9950:: with SMTP id b77mr1324470wme.46.1566513252105; 
 Thu, 22 Aug 2019 15:34:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id o14sm1929966wrg.64.2019.08.22.15.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 15:34:11 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org
References: <20190817085443.11471-1-thuth@redhat.com>
 <20190817085443.11471-3-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <60924a33-8297-0f27-4cfe-c225647290a6@redhat.com>
Date: Fri, 23 Aug 2019 00:34:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190817085443.11471-3-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 2/3] tests: Run the iotests during "make
 check" again
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/08/19 10:54, Thomas Huth wrote:
> People often forget to run the iotests before submitting patches or pul=
l
> requests - this is likely due to the fact that we do not run the tests
> during our mandatory "make check" tests yet. Now that we've got a prope=
r
> "auto" group of iotests that should be fine to run in every environment=
,
> we can enable the iotests during "make check" again by running the "aut=
o"
> tests by default from the check-block.sh script.
>=20
> Some cases still need to be checked first, though: iotests need bash an=
d
> GNU sed (otherwise they fail), and if gprof is enabled, it spoils the
> output of some test cases causing them to fail. So if we detect that on=
e
> of the required programs is missing or that gprof is enabled, we still
> have to skip the iotests to avoid failures.
>=20
> And finally, since we are using check-block.sh now again, this patch al=
so
> removes the qemu-iotests-quick.sh script since we do not need that anym=
ore
> (and having two shell wrapper scripts around the block tests seems rath=
er
> confusing than helpful).
>=20
> Message-Id: <20190717111947.30356-4-thuth@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> [AJB: -makecheck to check-block.sh, move check-block to start and gate =
it]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

This breaks when sanitizers are enabled.  There are leaks reported,
though I'm not sure if they are real, and in additions the warning lines
break qemu-iotests' output comparison.

Paolo

