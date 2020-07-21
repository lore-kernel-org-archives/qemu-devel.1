Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26AAC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC6D2077D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cS12iOIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC6D2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxufu-0003JM-Qu
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxufL-0002tW-E5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:58:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxufJ-0002uZ-PE
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:58:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id a15so6778104wrh.10
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mEeTZ2cmAcR5i8hd1VKggd6XPfzprou2Ahc+7rPYaIg=;
 b=cS12iOIvlZVP378UA0qN9HWm6/XejSNTJRRxZb/j9ZgQWaZaHzImOy/ZT9CUCN94JE
 DuUc0bBlu1VLY4ubaLS3ceBzalC46bPsaIsHG4VMTcrUxgL8hNBgP8ZDDxDOItmxyusd
 GFHfW1qJNOM6kU3PvcW1B84BBjTyWI1WvO/rm95RxxwgH30UIhe4rlOQrqsxznNzPWeR
 1v2JKnQP1DzsiEoHGt3cfvgxDfGYHmnIm4ch1xzvd6vx2aMeiEQfzhabKSJpPK78lqx1
 kBchDRZFSs72zOrCarJAhpq+rt6gP+r0Xg4NF5aheXejIHLhdbIImRUao3bPR56edl9f
 YcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mEeTZ2cmAcR5i8hd1VKggd6XPfzprou2Ahc+7rPYaIg=;
 b=mhdvmVsI4dPikF5cPFLT8z1kz3oubDXXHNxYCEiRa/+wFpig4kEAlPMpxRUS49PYhr
 QLgjC0Q/IX/UMNG5/BJBPRGp7ZKNRJEx3ImmvawEQmTE6PBEjgYs+NoT84BGYcGNv6bu
 8jwNUGhPyydn7QBp5DWZYNRzXZ+pcjLCz2ESUbCVSen3+Hzs5I/mI+Kh46vc/AedirZE
 zUnT1i6BtJnGsEw9Lb/iPpW8LuOmrNoqcZLzSYEE+yRkGjGogMkytq8fffu5kIOm2zXx
 5rSD8N52FXsdVgRTaTKFsy5lLdxALcrQDyT8nTRzxhdp9bN6E60CBrahHewpCjYo5XGM
 r4Lg==
X-Gm-Message-State: AOAM533lz5YOz1wzTHVTe3rwM+08m6JnzSzQ2vSyWOEp+2uZzEjcTDB8
 XuQCBWfaNKO1STr+mo3qQE68ow==
X-Google-Smtp-Source: ABdhPJyIFGbeRKKFjLZP6r3BW48QTK7HOQ27UT2os/kZ9GL7XoyqIN1OkQTCIjmqpcC+ijmzLjAGxA==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr10607714wrr.295.1595347127914; 
 Tue, 21 Jul 2020 08:58:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w7sm3775731wmc.32.2020.07.21.08.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 08:58:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 309D11FF7E;
 Tue, 21 Jul 2020 16:58:39 +0100 (BST)
References: <20200717105139.25293-1-alex.bennee@linaro.org>
 <20200717105139.25293-5-alex.bennee@linaro.org>
 <c575e03a-1655-c317-abf7-40a7449eaf0e@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 4/5] util: add qemu_get_host_physmem utility function
In-reply-to: <c575e03a-1655-c317-abf7-40a7449eaf0e@linaro.org>
Date: Tue, 21 Jul 2020 16:58:39 +0100
Message-ID: <87h7u0vp00.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 f4bug@amsat.org, cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/17/20 3:51 AM, Alex Benn=C3=A9e wrote:
>> +size_t qemu_get_host_physmem(void)
>> +{
>> +#ifdef _SC_PHYS_PAGES
>> +    long pages =3D sysconf(_SC_PHYS_PAGES);
>> +    if (pages > 0) {
>> +        return pages * qemu_real_host_page_size;
>> +    }
>> +#endif
>> +    return 0;
>> +}
>
> Is it worth examining our own RLIMIT_{AS,DATA} as well?

We don't anywhere else in the code so for now I'd say not.

>
> I suppose that's not usually what is tweaked in the example of a ram-limi=
ted
> container...
>
>
> r~


--=20
Alex Benn=C3=A9e

