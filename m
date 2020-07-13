Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AC4C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4C320738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CXirj6K5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4C320738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxYe-0000Hp-M0
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pjp@fedoraproject.org>)
 id 1juxVd-0005XU-0r
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:24:37 -0400
Received: from sonic314-19.consmr.mail.sg3.yahoo.com ([106.10.240.143]:45338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pjp@fedoraproject.org>)
 id 1juxVa-0008G6-8q
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1594643068; bh=tCyTpzJY5wpigREwleW4FSWebPzB536QcSSfxWE8UBA=;
 h=Date:From:Reply-To:To:In-Reply-To:References:Subject:From:Subject;
 b=CXirj6K5KlSjTBSEgaAdrutz6GxdXgUxyWjHviF5KVDcbIuZEqY1PkjDE2NnalMy+QfOliejNhE7+/ZJHo0tJffn8RKI82Rf21rb9/AdxqCr0SEN+4EgQRzYbeV/tn8eB3x9NHETv4p0876CNWjOKahrHclPpya7zqZVc669Es+5CR1WCNl/+E0H7ykU9TlRA+LXKj2EyW/FBYpNfMmZ1iT6aWvw6qzBihclz9KP9EehCdzAM8+VlqktRFQvIMGfzZH2Nt3k0LvRurq+6dgylDLLxBO5xF42g5b615S7F5/cgnbFl7g84iKNP1iTkjEcgC+DoJ0jdEbyhag0apW2UA==
X-YMail-OSG: V3EgCnEVM1lwhaCgL27hTbym9vfruSh6oD.focYbmVNjHWz8xhKKq1G37B4bJFp
 2VEib9vWNkN8QUtOIjeJO_y.EXuI7fb2AGmbYeTWauk2SbIMRQ6HdFbo_xe9Ru.Vmbz63o9ju9q9
 0_2bhNjyEgdIHfvOLZmkP1d7HBlBafBs3WMWSQzp4uxkaiXd7XW8QO7noLLJ.Fyoum.PYbPwnQ7E
 QhteUXDGrJMMbCbp5_PA5JOoi0CU8kwgOpOKvIqqhVFB830CfrGuX2uAzRnF2XeghChUHYOhtWtP
 eH4C3GU9Mf9O23UNwVNz5rEvEi_prNptcRRYUtlLMrQxQRp_SjiBSXkEL3_pzIKkZyzKI0yCWubC
 909li22d1hwL8g0t72RBTofbgbPrDPtQYqw5ZpER.lq9yEm5f.ebqqN_nrwGNPArxv2eQr7RMdbx
 OoRvqnHmz2h22.ghZ1jYiBmtrz6KSjiRpy_cppIiX3Fkr3AXueY.GHg4lF6UoF7mJddBFP44K8cL
 ijDt8T8EYbJJ6ehLDcVQzgKUMrDgoYygxjfuYOCtmZ66.Zf4K3psdCgQwpwcRa8CsnnN3GXh3uD6
 OwdvYjWq4UX00zhFv_IpgkcIpObKAbslSXvXoyPcqS92BZv7aN.Ya0zXqRTW4iXt8mfT6O.yzWW7
 dL.CpqNwxaRLop8qrscKiVW6mASDpgpOBAaWBFfF4DX_oCIDbA4xmVBDnSSXJpBV9mCeW7mmDlWg
 KCVSdg0Nwp_86g0g9mXHS.J8BLejC_Y4HLyHedCnM6kdppkl59TRvosxZqezpm3MdeZRDW8lCX1c
 GcQacGY8nmugnBRAl4YyO9mGHcFXp_HbqpN9Afy5IErq_no6BvlvafGETwciQ_q9Cw3tPNdy9yJc
 S__MvP_z3NVQvPdQ9NjPVB4RVcm5XYQ14nWrKfJVUuQqdEzqZT2KM5vOyM6PPIjk9cuD7CF38l0e
 C1u3rqlFrZn02geGyo3Pv03QYRS9RGVI7lSQ3L06mgnH2sxfgAUG9gdy6TAu3stijsLYOMaK3KDc
 nsxo6wugRsxPfC67bpmnjDq6aeP13lKn5AEY7eL79EIwpuWQkDHktmRhvEuCTyv9d25Bb.muRE4l
 09c9kXEKbS1caTCdXBHWVIEkIVAu9EM3p4fIMRdcIo6po89T6Sj1yJ26FJkc7920Dz6jOT0V16cb
 BgcF_cy1_9ifosh3sfeGqiZIzzdvYy31gQNs_dqCzL0OrxuMT4CGt7izdXpR4vO5usO_0XXYyRqE
 2csgKwM6uAr1tdD98sBZT7VUSIN5ZRSo6.0CXI8DdyVMP_rd7Tmxeer_g9xuhPWjCU7_cMZ1ykwz
 RI8zJEbjWTfiASckVsPKzEX8g9Q6yEQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.sg3.yahoo.com with HTTP; Mon, 13 Jul 2020 12:24:28 +0000
