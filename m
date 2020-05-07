Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BF9C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137ED21835
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag3/IzoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137ED21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkZw-0004T8-9O
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jWkVU-0004MQ-AA
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:33552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jWkVQ-0001sC-E1
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:24 -0400
Received: by mail-wm1-x32b.google.com with SMTP id v8so8030102wma.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:thread-index
 :content-language;
 bh=eaPyYTkYXBrXu/xH0NnuAlo+Tq2jEVRxDirxaSw4Dm4=;
 b=Ag3/IzoGlN3au/qY+FZpa2CRlAewKiyWW+S5kVf2ol4AXBrd54gIBzulDIW0UcAgvk
 7QEOG5ezi6c5yG0dvMa3fBA4XhAv7mf8JM0wyzADxytMZtnopGSmz3wxcP5dbw6dMVH8
 waJJUudnOaFisZEtev+OiOyqhyTHMZboI+r7KuDy57mkFl+RCyRNkT0mM4YgzIqxkZoh
 QKQESboX15XGVw7SDeLMKqHpogruNBMS6gyNMZvJVQ1x950l0QK4uJ7KqCrnjOEsDVqL
 dLYC/NIF1YFk8qJVjGLif0CZtdFxYqKhDAGYM1hw3O89yo91/25cu3Dwhd08bGhU5wQk
 g8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :thread-index:content-language;
 bh=eaPyYTkYXBrXu/xH0NnuAlo+Tq2jEVRxDirxaSw4Dm4=;
 b=cPd+npdaKsTk6kcUon9s7C/pWvJEhsBch31OF6gV9eWn6ldNV/PrwmdymxArRk6fy+
 tEC1Z+6xUpb5OtbCmPFNqKCy+AxC2eIJDagpSllSfU9Ri2MjBJXxqpTXKIMo2kdvVpjn
 2meB/8B4vq3M703Bxpntga/iuAfhdx1f/awNLhw6Kp/DF1gamefif9uCgRD2Fgsoupgk
 hTE8qwVYc2dAcKQrAMOMB9gxLQpk3gU0dfglPs5S9raZgqE7tD57Wlq46DLenI6NoX8D
 Ww5dO5r3DJR9ILJ44s5Ebxqm0B8w8SH74eMB+KzrmfdAV5rBB5owGbLke+Q6yoiPv8lf
 AYew==
X-Gm-Message-State: AGi0PuY2RE89SrDsMSb/xFObRxLObUxtYdVZ1NzYkfqMMV0HHd5OitD3
 OjBX0tMnJzpG6LRXtJLbKH96Z1rM538=
X-Google-Smtp-Source: APiQypJCeKi1dsLuz1/XdQ4gHUKarUmee4ON98uMkUjEOZrkzHu3A/+yV1UEtRqanV14aWFbNTS9yQ==
X-Received: by 2002:a1c:7d4b:: with SMTP id y72mr11731981wmc.11.1588873217964; 
 Thu, 07 May 2020 10:40:17 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.186])
 by smtp.gmail.com with ESMTPSA id i74sm9154972wri.49.2020.05.07.10.40.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 May 2020 10:40:17 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20200507155813.16169-1-philmd@redhat.com>
In-Reply-To: <20200507155813.16169-1-philmd@redhat.com>
Subject: RE: [PATCH] accel: Move Xen accelerator code under accel/xen/
Date: Thu, 7 May 2020 18:40:15 +0100
Message-ID: <00d101d62496$9261b6e0$b72524a0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLCd2e1MKAbxFSNuZsafCzsSnsP7KbEPi8w
Content-Language: en-gb
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32b.google.com
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
Cc: 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Eduardo Habkost' <ehabkost@redhat.com>, 'Juan Quintela' <quintela@redhat.com>,
 "'Michael S. Tsirkin'" <mst@redhat.com>,
 "'Dr. David Alan Gilbert'" <dgilbert@redhat.com>,
 'Aleksandar Markovic' <aleksandar.qemu.devel@gmail.com>,
 'Paolo Bonzini' <pbonzini@redhat.com>, 'Igor Mammedov' <imammedo@redhat.com>,
 'Anthony Perard' <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 'Aurelien Jarno' <aurelien@aurel32.net>, 'Richard Henderson' <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Sent: 07 May 2020 16:58
> To: qemu-devel@nongnu.org
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>; =
xen-devel@lists.xenproject.org; Stefano Stabellini
> <sstabellini@kernel.org>; Aleksandar Markovic =
<aleksandar.qemu.devel@gmail.com>; Aurelien Jarno
> <aurelien@aurel32.net>; Paolo Bonzini <pbonzini@redhat.com>; Igor =
Mammedov <imammedo@redhat.com>;
> Eduardo Habkost <ehabkost@redhat.com>; Richard Henderson =
<rth@twiddle.net>; Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com>; Dr. David Alan Gilbert =
<dgilbert@redhat.com>; Juan Quintela
> <quintela@redhat.com>; Michael S. Tsirkin <mst@redhat.com>; Paul =
Durrant <paul@xen.org>; Anthony
> Perard <anthony.perard@citrix.com>
> Subject: [PATCH] accel: Move Xen accelerator code under accel/xen/
>=20
> This code is not related to hardware emulation.
> Move it under accel/ with the other hypervisors.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Paul Durrant <paul@xen.org>


