Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD39BC282E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6AF62148D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gHN9R1xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AF62148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56837 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIyoE-0000TT-I8
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 13:02:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIymx-0008Eo-NT
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIymw-0007Py-SZ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:00:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:33223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIymw-0007Ou-LY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:00:58 -0400
Received: by mail-pf1-x429.google.com with SMTP id h5so7804624pfo.0
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 10:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Rs7tr5dHvFZsr5x/Cpg6JFvLu9Pu4xPc51f7CuCvXtk=;
	b=gHN9R1xl3mU36yUhkQ8Qb87cnO5H+ccHjUVivxPNJrHEs9pRMXuBOyTw8JQI72fsER
	0UgCvlh7ya4S2INulgXllauXDUUncOSzr8u12U1oyUAUjQ9iJW4g3nUe4Y2zBqUrtrVB
	UTOKaJu1bkajxbKh/3fxoBdhghVeGGkAmGtSZk5vtGYIyxz0PljWLZbjNE2laiEe6s8S
	7YoVdw3AjkJBzedUjeHNp/oBlVs1DM4v4hY+6uVcZASb+D6jW2W8id+HOMAfvLOZEso0
	lNuWWtVg2pjP3nXPO/vLetLcue/zPq8+sGo7/OVnYlQEq0HaDkcgc5lEJYCSV5TujWJf
	RFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Rs7tr5dHvFZsr5x/Cpg6JFvLu9Pu4xPc51f7CuCvXtk=;
	b=qnjkjd4qtL15/pRNlyJUyJuRWaQqt/TAcmixl3zAJ/IMMPpYRcCRIfZQgoyvJRQC/T
	uJDfvQ6sXuMtfPv74edovkU38eiPboaYcaG+Q3OqaJrjkA2qY8YV8QdXl53GRyq1Mfm4
	mCsZbZozRJlwgHHWDc8YhHVDYQA3s5UVCfok+6AIAYBGdEcaNkDp5UMx2wPdd5cYhML8
	5DmKHS1CyIhwf7S/BMg4ctbyOfXjLDyZDNW1cjdKXIsNfm3hxw8zPZLVHIEpFKvFL6zs
	MlOIepv7xkMkSFKGHQgJxjY8Mg+vqbZQ8E8OvDXZHYt4sVn8DUIm+jawB047//ZzzasJ
	+TWw==
X-Gm-Message-State: APjAAAUdhz1ZG1CMKsRzaaRkBrSp8mCqgrqGcpctNGMtNMVRqHxvH/PE
	NvBoPy5l/DULvx5WSRdbh20ofA==
X-Google-Smtp-Source: APXvYqxqNm30WEzSzwSSTbm6iMvpKYiktqMATB1UdSGs2QJGDnuBuzMAQVPhln5ASMhQ6oJmvTS/KQ==
X-Received: by 2002:a62:a515:: with SMTP id v21mr28428524pfm.41.1556038857563; 
	Tue, 23 Apr 2019 10:00:57 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	a17sm29657974pfj.123.2019.04.23.10.00.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 10:00:56 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	qemu-devel@nongnu.org
References: <20190423102145.14812-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0ccf7480-4f78-14af-c03e-8c28e41b1e32@linaro.org>
Date: Tue, 23 Apr 2019 10:00:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423102145.14812-1-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::429
Subject: Re: [Qemu-devel] [PATCH 0/2] tcg: more tcg_gen_abs() uses
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423170054.Y8qHJDmlQt2J7735_-Y5fnDXHXA3QLTsn0FV2wZ2d6g@z>

On 4/23/19 3:21 AM, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (2):
>   target/ppc: Use tcg_gen_abs_i32
>   target/tricore: Use tcg_gen_abs_tl

Queued onto tcg-vec-next.


r~

