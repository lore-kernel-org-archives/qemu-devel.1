Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71134C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B4D220665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AklWyRHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4D220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmzd6-0001Oq-AA
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 07:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57406)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hmzcv-0000zC-Pf
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hmzcu-00013q-NF
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:58:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hmzcu-00012z-AY
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:58:40 -0400
Received: by mail-wr1-x442.google.com with SMTP id c2so13585175wrm.8
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 04:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=sZfBwA6NtXGrHLu0g6t4gncZSEl3o2NEfRySe4WJ/qw=;
 b=AklWyRHjUkPW28QK4c4pDqRUemLAtoHvPCCQFsYTO/m4rMiXxd6DHoxq5jTpWanbTe
 O2e4NQdauvxRWfQPRbfSoM3KgQOQm9fNIzd0VbuS5mLbWS1itqQdlgI6XY05x8GtGEVK
 kmiTKWf05gvXQ7e+PSBjh6eeURc8HG4S6gEePkZ6doztBHmv18n0KhID/E55EPFVlhNg
 JnOwDSSwuUGtWHsy9Dwyi3Fc1iLIP0Rr97Hmscjv/RScj6s5Kj30ULLgMn37z5PBfkTD
 USpc5WPRh9AvZSif8OWGbp3hqxds73sNafFCOalEBfDYBkgGo0o5OFr6sPjy/IHxdY7Q
 Trrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=sZfBwA6NtXGrHLu0g6t4gncZSEl3o2NEfRySe4WJ/qw=;
 b=o4K4npW2pxh/TJiyDPs8e3UbPwww74IIQtqdqnq6Fi74Yo5FqFejh/7j49bT+jpNXE
 SiuhYkhwc13RVHgUXFjnZFbxPH3RFj40jn65n6A2EtIShakDTnH3FGOO67P+TaywUb7e
 4EYGupp6wa/cxIiFnDu8p6jniX56j99b6BDlfkmxWPSteuNh1poiP7qnPMOqQEXRTf8H
 uSwjWaHSUbmCMdFoLqgjvg1w/1gB/oxbB/BNNkbo5ULHy29QrPL/X656S479/jMdjkzs
 v8MHkLOAUNcDmpn8oN9k/tytnlPopi3wcNIHeFS0I1LiksiQ/xQGncyQqjAqKIGVyeYP
 bJGg==
X-Gm-Message-State: APjAAAUTrJHHYIi/3hU7IWaGe5eCvmrFN5jGQk1LgFlB23dnvjOCvh7C
 x2uF1bkOFgl7DFLQA6DG6hs3cHs0kfE=
X-Google-Smtp-Source: APXvYqxbjYTG8ZIHYNXe7faoS8x/sKzjSz25bZjy2n74JhojgV0IxIJ8nJqfhNMH2dXOTb9FUqfhpQ==
X-Received: by 2002:adf:f28a:: with SMTP id k10mr29874618wro.343.1563191917884; 
 Mon, 15 Jul 2019 04:58:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r15sm17029197wrj.68.2019.07.15.04.58.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 04:58:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A3ED61FF87;
 Mon, 15 Jul 2019 12:58:36 +0100 (BST)
References: <20190530101603.22254-1-alex.bennee@linaro.org>
 <20190530101603.22254-4-alex.bennee@linaro.org>
 <87imthsps2.fsf@zen.linaroharston>
 <f73a55a4-57c7-3234-a85b-21cf3c758ea2@redhat.com>
User-agent: mu4e 1.3.3; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <f73a55a4-57c7-3234-a85b-21cf3c758ea2@redhat.com>
Date: Mon, 15 Jul 2019 12:58:36 +0100
Message-ID: <87muhfv79v.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 03/26] tests: Run the iotests during
 "make check" again
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


Thomas Huth <thuth@redhat.com> writes:

> On 07/06/2019 11.33, Alex Benn=C3=A9e wrote:
>>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> People often forget to run the iotests before submitting patches or
>>> pull requests - this is likely due to the fact that we do not run the
>>> tests during our mandatory "make check" tests yet. Now that we've got
>>> a proper "auto" group of iotests that should be fine to run in every
>>> environment, we can enable the iotests during "make check" again by
>>> running the "auto" tests by default from the check-block.sh script.
>>>
>>> Some cases still need to be checked first, though: iotests need bash
>>> and GNU sed (otherwise they fail), and if gprof is enabled, it spoils
>>> the output of some test cases causing them to fail. So if we detect
>>> that one of the required programs is missing or that gprof is enabled,
>>> we still have to skip the iotests to avoid failures.
>>
>> Thomas,
>>
>> I've dropped this from the latest PR because I'm still seeing problems
>> in some places. One of the issues is tests failing when the underlying
>> file system doesn't support O_DIRECT. Some tests seem to have explicit
>> feature checks for this but others just fail.
>
> Ok, back at the keyboard, I'm now working on a patch that removes more
> tests from the "auto" group. Do you happen to have a list of the tests
> that were failing for you?

  Not run: 045 059 064 070 075 077 078 081 084 088 092 094 101 106 113 116 =
119 123 128 131 146 148 160 162 171 175 211 212 213 221 225 231 233 237 239=
 241 253
  Some cases not run in: 139
  Failures: 082 102 243 250
  Failed 4 of 138 tests
  /home/alex.bennee/lsrc/qemu.git/tests/Makefile.include:1095: recipe for t=
arget 'check-tests/qemu-iotests-quick.sh' failed

> Or can you tell me which file systems do not support O_DIRECT, so I can
> check it on my own?

ZFS on Linux:

  hackpool-0/home/alex.bennee on /home/alex.bennee type zfs (rw,nosuid,node=
v,noatime,xattr,noacl)

>
>  Thomas


--
Alex Benn=C3=A9e

