Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3427CC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3F632077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpeFK+Vc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F632077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iosIh-0001Ii-M0
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iosHA-0007z1-HE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iosH8-0005dB-Ub
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:04:16 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33462)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iosH8-0005cK-I9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:04:14 -0500
Received: by mail-wr1-x429.google.com with SMTP id b6so264900wrq.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 09:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HImR5jWRtvL22+YNBuFx+16suQ+5/mMCMitz+A2uTNQ=;
 b=VpeFK+VcXuBLZGJfVFrVmVLm5LGeKW+6rBgNP7xtQODl+37ijEd1z/5EE4BHmXzsGh
 D7n/V/wIJMhdo+gMTwrNUDLP33KW+n2BwUTgqbhyOJLlbSw69L507pXqb6rpW068LUVj
 5Y/uoH6cceCSmoRXty3p0nohSgzIBrgrN5JHcVlx/U27qIy/MXkE6OQHnvSFIaH8PJwg
 X5QjavjmipVZmjSsUA0bViA9cX44MvgKzWQlig81bfSBnatz5iH/q8QRRI7HetjRePmI
 3eN8pK2GOJLjL4yCGJbtIaYk9C9i1cUH8ZowVMlFaRffhFs/m/llw6m2EDmPAimgd4X+
 3c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HImR5jWRtvL22+YNBuFx+16suQ+5/mMCMitz+A2uTNQ=;
 b=AFx1JBnY0VmhHjrIxnDGpJ4BKoTMHYvlz0uJ9PtoKtxsyyUStDOKFHJWoSs/piY5DT
 5xNJUG/psUI0fVOAl7G48QV7M3bEheuabo0kAhaBGNmVqvrkim7DKiWOUvd9hyQWoTZI
 m7VkaFzeM/AVBfc7MqfNkd/IViwMivIcVzW5ugYIhbRNfbPHXcNwsyhSRb2HrBmkXEoc
 gWkxlp1Kqbt0jaFN9HXTjaeIzQpCpBH9wcmwc80z4LVACDWR5YZ1sBBnSHdA+sP0VPAa
 ycNkzFU0SjK0ztnpiUiFLbLa1ffPmo3XhyXSNHk23iw+01kNMAbPoniDbV+m2ETHjh8X
 fkHg==
X-Gm-Message-State: APjAAAUQxwPXXJojejlhajWOQyCcrg9kGQXo6jhPHGvjJg4vhXGFEAe6
 aE1Kq4hMzBuMveZQbVVxDVfFNg==
X-Google-Smtp-Source: APXvYqwQjGvFIc8pwtcPyVxL/FaBahcLpC9OS08InyKdNYcBxXJ1Mwq5vkIJj+AJ8BWWJ0NedJqX/A==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr1843wrj.325.1578416653146;
 Tue, 07 Jan 2020 09:04:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g9sm512212wro.67.2020.01.07.09.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 09:04:11 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F3EE31FF87;
 Tue,  7 Jan 2020 17:04:10 +0000 (GMT)
References: <CAFEAcA-U1JqzH8m2AWV7KuJKm0WfczDKK+ddzPs44y9usujB2Q@mail.gmail.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: race condition in tests/fp/Makefile
In-reply-to: <CAFEAcA-U1JqzH8m2AWV7KuJKm0WfczDKK+ddzPs44y9usujB2Q@mail.gmail.com>
Date: Tue, 07 Jan 2020 17:04:10 +0000
Message-ID: <87imlnjj05.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> I've just spotted this issue with tests/fp/Makefile which I think
> is causing my tests/vm/netbsd builds to fail:
>
> tests/Makefile.include has some rules that invoke a fresh make
> process on tests/fp/Makefile:
>
> tests/fp/%:
>         $(MAKE) -C $(dir $@) $(notdir $@)
>
> tests/fp/Makefile has some rules that invoke a fresh make process
> in the parent build directory:
>
> BUILD_DIR :=3D $(CURDIR)/../..
> $(LIBQEMUUTIL):
>         $(MAKE) -C $(BUILD_DIR) libqemuutil.a
>
> $(BUILD_DIR)/config-host.h:
>         $(MAKE) -C $(BUILD_DIR) config-host.h
>
> This means that we can end up with two 'make' processes
> (the original top level one, and the one invoked by the
> rules in tests/fp/Makefile) both trying to build things in
> the top level build dir simultaneously. They then step on
> each others toes and the build can fail.
>
> In the most usual case where "make" and "make check"
> run as separate steps, this doesn't happen, because
> libqemuutil.a and config-host.h will both be built by
> the "make" step, and then the second make invoked in
> "make check" will fairly harmlessly see it has nothing
> to do. But the tests/vm scripts all directly run
> "make check" without a preceding "make", so they can
> hit this.
>
> I guess the best fix here is to move the dependencies
> on libqemuutil.a and config-host.h into tests/Makefile.include
> (though then you wouldn't be able to stand-alone run
> tests/fp/Makefile -- does anybody do that?)

Not really - it needs bits to build. I guess when testing you might
invoke directly in the tree. I'll make it error out if the parent build
bits aren't there.

> Also, should we change tests/vm to separately invoke
> 'make' and 'make check' ? I think that doing a single
> 'make check' is a bit fragile because we don't
> really test it and there's no rule that says
> "check depends on all" or similar AFAIK.

OK - although shouldn't our rules be robust enough for this.=20

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

