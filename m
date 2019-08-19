Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A8CC3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDCA20844
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrgTYMJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDCA20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzfVJ-0006ih-LF
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 07:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hzfUV-0005pJ-HF
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hzfUU-0006eg-AH
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:06:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hzfUU-0006e7-4P
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:06:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id t16so8255683wra.6
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mAUlxeD1WBkr5V8kTgX7/msjr9puDT0Dp+edzLE5IPc=;
 b=jrgTYMJKLkFeH5QjBXET6Lb1uAS6YGNmmRP8TjhEezOSNIhhODZvmCfEwni5WeSTkz
 yU8WbN8xtpZvXuXTyOoxOUW/nOfq4XRBtZJaOd771SD9NLbXAuDQ6aOX70LulAYgdYsj
 ltACObZ3cvIzgtB8GEqvEN1yCCSjYhIb0Fx9ao4NCWBqrOlMJ5DSM9I+U3iZp7NPO5V3
 n+cB81Qn1DQn30nbFHq77fTQuVnsIdKtouiO2BoQ/KOD6ytfqsHNzGJu+DVPCQfqKaOK
 fLE0Vb+eSFDMOYR5pjHqTdpL5aTVnGCJiR3DON5e+uLDaZPvtW7+vigMk6th95kVGlak
 ZY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mAUlxeD1WBkr5V8kTgX7/msjr9puDT0Dp+edzLE5IPc=;
 b=e/+A+MFR00ynHmfewAGcQz35vGczcdlNV7fV1HSO879X+6HCSSH9XIGj248Or6nRv3
 2TVfnBXXZ0veXfsh6CEbrCEr081BUUdcvEU7VRGSsDIGXPLKpcPKXlaG29DgpBmpxtZ0
 2Zoo/vO8wmro1Bq8JHfE2RFJaPaQ04A+hjB5THSF1dJt/mre+aVVRulSi9F5E3kOq4iy
 trFOov0MAvbRWlzKmHKHtWFJ5Eiw2aYkv9E20TMUcWT+mAMy5UHnJ59R9FHgwA4C+w+W
 cVYTcSIH6RJa+TdjTYx330ugoyDayLydPFiZI9qTsWxKCbIwerkRqSt7nBZr/iw+9Hlt
 n2qw==
X-Gm-Message-State: APjAAAWhQYoOwysWiG3QBUsO+CsoOKUAMGVorq3BduD9xk2FIu7KcbL9
 LFyXDJrLA7uN4JfK1WCEu8W6ZQ==
X-Google-Smtp-Source: APXvYqxldQlvUO/1+CzT/Aem9vrZl4jkO4faWK2Ou4AtMwLZswH5t47ba+a0Bg7al9wQn0MyfUjLNg==
X-Received: by 2002:a05:6000:4d:: with SMTP id
 k13mr26869871wrx.196.1566212780564; 
 Mon, 19 Aug 2019 04:06:20 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id u8sm11642226wmj.3.2019.08.19.04.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 04:06:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 90F6E1FF87;
 Mon, 19 Aug 2019 12:06:19 +0100 (BST)
References: <20190816084708.602-1-david@redhat.com>
 <20190816084708.602-5-david@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hildenbrand <david@redhat.com>
In-reply-to: <20190816084708.602-5-david@redhat.com>
Date: Mon, 19 Aug 2019 12:06:19 +0100
Message-ID: <87k1b9h0t0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v3 4/6] s390x/tcg: Flush the TLB of all
 CPUs on SSKE and RRBE
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> Whenever we modify a storage key, we should flush the TLBs of all CPUs,
> so the MMU fault handling code can properly consider the changed storage
> key (to e.g., properly set the reference and change bit on the next
> accesses).
>
> These functions are barely used in modern Linux guests, so the performance
> implications are neglectable for now.
>
> This is a preparation for better reference and change bit handling for
> TCG, which will require more MMU changes.
>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/s390x/mem_helper.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 29d9eaa5b7..91ba2e03d9 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1815,6 +1815,11 @@ void HELPER(sske)(CPUS390XState *env, uint64_t r1,=
 uint64_t r2)
>
>      key =3D (uint8_t) r1;
>      skeyclass->set_skeys(ss, addr / TARGET_PAGE_SIZE, 1, &key);
> +   /*
> +    * As we can only flush by virtual address and not all the entries
> +    * that point to a physical address we have to flush the whole TLB.
> +    */
> +    tlb_flush_all_cpus_synced(env_cpu(env));
>  }
>
>  /* reset reference bit extended */
> @@ -1843,6 +1848,11 @@ uint32_t HELPER(rrbe)(CPUS390XState *env, uint64_t=
 r2)
>      if (skeyclass->set_skeys(ss, r2 / TARGET_PAGE_SIZE, 1, &key)) {
>          return 0;
>      }
> +   /*
> +    * As we can only flush by virtual address and not all the entries
> +    * that point to a physical address we have to flush the whole TLB.
> +    */
> +    tlb_flush_all_cpus_synced(env_cpu(env));
>
>      /*
>       * cc


--
Alex Benn=C3=A9e

