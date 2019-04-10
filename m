Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCB7C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 12:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9809020663
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 12:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=maven.pl header.i=@maven.pl header.b="ElJPGFu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9809020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maven.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59201 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hECaA-0005xm-C0
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 08:44:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arekm@maven.pl>) id 1hE8HU-0003Hu-KK
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arekm@maven.pl>) id 1hE8HS-0004u0-Me
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:08:28 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:36315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arekm@maven.pl>) id 1hE8HO-0004pv-UJ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:08:25 -0400
Received: by mail-lj1-x241.google.com with SMTP id r24so1248521ljg.3
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 01:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maven.pl; s=maven;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=kYWlGDWN9Z4lEq7d58QUoX8Yq6B/u3gNeHPFkyhJecs=;
	b=ElJPGFu4oy1vmqtN+A3vW1T9EauKArigEKj4gGcuJNEx2PFMwrl47hSeu2bPMk29Rn
	Yj0LURXQJrAWOsPZ88K8U76U9o1PjZ7ueLCVc7gvEG6BZ5/0zcfuyO0wx0JCnX8tE+dV
	rENCQ/IiWDoLya1nGUPF4r7ID3k7W8Uw/NUQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=kYWlGDWN9Z4lEq7d58QUoX8Yq6B/u3gNeHPFkyhJecs=;
	b=Oi+tQKn6B47YFnfrKfwSGhh2LLbG8xBqbRK8QjcMbFaBDyA4MBBUrUZbJyK1ZKuvn1
	3OZy+LcJcLhBQFszrJMicuNL8OqXSTq8YTw8kpY7vTtFTaGMBNSADOGxMRV1dQ42sQkk
	xHMzuO2iCLb5o/NioOMyhnHDvSbIA+6JpEnqoev2JAYU7FYa9FvilEBrzGhGKEOu68VQ
	h60RVe8e2E8XnTS4QC6aWqhHHVwvbr2rcaAyWobhFG+oflBaG9yyeHOmBGI85tGs+6sK
	o70VIOp1hOI6qI8bkkRlIr3DNDlJi+kpUFFVkYy5Mu9xg3x3atk31kMJ7fjgD2mEVxd/
	XCgg==
X-Gm-Message-State: APjAAAVeGikwMW7dV/JF0mopjdLU2RoHmFhxMfQg77vsnxRMW9a5x4vm
	7tw1gigAEHYvc0TvGbOVlxO3uw==
X-Google-Smtp-Source: APXvYqxgKyoNoB52EmFjgS60E3IakNM+bbv06GWA1iYaCwU64PI9Ru/h9J5WvzZrXLGrY67oN3t75w==
X-Received: by 2002:a2e:9811:: with SMTP id a17mr11717544ljj.96.1554883698923; 
	Wed, 10 Apr 2019 01:08:18 -0700 (PDT)
Received: from amb.local (out244.support.agnat.pl. [91.234.176.244])
	by smtp.gmail.com with ESMTPSA id s21sm633448lfb.52.2019.04.10.01.08.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Apr 2019 01:08:17 -0700 (PDT)
