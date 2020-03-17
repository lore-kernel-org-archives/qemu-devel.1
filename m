Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686DFC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02E8C20757
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqM+DA9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E8C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDoT-0007wj-S2
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1jEDnX-0006tW-Ot
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1jEDnW-0005Bb-Ls
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:06:27 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:43093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1jEDnQ-00048I-HY; Tue, 17 Mar 2020 11:06:20 -0400
Received: by mail-qv1-xf43.google.com with SMTP id c28so10999000qvb.10;
 Tue, 17 Mar 2020 08:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=iicBtEJsKuObftjCntJzhmJhcV615VU5yQU1s0QCYoA=;
 b=tqM+DA9ZFc00dAK/Tug9ooP0pnCRsp6bRkMjj/YhDt/lNE9e4Uu9LdjioBXV21f43d
 sGI/7UwLO6VlfqaUummDPaFpVF8GwfOdHPiNPC8vaB27hjA+rRl1bmPdqznQqLn6ILHT
 7Aec/u2B9mNOQtlBJkYM2lwwfD0t8BOMmjInfQ38ic+G24rcLERhRt5ORUMe30S3la28
 yf1hWukk2EeRSvn+UZI/c78e5xWqv9shv+rIjtgOxdWpE+qVP73ICLmmBaa5IPObGYa/
 bWNMWDK7+IfzUjjetOgbib9dV9hllMVg6jFOJXhM4SQ3S1LYSvPq6NRP+IXUTTpM5pom
 HH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=iicBtEJsKuObftjCntJzhmJhcV615VU5yQU1s0QCYoA=;
 b=hMEWbggs5B+xbMV5fk+4d1wW/m9fc8WR3gB3HwvltdjxztX2zAtvktBCYeA1ExZ70a
 tEf+I/TZeemCfGp9hZwvtsBTSHqfZ1CXxsEHtwi/vNBCiVRqHxyB0h3Q9IOwBIjrfi1I
 ID0fUXJOyoPl/DDWyE9CNcbZvSbZZu5QdUkNkY9ib7syvlvMmjd6Ky3taSlZ7mEZ3f6T
 Bli/jCRk5RPeAO9kYJI84pJpxb3H3ey568SwiEoNL8zoEbvMF71+MTeDTjaTFkbaYoqv
 c8CWniH5KrNWsZYisB0kgovwtUyzpRTQ7weYm0X4iv+gUeCwYHd4dxVsYJ5eJL+HAxiy
 6yyQ==
X-Gm-Message-State: ANhLgQ111qY2fJ8m4zjDVbkKC5nkzNkxBdsWvlqK2SeETX4loZ3T3zdw
 NbMtRYjXgdIUlVWwZDmwchWmrBuc
X-Google-Smtp-Source: ADFU+vvVFjReH1Ez0hhHxDWbPl/Cp+tI6VPwY5ub+bjR2jrW5BQV+2PbwLCjRMylCUbgflaHmgB+jg==
X-Received: by 2002:a0c:ed2d:: with SMTP id u13mr5378959qvq.203.1584457578392; 
 Tue, 17 Mar 2020 08:06:18 -0700 (PDT)
Received: from [192.168.0.4] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id p126sm2104362qkd.108.2020.03.17.08.06.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Mar 2020 08:06:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 6/8] target/ppc: allow ppc_cpu_do_system_reset to take
 an alternate vector
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.138.1584442890.3017.qemu-ppc@nongnu.org>
Date: Tue, 17 Mar 2020 11:06:15 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <34ABB38A-B887-41B5-9108-25DA6ADB4B24@gmail.com>
References: <mailman.138.1584442890.3017.qemu-ppc@nongnu.org>
To: qemu-ppc <qemu-ppc@nongnu.org>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, npiggin@gmail.com
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Mar 17, 2020, at 7:01 AM, qemu-ppc-request@nongnu.org wrote:
>=20
> Message: 3
> Date: Tue, 17 Mar 2020 11:47:32 +0100
> From: C=C3=A9dric Le Goater <clg@kaod.org>
> To: David Gibson <david@gibson.dropbear.id.au>, Nicholas Piggin
> 	<npiggin@gmail.com>
> Cc: qemu-ppc@nongnu.org, Aravinda Prasad <arawinda.p@gmail.com>,
> 	Ganesh Goudar <ganeshgr@linux.ibm.com>, Greg Kurz =
<groug@kaod.org>,
> 	qemu-devel@nongnu.org
> Subject: Re: [PATCH v2 6/8] target/ppc: allow ppc_cpu_do_system_reset
> 	to take an alternate vector
> Message-ID: <097148e5-78be-a294-236d-160fb5c29d4a@kaod.org>
> Content-Type: text/plain; charset=3Dwindows-1252
>=20
> On 3/17/20 12:34 AM, David Gibson wrote:
>> On Tue, Mar 17, 2020 at 09:28:24AM +1000, Nicholas Piggin wrote:
>>> C=C3=A9dric Le Goater's on March 17, 2020 4:15 am:
>>>> On 3/16/20 3:26 PM, Nicholas Piggin wrote:
>>>>> Provide for an alternate delivery location, -1 defaults to the
>>>>> architected address.
>>>>=20
>>>> I don't know what is the best approach, to override the vector addr
>>>> computed by powerpc_excp() or use a machine class handler with=20
>>>> cpu->vhyp.
>>>=20
>>> Yeah it's getting a bit ad hoc and inconsistent with machine check
>>> etc, I just figured get something minimal in there now. The whole
>>> exception delivery needs a spring clean though.
>>=20

Currently Mac OS 9 will not restart. When someone goes to restart it the =
screen will turn black and stay that way. Could this patch solve this =
problem?


