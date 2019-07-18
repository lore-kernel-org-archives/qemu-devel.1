Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6A0C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 02:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 730CF2173B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 02:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ4mheM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730CF2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnvz4-0006RJ-BR
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 22:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43434)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnvyq-0005r6-4n
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 22:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnvyp-00087x-7K
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 22:17:12 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38849)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnvyo-000873-UB; Wed, 17 Jul 2019 22:17:11 -0400
Received: by mail-pg1-x542.google.com with SMTP id f5so3262959pgu.5;
 Wed, 17 Jul 2019 19:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=/fvAlDMhh98/vOr7K9E+E8Vutkf/LTZ2yZyN8zcTiTk=;
 b=IJ4mheM03ryfOdjQ92CyxYDE4Z3KxSkFMt4Knr7xJOLGu9/gFGNjD04lJYS0HzfhjX
 9Vu8VYyVbQXqmms71ROqPpjdLfSibO1z6aeB5SQ5JPly9CEdMBSiDb3Kk8gJb/KrJbQa
 makhL3GkFh0LZ9DJxB8s6wV18esK2oj0uzM80Gw0Brpuk0YNE25MPUjSnCDwJRJuTOvA
 gv+rN9IXSWq/ZkX0AseI04i9L9Zh3eVpZzWmA5jKWPViGoglkifmvt6ij5cqV2oUwP+H
 RT6JLBTrt4zwHyktUY/jF2VX/x3idLm4wr++J6VisD3z9tewK7Bw5rfiTVuOuRxpKlnH
 3wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=/fvAlDMhh98/vOr7K9E+E8Vutkf/LTZ2yZyN8zcTiTk=;
 b=bfocgliJIKzNxbgoliX6TDu8/5e6/sBYCFzN0PYVkfhfq9buqjiI7QcoxHssoKMA92
 E9DlQE0q8ulScfzKI2Mvmqt56OcqdHDiMUG6s0TcJ/SU/QS/vuyTipRFWpwuCmF46T/0
 gzmreKrN1CLe05YItbgfEET6B7ez0KFvmav4jTqtogTIk5VY9lN4y1I4IB5YAJbIMe0T
 qDUoYCYvS/E0P89byI3L9CIwRMooTl5Fc8COkgpJPBMVZ7JiALElAREoee8TKAvZn75L
 Dn75e2QAYy+VdRqcg7CoOzW0mCMabwCR+HuI68GDig05EjeF+2unULZt8EOQPWtDpw/5
 PjTA==
X-Gm-Message-State: APjAAAXn0fvrTsWQFM+R7Bn1JyKE1hU/i9rcRGOxo++1wydvFcY/AyWz
 LIrN4Xuo00rIuoCAy+/lY80=
X-Google-Smtp-Source: APXvYqxdoZIoNU/0W9zVIo4zuyaIMuxOv7LHJuQOJzLR8iHSGxVSPUi8spzwrFNymOR+RfJ2r8MSMw==
X-Received: by 2002:a65:6448:: with SMTP id s8mr45137915pgv.223.1563416229672; 
 Wed, 17 Jul 2019 19:17:09 -0700 (PDT)
Received: from localhost ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id z12sm3473935pfn.29.2019.07.17.19.17.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 19:17:08 -0700 (PDT)
Date: Thu, 18 Jul 2019 12:17:02 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>
References: <20190717053952.13729-1-npiggin@gmail.com>
 <20190717053952.13729-2-npiggin@gmail.com>
 <f5beaba9-03cf-cfc3-df42-4d9c6d213c07@kaod.org>
In-Reply-To: <f5beaba9-03cf-cfc3-df42-4d9c6d213c07@kaod.org>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563416009.fiuieedoup.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v5 1/4] spapr: Implement VPA dispatch
 counter and prod bit on tcg
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

C=C3=A9dric Le Goater's on July 17, 2019 10:50 pm:
> On 17/07/2019 07:39, Nicholas Piggin wrote:
>> Implement cpu_exec_enter/exit on ppc which calls into new methods of
>> the same name in PPCVirtualHypervisorClass. These are used by spapr
>> to implement these splpar elements, used in subsequent changes.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> This is nice. I am thinking of using these handlers to push/pull=20
> the XIVE OS CAM line and escalate to QEMU when a vCPU being notified=20
> is not dispatched.

Great if it is useful.

>> +static void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU=
 *cpu)
>> +{
>> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
>> +
>> +    /* These are only called by TCG, KVM maintains dispatch state */
>> +
>> +    spapr_cpu->prod =3D false;
>=20
> I would have kept this prod bool for the next patch as we don't use it he=
re.

Okay I'll do that.

>> +    if (spapr_cpu->vpa_addr) {
>> +        CPUState *cs =3D CPU(cpu);
>> +        unsigned int dispatch;
>> +
>> +        dispatch =3D ldl_be_phys(cs->as,
>> +                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNT=
ER);
>> +        dispatch++;
>> +        if ((dispatch & 1) !=3D 0) /* guest set the "wrong" value */
>> +            dispatch++;
>=20
>=20
> You might want to add :
>=20
>   qemu_log_mask(LOG_GUEST_ERROR, ...); =20
>=20
> when the yield value is wrong.

Hm didn't know about that, good point I can add it.

Thanks,
Nick
=

