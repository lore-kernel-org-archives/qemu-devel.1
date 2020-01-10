Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A64C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549192072A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSyhqomA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549192072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipqqK-0001IS-En
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 04:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipqot-000054-8r
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipqor-0001gN-QQ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:43:06 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipqor-0001UZ-Gm
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:43:05 -0500
Received: by mail-wr1-x433.google.com with SMTP id c9so1121224wrw.8
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 01:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BYpge1Q13W2WA0qhDnQlmZrrqeRU6pMKIqJmBWGsqbM=;
 b=uSyhqomAl9PyOcCfSoqe0SvKpLLHB1Jbaq30E2NDY93mReyZH7kUtkZZR46dZMZfhD
 8v4DMKrtbqEXNCvlpt3jnWraKBrniiDM59P5kvV9iNzpFS6MRDBCiemY8ovLVYPTelv8
 0zyf/Vv0aoeE687g5SsSXq1MC3y0LwMarTArtmBR8E7fCQfbLQhuOP8bhI5RoyuWX0Mj
 iA9S8H/oc9zymQCm9KYtWsmwGl5eZfrWl7ydGSgLdheqVHtxlAPOBtkL82IXnxMqPLvE
 dMmAjN73KnwkRYx0gxp71lkNc6RPf0z/MaLdGYeda+y10LHCJVIKXgrYykFuJYd60XWY
 4tTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BYpge1Q13W2WA0qhDnQlmZrrqeRU6pMKIqJmBWGsqbM=;
 b=rYqYP/GrMuy9DSMEmd1Z5u/OvdBt7D/ZwQuBHswPDhz0JosKinzGF125lILQp7cqrm
 f0h0EY75msq5UK7JhhniPhzdONCk4zj4SFMbnSMUostQhfYf7weu4Yththe3ELKrIe3O
 XNqwZLHhnh15irNMmXA/W6vyiGQbr4m3dNUUjyw/0QIRIUhy7yUuPScqhf0/IZGqn/Ik
 Qzoax2v4Wsojoy0OuoiRNSu8DdLIPxEWWgdGH0orBH7Ss2GebpGqnwncF3W24hyBYtkh
 uN6Zt7k6ZYHvnwLDm4RwXV6BzdTs45UFy4vtoJiOBiaikXB+jLMoXSu8q+nfWDxZ++eh
 dA4g==
X-Gm-Message-State: APjAAAUf2e8Y/OSdd1xoy3WyR6srxqkYBHX/3N636hFk0YI8XcdROMUe
 RKkk1CxsXYZ++g9wT8wxQOkrTg71EI8=
X-Google-Smtp-Source: APXvYqzwpQTWjBWAwt5UOtiWnHsMLO7FpkZBnyUGvRi8gz+FwQPHyeYclrwfyndWEnXxohdfhVmDSw==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr2605376wrs.276.1578649371035; 
 Fri, 10 Jan 2020 01:42:51 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t5sm1580797wrr.35.2020.01.10.01.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 01:42:49 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D39FA1FF87;
 Fri, 10 Jan 2020 09:42:48 +0000 (GMT)
References: <CAE2XoE-GatzSG+y9y8HWU7TiRHfP4TX232pvim9sy8muXGVzjw@mail.gmail.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: luoyonggang@gmail.com
Subject: Re: Does ppc target support for MTTCG are stable?
In-reply-to: <CAE2XoE-GatzSG+y9y8HWU7TiRHfP4TX232pvim9sy8muXGVzjw@mail.gmail.com>
Date: Fri, 10 Jan 2020 09:42:48 +0000
Message-ID: <87h813ir53.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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


=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:

> I enabled it and working, but I don't know if there any other issue are
> still not resolved..

Support for MTTCG for ppc64 guests has been enabled for a while. While
there is a lot of shared infrastructure in target/ppc between the 32 and
64 bit implementations I'm not aware of any work done to specifically
prove all the 32 bit work has been done.

See the wiki page: https://wiki.qemu.org/Features/MTTCG#Developer_Details

--=20
Alex Benn=C3=A9e

