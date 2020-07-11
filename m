Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1C9C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A846206F4
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1Aztkuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A846206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juJZn-0004Lh-GA
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 13:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juJYj-0003lU-JK
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:45:09 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juJYh-0002GT-Us
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:45:09 -0400
Received: by mail-wm1-x32a.google.com with SMTP id w3so8980496wmi.4
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 10:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+Jroabn2nrHLEBHBIWDv0nevXhtOKngsG1YKLTiE6CE=;
 b=p1AztkujS1ebr0Hgt8xjnSvJYw25vn8QPPDfdI/ikvvkEGQbooOsRin2u258OYyLmd
 XexzKDB8iQqfz8+1H2oQ1flajSWG5lHo3WQkuTzcuzj1DlRbZHeYlXNdwlkgp+9ijxsi
 ptiJc+Z8R54w936i0ATjkqxH3YA4S6AIpo5xngx80vbo4PjDQFyC7FfyvV/7fwBJcIU5
 XIHXkIIR/t+8LZTwcpJ3aAIanJUfpfo7ZmAmyzAersayyS1uIIDcABW+TsqRr13YJzym
 B4w7WsXjUBg1fqiQIthBDfp6X87G0wqaZpc5mlLCPQ8HJB5zDSBUCt4UhGaegMK33JOx
 qp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+Jroabn2nrHLEBHBIWDv0nevXhtOKngsG1YKLTiE6CE=;
 b=UTvq2wCCgsG+TpyuHAqz87OAAAohy72BQ4fi7cP5IcF6WDBRuFdA+5I6+uvzmF6ebG
 pEoDqwD16YlIDNk7T781WlgxSkKgjuVnIYrgmkF3wkTIflO0fppvAiNMZkMOBp1DUCVB
 e5omStgQECIs5D+7m4EhMNcTiKeI6bh0gX+slwOcs38JvUvI7hx3yf3u1+zJCeHSWxlu
 FDFJAjeB/q/sFmETHErfhZ3PAMhztXaUg6qByKi1L7fkAyzfUKCRnzwhGxq6wVhws0ZJ
 VHUU2k+Eu7uXgmMgA7JzO0TAe/XMKeZhnHNoRnMtegiMq49rC4peMYiO8nOzcnHdjZAj
 BbrA==
X-Gm-Message-State: AOAM531YsB0RjVi0Loq0OPgT/5GqXJA+sID9AtKKhPOSYxLnwac0w+Do
 euRZSd0Obje861qcNCZY7Ie6rQ==
X-Google-Smtp-Source: ABdhPJzh2dr+b4GdWDeGi7owFqmhQmZfr+JfQ4WFjK2+y14Wr96Jxmx/plISoHSxREUXTfW26XcwqQ==
X-Received: by 2002:a1c:3954:: with SMTP id g81mr10770897wma.73.1594489505936; 
 Sat, 11 Jul 2020 10:45:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l14sm16128621wrn.18.2020.07.11.10.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 10:45:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D20871FF7E;
 Sat, 11 Jul 2020 18:45:03 +0100 (BST)
References: <20200707070858.6622-1-alex.bennee@linaro.org>
 <20200707070858.6622-11-alex.bennee@linaro.org>
 <fa8ee177-3a53-cde0-a8f1-8b0e8eba678f@redhat.com>
 <CAEyhzFsYb4KvDaeMGwjocSjU0QO957Eg_TQbi0oEr1c=rE5vwQ@mail.gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PULL 10/41] python/qemu: Add ConsoleSocket for optional use in
 QEMUMachine
In-reply-to: <CAEyhzFsYb4KvDaeMGwjocSjU0QO957Eg_TQbi0oEr1c=rE5vwQ@mail.gmail.com>
Date: Sat, 11 Jul 2020 18:45:03 +0100
Message-ID: <87r1tiq734.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Peter Puhov <peter.puhov@linaro.org>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Hi,
> Thanks for the detailed feedback!  I will look at making these
> changes.

In the interest of getting the CI green I've submitted v2 as is but I'll
roll up Robert's cleanups in my rc0 series (which is hopefully a lot
smaller!).

--=20
Alex Benn=C3=A9e

