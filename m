Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CB8C74A42
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 05:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D83208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 05:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohpNlEys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D83208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlRbW-0001Qd-9A
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 01:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52408)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <suratiamol@gmail.com>) id 1hlRb2-0000yy-R7
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 01:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <suratiamol@gmail.com>) id 1hlRb0-0003bA-UA
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 01:26:20 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:39342)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <suratiamol@gmail.com>)
 id 1hlRay-0003QU-R1
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 01:26:17 -0400
Received: by mail-pl1-x62f.google.com with SMTP id b7so2396176pls.6
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 22:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :content-transfer-encoding;
 bh=PCKCM48EOEDT7QabbySsUTyPsWZSjTpNK9Q/GRexDyA=;
 b=ohpNlEys7iO85q0RsDt/dGKbABNr2e9UAGCe13Hta+Q5zSaswPN8s/rZgtV9E2SV9E
 fJb1Mo3BK3MRdsc6gCDCSTKE/+TuHxknj5RmcSimTUpEGS6w/4NWRDwiAYE8AdTipgdd
 20Zhh8eT5ngAw/JAkwZGVkW2AWJ1n+j3gCUrPlNQ4a3ud3Efl3y5lCgNOKoAZj2D8nL3
 22MlpT24uE37ThjG1uZ+Wrz+AmAb1vvRJW52yeKpNp6kljxyJLPdfNm7AatKsEUJahvw
 BIK9RB42sIZYfnDSY7j15vQSPuHMDSCXzZQWecSDPeM0+LNN1D42q5KZ+roMcd8+j7S6
 bTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=PCKCM48EOEDT7QabbySsUTyPsWZSjTpNK9Q/GRexDyA=;
 b=j5IOWzw13BwSdAtyYhn1gGC4q5ENrKKpycPMVwnWs29Q5BeM/8fy1P9JAoPcHkQAmJ
 Kd0reKXWFJQulnVKs3m27+lpvrRhHw6eLGkllXrZnHR8vIoSBvrWA14l3M6ZarNp0toS
 kJM45A5Q2LJq43fyBNQF3QLkW/7ZKrsZL+4Ed3vLG/pZzgD+Fr1JNrPAXExERr9mLEUi
 O+IZnWmofcyv2Ndu2UhqcBzffdChmQHRR7DzHRxgQ45vNrS0xWiMwIha0hXCLU4xKE5U
 SRlVCJhbz7IFb0DV6kmEAbDR9kDKC83yzbrZ3QAfoxSbZDKs4G6Q3TwkFXKQaGLnHVzv
 RwGw==
X-Gm-Message-State: APjAAAXiELV9EKVKr6RVU9atySkT162FfPUIVgWzYBlRpYw/PTmoc0jL
 PsOOijZTh+rUB7+xmDKIpusF3wGmlusbnw==
X-Google-Smtp-Source: APXvYqyNMpSs4RXfHtJ3uYYCaw0xNIIbfBo7cuuPVJ6PGLD1P/j+R3tFF9xoCjRbHBcd7HSlAU6KjQ==
X-Received: by 2002:a17:902:2ec5:: with SMTP id
 r63mr2458044plb.21.1562822772696; 
 Wed, 10 Jul 2019 22:26:12 -0700 (PDT)
Received: from arch ([103.238.107.151])
 by smtp.gmail.com with ESMTPSA id x9sm4328499pfn.177.2019.07.10.22.26.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 22:26:11 -0700 (PDT)
Date: Thu, 11 Jul 2019 10:56:08 +0530
From: Amol Surati <suratiamol@gmail.com>
To: qemu-devel@nongnu.org
Message-ID: <20190711052608.GA2619@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62f
Subject: [Qemu-devel] qemu compilation failure with nettle 3.5.1
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
Cc: suratiamol@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The qemu upstream (at commit 6df2cdf44a at the moment) fails to compile
with nettle 3.5.1. It seems that Nettle has deprecated a few parts of
its API.

A workaround is to provide --disable-nettle during qemu configuration.

A portion of the error log:

error: ‘nettle_aes_encrypt’ is deprecated
error: ‘nettle_aes_decrypt’ is deprecated
error: ‘nettle_aes_encrypt’ is deprecated
error: ‘nettle_aes_decrypt’ is deprecated
error: ‘nettle_aes_set_encrypt_key’ is deprecated
error: ‘nettle_aes_set_decrypt_key’ is deprecated
error: ‘nettle_aes_set_encrypt_key’ is deprecated
error: ‘nettle_aes_set_decrypt_key’ is deprecated
error: ‘nettle_aes_set_encrypt_key’ is deprecated
error: ‘nettle_aes_set_decrypt_key’ is deprecated


The declaration of one of the functions from nettle's aes.h:

void
aes_encrypt(const struct aes_ctx *ctx,
            size_t length, uint8_t *dst,
            const uint8_t *src) _NETTLE_ATTRIBUTE_DEPRECATED;

Thanks,
Amol

