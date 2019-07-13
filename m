Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDACC742A7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 05:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD2920830
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 05:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdVhtQTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD2920830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmAPy-0006PO-RM
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 01:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48052)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <suratiamol@gmail.com>) id 1hmAPp-000605-RH
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 01:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <suratiamol@gmail.com>) id 1hmAPp-0002P5-2M
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 01:17:45 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <suratiamol@gmail.com>)
 id 1hmAPo-0002N8-SS
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 01:17:45 -0400
Received: by mail-pf1-x444.google.com with SMTP id 19so5201596pfa.4
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 22:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=KfFTlKZKKH3EOz05jOan/IK3bjBFSwfacBwN8wNOaQc=;
 b=YdVhtQTd8zUp4zcyaBtHx317abaUIWqWy7qNcLy2EcPl7ws5Ix2VjBBETFmPbfQk0w
 uGgRFER1tnitlaER9xAtfFkwneZoBdJMlJYxUPfK35hEr6zAV6Zf8EWOy2vIIqCTIt0l
 Uw6k/FgAtE3MaSJLGdXN+NbKQvFgyiLt00MKV46OX4kimj2HduEy1np6ukkoGQtS7vUv
 vFmhj2dVAsmMV7/cabNlmMb/m/8Bp6WisFVaWQpUEN/c0L2Y8bfXBWoSlfODOYmMtdJl
 7wn1wBjL9LumX/jamWGvjAiAwzQZ6JC5T0aQUpvTQwc2avmE2JWa/+NeqjVNYqPKKWMA
 A6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=KfFTlKZKKH3EOz05jOan/IK3bjBFSwfacBwN8wNOaQc=;
 b=NBN0bMnz9L7Etrot+HHmDfL3r9uMDfmV+0/NcS5v08dE6HrjCE95N4lWa1oYHP/JD/
 N0N+WlUsQLM9ashy/e0ASyX5/L6nGgwVGcjqI1YLw7iToeKEHWhlOAd4pMBldX3v4RNr
 mlBhcPZhAhDSgoxgB1XaVFojgCm8ksGwvtFRBFYkcWsXWFeJtHqqf8dGICtl+M7nkqAV
 HUgY6xoFLg5v3Zh3sdSJRhmmtOCX3cykpqUKq8X7uBUlRv9iWPXrxlFHL+TZP0DDyyZa
 qMxmR3rIlVJ91P8/QvK9lMEyh+RDd3ryKqBPtMUyVHrkrVzbdYZT2Xa0yTswpyfan/Zc
 2+Tw==
X-Gm-Message-State: APjAAAX0cCk18/WeGUDR9len94Vlj7ym2BAfjGjcRSHnJ+neLp2p6JoG
 uONEI0/MxvIHAcpCcJN+qio=
X-Google-Smtp-Source: APXvYqzSSNWkT8FanGsvKE9GWs6P1uCIViwzrCQYbEfa7RFsVAJiPJot3jLg23trnkKJnPh4jUKFNQ==
X-Received: by 2002:a63:e1e:: with SMTP id d30mr15122860pgl.100.1562995062914; 
 Fri, 12 Jul 2019 22:17:42 -0700 (PDT)
Received: from arch ([103.85.9.12])
 by smtp.gmail.com with ESMTPSA id o14sm8768163pjp.19.2019.07.12.22.17.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 22:17:42 -0700 (PDT)
Date: Sat, 13 Jul 2019 10:47:37 +0530
From: Amol Surati <suratiamol@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190713051737.GA19790@arch>
References: <20190712101849.8993-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190712101849.8993-1-berrange@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] Compatibility fixes for nettle
 2.7 vs 3.0 vs 3.5
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 12, 2019 at 11:18:47AM +0100, Daniel P. Berrangé wrote:
> This short series fixes a few compatibility issues around different
> nettle versions.

Thank you for the fix. The compilation with nettle 3.5.1 now succeeds
without resorting to --disable-werror or --disable-nettle.

-amol

