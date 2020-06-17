Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F29C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510B520C09
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="oGvf0RxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510B520C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTU2-0005Ss-ID
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTSv-0004Ui-DQ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:30:37 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.236]:52883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTSt-0004xo-C6
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:30:37 -0400
Received: from tpw09926dag09e.domain1.systemhost.net (10.9.202.36) by
 RDW083A009ED65.bt.com (10.187.98.35) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 17 Jun 2020 09:17:11 +0100
Received: from tpw09926dag12f.domain1.systemhost.net (10.9.212.20) by
 tpw09926dag09e.domain1.systemhost.net (10.9.202.36) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 17 Jun 2020 09:24:24 +0100
Received: from RDW083A009ED65.bt.com (10.187.98.35) by
 tpw09926dag12f.domain1.systemhost.net (10.9.212.20) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Wed, 17 Jun 2020 09:24:24
 +0100
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (104.47.20.57) by
 smtpe1.intersmtp.com (62.239.224.236) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 17 Jun 2020 09:17:04 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL5yWqb8niP8acEdP1yByb9VyW8K0inpjdVwZ/y1F4UpZDggOsCdawfOZdyT01AZOS+lgIhbFfiNKLpFTpXNCm0V0BU2vaUNCVYbaTZf3bewChZA/YUKmUx9XsHn7U+v+CZO58vp99uaQ3hW5xT3mlCZ6soyRll0wVfNBE32v0Nn98EU+f1+CVowwAjqHIT2DU2N5S8NOJVnGWNuU4rTjxMY1wl1cn14pWhOwM19BYni1i9wt6ypbNMhHGVSl8nXoUqY3RZtYglGJ84ZV1ZWRL+RZxJ5Y+65A6ewmf14g9xf3D0DZtJSK2Z1hFNtENhamTIPYMZC1FMt4D4eZKgBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dLWM9wTLHHlPApMv1pUBVsmPDgFSwoUNc9XtHkJQ3s=;
 b=HbuI8cQXfhk++KfrAjViB3hzvLxTU90m83Rlgz81zehI3M63To9CVZV2E1tc9EYiWycKf6FmCnGYEG7h7NM6AfWU2AT3kvdplCSreb+4tBIHsbgoZDv2rnsHCblSUGiPGp30gOP/TBylalAJpHFKAhJXb+es0aW7Hz0Qcbwy2QarIHiRCcB4kS39Mb3lvPBtZsyaYDeLkbyTNsjbybaXKEZnvDUkWWhYpexYwm0lraBL52Fqrc3BTMT1McjYGOMjY2EwMo5O5yzQJf8qVqog6xsluv44JZbNuXe+YZDt09bXV7GtLpU/w7RV/ACNaxRYZDvYZGnbEIcWVJACeSL8uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dLWM9wTLHHlPApMv1pUBVsmPDgFSwoUNc9XtHkJQ3s=;
 b=oGvf0RxCPDMW4/mu2UOLu2nkFHJUXDzDrX64a6K8bBKhurC7lJG4MlrIFbI6yf4JLBXSZK+aD402SM1ClZoq/2l2HqN4d2vZuw0T91bBlU370VyzhO/Ybysv8XzXANzYUPY1lN/MqXa3W+RWwK+eRK3DUOjymBoD8eJiJuy57Zk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bt.com;
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:7b::18)
 by CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 08:24:22 +0000
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b]) by CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 08:24:22 +0000
From: Jasper Lowell <jasper.lowell@bt.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 0/8] ESCC2
Date: Wed, 17 Jun 2020 18:23:54 +1000
Message-ID: <20200617082402.242631-1-jasper.lowell@bt.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:54::15) To CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:7b::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.128.24.45) by
 SG2PR02CA0051.apcprd02.prod.outlook.com (2603:1096:4:54::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 08:24:19 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [185.128.24.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 589b7c82-614c-4ba9-9cf3-08d81297d6a3
X-MS-TrafficTypeDiagnostic: CWXP123MB3255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CWXP123MB3255725FFD0C39C2244B8495839A0@CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM>
X-Antispam-2: 1
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLAzgzRIMXoFLeucMzxpybZ6RTqExMoE/FHzkieUX8dNwwoohiZHJvBIsDvQO0oCSnkMSVgrZ1aWWWArPzOVVpxycCctId4g5BKRRSgL0yZaeV134d6MMwLrar5VeLRtDqcGuSIw5GEkL01AQ7EHsw+m+lWPgYeGnBhbJQaqMx7XcJkZTt5EIvawexyaUy6Nh2aZQmbc8MTWPmdski7EM3rmha+lQPI/+90r67/ZRpQ+KrvfO7SdM6YaSBw2p5GLtHTsjDsN58jX62la2raHFiUeSD7mo3WzeipVtV5A7pav+/U3ioR/LF26TdRhVKtOs1CGcXHKQPhWbcxwPPfosDiXdnoUPitEwFuRTWpbCmeLQErgi43rVvYwf0UtnsSz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(44832011)(1076003)(8676002)(2616005)(316002)(8936002)(6666004)(6486002)(956004)(2906002)(5660300002)(83380400001)(6506007)(69590400007)(26005)(6512007)(36756003)(6916009)(186003)(16526019)(478600001)(52116002)(66556008)(66476007)(4326008)(66946007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XvK/S8fV0gxPlsc72joP77jJT2Kg24DPip76v1eQiqzVPQ7KMRoUaNAIxeioIobJrODMOnCCq7gFeIZ6C7KSzpJSiMSoBlpSR4l1yjTZeiac0bs2Y0/dxBhsbkHBBb8x6A9W6wJF3ewh60MYVfd3NW76ukVNQokE9uSQOI+wrv/Z9LxpblvOVJ41vs7sextDfgSrT7Jgs+OIF3qbN4sRWWq0k/m28lM4Zi8bOl4nueP6bF8cjzut91quuB9PVt2/B4YJUKpsHVKKLrJ8DQPuxUeijROxZr2surNcutfT7ecQPZjA95OYqA+wjaLeFA40JVle5IpaNPd1402L1pj71wN7jmQ4D4XdSLRApwLQKqQWTKAK3L2fbwTpUD3XspyCYIOz9wuerlo3ZXusBnlgukn9BQvwqkyIoJj/87NbtcL2JfByOtp41UdQ7mOvBbIq4EoxJ8jUdzFM0D50QOJIpwC6IsWhGe8fTUSPHJ8eGGc=
X-MS-Exchange-CrossTenant-Network-Message-Id: 589b7c82-614c-4ba9-9cf3-08d81297d6a3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 08:24:22.6761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rld2ZqyaEzCSwkEfhi4dDNrf5nl4GeCIqFEKAmDemC3iR4+1X0pnJ2ZBQ+e7kBKnBz1Xg6C1NjnTJtyLHJu1pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3255
X-OriginatorOrg: bt.com
Received-SPF: pass client-ip=62.239.224.236; envelope-from=jasper.lowell@bt.com;
 helo=smtpe1.intersmtp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 04:24:30
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 SUBJ_ALL_CAPS=0.5, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: tony.nguyen@bt.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 Jasper Lowell <jasper.lowell@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've been working on improving Solaris 10 emulation for the SPARC64
Sun4u architecture with the goal of a working shell. Currently, Solaris
10 boots with a number of errors before displaying the prompt of an
otherwise unresponsive installer shell. It's been mentioned that this
problem may not be isolated to Solaris 10 but may affect derivatives of
OpenSolaris including illumos.

From what I can tell, Solaris 10 never attempts to use the 16550A UART
for the serial console. The kernel will probe registers to identify the
device but will not use it for receiving or transmitting. The kernel
only prints to the console using the prom interface that OpenBIOS
provides. It's difficult to ascertain what the problem is because there
is no visibility into the kernel. The 16550A UART on the Ultra 5
(Darwin), the machine that QEMU Sun4u is modelled against, is used for
the keyboard/mouse (SuperIO) and is not traditionally used for the
serial tty. Instead, the SAB 82532 ESCC2 is used to provide ttya and
ttyb on this system. This patch exists to increment QEMU Sun4u towards
being hardware faithful.

The SAB 82532 ESCC2 is complex because of the jungle of features that it
provides. Linux and OpenBSD only use a small subset of features
restricted to the ASYNC serial mode. The ASYNC serial mode is
relatively simple to implement in isolation. I have made progress on a
patch series that supports all serial modes, along with transitioning
between them, but I have decided against submitting it. The serial
controller appears to multiplex bit positions in registers across serial
modes while preserving the bits themselves. This means that some 8-bit
registers need to keep track of more than 8-bits of data and that the
interpretation of the value the register holds depends on the selected
serial mode. It's not ideal having a copy of each register for each
serial mode because some bits are shared across some of the register
modes. An added difficulty is that the manual doesn't document this
behaviour well and its unclear what exactly happens when there is a
transition in the selected serial mode. I've avoided depending on
registers being uint8_t and have made use of macros so that the backend
implementation of each register can be changed at a later date when
supporting other serial modes. If I have the opportunity to test real
hardware, or it becomes clear that HDLC/SDLC/BISYNC support is needed,
I'll look at upstreaming the other changes that I have.

I have written a bare-bones patch for OpenBIOS that adds this device to
the device tree. With that applied, Solaris identifies and attaches the
device successfully but does not interact with it further - similar to
the 16550A UART. I did notice, however, that Solaris 10 entered an
interrupt routine for this device when the network card was being
configured. I couldn't manage to provoke this behaviour for the 16550A
so this might be some small success. I strongly suspect that the
interrupt is a spurious interrupt caused by misconfiguration of the
devices in the firmware but I have not investigated this further.

Solaris 10, judging from the OpenSolaris source code, determines
stdin/stdout for the console by examining the stdin/stdout properties
under /chosen in the device tree. Naturally, this is done with the prom
interface. From what I can tell, to set these properties to the ESCC2
node it's necessary to change stdin/stdout for OpenBIOS completely. This
requires a device driver. I have made some progress on an OpenBIOS
device driver for the ESCC2 but it's taking longer than expected to
completely replace the 16550A and it's unlikely that I will have this
finished soon. It's possible that Solaris 10 emulation for this platform
will improve once that work is finished but it's unclear.

This is my first patch series for QEMU so it's possible that I've made
mistakes in the contribution process - sorry in advance.

Jasper Lowell (8):
  hw/char/escc2: Add device
  hw/char/escc2: Handle interrupt generation
  hw/char/escc2: Add character device backend
  hw/char/escc2: Add clock generation
  hw/char/escc2: Add Receiver Reset (RRES) command
  hw/char/escc2: Add RFRD command
  hw/char/escc2: Add Transmit Frame (XF) command
  hw/char/escc2: Add XRES command

 hw/char/Kconfig         |    8 +
 hw/char/Makefile.objs   |    1 +
 hw/char/escc2.c         | 1135 +++++++++++++++++++++++++++++++++++++++
 hw/char/trace-events    |    6 +
 include/hw/char/escc2.h |   17 +
 5 files changed, 1167 insertions(+)
 create mode 100644 hw/char/escc2.c
 create mode 100644 include/hw/char/escc2.h

-- 
2.26.2


