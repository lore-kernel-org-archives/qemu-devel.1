Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD49C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 02:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A0D2173B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 02:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XndnAz/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A0D2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnw0S-00084T-7g
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 22:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44049)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnw0G-0007Pp-L0
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 22:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnw0F-0000Yb-P7
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 22:18:40 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnw0F-0000YD-JS; Wed, 17 Jul 2019 22:18:39 -0400
Received: by mail-pl1-x641.google.com with SMTP id m9so12946463pls.8;
 Wed, 17 Jul 2019 19:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=Zt/iFW+533iUzw3/VidFxFQomxAs1nVRTZ9mikw24hA=;
 b=XndnAz/ijnNrhTYRcEWcqhbJojntLoDkFOpnP2DyLjXUMhXUznuIoZeoWYLo8EYJSW
 8ou2qqpysgdvoTVIvzRAMyxjgxzeSn9zuJo9LwJ01rS7vt3g8Z/6rHoKjrpEc8lvWYPk
 1FvBI0ljZlvJIgfxfiHralN784WYGZTAFAlVAgwWQmOytVWYyt9Q7B5TIq9GiTWJRiOA
 2mOeXKoty9H5ojvUtSrXc03xTF4vauHdWoni3lFAZ0O14QXItTQ9A/7vSNMd3bDL0KNC
 rrX5s6ecHl9GPQ7i5DRtW/XGbkkwbMpictA5UhQYxZ/GYjOui1Avhqh6qLe6EkwkRn3T
 rbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=Zt/iFW+533iUzw3/VidFxFQomxAs1nVRTZ9mikw24hA=;
 b=CcuBm4pmUeev3VXDoB7QncWcl9yh/W6P4lq+ddXTTDfq4G194twtR6o0OAzcLOxbvs
 w4L9SDtkkVtLMMFLXRjtgMOw3ycv5s3rqjvheYglmSU5uH9PmPwSK5GTYOQeOS3CkeFT
 J2XKBQl2ByK3BbtmL7QJQ66f5pLLazJ1wu+MBStnmnIvFLCPUn/8+0p9M2AC3NBjseWo
 uaZDJb5gaBKzVRt1jSdtKyLjfpTNbENB7LtLzwDK6VFA8B//JriGnQ5mX1OF7UdBgaM5
 myLsMEcxPuj+aBeDDMt7Od/FiOWQ3Jzt0qFGgJUvtNwT+kfmdj81oXJS1+OsIfZzLjlJ
 RCcg==
X-Gm-Message-State: APjAAAW4/W5fx0QzIe74pwZdA+BHPxLE7leeIQXF3fSLKYtDVSR6iyoZ
 3DHrJYUilRdG9q9ZzBpclt4=
X-Google-Smtp-Source: APXvYqzVV2xzvSGwIcMonyNQ0XMn6Vw7IgELuGCdHbot888kChlbzue2/jEhWJmRxqpOze+i/v9LwQ==
X-Received: by 2002:a17:902:2a27:: with SMTP id
 i36mr46405916plb.161.1563416318618; 
 Wed, 17 Jul 2019 19:18:38 -0700 (PDT)
Received: from localhost ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id d2sm23167605pjs.21.2019.07.17.19.18.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 19:18:38 -0700 (PDT)
Date: Thu, 18 Jul 2019 12:18:30 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Greg Kurz <groug@kaod.org>
References: <20190717053952.13729-1-npiggin@gmail.com>
 <20190717053952.13729-2-npiggin@gmail.com>
 <20190717172910.426f3d22@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190717172910.426f3d22@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563416246.khbnwcjhsc.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz's on July 18, 2019 1:29 am:
> On Wed, 17 Jul 2019 15:39:49 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>> -    cpu->machine_data =3D g_new0(SpaprCpuState, 1);
>> +    spapr_cpu =3D g_new0(SpaprCpuState, 1);
>> +    cpu->machine_data =3D spapr_cpu;
>=20
> What's the purpose of this change since there's no other
> user of spapr_cpu in this function ?

It is an orphan from when the previous patch kept a dispatch_counter
in the state data structure. Now we just use the VPA directly I can
remove this completely, good catch.

>> @@ -10624,6 +10646,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, =
void *data)
>>      cc->tcg_initialize =3D ppc_translate_init;
>>      cc->tlb_fill =3D ppc_cpu_tlb_fill;
>>  #endif
>> +    cc->cpu_exec_enter =3D ppc_cpu_exec_enter;
>> +    cc->cpu_exec_exit =3D ppc_cpu_exec_exit;
>> +
>=20
> This code only makes sense with system emulation. I guess it
> should be guarded with !defined(CONFIG_USER_ONLY).

I can do that.

Thanks,
Nick
=

