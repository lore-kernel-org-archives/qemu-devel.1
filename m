Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FECC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0DD2078E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SbGjOVwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0DD2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlHu-0004cD-AP
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPlFe-0002U7-Db
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:35:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPlFc-0008Fx-1l
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:35:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id m6so13087697wrn.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZJU58Ttd7Z0QJDecO8b1aJOuM43L9YyY250TY1b6a1Q=;
 b=SbGjOVwLmlLRDEBY+yoM9+/Un3LKZtRKLqZ6lVztGGdT6aeQGIh/eoQ0cF7WBn/lkH
 06ZgMENNC07QDNJmOqPeL+0XM04oacSUDBliNBhmQfJTFW6HuF/uxDBTf+vjq7tb/48/
 B7VnSYvXugnU1umCxXJ1ZjtGADVT5w5d8NiXkzBlzV5eLYjIMA/5kVlXxtxVuJ+dV8fP
 gXjTSqA3yTEbZ0bhudBJQgw+vE22YvLSaWsFAG4tYhSm7ghChIlX4Ef39w753f2ZbZyS
 r+i7W3T5uLex0E/+C/HGUSOao+vwhpyaQbPc6jGoBjy9DZc8A02Ddmlur5thFztXY9Ws
 ap9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZJU58Ttd7Z0QJDecO8b1aJOuM43L9YyY250TY1b6a1Q=;
 b=dGeDRtdIu3Zz5yI46YYVuH3Tg0fSbFRKs78vcVhhkje794nJfMd3+6jee+en3TapiQ
 XcjLpYrAJl8ShhBb8mq8avNmFD9syzsmPa6PvKsz7Npy/s+DnG7BW+q+cWRo7HuzEbKc
 hjzMxHYOyZcG3ThOVe8NmBjJd8j90bdf5CmFl2D9SpKrHAY+GBo1TUVFr/JImiTbis6L
 sn6IXJSrtckTjJC42pyGwCpNMIiZxbs0sKhPnm56ltThoVvow/45toC7wnQsHQxKF0gP
 JIki19modj/6XmQILVn9DYBgg6lTuiklvxdVpOUuB6ohRUs0dqhNrUG+0qkfF/IdRHcb
 w7Fw==
X-Gm-Message-State: AOAM531kvkGRogGUVAt0yStEin7PBervacYlsshUkCyubxhxKEER+HKg
 h3oGvLdOJYX1Rv6vWX2GD37aQg==
X-Google-Smtp-Source: ABdhPJxNkk5AjEtVkj38BxMMXk820SYFTYj59LkNhO0rKaR5i6uk7VNJ3uSNIciSp0QLs5DE4sYIww==
X-Received: by 2002:a5d:4a0e:: with SMTP id m14mr4652203wrq.313.1601984121659; 
 Tue, 06 Oct 2020 04:35:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x10sm3655238wmi.37.2020.10.06.04.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 04:35:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E4C301FF7E;
 Tue,  6 Oct 2020 12:35:19 +0100 (BST)
References: <20201001163429.1348-1-luoyonggang@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v3 0/6] Enable plugin support on msys2/mingw
In-reply-to: <20201001163429.1348-1-luoyonggang@gmail.com>
Date: Tue, 06 Oct 2020 12:35:19 +0100
Message-ID: <87pn5v1tag.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G . Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Yonggang Luo <luoyonggang@gmail.com> writes:

> V2-V3
> Split following patches out
>
> V1-V2
> 1. Fixes review comments
> 2. Increase QEMU_PLUGIN_VERSION to 1 for compat  QEMU_PLUGIN_VERSION 0
> 3. Revise the loader to support for version 0 and 1
> 4. By export function qemu_plugin_initialize in plugin, and call it in lo=
ader=3D
> , so
>   we have no need call it in every plugin. And also provide a standard im=
plem=3D
> entation,
>   anyway, use can also override it.
>
> Add this feature on msys2/mingw by using glib provided cross-platform dls=
ym f=3D
> unctional.

I've grabbed the first two fixes into plugins/next for now. Aside from
fixing the review comments I'd like to have an indication that the
proposed change to the API linking doesn't adversely affect the
performance of the plugins.

It might be worth enabling a --enable-plugins build for mingw gitlab as Cir=
rus
seems a bit broken at the moment.

Thanks,


--=20
Alex Benn=C3=A9e

