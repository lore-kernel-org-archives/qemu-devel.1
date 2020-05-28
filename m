Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5CFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 07:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDDC207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 07:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr7SjPYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDDC207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeCse-0001c7-BQ
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 03:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jeCs5-00016c-59; Thu, 28 May 2020 03:22:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:32898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jeCs3-0007Z5-La; Thu, 28 May 2020 03:22:32 -0400
Received: by mail-wr1-x434.google.com with SMTP id l11so26820540wru.0;
 Thu, 28 May 2020 00:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=lG1goK+j76bC1xgzoN5RNMDZSAMph60A5AtJ8km1I0o=;
 b=Lr7SjPYKWCR+htcjVxHMvdv+mCpf1sadXNCcM9IFhKuaKLja69ldRd2SOn3LRNumSu
 HRSg1cxgh7W92gTWYjP0WAAl8iw4Ec1h0JEttKppapN7tTaDDZ+XiBubDhrDO/IK28+B
 XXu54Cn1gEhQVSVHDdAZC7dPzTbYzBfm2UAjNieTSvnYITzTYC04GpSVnNWLHzN7Ekhc
 e+KEvumqJUPxWUosz5wPdY8LTeJa/1ztP6iYJF/9LLc3M5o6pGYHm9uDMCKKqFgW10zY
 h7W+gODx9k3RU3FpuI/s0JYIgDZY7JsGmU7N0iAGJr6+ZXwLIakFqWDJo0GYa+DoJV6h
 6/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=lG1goK+j76bC1xgzoN5RNMDZSAMph60A5AtJ8km1I0o=;
 b=T9VxOw3D4n2uKJiWwwrJr93tenGzUrLXD12BnM+6pK7OXU5OHs5hiW739an17RBOR+
 qHVC5J3POGQsbm3hf+XNlULI5R85U+ghX8xCaDZcwll4kE5r2H9N8Bdm/bjCbYHl9SEi
 JX2T1XtiZXoZ6GHQUyG2aqMQBNdNq1RcvB4saHrUJmPTom8seudHSSRdJ5m9mYbPuMOs
 o1257uoNs79fLgg2dZHcfQ/tHjKgLorba3FlLoSOGYNndo5vyeoPUNa4bjiKjqtyenIy
 rXyVXtCTMvwnh6okeXGsYYh8w+6um+YLCXmTmqASH0V7m4Ikh5C1gkKZ2lHprlPu44Jw
 2wAA==
X-Gm-Message-State: AOAM533i5p5hcBj7VKQCcJ6Y4STog8GbXLValrgLpH6++VUdeT6Zl2NH
 bY8VIdyoBYr7dl8h3tmceOY=
X-Google-Smtp-Source: ABdhPJzZeepf4f9Lhk6hcKohahXMsHQAxqVj1ZuAYT/Mm4ajGdUstVvT/LRiUMw5ohCj4bzJ7lehzg==
X-Received: by 2002:adf:eb47:: with SMTP id u7mr2142080wrn.14.1590650549215;
 Thu, 28 May 2020 00:22:29 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.186])
 by smtp.gmail.com with ESMTPSA id p1sm5125372wrx.44.2020.05.28.00.22.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 May 2020 00:22:28 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Roman Kagan'" <rvkagan@yandex-team.ru>,
	<qemu-devel@nongnu.org>
References: <20200527124511.986099-1-rvkagan@yandex-team.ru>
 <20200527124511.986099-3-rvkagan@yandex-team.ru>
In-Reply-To: <20200527124511.986099-3-rvkagan@yandex-team.ru>
Subject: RE: [PATCH v6 2/5] block: consolidate blocksize properties
 consistency checks
Date: Thu, 28 May 2020 08:22:25 +0100
Message-ID: <009a01d634c0$be65dc00$3b319400$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQIXeuT69nnYcgltbfOkY7MAd59asgG7AZYfqCyzbjA=
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: paul@xen.org
Cc: 'Kevin Wolf' <kwolf@redhat.com>, 'Fam Zheng' <fam@euphon.net>,
 'Stefano Stabellini' <sstabellini@kernel.org>,
 "=?utf-8?Q?'Daniel_P._Berrang=C3=A9'?=" <berrange@redhat.com>,
 'Eduardo Habkost' <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "'Michael S. Tsirkin'" <mst@redhat.com>, 'Laurent Vivier' <laurent@vivier.eu>,
 'Max Reitz' <mreitz@redhat.com>, 'John Snow' <jsnow@redhat.com>,
 'Keith Busch' <kbusch@kernel.org>, 'Gerd Hoffmann' <kraxel@redhat.com>,
 'Stefan Hajnoczi' <stefanha@redhat.com>, 'Paolo Bonzini' <pbonzini@redhat.com>,
 'Anthony Perard' <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Roman Kagan <rvkagan@yandex-team.ru>
> Sent: 27 May 2020 13:45
> To: qemu-devel@nongnu.org
> Cc: Kevin Wolf <kwolf@redhat.com>; xen-devel@lists.xenproject.org; =
Gerd Hoffmann <kraxel@redhat.com>;
> Daniel P. Berrang=C3=A9 <berrange@redhat.com>; Paolo Bonzini =
<pbonzini@redhat.com>; Anthony Perard
> <anthony.perard@citrix.com>; Laurent Vivier <laurent@vivier.eu>; Max =
Reitz <mreitz@redhat.com>; qemu-
> block@nongnu.org; Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>; =
Eric Blake <eblake@redhat.com>; Paul
> Durrant <paul@xen.org>; Fam Zheng <fam@euphon.net>; John Snow =
<jsnow@redhat.com>; Michael S. Tsirkin
> <mst@redhat.com>; Eduardo Habkost <ehabkost@redhat.com>; Keith Busch =
<kbusch@kernel.org>; Stefano
> Stabellini <sstabellini@kernel.org>; Stefan Hajnoczi =
<stefanha@redhat.com>
> Subject: [PATCH v6 2/5] block: consolidate blocksize properties =
consistency checks
>=20
> Several block device properties related to blocksize configuration =
must
> be in certain relationship WRT each other: physical block must be no
> smaller than logical block; min_io_size, opt_io_size, and
> discard_granularity must be a multiple of a logical block.
>=20
> To ensure these requirements are met, add corresponding consistency
> checks to blkconf_blocksizes, adjusting its signature to communicate
> possible error to the caller.  Also remove the now redundant =
consistency
> checks from the specific devices.
>=20
> Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>

Reviewed-by: Paul Durrant <paul@xen.org>



