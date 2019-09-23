Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC92BC3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBD32064A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBD32064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKRs-0004sL-Us
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCKAo-0006p5-5J
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCKAm-0002iy-04
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:58:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCKAl-0002iU-PX
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:58:19 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8AD93680A
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 08:58:18 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id m16so1384622wmg.8
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 01:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=URrnnj7sUzJvV6cAwqpmdpic4G5LY5oWao01BbdCO/c=;
 b=GhImGWiUrCHAftQxalfWpugfiOulO+Ig2KFOBqcIsrSPw8mDekHJ+yipIkSVv0kXK6
 6qYfZI7S39D1PPf5fv+xYPYRs9EumA4HTJhtDN90alW4rgjL2cn3wgNcUYurU5SoIrvT
 qkNa/lSpakGH8MZclpUQ667S9nEu1G32sS7yKv+e5nqPnQwPSOhdkL/6XoTNOuxbn+IZ
 vLt3k9/5W0GjUVYyFtqCC8IwCRicoN1IH96bjIyPMNIojNcsCi2Tnb5oAlr6MseunNZA
 8Ah2XvG+JeTRrpySFPrOvUg/gzh987yUhJNcDBh7INgkD6qB0q5PVC2fXOv+4TEdLkiU
 1dBQ==
X-Gm-Message-State: APjAAAUDEdmD+o0M2Zvf72pI9AbSe5uV4tzQTpVutzlWULphCe1Nvenx
 eoG055T4zdwYTnUjeY4cEP/b0qVYYrgav2h1StboyUdfTcVk8ezDt+VZCNKuH37XaYuL60R/MwW
 TiojhWOqMpFxcEtY=
X-Received: by 2002:a5d:6647:: with SMTP id f7mr20959135wrw.170.1569229097755; 
 Mon, 23 Sep 2019 01:58:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxBaCneC060fAVygs7NlkzsxP4dfOX844iLbRl6V82yLyqO87HmOd3kTUo0swqKryL/vzQm6g==
X-Received: by 2002:a5d:6647:: with SMTP id f7mr20959110wrw.170.1569229097484; 
 Mon, 23 Sep 2019 01:58:17 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id q124sm19084259wma.5.2019.09.23.01.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 01:58:16 -0700 (PDT)
Subject: Re: [PATCH 0/4] Make it possible to compile with CONFIG_ARM_V7M=n
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190921150420.30743-1-thuth@redhat.com>
 <faa7f493-6c40-a5ac-cc70-8cba6e016cb8@redhat.com>
 <11706c6f-a2e4-f181-208e-a7357e0c8d57@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <db702e08-5b0e-f225-1d79-62060e0260c3@redhat.com>
Date: Mon, 23 Sep 2019 10:58:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <11706c6f-a2e4-f181-208e-a7357e0c8d57@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 10:50 AM, Thomas Huth wrote:
> On 23/09/2019 10.37, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Thomas,
>>
>> On 9/21/19 5:04 PM, Thomas Huth wrote:
>>> We've got CONFIG_ARM_V7M, but it currently can't be disabled.
>>> Here are some patches that should allow to disable the switch
>>> (if the corresponding boards are disabled, too).
>>
>> What about the ARMv4/v5/v6/v7r?
>=20
> We don't have config switches for these yet, do we? You started to
> introduce them in some of your TCG-disablement patches which are not
> merged yet, so that's something that should be addressed once they are
> merged, or directly in your series. Here, I wanted to provide you with
> these patches so that the arm_cpu_register() is available for your
> patches / later clean-up patches ... I mentioned that in the RFC cover
> letter
> (https://www.mail-archive.com/qemu-devel@nongnu.org/msg641907.html) but
> forgot to copy / update that paragraph for this cover letter here again=
 :-/

Oh OK, I thought it was a complete replacement of my series, now I
understand this only address the V7M case which is the sole switch
available as of today.

Thanks,

Phil.

