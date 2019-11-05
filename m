Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94F2C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0D621882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0D621882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3F3-00044d-O4
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS3E5-0003KP-SP
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS3E4-0002VE-Su
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:06:45 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:55113)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS3E4-0002UU-JE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:06:44 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N9L64-1hpRDw2mPs-015EsJ; Tue, 05 Nov 2019 19:06:40 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Q800 branch patches
Date: Tue,  5 Nov 2019 19:06:36 +0100
Message-Id: <20191105180637.26020-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7sqW3NU9iPbAvFrquiubPxlo+unqlh9nak+BptA9Ot5J+VHRoO9
 B9Pmwis6LZV7GaoxQCsqDRfh5DQq/1boJ2n0CeX56nJvg2lEPKUtDLcT9pETZYYIylz/vd7
 omwhKywgdsmgwiHQrEnwiWpjN3i9/qnri5Fk5RwieZm3BKddOFPkj8wgG9HCgIBV2RZS92e
 NrMLGcu06BlORZX9kU3Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2pWEQ77Pdcs=:UPoCeDy6BzxSZ9Im1AlftA
 ZnXNGnKpWXLpApw3Vi+n4BhuQtMeiqFJoJ3i3YJ8by3r6HuKgdz4TzpEw+6FlNLnYAed/9y+Y
 o/irfu9WDpIpYwuOmIW0Vb80jTHTOjiRNlF7XIJzyujynOD5vrvazoqOr9tZPrqHOjU0VaSnN
 E3Mn261J1RlG+VJwqqoImapGAfVt5AFSXTKWjCoJ9qlh7hbxrABnpMbEUOPbBL2tcnmOD7Vxd
 Xx+mXzz4a0OXagNtyyrmdj8HCpopXENdDp3W+LnobIvdiGS0rGwCzMSoasSWqg57DQk66+pm8
 s6QDPcsG33ANOvFzn6wVD6N5XncUPAc81qCs0/htyxCEGRy/jjy0SaDxeGjB/5rIOJTaalldO
 KJ2cuBS6psAK0jrmefKL4FLEK+9bmtSSzCCZ7eoCImd84pduYAwwHDJV9ZFQRoZIHWAMP5yUK
 5QMY3M0jApDkQQM0fc/Li8thYBlOU+iJesvuI+SYsKPMxONMdQ30fNAWD01U/9pe1jmZil9qH
 BLN1ScrqHMV3SpNTbVReMFXauvbkWLgBoZzQJESCYKztvbw43gzHM0oV5W8T5fk8zYBOBVI7G
 Owpto969k6qN17ZBSsqBMU3HwPLW5mkQU7VxJt1imW8ICh7qqG3i4camnwHhAJzRmQJClKUrf
 nFg4tHDbmmMnXtn5h+Y21GmbStq14QtElJFnCeOggyNnfPeFJvTG2ZMzJwYwRCdRQCd0tyDPE
 dFhfqeyE9/fp0lKS2d3j5kQPioxiqPBorI7XwkMPIASr9kgsubN5lBlLzET1oNsPntleZst0l
 QOB1akObisylD2f+M3JGB7B/doI9GDirq1ELY13dQn4lZVZ9xWelWs6zpql3qNHWaLbmB7D8g
 nnDH45LTwnR8UHO7Y4XInzY4v6js6azwrX+X8z4U4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b7c9a7f353c0e260519bf735ff0d4aa01e72784b:

  Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2019-10-31 15:57:30 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/q800-branch-pull-request

for you to fetch changes up to 653901ca2be30299a224677a8203ff3361dbd5c5:

  q800: fix I/O memory map (2019-11-05 18:52:29 +0100)

----------------------------------------------------------------
Fix q800 memory map

----------------------------------------------------------------

Laurent Vivier (1):
  q800: fix I/O memory map

 hw/m68k/q800.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

-- 
2.21.0


