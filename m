Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AECC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84061207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84061207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY7Tw-0002ti-Ke
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.brenken@efs-auto.org>)
 id 1jY7Sv-0001mh-6M
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:23:25 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <david.brenken@efs-auto.org>)
 id 1jY7Su-0004Vv-4S
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:23:24 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGQ85-1jJbmy1fVV-00GpWN; Mon, 11 May 2020 14:23:17 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] tricore: added AURIX TC277 D-Step TriBoard
Date: Mon, 11 May 2020 14:21:58 +0200
Message-Id: <20200511122159.7260-1-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
X-Provags-ID: V03:K1:D74L9oR/GvIPmzzrK6T2C1TzXRo8wsPMvwK5z/E1wK0ab+4/gKh
 pn46KS7dtH7QcMoOAlGUYe/w++cZa8CBg8O2K7fxZurDY0gYA0ql0szSK12iBwhTiHfxlzE
 Ndf2X0DWwTeCJJvQ4F2t+gZLgOjXFX5KR77UrFrT/QrPmD45HuTE7YgcLCXIPQOB4JeRoLA
 dGXCIVY16Lp8xrkuHYZIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:28TQgkajSvQ=:vZ1kEfBratKZKtHWsz+YmZ
 OruaPiBAFons0/QfeoKkIaEygiknNnHAva4zEnCGhH2WxCCi0iOIWvGdUsV83TXYO3VpnqoU0
 ApB8bN1eb8tUxrCHgTBzK73jLlmL5mK5CbDu2vcWvwvqgInHwYbXcL99vYpaZ+hmZpH7hxlNG
 df1TjV9kWuAaPBykyPGiAlD5SxruL5TNxzmnqOP0Ey2N19G/vzxkdaUfWoFY6VlCO2XnkTtYk
 Vk94TkZVH3FiC4utmKUAukKnA+L5Y79XdQd4pUxesI+8e1VyLShOdh7WWzyUbc61DnEF7hm7V
 5uIFELi8a5cQvd4C017yAYPiCCWUFDmuzGLNKsv2w61I5n8+GIW2pOtSfK9W5xuR2Eg2cjX3q
 iPuysDqe+M5xp6nucqQkaowOA54QvUQZ3+1sCCRANbRCiZyO3gKHPXocVMWFMK2msmKu+qQ98
 vhfTYoN6598PNtUBI8cLpgzck/PenMDJulBOKSB+AQ3hVe5zkZvr+bIWAUMRdNZNyDWhZmxLa
 xjJ4M+nOQmwPjNRZ8nzFJa41kzO8vvwKtq4bUFVxk4vDBZa0OC6FcE8JpQ2Mqg7VzaU9Wu7DN
 Sjd+WxDMfNORdHFo1EpklXxehKugMpUBZeizCXEpvqyx+TCmx9U475hu9hyWTFQYw+Fsiekm4
 iwiA8hqJpnY64aDsuYJFqDgyZXQfEt76uicsS7FNEB/sQFr2JVAKAIlHQaQm4LI+J40ZncK88
 mowF8k3FBc15UW2Mhh8WKMN87Z3UVk0z0f/Dfg3FjdxyDTv7mXcugzZcoEeAsguj8VXDD/Ab5
 VowGlvtJM9krXwLlSSaNMQnL3JfZ22Z36yvATcPWOX+t1jJC63BZl/HH4OAKsEj+g11SFx4
Received-SPF: none client-ip=212.227.126.135;
 envelope-from=david.brenken@efs-auto.org; helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 08:23:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kbastian@mail.uni-paderborn.de,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andreas Konopik <andreas.konopik@efs-auto.de>

Hello everyone,

this patch adds the AURIX TC277 D-Step TriBoard as QEMU machine
(-M AURIX_TriBoard_TC277D). Memory maps are implemented according to the the
"AURIX TC27x D-Step User's Manual V2.2 2014-12". AURIX memory layouts normally
are specified by the processor, so this machine should not be used with any
other cpu than the "tc27x".

Andreas Konopik (1):
  tricore: added AURIX TC277 D-Step TriBoard

 hw/tricore/Makefile.objs           |   1 +
 hw/tricore/aurix_triboard_tc277d.c | 240 +++++++++++++++++++++++++++++
 2 files changed, 241 insertions(+)
 create mode 100644 hw/tricore/aurix_triboard_tc277d.c

-- 
2.26.0


