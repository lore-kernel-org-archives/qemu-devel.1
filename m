Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B72C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04EC20725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="TIspNaB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04EC20725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtpHs-0005Vh-UN
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jtpHA-0004aj-7G
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:25:00 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:34953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jtpH8-0003tY-AO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:24:59 -0400
Received: by mail-ej1-x62c.google.com with SMTP id rk21so5318781ejb.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=KQI0uWnZbDcP2LwXvQrT4QTaHp77pVPs9vkVnBBc/ZM=;
 b=TIspNaB7vfHvSCtUzCJqCsENbyete6ii2T3x8Sv4a0xICv8bOf6AzF5rOUCnVwuDw7
 gBWxPjMvr2fZLTlUsn9PqnAcyb2RWPOOG8r1iewTer2ZhER1pZUZ/NLt406XMx/X/KtU
 HelyFCFU6/fP5zken1gnLIVNHrHFgKW6e6hPp4XumE84AKU8tM5dVmi9VlaUm1KG+nJV
 0mVDbb/HcidEqcVqkxaPO1arAppJeCoNGdSBUToM1ipiZKjkKV8p/JHFGYq8xSHOVrOT
 4wawqQmm792nJ2J8utIYr/K4leFWrvOndloDXMMysQwFJsefhE9jvL8PhA/ZBWoD7VLZ
 g3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=KQI0uWnZbDcP2LwXvQrT4QTaHp77pVPs9vkVnBBc/ZM=;
 b=NvUmpfrDVGXTEBWEE2VSnUVkB1uHpYctmUm65pW9Q06GuVQsyN3L2f8AF8BIpaeGXE
 XXK89gv1iS4EEXUn0TC2SYcFiymx0GnlRgLnXTLGm1q5x+448VGrzNm2qE88ynTTkjsH
 CedYiYRCRvkXFcBLCLmp8QfQ76s978Fu8iGZ1JEtN4fQOzPeLT9A1QQtMkkhvG7FBsO+
 epjp8HAzHJG/qJGQCrGsyWm/RlwIOFhJotBezjfePWeEm/7LvJvrhz6FnvZpXQAAIBvc
 vncT80dzKMBIFDH10naroDrqS6ZNXZvtyxIfcLu9RBiny0BqTcumW1kFW/u0K/igVl89
 eYSA==
X-Gm-Message-State: AOAM53232GQriC7dicvzeXVJ+L/4ZLtgsLFNMgcqXITnrEJ5lkjQ1zwz
 Ko1RmaOx2vpG5Mpl6b8PJUTdEruUukU=
X-Google-Smtp-Source: ABdhPJzVv86f76aOOGj2VdZ9Vd8kYh+N8NT1LW4sTGe6sAFh+DvvCGWoSe9RhPMSi8OSFZkrbVMVzw==
X-Received: by 2002:a17:906:2a5b:: with SMTP id
 k27mr58443483eje.82.1594373096509; 
 Fri, 10 Jul 2020 02:24:56 -0700 (PDT)
Received: from wks.local ([86.121.22.151])
 by smtp.gmail.com with ESMTPSA id q17sm3308506ejd.20.2020.07.10.02.24.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jul 2020 02:24:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Separate notifications from list messages?
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <20200710085454.GD4017912@redhat.com>
Date: Fri, 10 Jul 2020 12:24:54 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <94ACA177-24F6-461F-B12E-79958D713BF1@livius.net>
References: <E646BE29-B46F-4B56-ADF5-B0DC6CCEF422@livius.net>
 <0a3689e1-001a-76ec-894d-0bb63115ecdd@redhat.com>
 <CAFEAcA-Y_e9V2UTEZoVbxOWQcs_eP96cMQ1J2BtC6Y0AAUTgSA@mail.gmail.com>
 <FF6A540C-7C16-4FFC-9A6D-FAB9EFE56B7F@livius.net>
 <CAFEAcA_c3M-NQcXMt7pnA1qn9B8AYSnFMP1zHx3i_cU2cqpnSQ@mail.gmail.com>
 <008CCEB6-D3F4-4F1A-80DE-83F47873851F@livius.net>
 <20200710085454.GD4017912@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Received-SPF: none client-ip=2a00:1450:4864:20::62c;
 envelope-from=ilg@livius.net; helo=mail-ej1-x62c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 10 Jul 2020, at 11:54, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> This wasn't a mistake - it was very delibrate, precisely so that all
> involved in QEMU development will see the failures, instead of =
expecting
> a handful of people to take all the work of dealing with failures. In
> general anyone who's a regular contributor has a shared responsibility
> to help keep QEMU building reliably.

Yes, sure, but the typical workflow allows anyone to submit =
contributions, these contributions are automatically checked by CI, and =
if they pass, someone with administrative rights merges them into the =
repo.

Thus the main responsibility for dealing with failures goes to the =
contributor, there is little the community can do to fix the failures.

---

Anyway, do as you like; I already added filters in the mail server to =
remove those messages.


Regards,

Liviu








