Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0575EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB41F217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB41F217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i355j-0002nf-Sm
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 17:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i351O-00082B-LM
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i351N-0003vg-Gn
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:58:26 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60101)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i351M-0003rk-QO
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:58:25 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MzQbw-1iOtAD1Ilk-00vPn0; Wed, 28 Aug 2019 22:58:13 +0200
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20190827192526.21780-1-laurent@vivier.eu>
 <20190828061103.u4l4inomwfvbodtn@sirius.home.kraxel.org>
 <79ea4476-f2ae-4b6f-1f65-48de3b0ffebd@vivier.eu>
 <20190828090753.ho2stm7ppzej4zcb@sirius.home.kraxel.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9f4c6ccd-ab3a-3d9e-a41f-8c9e3cc854db@vivier.eu>
Date: Wed, 28 Aug 2019 22:58:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828090753.ho2stm7ppzej4zcb@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:katOH2WRS4mPrpzR4i7SLMswkbV2GU3c5Cy94y7exqXHHuQu9S1
 ylZ4712Wz8gXVWAsthfKZ59Rr4tWoxtV8t7p0hfiUS1K3w59jCM2zYvgoPw5zfPugyVDJ5J
 yOF58bSgWOBva90kFDb75yXJ9MtvzMD2P1tIynqimZY0FC1BtS8ggh9/Nsh2Hm3Ky6YMD8q
 O+gzUR6qjAs0v2+FNWelA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yYIoGBpfTv0=:pqeT4aEW7XaGdGC+wpfWCh
 xZIy00LhU0j+H0CwORtW3ull1XdasXZ/QarWM2ZUUQIXL+zU6kUgKXtOLqajWEXYeVFLhnbTy
 cSGXx48zO7DAv56zW7JoOZX4CWJV97uSLdEH5sQ/O4xnRU3/dmXCj/IwAAssUCWSCTzvpCAJn
 /W73AkC71PPHYFPOreYW5vS9Gd2PR7b0YfwXvt29YGYaq6q8mJw8Ujg3nAc6K4Kwby6VsbZTg
 GuCzUB0WlPaeXXWBVNEINcjFOO0UthUx93FYJcCnXa0E8Fv2FtuQCBwRnZvGpwQF4cVRuMFDA
 JWRz4EmzO3pctVmZM/dxLSk7fGbX4LiHKmHx1vCFQz41YxPXj/04+A+nN7urC0QO1tM7PM5uV
 2g2Q9JUILiyIXcZFVQzEauGootOc1DIe4QQguAP3y+jj2PJCnsbMdX68IWpkI0wjT6VzZ3+Fl
 VqVoH5dHfcvTFeQsDKfPHbgBdct7MWzw6HvD3uy7mjbkIPvqT30rVJKt5KAuCQu/Vfnr1Eh/a
 hqP2KHgeYy2nBk9BjIaeIBUfxgZvQwAnEJ93/iuuX+Ve/E8zMwfVA5/rpztgjV3E9SXvmUqMK
 YmQLhNUxU0iHVaXpRZbOHrluK/WM6P7JVCLl3TvlTI9hhhEBLDq3NP5qyQ+0JIhi/y0jh3g4z
 EpVM4HkYVQLPPNT2kpecTRfG8APBt/FnIigaO8Wz5t0Lc/6pf1Dem1SDbLaY3lIchEtZogF4l
 s5NeF6BgAmRLA6A+oONV3EziHrrdcSojqC5GWT/J5oCDuWv+j8x21EoR8uzXZdRHwMNzpBCIT
 ZIDmDaZPefuxMFN36TqscLrE78qxw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: Re: [Qemu-devel] [RFC,Draft] ui: add an embedded Barrier client
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 28/08/2019 à 11:07, Gerd Hoffmann a écrit :
...
>> I will try to add a keyboard remapping as we have with VNC because it
>> doesn't work well with my french keyboard (AZERTY). Or perhaps I can use
>> the "button" id instead of the keyid but I don't now how to map the
>> value to a qcode.
> 
> Depends on how the button id is defined.  If it is one of the usual
> keycodes it should be easy and should work better than reverse mapping.

Yes, it's an Xkb keycode and qemu_input_map_xorgkbd_to_qcode[] works
like a charm.

Thanks,
Laurent


