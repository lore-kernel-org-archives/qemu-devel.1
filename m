Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974D3C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 22:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B5B206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 22:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B5B206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i21Pf-00078k-IE
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 18:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1i21Ok-0006Ur-K6
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 18:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1i21Oj-00063z-Ns
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 18:54:10 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:54378)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1i21Oj-0005xX-HM; Sun, 25 Aug 2019 18:54:09 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 050A510B3E;
 Mon, 26 Aug 2019 00:54:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bJ07yFv_4WSL; Mon, 26 Aug 2019 00:54:05 +0200 (CEST)
Received: from function.home (unknown
 [IPv6:2a01:cb19:979:800:9eb6:d0ff:fe88:c3c7])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 17CB710B3A;
 Mon, 26 Aug 2019 00:54:05 +0200 (CEST)
Received: from samy by function.home with local (Exim 4.92.1)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1i21Od-00068Y-Lt; Mon, 26 Aug 2019 00:54:03 +0200
Date: Mon, 26 Aug 2019 00:54:03 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190825225403.vwg2fhfff6i7gnwd@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@gnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 slirp@lists.freedesktop.org, Petr Matousek <pmatouse@redhat.com>,
 Vishnu Dev TJ <vishnudevtj@gmail.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Prasad J Pandit <ppandit@redhat.com>
References: <20190822144134.23521-1-philmd@redhat.com>
 <20190822144134.23521-2-philmd@redhat.com>
 <20190822183313.pptfwjsnrpdi6tfp@function>
 <14216968-a066-6abf-1952-3cff3aa3eee3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="aemxj2oy7a3cf7hq"
Content-Disposition: inline
In-Reply-To: <14216968-a066-6abf-1952-3cff3aa3eee3@redhat.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a0c:e300::1
Subject: Re: [Qemu-devel] [Slirp] [PATCH 1/2] Do not reassemble fragments
 pointing outside of the original payload
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
Cc: slirp@lists.freedesktop.org, Petr Matousek <pmatouse@redhat.com>,
 qemu-devel@nongnu.org, Vishnu Dev TJ <vishnudevtj@gmail.com>,
 qemu-stable@nongnu.org, Prasad J Pandit <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--aemxj2oy7a3cf7hq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Philippe Mathieu-Daud=C3=A9, le ven. 23 ao=C3=BBt 2019 17:15:32 +0200, a =
ecrit:
> > Did you make your test with commit 126c04acbabd ("Fix heap overflow i=
n
> > ip_reass on big packet input") applied?
>=20
> Yes, unfortunately it doesn't fix the issue.

Ok.

Could you try the attached patch?  There was a use-after-free.  Without
it, I can indeed crash qemu with the given exploit.  With it I don't
seem to be able to crash it (trying in a loop for several minutes).

Samuel

--aemxj2oy7a3cf7hq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/src/ip_input.c b/src/ip_input.c
index 7364ce0..aa514ae 100644
--- a/src/ip_input.c
+++ b/src/ip_input.c
@@ -292,6 +292,7 @@ static struct ip *ip_reass(Slirp *slirp, struct ip *ip, struct ipq *fp)
      */
     while (q != (struct ipasfrag *)&fp->frag_link &&
            ip->ip_off + ip->ip_len > q->ipf_off) {
+        struct ipasfrag *prev;
         i = (ip->ip_off + ip->ip_len) - q->ipf_off;
         if (i < q->ipf_len) {
             q->ipf_len -= i;
@@ -299,9 +300,10 @@ static struct ip *ip_reass(Slirp *slirp, struct ip *ip, struct ipq *fp)
             m_adj(dtom(slirp, q), i);
             break;
         }
+        prev = q;
         q = q->ipf_next;
-        m_free(dtom(slirp, q->ipf_prev));
-        ip_deq(q->ipf_prev);
+        ip_deq(prev);
+        m_free(dtom(slirp, prev));
     }
 
 insert:

--aemxj2oy7a3cf7hq--

