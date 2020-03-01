Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E280C3F2D1
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 11:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D642087F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 11:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfMHM7Oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D642087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8NF5-0003oX-C4
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 06:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8NEQ-0003PD-9J
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 06:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8NEO-0001l1-6U
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 06:58:01 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8NEN-0001js-Ut
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 06:58:00 -0500
Received: by mail-wr1-x442.google.com with SMTP id j7so8851255wrp.13
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 03:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=t2LPPNNSC58YZNWIz2zOj/vZ5hicgLMqdgTFkhVT0pE=;
 b=mfMHM7Ocvqy+ZiZPYRJfLOVnbu9T9Rv7mi5tLPbHEvn1snADRsWlMdt0IYWspuBJMR
 rHvJfPTohKmPFfQxiqc899/qxWmEWR+444SRzjjKdNDMKrNmbbRAGba8S6Xzx1yMqwNw
 Ku6cChSfZMgoGkZaJo8/n49zoZkEnULHbs3mhNt7NDuY+54gqRj0IDgWUfcvQDBWKdST
 u5C0eViGaKSRsRvvs1fvlKe3mZFY0+t8okkJV9PiiOInT+qXe/wu4MOAtYX6qimy/xT7
 3sbI3Ix/QW1+rDO9nB3egqlufL5rFVtpq1gvBV87v4SZF6PYjkdveJHGgJyeduOtbj77
 9weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=t2LPPNNSC58YZNWIz2zOj/vZ5hicgLMqdgTFkhVT0pE=;
 b=joPK8ffI4OHCjMZ90Cajzx9cUbpeM06YJSHCzcI8mjFEgCwWDKePFiZ3DqZHRo6Cud
 QqtgiBUZpiOYwcFYfTRr1SwKaEOuRGcdvnk+JXUaspBF3Qo1f2y+HyNbfgndu5XXSkqW
 /qcIZ54HIFa2hBgUbodfgRIoBFXyBVjjZigOOP3enpvoLKCAW4+XtT1ooF73zhhPDqEH
 2VmJ/pevOfy5/aSVNaXgbxLWeaqsd2V7V0/E7LeykGSu4AHQjGloRnIMy+xgdQOoapSj
 EvwnKzefdTkZZsE+VLrb8nTeNS1N8AZr9UP1KV1ELartzNeVBXvon7e8wwfgVTYDyGo8
 Yk+g==
X-Gm-Message-State: APjAAAVDp70JtmiM4MDnQh+cXN01ZmfsmPVjSw/frVFzaldj5kXSq9YI
 5bnUJb4bLfFN+GqjuXj4u0cohw==
X-Google-Smtp-Source: APXvYqxothgYDE6cpzm9fkCaKAMY8uiDPSiG/AjqXBoFN6bicmN7RByTIYl7K+GLmrMcDRKSesmVYg==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr15711649wrq.137.1583063878421; 
 Sun, 01 Mar 2020 03:57:58 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b14sm11833858wrn.75.2020.03.01.03.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2020 03:57:56 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 91C3C1FF87;
 Sun,  1 Mar 2020 11:57:55 +0000 (GMT)
References: <cover.1582576372.git.jag.raman@oracle.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 00/50] Initial support for multi-process qemu
In-reply-to: <cover.1582576372.git.jag.raman@oracle.com>
Date: Sun, 01 Mar 2020 11:57:55 +0000
Message-ID: <8736as5lto.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jagannathan Raman <jag.raman@oracle.com> writes:

> Hello
>=20=20=20
> Started with the presentation in October 2017 made by Marc-Andre (Red Hat)
> and Konrad Wilk (Oracle) [1], and continued by Jag's BoF at KVM Forum 201=
8,
> the multi-process project is now available and presented in this patchset.
> This first series enables the emulation of lsi53c895a in a separate proce=
ss.
>
> We posted the Proof Of Concept patches [2] before the BoF session in 2018.
> Subsequently, we posted RFC v1 [3], RFC v2 [4], RFC v3 [5] and RFC v4 [6].
>
> John & Elena presented the status of this project in KVM Forum 2019. We
> appreciate the in-person and email feedback we received to improve this
> patchset. We also received valuable feedback and direction on future
> improvements from the bi-weekly KVM community conference. We have
> incorporated all the feedback in the current version of the series, v5.
>
> Following people contributed to this patchset:
>
> John G Johnson <john.g.johnson@oracle.com>
> Jagannathan Raman <jag.raman@oracle.com>
> Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Kanth Ghatraju <kanth.ghatraju@oracle.com>
> Konrad Wilk <konrad.wilk@oracle.com>
>
> For full concept writeup about QEMU disaggregation, refer to
> docs/devel/qemu-multiprocess.rst. Please refer to
> docs/qemu-multiprocess.txt for usage information.
>
> We are planning on making the following improvements in the future to the=
 experimental
> Qemu multi-process:
>  - Asynchronous communication channel;
>  - Performance improvements;
>  - Libvirt support;
>  - Enforcement of security policies and privileges control;
>
> We welcome all your ideas, concerns, and questions for this patchset.

There seem to be quite a few CI failures with this series applied:

  https://travis-ci.org/stsquad/qemu/builds/656432858
  https://app.shippable.com/github/stsquad/qemu/runs/1275/summary/console
  https://gitlab.com/stsquad/qemu/pipelines/122030403
  https://cirrus-ci.com/build/4577637150490624

--=20
Alex Benn=C3=A9e

