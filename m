Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCEACA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 02:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1019208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 02:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX1WeQQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1019208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOvEo-00070B-Ug
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 22:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1iOvE5-0006CG-Su
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 22:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1iOvE4-0005hq-AF
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 22:57:49 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1iOvE4-0005h8-2S
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 22:57:48 -0400
Received: by mail-lj1-x244.google.com with SMTP id q78so9639916lje.5
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 19:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=zhYXlb7qG9qsgY2rR5GRQQ5cxTYzrGD+oeJZGMlj038=;
 b=KX1WeQQqZjRuKUZNcaOoAesL34Kg4knj/vPFA3O1N5PFGMM/iRZ4UFMXs30IicODkM
 i1i/MONEYBIIgkuZ6WoRq1TJFBeMRRVgzaz4q9HKHU1b1MQQ2Z9DCuQc6R2Du05lbO5r
 Xm2iYv67+gzvQ0y3r4X3WR23R1ehRox7FbEEgrPwj0vcxcEEdRI7ChPsBMaHi3zvh6NV
 aNhlXgByDTne+sGhQXcGNPcrRuSjYLq6fZvSOqHGETkd7cxjWMS3Sj//h7ZjLy/yCOrH
 FZ2/Mlq+++wI04g7qLG0DK6QK3b26JQnPjA/ASxj1xfRnzin+kSy1Vg5c4PedoD6F+Dz
 DBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=zhYXlb7qG9qsgY2rR5GRQQ5cxTYzrGD+oeJZGMlj038=;
 b=RZ3DGtMq1YioJFhubnKjT8C2bgofC8WJiQxk6Sf9ytdLtnxzkx/7fS2p/TXU5293qG
 ZmLxrrwvtDAJp9FWQ/0Yv1TJ/Xj4E0oNuI0huGLYzO/Jvq03IAKhtNxj1JoMKP5aalI5
 v9QZ/NZmkEGf/DBSmPawhfzQDo3rawY7FonBN0k0KDjZln6cL0uPMAp42Rv4TeYLL/2o
 noYdonM/BCXbf2+WvkK7sip3LZ8vyEa3+vWYua4HuwgMx43fHhecng/zrTz73BQG4uvo
 +ZY8jz7mJbvawBHk+HQs9vA5MCXGbrFsDVnwEH1JKvvglf0PRdkBexWLaZxteBJB3rfr
 WN7w==
X-Gm-Message-State: APjAAAWoilzS8iz/JwVlROtQ3CIEfGB9PjDHelWEHARTqj80PYubsUHY
 9KXsfGlsGwNdeLAwU6kBzIVP5PaN5Y/gKsFb/G69HOhWNa7CxQ==
X-Google-Smtp-Source: APXvYqzX/g5MWufU8zU4KOK9GdUN+mj0rfFBxMMz1MBpJqgXFlgapxwJzEEXp+TSJ6QWeE6fXe0xrHJO+mAePIpeNSU=
X-Received: by 2002:a05:651c:120c:: with SMTP id
 i12mr1840574lja.123.1572231465440; 
 Sun, 27 Oct 2019 19:57:45 -0700 (PDT)
MIME-Version: 1.0
From: Coiby Xu <coiby.xu@gmail.com>
Date: Mon, 28 Oct 2019 10:57:09 +0800
Message-ID: <CAJAkqrUo+8qJGAMprEY2ZxqL-3meHo-56PYc_M1oxXNy5SVvow@mail.gmail.com>
Subject: Failure of troublesome vhost-user/flags-mismatch test can't be
 reproduced
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000009d590595efaa5f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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

--000000000000009d590595efaa5f
Content-Type: text/plain; charset="UTF-8"

Hi,

