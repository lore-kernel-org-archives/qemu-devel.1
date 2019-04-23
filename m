Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B6EC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 06:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDCE920674
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 06:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dkXSpElB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCE920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48977 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIp3r-0004Gh-1S
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 02:37:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIp2h-0003hY-Qt
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIp2g-000736-W6
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:36:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:47507)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hIp2e-00071C-VU
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1556001387;
	bh=QWjXhxiiAgYTFjFpWMIVaI32Qw7zqC+nYTrXcqgPB9Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=dkXSpElBbJj4RSs2k4pgCas5AzLJFn+iO1z6emzOAIH74g7/cQ9e5Oi3pK1+Lm61z
	0N53w+3LGXlCbLlOChmDFkeLBsEfX1/skE8Szb7RDrl/TPQeKLcm0UflFLdVR1jLD6
	SmtyxrNBGv9LRNgNR6vlOPrAcejretH7+lWg6E54=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from zoom.local ([2.122.11.66]) by mail.gmx.com (mrgmx102
	[212.227.17.174]) with ESMTPSA (Nemesis) id 0MXEs5-1hMQ3S0Hg5-00WDNw;
	Tue, 23 Apr 2019 08:36:27 +0200
Received: by zoom.local (Postfix, from userid 1000)
	id C48009C5571; Tue, 23 Apr 2019 07:36:23 +0100 (BST)
From: Nick Hudson <nick.hudson@gmx.co.uk>
To: Richard Henderson <rth@twiddle.net>
Date: Tue, 23 Apr 2019 07:36:19 +0100
Message-Id: <20190423063621.8203-1-nick.hudson@gmx.co.uk>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:Q2XnrQfIu8mmxSPtA9fFz3oqwduqe97WAAfs0rvNtyDzyBqzXwh
	3K7HCUDBUAdan4v+P2hE0afyIXG+y9NGV1hwBr/q5FtVKTGASCwXd6JCecmk/yhw+RVp8UH
	2cfJ2SJ7wHl+MimnhtEaLpo1QyzBDNSlriDhL9LIo1ug3sJmODYJHVnLIVulLzGbCSHURsC
	Kf/X5oMbZ5PrMIZE2g/pQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tSAc5fERP1M=:LJKgGQCRnCidIcYSLFbIWG
	aPLyKNVsCvMmA4QOY0FSGos7xIf10e2seuwV54Wk4MBWJIvel4VhOghXId/eo+tkLSXlqwSYr
	9a5MxeyoTApDh3uEyoA8N1xVIf1NZ0dzH3vcTn4OwaJy/F079QC/BzhFHcv93d6Gt0groMMKr
	04IlICM+2PXSIwzRLH8BAgdqC/nzv4KWuFfJPldu2SgIM2xogQiLwglmK2wVQ6s/feT1SuWmX
	KDSI86BVWSzlN6pRKmppXPeuJlJVp/+mwky3eb1ich1kX00tzLv4/ZmbDAdS1nZBVQjIoQZTJ
	2Qtn99mjMutRolkkgrBlAZ0TkTiGSmCDOeS79uaYhJyMnULm0O+6bsyWpOTsvSGRqJRMWmFwn
	uE2DLPD7atKPlnOsv03BBhLaE4XEC2Rfob8fLuXguyajCnkXJmtt2vZQ0mzhEzGyswjFix6Yl
	LwrWfDexf8qrSd2Fu66S/qMylYB50ek1CAbo4Bmbxhz+Q8Vi3BvJJIX896eGqlSCAh41mL54h
	pO8CKvj++G0Gs7OJacKAQvpqBccOW1VakveOJBk1hUqJQwB1BD6Gss7cr5rhJV5oNfk5YiU2h
	fwuWIXzX0jpCPGBkyynDOqnJf2sYI/wyS7mNhhTThLoc/GhRK5B3uYudERwXRCUqVsWJbI7Mr
	ErkKoiSfzA7y789ePfd2PgSOEJQUvkhFOzOLOaScKlWhufFh8VK0TwXJv5/eNVIxxHnAa5mmS
	pz23JwyDrGJjQyYyMvNttlUridbT0LDJp+dUNWXfZWLrx2g0UIp+zLLgFsWurI1HOOurVuF9h
	UemDENtT+df/tBz94lM5g/PWfLUYwaVMqC8F3gRnEiI+zGU0yHKZU89kC/0LY3clJ/rEKYsaJ
	Tn6rZaqXT5KGwHF9zC6pxz5c7IeH7UHeRTriXzn5FV8ysXbaW8NRoaIJVD+62/
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.20
Subject: [Qemu-devel] [PATCH v3 0/2] HPPA fixes for NetBSD/hppa emulation
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
Cc: Kamil Rytarowski <kamil@netbsd.org>, Nick Hudson <nick.hudson@gmx.co.uk>,
	"open list:NETBSD" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423063619._KoApfbmIv8I2_6jdtieOmBc_TBxxPudjI8bn-qgtow@z>

v3 changes:
 - Don't use C99 comments and fix a typo in the comment

v2 changes:
 - remove old debug code

*** BLURB HERE ***

Nick Hudson (2):
  Implement the pcxl and pcxl2 Fast TLB Insert instructions as used by
    NetBSD (and OpenBSD)
  Always return EXCP_DMAR for protection id trap as EXCP_DMP is
    considered legacy.

 target/hppa/insns.decode |  3 +++
 target/hppa/mem_helper.c |  3 +--
 target/hppa/translate.c  | 52 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

=2D-
2.17.1


