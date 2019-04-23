Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D50C10F03
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 00:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBEBC218DA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 00:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gAXZqqKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEBC218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33135 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ5Q5-0002QQ-9A
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 20:05:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5No-0001DK-54
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5Cc-0007SK-2S
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:51:54 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:45430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ5Cb-0007Rn-Rt
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:51:54 -0400
Received: by mail-pg1-x529.google.com with SMTP id y3so8381678pgk.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 16:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ut83/zAni/knfCuY3vmIr7CX5BTwDiDjQDoDEynbIUA=;
	b=gAXZqqKP3Dg2da4jRi4TtC/J3Q5L8pSuZQCM6+/Tiz62KZQIpahYlfiLdqv/Jy/jzS
	VcQIoalkfvDUSbDB5jWBhp+Bt+lYr7YDq12gFJKpoMot09GOn0YOPraR7eepQK3+zRx0
	K2lOjOeq3Gpa6VpW1P4ue3iSc4by6F6zoWDnYfGB2/2ctGw6WtEYcQXAGpNoY2tQYik9
	6jUOmomzncjd42wnIQHULvNwZxMiFs2p3DnDGbVtUKMz21wGxdin10jBJM8nV97UTIAd
	YaXXsur3ssO6DyNGgtduHmb79kTs9xhCFIcmm1mS0yYYbnJ4So05EeCtG2H8hkQ7wuSt
	56Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ut83/zAni/knfCuY3vmIr7CX5BTwDiDjQDoDEynbIUA=;
	b=VRcmOrHf5Tv1YvofXe5Tc3YIgW/r8snL9KenXWAsDa3H723t2yWr5eKfL8cOz3TkIo
	80y4s4JLDmVOP8+7IdRHaA3P8HMY+5aSk+nSTJSczrleNceZTNPJDafaUiwXopLSaeYD
	TriPMcJnzth+qm12ZEYsguv2S4CvBF9eQHRmsXZQ09qhlGJM1XiENdhdIcw1DL6H6WF5
	5/b6WOPTRyMeZOGNqsizdptcjuJPIYtoy46UUJBF41j+Etbv1xLh/a5mPzZRRUkNRXT3
	VXTgAf3wWJHE5fqWSN0NFqEVcR0eeNl9rz5FBtfK44f+VSse+Yw2aEUZMHlOIFPitz1I
	gmLw==
X-Gm-Message-State: APjAAAWgz0QND3gP3DP9kh7F6lL3tLDLwj8OEPtp9qE8cszuFOF2wS8L
	1JOCUtt4YArIBb7PiKzHK5g/5ejweVA=
X-Google-Smtp-Source: APXvYqynihZMPFKMiZKyamMrlxhkd8GWtP02JHs9N3HgemMpGr9mozSRBlqVv7lW9C9OFuIaUWZK8Q==
X-Received: by 2002:aa7:92d1:: with SMTP id k17mr30196783pfa.91.1556063512178; 
	Tue, 23 Apr 2019 16:51:52 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	p20sm14445849pgj.86.2019.04.23.16.51.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 16:51:51 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-18-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f32055b7-e698-9130-0949-825f27938692@linaro.org>
Date: Tue, 23 Apr 2019 16:51:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::529
Subject: Re: [Qemu-devel] [PATCH 17/26] target/arm: Overlap VECSTRIDE and
 XSCALE_CPAR TB flags
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423235149.5uUwFWa8Zw3E4tESc7kyYVc1KcVVq-r6renaIBQgAwc@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> We are close to running out of TB flags for AArch32; we could
> start using the cs_base word, but before we do that we can
> economise on our usage by sharing the same bits for the VFP
> VECSTRIDE field and the XScale XSCALE_CPAR field. This
> works because no XScale CPU ever had VFP.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       | 10 ++++++----
>  target/arm/cpu.c       |  7 +++++++
>  target/arm/helper.c    |  6 +++++-
>  target/arm/translate.c |  9 +++++++--
>  4 files changed, 25 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


