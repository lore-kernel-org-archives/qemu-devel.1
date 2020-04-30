Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ED4C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F421F20784
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeFBAX/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F421F20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6jb-0000U9-SQ
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU6iP-0008F3-3l
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU6hW-00042V-0y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:46:48 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:38519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU6hV-00042N-Ht
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:45:53 -0400
Received: by mail-oi1-x233.google.com with SMTP id r66so4811941oie.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 03:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=b1TPa9fcJfC7W3DlJG5DDNliiB12sN+PH0UvCPsH9Sk=;
 b=MeFBAX/pejWHuAwWbD5xRQnN9l+F00orrgj6p4zNr9bftZw5FPKPxD+mXY+bdiNmy1
 YQYXdyb5DSL/PxVHZVvjBJ857PjXYht9hHWzfqGv7zpys/VN/f5K8RKHdycXmQDEunE0
 atHA32sOydM9SH0B8GdWNJe90Kt2k8VePcNhJhE9sm1WaS5EXUJax1sdVOh4q+cxTigz
 5t0BEJpTozcx75ua2uurmgtu0Y7E1gTevBoXWXCXH3Z6TFlgsQ8MDmdWDC4g7CqEmxgC
 3IXSzu88jjg/i5H9ZFYs5EzhH6lClgiWSSdytHzJr2rOLbvyLqGtNvK5bxzDPe49q8yI
 pPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=b1TPa9fcJfC7W3DlJG5DDNliiB12sN+PH0UvCPsH9Sk=;
 b=jcTerf+EycPo+8QRxE4S3PVTWrUGUndAfInAZ5bxWfZ+9eEwzLSrgQxUx+lAv6nhj5
 8OMwEy3k25f7uJjx5GLHD0oi/5lDcgFuIRgSZqSDhdmRoSgOV0Bl6QVEEG3E6FKpUrVM
 ZOOx4BEPk8v7ZkzyDpkvSQG842pEmGM7EgmcZvT8e8N+eg+Mv0wBIrT25z4mTyHHpb4B
 z0vcbJtSmL6pAFSJslsDPG8Nez20RAJbJovJ9c3HEX4GrRSef2mhuQ8TKeaWl4OjQYzL
 MegTf3pdNNWF1A1R/FJOPTL70UTdHVVZhMdMC88PoJoVIAaBpMz4kDqtel/7sjz6mE4A
 U29Q==
X-Gm-Message-State: AGi0PuZwf0To4cU/Bn26LcEjMDDc3WMCCOF+9avnqNkWIbkeAgxsIPc6
 htg5WXNkGo1xMr+z7K3CoCwELpo8Ob7SK9CVUtDdpA==
X-Google-Smtp-Source: APiQypJnLKmgQ7n3E/z4XttwQAsahmDSWQHPXM6s3L2nvQNJsRLo7WR9xnh7Ty4u8MX1bKeFTV1+w14mVJohUwL02qI=
X-Received: by 2002:aca:895:: with SMTP id 143mr542335oii.163.1588243551954;
 Thu, 30 Apr 2020 03:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <87mu6uia5i.fsf@dusky.pond.sub.org>
 <20200429155719.GL1495129@redhat.com>
 <87k11xh2kq.fsf@dusky.pond.sub.org>
 <CAFEAcA9-oxkMD-kJ1z12d4K1S_Jaz7Wj6_38Ah7ChSaBfQNkkA@mail.gmail.com>
 <87tv11e1en.fsf_-_@dusky.pond.sub.org> <20200430103437.GI2084570@redhat.com>
In-Reply-To: <20200430103437.GI2084570@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2020 11:45:40 +0100
Message-ID: <CAFEAcA_1BB6qCpP+yAOKBeryxCZk5aC-YAw+KbGLFm2zCVL2oQ@mail.gmail.com>
Subject: Re: Configuring onboard devices (was: Failing property setters +
 hardwired devices + -global = a bad day)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x233.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::233
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 at 11:34, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> We "merely" need a new query language targetted to QEMU's qtree
> structure, which we can expose in the CLI that gives unique access
> to every possible property.

Past resistance to this has been grounded in not wanting to
expose the exact arrangement of the qtree as a user-facing
thing that needs to be maintained for back-compat reasons.

Eg in your example the i440fx-pcihost sits directly on the
'system bus', but this is an odd artefact of the old qbus/qdev
system and doesn't really reflect the way the system is built
up in terms of QOM components; we might one day want to
restructure things there, which would AIUI break a
command line like

> To uniquely identify this we can have a string:
>
>  /dev[1]/bus[pci/0]/dev[id=3Dballoon0]/bus[virtio-bus]/dev[0]/deflate-on-=
oom=3Dtrue

thanks
-- PMM