Date: Mon, 13 Jul 2020 12:24:12 +0000 (UTC)
From: P J P <pjp@fedoraproject.org>
To: =?UTF-8?B?5p6X5aWV5biG?= <19210240159@fudan.edu.cn>, 
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <mdroth@linux.vnet.ibm.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <1836306741.887225.1594643052123@mail.yahoo.com>
In-Reply-To: <6160dba5-fd15-2467-fe53-14c391b2ce30@redhat.com>
References: <42a0ee9.78e1.1733dd8c113.Coremail.19210240159@fudan.edu.cn>
 <6160dba5-fd15-2467-fe53-14c391b2ce30@redhat.com>
Subject: Re: cve patch wanted
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.16271 YMailNorrin Mozilla/5.0 (X11; Fedora;
 Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko)
 Chrome/73.0.3683.86 Safari/537.36
Received-SPF: permerror client-ip=106.10.240.143;
 envelope-from=pjp@fedoraproject.org;
 helo=sonic314-19.consmr.mail.sg3.yahoo.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 08:24:29
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FORGED_REPLYTO=2.095, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Reply-To: P J P <pj.pandit@yahoo.co.in>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello all,

Thank you Philippe for looping me in.

On Monday, 13 July, 2020, 1:46:45 pm IST, Philippe Mathieu-Daud=C3=A9 <phil=
md@redhat.com> wrote:=C2=A0
7/11/20 2:28 PM, =E6=9E=97=E5=A5=95=E5=B8=86 wrote:
> =C2=A0 =C2=A0I am a student from Fudan University in China. I am doing re=
search on
> CVE patch recently. But i can not find the PATCH COMMIT of
> CVE-2019-12247 cve-2019-12155 cve-2019-6778.Can you give me the commit
> fix this cve?

CVE-2019-12155 QEMU: qxl: null pointer dereference while releasing spice re=
sources
=C2=A0 ->=C2=A0https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Dd52680fc93=
2efb8a2f334cc6993e705ed1e31e99
=C2=A0 ->=C2=A0https://www.openwall.com/lists/oss-security/2019/05/22/1


CVE-2019-6778 QEMU: slirp: heap buffer overflow in tcp_emu()
=C2=A0 ->=C2=A0https://www.openwall.com/lists/oss-security/2019/01/24/5
=C2=A0 ->=C2=A0https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg031=
32.html

This slirp patch is merged upstream. IIRC, after its merger SLiRP code move=
d into a new repository
will have to dig through git logs/history to find patch link/URL.


CVE-2019-12247 QEMU: qemu-guest-agent: integer overflow while running guest=
-exec command
=C2=A0 ->=C2=A0https://www.openwall.com/lists/oss-security/2019/05/22/4
=C2=A0 ->=C2=A0https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg045=
96.html


@Michael: Looks like 'CVE-2019-12247' patch above was not merged...? Any id=
ea?

Thank you.
---
=C2=A0 -P J P