To: Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm@lists.01.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-acpi@vger.kernel.org, qemu-devel@nongnu.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20190410040826.24371-1-pagupta@redhat.com>
From: =?UTF-8?Q?Arkadiusz_Mi=c5=9bkiewicz?= <arekm@maven.pl>
Openpgp: preference=signencrypt
Autocrypt: addr=arekm@maven.pl; keydata=
	mQENBFt2o9QBCADNKJoRG48ht52iz9lgw1vLWit+bsftajnXfC5nk4QoqG3zP2S092DIVyKA
	I2hXZN2640EDc+AiVbnagvXJMAUYhr8Ax53bW6hX8gtndY5ONLMZcq8ETrr6ClnXBL3TZIJ4
	MIzE8aS/cDNWAZyaLPBxuLbCWfPnlGZAoQ/ag7c8NvWSORyP8/r+UHBH64N6weGoFtC2psGq
	Nj21qZYyZ9zuooRrBZwA5kGT8/JU+9X0s2+8/vAOt+EKMuJj5bFljD6qprJ2Tqb11dSapM7b
	cdJdbK57lm6RvLCV1BC4jsatsaolHoY/iqVhVw30IAkuOp/ZbcJzGInT/1Tu4FO6btT5ABEB
	AAG0JkFya2FkaXVzeiBNacWba2lld2ljeiA8YXJla21AbWF2ZW4ucGw+iQFUBBMBCAA+FiEE
	wQ5Dg38sxn0K2F5XRm/ZzsclrvoFAlt2o9QCGwMFCQHhM4AFCwkIBwIGFQoJCAsCBBYCAwEC
	HgECF4AACgkQRm/Zzsclrvqi1AgAlpySwbMh2164+OcPAhTZFzYEUHJCNZMf/k/mH73vfYSR
	+b/rMDDlyZwvA5BJMaOl2sUhLuwhu7RRAg0eiwEaDfDifSqS5gEcGIFltHqbf3/E2oP4Rr/R
	KGv3XodwBsWPA3vAcPJ7Feh6M5GgJCH/LBwrQ+/L7WmfgJpOsa/DSkt0FvMvv6l6oXiOa0T0
	A+pzMecL/KNN28RmHQFV5i+bfkLiDW8thtSSiECpNceTCPzkR4qEzXgmzyZ4KLROCYLUwGup
	r93PTUazDva6SuzKB0d1A4sEvQzaZThKXseGK/oz7Fy0ACbIo8DzweuYXFYc5Ju09r+BAqev
	4jZFfrO1M7kBDQRbdqPUAQgA7dze5ejBRrMoCPsPFZPQVOULOey2ldXDazfvLiMeyNKSWycw
	hOuMqTJ25lapW3F63fLRWw3KiSxhWWFCu36OdJRwevixP65N3ZP+w+3zFvfDSXS1XWXOyp9m
	LrWCvaKB25Y1xgxb3P8tBtso3mVNG8KDMsLYi69c+LwkhOd0zcKMAuNHHvA9eS2DbHK3PdE5
	JiZQ2dvU9Nor1EjgquzVSu9SIzanVx47MZhflZbRXupb32YCiB97gK1Ohr1jkDtpuF4X1ZD3
	sHRkFzCKp9lnTWtVU0nGDGbO32YMjMlRqBPoGwVeoIhP43o0YTvrI/N8HsF6auePfV4pt4wj
	OQPgvQARAQABiQE8BBgBCAAmFiEEwQ5Dg38sxn0K2F5XRm/ZzsclrvoFAlt2o9QCGwwFCQHh
	M4AACgkQRm/ZzsclrvqdpQgAqw9j6s0sBB54blOfSlM52hRUPFDVrSzlbb4MxjC21bMlfReg
	ESx3JdQexpgDdzdkevLS75hJ5tILRBxbSSWB4Ko/MTN1uOqhqIVPoO5u4V6aSyL/qpqiJJ0U
	DqnomJ4dOPxKqqGVlvxp70m6ih31f246lkjQeOLTl8h9OLOprolI8OcRzmOPjI4CpQF6f2Qk
	LWbVmlg3pFJOWrwgOMQCTvbG7SoFOmCG0NeswVtHmsqFc/rDfNKuXmJhc2XqwXeO3A+r5l7Z
	uq1gE5zK3wI3IOsYrEnKzsXBiYC6teKY9SJQqZK+4DDWmn2T8Ne6ijxfEcwXLsS9mFD3Xztd
	Dxirog==
Message-ID: <946ba5b9-62c1-aaec-9ca7-a71e154340db@maven.pl>
Date: Wed, 10 Apr 2019 10:08:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410040826.24371-1-pagupta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: pl
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
X-Mailman-Approved-At: Wed, 10 Apr 2019 08:43:02 -0400
Subject: Re: [Qemu-devel] [PATCH v5 0/6] virtio pmem driver
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
Cc: jack@suse.cz, mst@redhat.com, jasowang@redhat.com, david@fromorbit.com,
	lcapitulino@redhat.com, adilger.kernel@dilger.ca,
	zwisler@kernel.org, aarcange@redhat.com, dave.jiang@intel.com,
	darrick.wong@oracle.com, vishal.l.verma@intel.com,
	david@redhat.com, willy@infradead.org, hch@infradead.org,
	jmoyer@redhat.com, nilal@redhat.com, lenb@kernel.org,
	kilobyte@angband.pl, riel@surriel.com, yuval.shaia@oracle.com,
	stefanha@redhat.com, pbonzini@redhat.com,
	dan.j.williams@intel.com, kwolf@redhat.com, tytso@mit.edu,
	xiaoguangrong.eric@gmail.com, cohuck@redhat.com,
	rjw@rjwysocki.net, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410080815.9oH2d3Lry9dkuTO6R7HUrn5b3kVO4vDqKs0fRR6BaR4@z>

On 10/04/2019 06:08, Pankaj Gupta wrote:
>  This patch series has implementation for "virtio pmem". 
>  "virtio pmem" is fake persistent memory(nvdimm) in guest 
>  which allows to bypass the guest page cache. This also

Will kernel pstore be able to use this persistent memory for storing
crash dumps?

-- 
Arkadiusz Miśkiewicz, arekm / ( maven.pl | pld-linux.org )

