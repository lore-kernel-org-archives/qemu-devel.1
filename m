Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A1BC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C3420B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C3420B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48244 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCRb-0004TC-O6
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47320)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lvivier@redhat.com>) id 1hZBBY-0006kF-M8
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1hZBBX-0003Ox-Gz
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:29:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47466)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>)
 id 1hZBBX-0003N2-BJ; Fri, 07 Jun 2019 05:29:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DACE130832CE;
 Fri,  7 Jun 2019 09:29:17 +0000 (UTC)
Received: from [10.40.204.44] (ovpn-204-44.brq.redhat.com [10.40.204.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6FBF7DFD0;
 Fri,  7 Jun 2019 09:29:14 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
 <20190529065017.15149-24-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <31966f5b-d46c-4b86-6852-c949d9f72497@redhat.com>
Date: Fri, 7 Jun 2019 11:29:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190529065017.15149-24-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 07 Jun 2019 09:29:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 23/44] target/ppc: Use vector variable
 shifts for VSL, VSR, VSRA
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/05/2019 08:49, David Gibson wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> The gvec expanders take care of masking the shift amount
> against the element width.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20190518191430.21686-2-richard.henderson@linaro.org>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/helper.h                 | 12 ----------
>  target/ppc/int_helper.c             | 37 -----------------------------
>  target/ppc/translate/vmx-impl.inc.c | 24 +++++++++----------
>  3 files changed, 12 insertions(+), 61 deletions(-)

This patch introduces a regressions
 with Fedora 29 guest:

- during kernel boot:

[   40.397876] crypto_register_alg 'aes' = 0
[   40.577517] crypto_register_alg 'cbc(aes)' = 0
[   40.743576] crypto_register_alg 'ctr(aes)' = 0
[   41.061379] alg: skcipher: Test 1 failed (invalid result) on encryption for p8_aes_xts
[   41.062054] 00000000: 91 7c f6 9e bd 68 b2 ec 9b 9f e9 a3 ea dd a6 92
[   41.062163] 00000010: 98 10 35 57 5e dc 36 1e 9a f7 bc ba 39 f2 5c eb
[   41.062834] crypto_register_alg 'xts(aes)' = 0
[   41.077358] alg: hash: Test 2 failed for p8_ghash
[   41.077553] 00000000: 5f 89 ab f7 20 57 20 57 20 57 20 57 20 57 20 57

- with libssl:

# curl -o /dev/null https://www.google.com
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
curl: (35) error:1408F119:SSL routines:ssl3_get_record:decryption failed or bad record mac

[before, this one fails with:
curl: (35) error:04091068:rsa routines:int_rsa_verify:bad signature ]

If I revert this patch on top of 0d74f3b427 + "target/ppc: Fix lxvw4x, lxvh8x and lxvb16x", all works fine.

Thanks,
Laurent

