Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB091C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9636824672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9nrnNbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9636824672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMsE-0002PT-Qc
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1irMpq-00007Q-7l
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1irMpp-0005Uv-5M
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:06:22 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732]:38939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1irMpp-0005U3-1S
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:06:21 -0500
Received: by mail-qk1-x732.google.com with SMTP id c16so12151205qko.6
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 06:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=Akw5C8eaMK8w71cyFsQQF9LIxkUYiRmnyP2N/7loS7A=;
 b=l9nrnNbONO23Y61FuUch8bAHP+jzYJRJO072F1OUznFlgdt2XcecP4zH2stftvR2/A
 Ts0GhHTPsEMpMkqqy5pUXNKig4vCJW8c/yQUr/rZAbAC7CCUbBzXFzTX4QnsB9nTgjyz
 nZLEembNEmLukg1oVH08t6rqtNVDdWVjYsU9mb06dKZqjLZUyEQV9qDx+MlxeFm+fn3S
 DqEHSmqysH45Hy/K7dGylHg+xsJGk641kpTKB83pHqjKOTEkadE2rN35cYxVbwWwCmeQ
 wmBzoggnoxbeCNR8Mm4ncbUeu30zSQBkKLRzzcIuDll1UPTbCg6Y+2rc/x9O7WfSTgFn
 KOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Akw5C8eaMK8w71cyFsQQF9LIxkUYiRmnyP2N/7loS7A=;
 b=U3znSvWC0Bi0AKAU5LmfA+JoBQHZLjWtsp+pnAsIi4dZ7AezWQc6oy8SU+Cf5s5mnk
 biNJpHQ2cfNMM7Qpd7JuZwppNKuoWBH/Pt6MLi+rntc84jkcibdbc8caldqMWf6tYKkr
 Y7jMCSq7QviBD+Yrtg6x22abrmQW+QNH93qrodY0+p/3HAYGcxgYDlvF61qR4s1zXhy0
 TT4t3xXgv0Xk+Yr6hPO3iGB0VsMDgRy5bbv8U4gYRYpDv2yZFqurc58jFUo1PGIs0fGt
 eUwOvPKmeeNNrMKZotadEd52cwqhiAPcVzumxj0NVgLjNIxEOP1WAXHehRyPF99+P9Wr
 +cFQ==
X-Gm-Message-State: APjAAAUiSBXzVzuGRlCW8muoo5PrVziWOMvaJaQvx7t1A+Kqir9Hoh7x
 KNUmrEwJXaTJDt+DN8SO82+jwUXNKuk8slRYrHg=
X-Google-Smtp-Source: APXvYqxzgyq9AlC4s/EXHM76A7Pz+kIM7AlkQ/nLF3cUDpwAVjWKzAVOaMPQUM2RsAzByK7a7bthK88p+ViOREg++rU=
X-Received: by 2002:a05:620a:1014:: with SMTP id
 z20mr21340953qkj.196.1579010780210; 
 Tue, 14 Jan 2020 06:06:20 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUUR72Rr_deeckz+RHpZMEBv692V4XupWy9ai3i2QD8bw@mail.gmail.com>
In-Reply-To: <CAJSP0QUUR72Rr_deeckz+RHpZMEBv692V4XupWy9ai3i2QD8bw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 14 Jan 2020 14:06:07 +0000
Message-ID: <CAJSP0QU=VP3geaJX-0=fAADB263KZOwAgSBZOvxrx2x-QiGUbA@mail.gmail.com>
Subject: Re: Requirements for out-of-process device emulation
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>, 
 Felipe Franciosi <felipe@nutanix.com>, Jag Raman <jag.raman@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::732
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The call is starting now!  Sorry, I forgot to send this to qemu-devel.

Stefan

On Tue, Jan 14, 2020 at 11:50 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> Hi,
> In today's KVM Community Call we will discuss multi-process QEMU and
> related topics (muser and VFIO).
>
> I wanted to share requirements that I've gathered from our previous discussions:
>  * Multiple bus types - new bus types can be added in the future.
>  * Security - VMM does not trust the device emulation process and vice versa.
>  * Unprivileged operation - QEMU and the device emulation process can
> be launched without root privileges.
>  * Live migration - saving device state and restoring it.
>  * Recovery - the device emulation process can be restarted after a
> crash without the guest's knowledge.
>  * vIOMMU - address translation and the ability to expose only a
> subset of guest RAM to the device emulation process.
>  * Portability - works across host OSes
>
> Following the VFIO API closely seems attractive to avoid reinventing the wheel.
>
> Stefan

