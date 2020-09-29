Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037EEC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4936F20848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SvHlvcGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4936F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNC9g-0005sq-1b
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNC8M-00050v-EO
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:41:18 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:36166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNC8K-0006bX-4V
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:41:18 -0400
Received: by mail-ej1-x642.google.com with SMTP id h26so3937605ejq.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mD2lUNXS820ivhqt/BEwt+zmmmz59Llyjr/7c/ee9t4=;
 b=SvHlvcGh8xjGKDHHJP73k6iFwLzpwGzjM+WMqFuCJ+bxiU3vWlRXLFNMvFruvQKIGo
 3YBzltdegpvRqkesoAdEBJ5KI2rZvfLHex4ez0m5k4+NksYLuddkl8SKwnESy9ymZEQx
 5KnH/LhQB6bj2I8t168U/b0cAECHTH3yKKt4MG+46dJNBWzrPs1wdqj3etbysCzMRtUO
 dW0jAD22s34XYmFYa0IrfnbhNVB0NsgPfujuRn3FXqR6zNiCo82CY/qxOw7Kqpm4XOf+
 qMOXt7yhJag24gIB0OS5Kx49JTgsiwThxPfiGo50CtdFZwEV+3fYihANaeyXZoJEajNk
 0U7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mD2lUNXS820ivhqt/BEwt+zmmmz59Llyjr/7c/ee9t4=;
 b=WSYJ62c4txRrj2r4A2tGvSio0DFjj71urms9L5rSo9ryZttMRsTZB//qzgO7jufRpz
 sCgkC84kqB/SnY/HdDbfCOArCdSwOWvZtbsvE35g1PA1QZGz+UaXRxlEF45IvowY0h+n
 LK4LxjYHGqs3KSOR80dyX41dp8J/9ImlXQrdPadblTqjBSFXpnCIEfqUs5wT45JX/DQ8
 e6c66zVK3XPxYfTw/GuitYSOlrr91IUXwF2Xsm67XfnoAlNOsMfcSqlCSPnhh0Cz3kNi
 /3uX7gYups1MH7t19iJ12iDUZKGqSMP3pPZjnP58hKu3h646l/e380ew6jMG8nSZ2wQG
 4Uew==
X-Gm-Message-State: AOAM531NPlU+Ker4A8cmNGuc0LSEth+fDA36nWcPgz2rjUi1v6Y8wa4U
 pD5HuY7vKiBorHk72vDRdA4XgKGJn8Y7Lpd6a4RBTw==
X-Google-Smtp-Source: ABdhPJzbr7vofetBy7WaHGCcBJoU8dEFaA6t6w9PFKrIsGW02rnD6YDbCI2WmhPDjcnFLwIqYzhnqFYJF/zHMKtP0x4=
X-Received: by 2002:a17:906:71c9:: with SMTP id
 i9mr2903304ejk.250.1601372472862; 
 Tue, 29 Sep 2020 02:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-10-peter.maydell@linaro.org>
 <87a6x90yy8.fsf@dusky.pond.sub.org>
In-Reply-To: <87a6x90yy8.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 10:41:01 +0100
Message-ID: <CAFEAcA9RauKyN2XfECOwqhT02FsmZdxbQkRa89=QGcq+z0Oorw@mail.gmail.com>
Subject: Re: [PATCH v6 09/21] docs/interop: Convert qemu-qmp-ref to rST
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Sep 2020 at 09:28, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > diff --git a/qapi/meson.build b/qapi/meson.build
> > index 2b2872a41d8..a287ca5d9d7 100644
> > --- a/qapi/meson.build
> > +++ b/qapi/meson.build
> > @@ -97,7 +97,7 @@ foreach module : qapi_all_modules
> >  endforeach
> >
> >  qapi_files = custom_target('shared QAPI source files',
> > -  output: qapi_util_outputs + qapi_specific_outputs + qapi_nonmodule_outputs + ['qapi-doc.texi'],
> > +  output: qapi_util_outputs + qapi_specific_outputs + qapi_nonmodule_outputs,
> >    input: [ files('qapi-schema.json') ],
> >    command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
> >    depend_files: [ qapi_inputs, qapi_gen_depends ])
> > @@ -121,5 +121,3 @@ foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
> >    specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: qapi_files[i])
> >    i = i + 1
> >  endforeach
> > -
> > -qapi_doc_texi = qapi_files[i]
>
> Doesn't storage-daemon/qapi/meson.build need a similar update?

I was previously unaware of storage-daemon/qapi...
It looks like we don't actually do anything with the generated
qapi-doc.texi there, so I'm not sure why we were listing it as an output.
I think we should only need to remove the " + ['qapi-doc.texi']"
in storage-daemon/qapi/meson.build, and that should be a separate
change after this one and before we remove scripts/qapi/doc.py.

thanks
-- PMM

