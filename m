Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15940C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22EE2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22EE2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6D7A-0003BI-VQ
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 07:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1j6D6U-0002V7-ES
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1j6D6T-0005fM-2v
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:44:54 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:55739 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Aleksandar.Markovic@rt-rk.com>)
 id 1j6D6S-0005dw-Rw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:44:53 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 2E86B1A1D98;
 Mon, 24 Feb 2020 13:44:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: by mail.rt-rk.com (Postfix, from userid 492)
 id 2CFE71A1E5B; Mon, 24 Feb 2020 13:44:45 +0100 (CET)
in-reply-to: <CAP+75-UByGQ88k9eTJsB0SM9i-CxTeP33=xWvC11E=AGRV3TDw@mail.gmail.com>
to: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
from: "Aleksandar Markovic" <Aleksandar.Markovic@rt-rk.com>
message-id: <4173-5e53c500-1-4bb99580@45567176>
subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH=5D?==?utf-8?q?_MAINTAINERS=3A?= 
 Reactivate MIPS KVM CPUs
X-Forward: 127.0.0.1
date: Mon, 24 Feb 2020 13:44:45 +0100
MIME-Version: 1.0
content-type: multipart/alternative;
 boundary="----=_=-_OpenGroupware_org_NGMime-16755-1582548285.140905-0------"
User-Agent: SOGoMail 2.3.10
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: James Hogan <jhogan@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------=_=-_OpenGroupware_org_NGMime-16755-1582548285.140905-0------
content-type: text/plain; charset=utf-8
content-length: 991
content-transfer-encoding: quoted-printable


> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> > >> diff --git a/MAINTAINERS b/MAINTAINERS
> > >> index b0728c8..9cc55d5 100644
> > >> --- a/MAINTAINERS
> > >> +++ b/MAINTAINERS
> > >> @@ -365,8 +365,8 @@ S: Maintained
> > >>=C2=A0=C2=A0 F: target/arm/kvm.c
> > >>
> > >>=C2=A0=C2=A0 MIPS KVM CPUs
> > >> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>
> BTW are you sure you want to remove Aleksandar Rikalo as reviewer?
> (There is no description about this change.)

Aleksandar Rikalo is an experienced engineer very familiar
with QEMU, and he is helping reviewing many other areas of
QEMU for MIPS - however, his main day-to-day duties currently
involve projects other than QEMU, and he is not sure if he will
manage to get enough time to devote to KVM/MIPS. I talked to
him too about the whole situation. If the current situation
changes (he gets more time), and he wishes to participate,
he will be welcomed, and we can add him easily.

Thank you,
Aleksandar

=C2=A0

------=_=-_OpenGroupware_org_NGMime-16755-1582548285.140905-0------
content-type: text/html; charset=utf-8
content-length: 1318
content-transfer-encoding: quoted-printable

<html>&gt; Philippe Mathieu-Daud&eacute; &lt;philmd@redhat.com&gt; wrot=
e:<br />&gt; &gt; &gt;&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br />=
&gt; &gt; &gt;&gt; index b0728c8..9cc55d5 100644<br />&gt; &gt; &gt;&gt=
; --- a/MAINTAINERS<br />&gt; &gt; &gt;&gt; +++ b/MAINTAINERS<br />&gt;=
 &gt; &gt;&gt; @@ -365,8 +365,8 @@ S: Maintained<br />&gt; &gt; &gt;&gt=
;&nbsp;&nbsp; F: target/arm/kvm.c<br />&gt; &gt; &gt;&gt;<br />&gt; &gt=
; &gt;&gt;&nbsp;&nbsp; MIPS KVM CPUs<br />&gt; &gt; &gt;&gt; -R: Aleksa=
ndar Rikalo &lt;aleksandar.rikalo@rt-rk.com&gt;<br />&gt;<br />&gt; BTW=
 are you sure you want to remove Aleksandar Rikalo as reviewer?<br />&g=
t; (There is no description about this change.)<br /><br />Aleksandar R=
ikalo is an experienced engineer very familiar<br />with QEMU, and he i=
s helping reviewing many other areas of<br />QEMU for MIPS - however, h=
is main day-to-day duties currently<br />involve projects other than QE=
MU, and he is not sure if he will<br />manage to get enough time to dev=
ote to KVM/MIPS. I talked to<br />him too about the whole situation. If=
 the current situation<br />changes (he gets more time), and he wishes =
to participate,<br />he will be welcomed, and we can add him easily.<br=
 /><br />Thank you,<br />Aleksandar<br /><br />&nbsp;</html>

------=_=-_OpenGroupware_org_NGMime-16755-1582548285.140905-0--------


