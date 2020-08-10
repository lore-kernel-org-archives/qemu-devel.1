Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77498C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419F32070B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJqj0CZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419F32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k54Qi-0007Nh-GQ
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 05:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k54Q0-0006wR-62
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:48:36 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k54Py-0002uc-EU
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:48:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id a15so7502313wrh.10
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=51Dx49GYHe6auimOsobWQ7KvkN/Sa69ZBCHRllBEtWU=;
 b=DJqj0CZoUG6EoBupqAzKe6pk29xJTeVPzYULnMIo+tije10xIJ/DdPy3+WEsLTOesi
 r/zS20orCLlvI6cTmWA1YwqNupi17edMoj7Zd4teKPbIYK0kgPzDeE9BiTCjxEVkr+Xr
 OOSN4GFwGHg0wNP8v8ycXjo3S0mfMDgTcVjLeCP/7NlHq/NBYCyFuKcrsdOUr0CiviUF
 wIA23olrBGTU4XGng/269O8dVL7RmVf7gRTupRwUPv4CzJmABq0pcykTI808D1OLzuS+
 Olle2ZV9qER2eSsjCHA0K/zrmDvwxPpR8E9x/CjCLOeTpeITEDoI6Y7gErQOBpzjOMJJ
 KUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=51Dx49GYHe6auimOsobWQ7KvkN/Sa69ZBCHRllBEtWU=;
 b=LlLG0j2gpGrtHtvmcUS0scH3dpHTh0VC8PFIvOEe87htjs/sc/Zhq2TeL8SnJBDlXY
 iCjftoOZobdByZEWqna7z3nGUIiAAE2QUW1ABoE3smk0LC1Cqu3Z/ng0dY4rGwqYY1su
 M+GKhmHL8ia+khqy65d9D95wmBWiisY/HHa4MVL3w7jdHjBTjG9cNfOmHWPkbDx8WHC/
 5OyMq0uZfxQgsusIXsVHZ0ehhXP/YW18prdIToyRydj0YhsAEeX/Cnc6valglmglfArM
 ttcr5yFuWGiHPK9AE9ezZpiQ8mvBcy6q7Kf2xAlm8mqQqs//UF9y2/ZLb855Dn96lEcN
 uFXA==
X-Gm-Message-State: AOAM532bILa3qdx90gklk+GXAyyS44bjUfOW0cdxw/soa8h190JfTR2f
 pRIRjCQSKgDtDmpfRFFEUVoGiV4uCgg=
X-Google-Smtp-Source: ABdhPJydKLvV1Utp/PGOLRyngs3ff/dysRqQCWeYqHS8wKRUxlqniKphQf7Bw3uWAVlUvKwIib8y2g==
X-Received: by 2002:a05:6000:120c:: with SMTP id
 e12mr23489290wrx.354.1597052911326; 
 Mon, 10 Aug 2020 02:48:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g3sm22588748wrb.59.2020.08.10.02.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 02:48:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4FFB11FF7E;
 Mon, 10 Aug 2020 10:48:29 +0100 (BST)
References: <CA+aXn+GrFDssmZWBCL0gh3QLX5BMhmgTQUywLSSQn=cpF2P1ZQ@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pratik Parvati <pratikp@vayavyalabs.com>
Subject: Re: QEMU Library support
In-reply-to: <CA+aXn+GrFDssmZWBCL0gh3QLX5BMhmgTQUywLSSQn=cpF2P1ZQ@mail.gmail.com>
Date: Mon, 10 Aug 2020 10:48:29 +0100
Message-ID: <87r1se3k7m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pratik Parvati <pratikp@vayavyalabs.com> writes:

> Hi team,
>
> Lately, I have been working on QEMU modeling and interfacing it into the
> existing platform. What actually I wanted to check is; whether QEMU
> supports library that gives developers a clean interface to develop and
> integrate peripheral model in to QEMU. I know of the Greensocs SystemC
> bridge - but that was quite difficult to work with in past.

Not really - with a few exceptions like vhost-user and in KVM device
emulation all devices are emulated in the QEMU code base. As a result
the best way to maintain a device is to have it integrated upstream
(along with some tests to ensure it is working).

As you note there are various forks of QEMU that support device
modelling but none of these features have been merged upstream and would
likely need to assuage worries about such interfaces being used to avoid
GPL compliance.

What sort of devices are you looking to model? Are these existing
devices or experimental/research things?

--=20
Alex Benn=C3=A9e

