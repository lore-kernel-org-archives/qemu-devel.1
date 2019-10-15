Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D323C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF6C20854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=astrobotic-com.20150623.gappssmtp.com header.i=@astrobotic-com.20150623.gappssmtp.com header.b="Y5XUgSS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF6C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=astrobotic.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKOXJ-0004Bc-3T
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 11:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joshua.shaffer@astrobotic.com>) id 1iKMiH-0001bY-5u
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 09:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joshua.shaffer@astrobotic.com>) id 1iKMiF-0007Kw-QA
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 09:18:09 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d]:33442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joshua.shaffer@astrobotic.com>)
 id 1iKMiF-0007Jb-82
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 09:18:07 -0400
Received: by mail-lf1-x12d.google.com with SMTP id y127so14478166lfc.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=astrobotic-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=GBsM+jjArf1xZWuYwUzAXxh0zV7QecWSOqNQxsYKnbU=;
 b=Y5XUgSS2I314k4eIv9/Lj2hh6OhItFxLAjLsphws+PtkohZzsuHS91a9IlsSUNiCyu
 pYpc7JoTWx1Hhh7lZaVAN9ZpWTCQDBBUMofwZOCHvqfDj0hGGAZ7N8ILha//Zm0m7rEM
 TqyaeAbg9Fi6Hs6MnWVdiSZSFP3CHUJ9uvjS5YEkLdLU40ZWd8Tjvz/S0ktzM327OIwO
 QtdvGLWektrgw3VYvbTdIjB+sEUDeomsyGnoMmYMoKnjkJQFy8WKOSOKg2dpu+RslXUj
 H+PxZCxT6LLtLKpB5gxrQrLCpfECHSiaEG6C8lXOqlz2M8aGuPDtCq9McFtG2LQxabmV
 sedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=GBsM+jjArf1xZWuYwUzAXxh0zV7QecWSOqNQxsYKnbU=;
 b=gcvWV9Vq6tKM4AK/H+THXLfe+zvmnhAlkVs4F+A+yM7XFv3FN+DT2mpV2VCWXR78Pi
 GMSiW5OoDcREzInfo3Nw5AGxQJCfSwdF5upRJLejxCG6etLFMLLuEHPgt5RxxH/Cya/9
 1A+Sa9NJfU2zZGSp6Ow9fUBxkzuAj5MR8VJ7LX0+E08U8kO1iMAjeNgCLVU+1CwHqAHA
 Je15ZNmwcN0vllW14CyJuUb/867Uc3aJu9e+l0a8PBvbDRLKAgNKfbDEQk9RJcJpK/tL
 kTdkIOcrsHNTjy//OrCuCyQUfhUYbW6EbvymGU03m9cmN0/ITdCE0G+T2/M9ggQlQarg
 Eynw==
X-Gm-Message-State: APjAAAVtUmq53NcztECstciaRs9RkMdS16wBPiJhsUDV5q0RvNUM9Lap
 aFVab9OXTVn0aQf01bXXbIQUZ+/yoxdWWHEl0Ff0xaQBXTxNct0V0WjztJZL9o71T1k2Mtp0P2f
 AlVF9CoGfbH4qrnvGuAuJt0dmtt0=
X-Google-Smtp-Source: APXvYqzmTvLUys4nSKeusfZ8C2r6Sa6okqkMpeBRMR3URTgt+d37v/WkiWV/PQBu5ulTsRmCN/zKEaLtkcrdJUOQTkI=
X-Received: by 2002:ac2:555e:: with SMTP id l30mr20727504lfk.163.1571145483456; 
 Tue, 15 Oct 2019 06:18:03 -0700 (PDT)
MIME-Version: 1.0
From: Joshua Shaffer <joshua.shaffer@astrobotic.com>
Date: Tue, 15 Oct 2019 09:17:52 -0400
Message-ID: <CAPJW7GKLH3pkrGQQj_OaAy0UecUJttsHOJp35+CcpZvm9cM2WQ@mail.gmail.com>
Subject: LEON3 networking
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006ea5f70594f2d066"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12d
X-Mailman-Approved-At: Tue, 15 Oct 2019 11:04:09 -0400
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

--0000000000006ea5f70594f2d066
Content-Type: text/plain; charset="UTF-8"

Hello,

I've been using the LEON3 port of qemu, and am wondering if anyone has
touched the networking setup for such since the thread here:
https://lists.rtems.org/pipermail/users/2014-September/028224.html

Joshua Shaffer

-- 
Notice: This message is intended solely for use of the individual or entity 
to which it is addressed and may contain information that is proprietary, 
privileged, company confidential and/or exempt from disclosure under 
applicable law. If the reader is not the intended recipient or agent 
responsible for delivering the message to the intended recipient, you are 
hereby notified that any dissemination, distribution or copying of this 
communication is strictly prohibited. This communication may also contain 
data subject to the International Traffic in Arms Regulations or U.S. 
Export Administration Regulations and cannot be disseminated, distributed 
or copied to foreign nationals, residing in the U.S. or abroad, without the 
prior approval of the U.S. Department of State or appropriate export 
licensing authority. If you have received this communication in error, 
please notify the sender by reply e-mail or collect telephone call and 
delete or destroy all copies of this email message, any physical copies 
made of this e-mail message and/or any file attachment(s).

--0000000000006ea5f70594f2d066
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>I&#39;ve been using t=
he LEON3 port of qemu, and am wondering if anyone has touched the networkin=
g setup for such since the thread here: <a href=3D"https://lists.rtems.org/=
pipermail/users/2014-September/028224.html">https://lists.rtems.org/piperma=
il/users/2014-September/028224.html</a> <br></div><div><br></div><div>Joshu=
a Shaffer<br></div></div>

<br>
<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;background-=
color:rgb(255,255,255)">Notice: This message is intended solely for use of =
the individual or entity to which it is addressed and may contain informati=
on that is proprietary, privileged, company confidential and/or exempt from=
 disclosure under applicable law. If the reader is not the intended recipie=
nt or agent responsible for delivering the message to the intended recipien=
t, you are hereby notified that any dissemination, distribution or copying =
of this communication is strictly prohibited. This communication may also c=
ontain data subject to the International Traffic in Arms Regulations or U.S=
. Export Administration Regulations and cannot be disseminated, distributed=
 or copied to foreign nationals, residing in the U.S. or abroad, without th=
e prior approval of the U.S. Department of State or appropriate export lice=
nsing authority. If you have received this communication in error, please n=
otify the sender by reply e-mail or collect telephone call and delete or de=
stroy all copies of this email message, any physical copies made of this e-=
mail message and/or any file attachment(s).</span>
--0000000000006ea5f70594f2d066--

