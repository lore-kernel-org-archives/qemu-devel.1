Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4890BC282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF972171F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="f+oa7lrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF972171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33161 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHae9-00030t-Bv
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 17:02:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hHacY-00020F-FO
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hHacX-0002fY-MJ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:00:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:59883)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hHacX-0002eu-Ce
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1555707614;
	bh=eTH1PvFvm8bIVTMMgDNj8G3jPQ0P7SiNunJIbD2I0EE=;
	h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
	b=f+oa7lrZ4CkV2WXyfcvWanLs9oYALpdLQjVL1rKtjZ1TBtHGnYLBgxb4tnStjeZUp
	BFhpcikRsrAHCVBc8DZoFiXYRfiXmqLjdYawXucEf1iYtVcEI8YAWC8BlKaP7Ba/73
	Yi2RtxaFZ79OiWqNA8lRHh30CR/aDV1iuKVgFlVA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.96] ([90.214.132.136]) by mail.gmx.com (mrgmx001
	[212.227.17.184]) with ESMTPSA (Nemesis) id 0M8m7Q-1h7ezp3YiK-00C90a;
	Fri, 19 Apr 2019 23:00:14 +0200
From: Nick Hudson <nick.hudson@gmx.co.uk>
To: qemu-devel@nongnu.org
X-Mozilla-News-Host: news://news.gmane.org
Message-ID: <b148c658-09ed-15a5-02e6-42e1c544e847@gmx.co.uk>
Date: Fri, 19 Apr 2019 22:00:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SMvZq/qW+EtGDWccc+q8+MTSLPotkhvI1mk6G9hA7wXgQiJZ4Cq
	Io0gnqG1TWwsHcozYUd20yluwEyMFUWjkILt6gBN287KAf8dhdtHfaS1rrp6wiw+IfhqQRj
	dtIXcp5UnD7h2iVGZMCDqj3OG0nuNDiySBuHOWCBQlvshLe4nD3qa45ZRxgMJc55vvDBMlI
	sPdWyxRWwKdEVA3Ts4CvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qxPwaTDGsZ8=:8Tw7JEY4agbrQzhyICuHP4
	qv8Bn/dPiAKiScKRlftjRj/YE4D+5NaRJCSC9XL/Dv8nI1+vxYgVnvYiLJO1obDCCE60jKfM5
	y5bts81R+yMeNO0srbevn/gf7l7XX0t4Jr1YuQ+O+K+HL1VRj5Se++JGSs9MiwfogMw/J2iev
	D/xEc0jGqzO02vzG5Axc9/50LG/ITG7muGpca2LUv+12L9VgD9mPlUdEnftA9cZSAQE/SL1WB
	bWc3ZLfUL5U1kMiDi2atUiwg982YOVSQbqBrw+N/MbLaB3A9CTEamoqTNpCcNSAAZjRra3xsN
	YNYvMmBZ3cRHB6QoJGfvk7eo/r/PSIxtqqjgnyn96+hSFPKFH1lq6Q8MBMKyD51w6GC23ykae
	N2/s1uhZCmz3S9tmaRBHf+GdgDW4kimsmi9jja4J4MF8Fa+OfEb6TqQENjqU5A3V+plNfRQY4
	LuZoFHZogl3XmMXQA7qQbPx3KsMd2ADLBcd0h4V1gvJj4SyhIiO9K91XnSNxU6yqzCxWUxgIb
	siBjXyqS+P7BCtZax8oDz4yWfUIQItiL4SDWfH2eIoo2J2BUGw4H1IAmuL+AZSzFr/qZBA+4u
	JyjfuOmkvpKKzDhOVaLE0GEwFgoKxjPc+PraTbbnBhwaEK/Df3vu2HKuFtmZDHQyw/tIVBOOU
	WHXGIyGaYnXR85xjcsAEySPq322/4h0Tu34HLBp6uqG8ttNCaIVFkZySKmCfi2i4nRhzlFX14
	Q6t1fMwC96VUXOF3lteYy+C5aT/D9YkfwRXgn88U0M4wMKPbvgpylQdw786NqthC5zipUEZkf
	xOXOelNa8Smw16rpY34omy+NAMPGwvl8g83PU8AU0+PKrdOUDdLDQfAsrOrn6uq8eeCkqvo81
	j33Kx7DfF8dsdaLFySwBbggi33Y1herIL+/JGq5bz10wDm7fdCM3EhelqEByJaL9JbZtwwm3j
	fRzbK/OW4sA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.18
Subject: [Qemu-devel] [PATCH v1 0/2] HPPA fixes for NetBSD/hppa emulation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419210003.lnfc0QBp6wWl4LyJanQy7PC0gRdGUI0wo2LjJUA5D14@z>

Hi,

Here are the required changes to allow qemu to emulate NetBSD/hppa.

Nick Hudson (2):
   Implement the pcxl and pcxl2 Fast TLB Insert instructions as used by
     NetBSD (and OpenBSD)
   Always return EXCP_DMAR for protection id trap as EXCP_DMP is
     considered legacy.

  target/hppa/insns.decode |  3 +++
  target/hppa/mem_helper.c |  3 +--
  target/hppa/translate.c  | 54 ++++++++++++++++++++++++++++++++++++++++
  3 files changed, 58 insertions(+), 2 deletions(-)

=2D-
2.17.1