Can anyone reproduce the failure of one troublesome test
vhost-user/flags-mismatch (https://wiki.qemu.org/Testing/CI/TroublesomeTests)
which has been disabled since Aug 15 2017 (
https://patchwork.kernel.org/patch/9939431/)?  Last month I downloaded QEMU
source code (commit ID: 3483534ec3) and this version also failed this test.
After debugging this issue, I thought I have fixed this issue by saving
acknowledged features after vhost backend disconnect with the client
(qemu). But later I reviewed the commit history of net/vhost-user.c and
found out this test failed on my machines because of  a newly introduced
bug from a recent commit (https://patchwork.kernel.org/patch/11054781/) on
July 29 2019 and this new bug has already been fixed by a more recent
commit (
https://lists.sr.ht/~philmd/qemu/%3C20190924162044.11414-1-amorenoz%40redhat.com%3E).
After more investigation, it surprised me both 3.1.0 and 2.9.1could pass
vhost-user/flags-mismatch test. According to the comments on the commit
https://patchwork.kernel.org/patch/9939431/ which disabled the
vhost-user/flags-mismatch and other two tests, it seems the tests are only
broken on travis. Maybe we should re-investigate this issue to re-enable
the test so similar bugs like
https://bugzilla.redhat.com/show_bug.cgi?id=1738768 could be prevented in
the first place.

Btw we can excluisvely check this test on latest QEMU by given TESTPATH and
setting QTEST_VHOST_USER_FIXME environment variable,
    QTEST_VHOST_USER_FIXME=1
QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img
tests/qos-test -p
/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/flags-mismatch


-- 
*Best regards,*
*Coiby*

--000000000000009d590595efaa5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br>Can anyone reproduce the failure of one tr=
oublesome test vhost-user/flags-mismatch (<a href=3D"https://wiki.qemu.org/=
Testing/CI/TroublesomeTests" target=3D"_blank">https://wiki.qemu.org/Testin=
g/CI/TroublesomeTests</a>) which has been disabled since Aug 15 2017 (<a hr=
ef=3D"https://patchwork.kernel.org/patch/9939431/" target=3D"_blank">https:=
//patchwork.kernel.org/patch/9939431/</a>)?=C2=A0 Last month I downloaded Q=
EMU source code (commit ID: 3483534ec3) and this version also failed this t=
est. After debugging this issue, I thought I have fixed this issue by savin=
g acknowledged features after vhost backend disconnect with the client (qem=
u). But later I reviewed the commit history of net/vhost-user.c and found o=
ut this test failed on my machines because of =C2=A0a newly introduced bug =
from a recent commit (<a href=3D"https://patchwork.kernel.org/patch/1105478=
1/" target=3D"_blank">https://patchwork.kernel.org/patch/11054781/</a>) on =
July 29 2019 and this new bug has already been fixed by a more recent commi=
t (<a href=3D"https://lists.sr.ht/~philmd/qemu/%3C20190924162044.11414-1-am=
orenoz%40redhat.com%3E" target=3D"_blank">https://lists.sr.ht/~philmd/qemu/=
%3C20190924162044.11414-1-amorenoz%40redhat.com%3E</a>). After more investi=
gation, it surprised me both 3.1.0 and 2.9.1could pass vhost-user/flags-mis=
match test. According to the comments on the commit <a href=3D"https://patc=
hwork.kernel.org/patch/9939431/" target=3D"_blank">https://patchwork.kernel=
.org/patch/9939431/</a> which disabled the vhost-user/flags-mismatch and ot=
her two tests, it seems the tests are only broken on travis. Maybe we shoul=
d re-investigate this issue to re-enable the test so similar bugs like <a h=
ref=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1738768">https://bugzi=
lla.redhat.com/show_bug.cgi?id=3D1738768</a>=C2=A0could be prevented in the=
 first place.=C2=A0</div><div><br></div><div>Btw we can excluisvely check t=
his test on latest QEMU by given TESTPATH and setting=C2=A0QTEST_VHOST_USER=
_FIXME environment variable,</div><div>=C2=A0 =C2=A0 QTEST_VHOST_USER_FIXME=
=3D1 QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=
=3Dqemu-img tests/qos-test -p /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/=
virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/flags-mismatch<br></d=
iv><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><i>Best re=
gards,</i></div><font color=3D"#00cccc"><i>Coiby</i></font><div><font color=
=3D"#00cccc"><br></font></div></div></div></div></div></div>

--000000000000009d590595efaa5f--

