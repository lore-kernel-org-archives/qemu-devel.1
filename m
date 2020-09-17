Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98810C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B913206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bD7OSA7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B913206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqDF-00084L-Af
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 05:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIqBd-0006dQ-R1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:26:41 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:33869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIqBc-0005zI-1M
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:26:41 -0400
Received: by mail-wr1-x42e.google.com with SMTP id t10so1277960wrv.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 02:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=wstpYtybNOSoDcLeeBZeNQtZ+GRfooT+zZ1jiiued+o=;
 b=bD7OSA7CiGYnZDUidp6dEyTZGU767ifD2eUwup9wRlcZaybhFF8u+a7thQt23Gl9o6
 +3q9mSws+8XwuHDVtxUWBDfRvSUQ7KhmXG4P3o5KcheyRZcWE1h7VVUCp498fJPswCCV
 YLFhW62LSrX1HpitV1TOPDcSriIArPGtUMARwN5rPazpRmz1ts1J9cYtLIyaZIP4zWjn
 XXgz+w6b+uqECNvSEKUWzeRK+oojuJtugTdpn78gGumnZdTcro/ZHkiHmfsFs0MX9FPs
 IMwMTbiZNqcTw3Rq7r04LErYnAFyMGyu0zDG+fOZvnirNAR/jG0Sm3eQYNgooPOSG71V
 dGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=wstpYtybNOSoDcLeeBZeNQtZ+GRfooT+zZ1jiiued+o=;
 b=BH95DZer1h0vzDTZvDH1/QIFC8Jz8u7mFcLRyQwmvYlqI/CwPpvL7XWpt2EDLzlHJF
 QX9mItA4HAIc45GhFUbJRr5ooQi9a/1afJLCQeuKfnS19e5DopY1be2a51qn57GMmOvk
 lVoG+QwZGxVfRMtHP28uv1jj2KLOC2P+jk1RXwKcKzg8O3y7iTwrWgidMvwVKA1+pWc8
 tsBVaHG1NahI7jDPVeT+f24eHEBMcdevzOS1+zTWWoHuINJqWy/Rc9c7IOaFa6xhKvx8
 ibJ9v89ATlBdiqyK6o1i7UgGVQh8eD/Kw5y12qBKKIpGAOZ99I4Bhok9utxrJr5H4iHz
 Gmwg==
X-Gm-Message-State: AOAM532fZAlxdJelbZKZpQeCjD1wkmuxIkN1IPQi24DAdb17pggsHEO3
 mn1/JDSepK3T4juBzT3uSbaADg==
X-Google-Smtp-Source: ABdhPJxogjo8AgNovTxyiDsCfYnzq9PE/2A7DoDc1HfOFuAX9aQQyRbBe6/00uQEtILwG8iTBaBidA==
X-Received: by 2002:a5d:4d49:: with SMTP id a9mr33278913wru.363.1600334798413; 
 Thu, 17 Sep 2020 02:26:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b84sm10922193wmd.0.2020.09.17.02.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 02:26:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C383C1FF7E;
 Thu, 17 Sep 2020 10:26:36 +0100 (BST)
References: <1836935.RIYQIvKipu@silver>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: QEMU policy for real file tests
In-reply-to: <1836935.RIYQIvKipu@silver>
Date: Thu, 17 Sep 2020 10:26:36 +0100
Message-ID: <87y2l8ycs3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Christian Schoenebeck <qemu_oss@crudebyte.com> writes:

> Hi,
>
> is there a QEMU policy for test cases that create/write/read/delete real =
files=20
> and directories? E.g. should they be situated at a certain location and i=
s any=20
> measure of sandboxing required?

I don't think we have a hard and fast policy. It also depends on what
you are doing the test in - but ideally you should use a secure mktempd
(that can't clash) and clean-up after you are finished. This is a bit
easier in python than shell I think.

For example iotests end up in $BUILD_DIR/scratch (driven by TEST_DIR
being set somewhere) whereas the gdb stub tests use socket_dir =3D
TemporaryDirectory("qemu-gdbstub") which get auto-cleaned when it
finishes.


--=20
Alex Benn=C3=A9e

