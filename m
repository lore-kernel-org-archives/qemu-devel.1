Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70B6C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6682173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+SzdVT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6682173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8k80-0000V6-Iu
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8k7K-00087X-7D
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8k7J-0003C6-AH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:24:14 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8k7J-0003C2-4d
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:24:13 -0500
Received: by mail-wr1-x444.google.com with SMTP id n7so4422222wrt.11
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=wFn3Q08PGvUpbXUJA7+4l+QIB/piA09HNGyQwJfac7I=;
 b=X+SzdVT5D5wE+45Tf5m4qL1O0T9xhZ0xSM2hp9UNwyKe1zcx+3aGRnDR2Jc3RNiPLR
 wV6m72i1d5RmElwd3dTX9om9pdGsPlzCTaeLH3pI69XJjR9tSuHByfBF9sZ27cYgNeOY
 G+BeKFiXMemViQItbWHUJMFqqPJE+ChjLLktVsEp0397LEuSlAJKGWNbG+TNOXMQwvx+
 1ixuFlHDYfSBCIl28FV7khWbgK1Sao52bcygtNiDWMlW9OoXWo2Ma2GxT2EL9xZlBs1Z
 7Pybu/bsaKs6kgtoFoA2KDXxjq1cc/CxSQiVYvfGJZ6o4UTtLX9ZMF3aJrGo2eNmEDQW
 IJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=wFn3Q08PGvUpbXUJA7+4l+QIB/piA09HNGyQwJfac7I=;
 b=umFRM7kAERQoOZbn1n0jitp40fWkb7lAnNrAiFEkVp1vuDf8I2WHEjT6tI3guvcKoE
 vvArSla9gAceX95J697xKDWyJUVOA1FdHjXmN7zlM1iZYjmF1lgWNIeyr7NdcTHZN+7I
 Z9yXpeWehqxz/rrSvQszKrptBPPSA5nE3YsBUvu9ubp0mMMSWgSpvN7B2Gsov8JtXt0/
 MJwCeK4aWdpBqXQwwXrnBhQgFhEasMcvuFJiaC8rMqoHvsmX4evZKX06XS9FBeeIfItY
 bCKhcbUB77QpFgOaHAYCMQCgO6ozr9xxZBtSV8L24+FaPSR8y2/+p0F9PHVz3kKTMJKc
 e96Q==
X-Gm-Message-State: APjAAAXUbh4y3bBNejVDhu+wuZbXI5v+apBvjbALjHXZ5+WnrC/Zww0C
 gTuBy9nLYgKrLO4GRyF/Cv2zVw==
X-Google-Smtp-Source: APXvYqzQR0wog4wlu6pTV3eefutzAyQrO0FwFW/shN/DoAwgnLrsJOdr5p0dWZeDut7VEBc8gpjNZA==
X-Received: by 2002:a5d:4c92:: with SMTP id z18mr16154953wrs.294.1583151852156; 
 Mon, 02 Mar 2020 04:24:12 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z5sm9757223wml.48.2020.03.02.04.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:24:10 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 04D601FF87;
 Mon,  2 Mar 2020 12:24:10 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-29-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 28/33] docs: Split out sections for the manpage into
 .rst.inc files
In-reply-to: <20200228153619.9906-29-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:24:10 +0000
Message-ID: <878skj9c7p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Sphinx doesn't have very good facilities for marking chunks
> of documentation as "put this in the manpage only". So instead
> we move the parts we want to put into both the HTML manuals
> and the manpage into their own .rst.inc files, which we can
> include from both the main manual rst files and a new toplevel
> rst file that will be the skeleton of the qemu.1 manpage.
>
> In this commit, just split out the parts of the documentation
> that go in the manpage.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

