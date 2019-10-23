Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0F7CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 541E921925
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=astrobotic-com.20150623.gappssmtp.com header.i=@astrobotic-com.20150623.gappssmtp.com header.b="MxAStarE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541E921925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=astrobotic.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNK4g-0002vT-SP
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 13:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joshua.shaffer@astrobotic.com>) id 1iNJza-0007NA-KZ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joshua.shaffer@astrobotic.com>) id 1iNJzZ-0006wL-9V
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:00:14 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joshua.shaffer@astrobotic.com>)
 id 1iNJzY-0006s9-Ch
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:00:12 -0400
Received: by mail-lf1-x142.google.com with SMTP id i15so9240997lfo.7
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=astrobotic-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=r8sfDS5dTki4Hmb9E3zat+NOVe6WUF2vcvXnCBQBCPI=;
 b=MxAStarEp8HHKrn0gqL+zI73shASPV7vgkrcU3LrmmlKKRfYOwpn75fCgtAek3wSCz
 jgQhCftgWcE7tNu6elKMNzjrkdvbiWIMqvI9v2MPcUtmb4IgplPcggsdWN+CK2HIl/zN
 pa8Mqo+kYgmOxCvb8BigyinSgUPwywVPmRlHSolMBO2OQBrUOlmlwN/s2wIFFSn7ensm
 G1uofQcfhOg5EdwKxKDIKxocma6hvb2ATzslUOpECCmDUUpOsqcaSzOOrMRcbA1Dd19G
 Sgi1hhaQ83BijCl6indOA8mmey5klig7vxsIP/sYkodVHc3XWQpvhaFYxXT4mtamC5QC
 /jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=r8sfDS5dTki4Hmb9E3zat+NOVe6WUF2vcvXnCBQBCPI=;
 b=g0dglBKfekZjWpMjcNFL+9OxbwNzufCTGIQG4ywrnffkVPC3lJY36gbueqwv4yCyAS
 xI0NT+XMgbCSl78kOmB81yY9uPuoLpvFe7cvCvqYxiZtXxD2AfqagcxNlLgmONpDpxdd
 PNr9qUdRF5FniiBvx9A0pGvXXqO4r8f3WGG54IApAjKHiebeMnrQOzK3Zo+DGwRcQy8w
 T0fNPVoC/3sJsFl/WvM6uBLFKRgdepJWap6YV7Rn9s7RteBqm/xHoANypxKw6VwiUeEV
 rPAZAhigsi5Ve2y5K0UGiJGtGZ+mhPwcTgvMzrqztj0zA4m7Py6l8WZLas2VrZMCoBTn
 FAMw==
X-Gm-Message-State: APjAAAWcUv+unasdWtBaYNQ9C14A0vLR93cWYPAgjhQcDrsI+iocY7GC
 bOr0Ai4psB6HXVmts/UmiijjR1gL+DYXQp4eFqVxf+s0kdeE3ZxEVHXE1owLdqtp0mgpCP5BNVc
 EQS3OUNVi4aY2bXK6hrus2g==
X-Google-Smtp-Source: APXvYqz4qLPVPSWN85wAYtsb1SYfGwckDAv416QmG6LOQiogR6HhQnv1ZQxjiwV/N+S/dcTPiracs0PVegINNq/S0Iw=
X-Received: by 2002:ac2:414f:: with SMTP id c15mr14178835lfi.157.1571850009732; 
 Wed, 23 Oct 2019 10:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJW7GKLH3pkrGQQj_OaAy0UecUJttsHOJp35+CcpZvm9cM2WQ@mail.gmail.com>
 <6bb8abb2-68f0-db85-1557-6e04839b5ea2@redhat.com>
 <32c38984-e745-de6c-792e-09910b68cedd@adacore.com>
In-Reply-To: <32c38984-e745-de6c-792e-09910b68cedd@adacore.com>
From: Joshua Shaffer <joshua.shaffer@astrobotic.com>
Date: Wed, 23 Oct 2019 12:59:58 -0400
Message-ID: <CAPJW7GLOTyjdMozrb+TSnqpEyoiFh2sxZjYkLXx2pz2_J_dPgA@mail.gmail.com>
Subject: Re: LEON3 networking
To: Fabien Chouteau <chouteau@adacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Jiri Gaisler <jiri@gaisler.se>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Does anyone know what needs implemented to get networking supported?

Joshua

On Wed, Oct 16, 2019 at 6:34 AM Fabien Chouteau <chouteau@adacore.com> wrot=
e:
>
> Hello people,
>
> On 15/10/2019 18:57, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Joshua,
> >
> > On 10/15/19 3:17 PM, Joshua Shaffer wrote:
> >> Hello,
> >>
> >> I've been using the LEON3 port of qemu, and am wondering if anyone has=
 touched the networking setup for such since the thread here: https://lists=
.rtems.org/pipermail/users/2014-September/028224.html
> >
> > Thanks for sharing this!
> >
> > Good news, Jiri keeps rebasing his patch with the latest stable version=
.
> > Bad news, he didn't not signed his work with a "Signed-off-by" tag so w=
e can not take this as it into the mainstream repository, see https://wiki.=
qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:=
_line
> >
>
> The Gaisler patches have been rewrote by my colleague Frederic (in CC) an=
d they are now in mainstream.
> (see https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03869.html)
>
> But none of them are implementing network support, and I never heard of s=
omeone working on network for leon3.
>
> Regards,
>

--=20
Notice: This message is intended solely for use of the individual or entity=
=20
to which it is addressed and may contain information that is proprietary,=
=20
privileged, company confidential and/or exempt from disclosure under=20
applicable law. If the reader is not the intended recipient or agent=20
responsible for delivering the message to the intended recipient, you are=
=20
hereby notified that any dissemination, distribution or copying of this=20
communication is strictly prohibited. This communication may also contain=
=20
data subject to the International Traffic in Arms Regulations or U.S.=20
Export Administration Regulations and cannot be disseminated, distributed=
=20
or copied to foreign nationals, residing in the U.S. or abroad, without the=
=20
prior approval of the U.S. Department of State or appropriate export=20
licensing authority. If you have received this communication in error,=20
please notify the sender by reply e-mail or collect telephone call and=20
delete or destroy all copies of this email message, any physical copies=20
made of this e-mail message and/or any file attachment(s).

