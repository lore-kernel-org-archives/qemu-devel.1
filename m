Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B779C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC164207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p00yz1v9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC164207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CQw-0002YP-4y
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5CPd-0001Gg-DE
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 14:20:45 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5CPb-0002y0-6M
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 14:20:44 -0400
Received: by mail-ot1-x342.google.com with SMTP id a65so8030459otc.8
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SUKIF7YAq+gxcV4P0x/LHb+7gEhUOeKzNZ+fgumOGU8=;
 b=p00yz1v900SgH+X7fzkP+zCXSstFSRX6Ou95GSrNeshHd8FRxeE3/mSPloWmPWgkEb
 N8faYNm7CkCGdDFwaoOvPaRw5wLWI/ScUrOyB9hAgDgNq7bk5XKstZVULhuABvj1RTtO
 0WfxRnsBKXjl0W4H4oXeUKyksJSFPmTjMZXeeU3CGD4KjM+vP8MofL/RENsqDqiUOA+D
 7gFvEvImzwavRf4XMn15GrxOO6/1H/usbYWmSkHGSwKMF7WVfku8IF7pySfENnV6+w/L
 1tgwPfus0Zyp0xBk++l66c6YJRxWK1Nq5+X6FXdVmNZIs7IWoR/PBNGs7YyksA5SIBr8
 GzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SUKIF7YAq+gxcV4P0x/LHb+7gEhUOeKzNZ+fgumOGU8=;
 b=eioq1Vcw60Ep+WONAWy1SSEplGpEFcMcl9IbCEJLzBpQt1BtbZaGXzN0s9YXLKhDJ5
 nS5SRIxwdSdgU1dTo45C3tAazmWt5WFX46+ReMynCO7pHE2uptqBf86s3Q3fxc2cStFj
 iHAEgHyi0gKSiFtja+tIBssjK1JjRrYkyGpaAADB2s0f6EvsDcQ0o8J003yjoLwMODyH
 6wXqsgWWr7wUWaL27xc5hWdh0xmxPbtuvfbvh0uGdvdrVf4OgIglDThBrjbrVOn1iA1H
 GJtpWkebmez6EYHbTnVfzRNqvg4d5B5e19jjmiodAhglpgvlULobAn6KDCfeSs1EBONJ
 CkgA==
X-Gm-Message-State: AOAM5305/o0wf/m6BV1ncrZpcUBFYkq+ti0lQT8c1uBTNGRl9E0tR8kn
 SuRB9vJPlb8eU54n1QU8RS3XF/JNIjePju223ZAyyA==
X-Google-Smtp-Source: ABdhPJwUJE8zQdrSv03du82G7oe3r3LNRCSJkHh9FA1RG5kOKav9IB2h20UsKlc/rrQ+rqkMQb1aS6mZRvmEizSpO9s=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr1700935otq.221.1597083641423; 
 Mon, 10 Aug 2020 11:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
In-Reply-To: <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2020 19:20:30 +0100
Message-ID: <CAFEAcA_cBDHNgNsDMJS+WqX+W-xbo18c1Eno2RqGnwa-iGw3-w@mail.gmail.com>
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 19:09, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
> The other hosts are still running, will report results as
> they finish.

ppc64be host:

In file included from ../../contrib/vhost-user-scsi/vhost-user-scsi.c:15:0:
/usr/include/iscsi/scsi-lowlevel.h:810:13: error: inline function
=E2=80=98scsi_set_uint16=E2=80=99 declared but never defined [-Werror]
 inline void scsi_set_uint16(unsigned char *c, uint16_t val);
             ^
/usr/include/iscsi/scsi-lowlevel.h:809:13: error: inline function
=E2=80=98scsi_set_uint32=E2=80=99 declared but never defined [-Werror]
 inline void scsi_set_uint32(unsigned char *c, uint32_t val);
             ^
/usr/include/iscsi/scsi-lowlevel.h:808:17: error: inline function
=E2=80=98scsi_get_uint16=E2=80=99 declared but never defined [-Werror]
 inline uint16_t scsi_get_uint16(const unsigned char *c);
                 ^
/usr/include/iscsi/scsi-lowlevel.h:807:17: error: inline function
=E2=80=98scsi_get_uint32=E2=80=99 declared but never defined [-Werror]
 inline uint32_t scsi_get_uint32(const unsigned char *c);
                 ^
/usr/include/iscsi/scsi-lowlevel.h:810:13: error: inline function
=E2=80=98scsi_set_uint16=E2=80=99 declared but never defined [-Werror]
 inline void scsi_set_uint16(unsigned char *c, uint16_t val);
             ^
/usr/include/iscsi/scsi-lowlevel.h:809:13: error: inline function
=E2=80=98scsi_set_uint32=E2=80=99 declared but never defined [-Werror]
 inline void scsi_set_uint32(unsigned char *c, uint32_t val);
             ^
/usr/include/iscsi/scsi-lowlevel.h:808:17: error: inline function
=E2=80=98scsi_get_uint16=E2=80=99 declared but never defined [-Werror]
 inline uint16_t scsi_get_uint16(const unsigned char *c);
                 ^
/usr/include/iscsi/scsi-lowlevel.h:807:17: error: inline function
=E2=80=98scsi_get_uint32=E2=80=99 declared but never defined [-Werror]
 inline uint32_t scsi_get_uint32(const unsigned char *c);
                 ^
cc1: all warnings being treated as errors

(Looks like an error in the version of the system header
file on this system, which, unlike my x86 box, defines
the prototypes with "inline" (a change that came in upstream
in commit
https://github.com/sahlberg/libiscsi/commit/7692027d6c11c58948ec3c493abea80=
8af00fdd0
).

However, old make-style compilation worked on this system, so
something has changed.

thanks
-- PMM

