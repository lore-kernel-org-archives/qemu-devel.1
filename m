Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DA9C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 12:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A314A21850
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 12:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A314A21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjNIr-0006TO-ED
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 08:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52866)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hjNHG-0005UG-IX
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 08:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hjNHE-0003oM-Fl
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 08:25:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hjNHE-0003j3-AG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 08:25:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C9CD59464;
 Fri,  5 Jul 2019 12:25:18 +0000 (UTC)
Received: from kaapi (unknown [10.65.150.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C49C88E170;
 Fri,  5 Jul 2019 12:25:14 +0000 (UTC)
Date: Fri, 5 Jul 2019 17:55:12 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
In-Reply-To: <nycvar.YSQ.7.76.1907021539350.23656@xnncv>
Message-ID: <nycvar.YSQ.7.76.1907051754170.15068@xnncv>
References: <20190701123558.30512-1-ppandit@redhat.com>
 <20190701123558.30512-4-ppandit@redhat.com>
 <20190701175010.GN3573@redhat.com>
 <nycvar.YSQ.7.76.1907021539350.23656@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 05 Jul 2019 12:25:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/3] net: tap: refactor
 net_bridge_run_helper routine
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
Cc: Riccardo Schirone <rschiron@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Tue, 2 Jul 2019, P J P wrote --+
| |    -netdev bridge,helper="/path/to/helper myarg otherarg"
| | 
| | In theory any parts could contain shell meta characters, but even if
| | they don't we'll have slightly broken compat with this change.
| 
| I wonder if anybody uses it like that. Because of the 3 arguments that 
| qemu-bridge-helper takes
| 
|   --use-vnet --fd=sv[1] --br=bridge
| 
| only bridge name is supplied by user; Which is anyway comming without 'helper' 
| having to include '--br=bridge' argument, as is looked for before shell 
| invocation
| 
|   if (strstr(helper, "--br=") == NULL) {
|       snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=", bridge);
|   }
| 
| '--br=bridge' has limited scope to use shell meta characters, ie. other than 
| space(' ') and tab('\t').
| 
| 
| | The QEMU man page has never documented that you can pass a command
| | and args, which get sent via the shell though. It only ever documented
| | the helper arg as being a plain qualified binary path.
| | 
| | So the question is how strictly we need to consider compatibility.
| | 
| | The "if it isn't documented it never existed" option is to use your
| | patch here.
| 
| We don't know if "/path/to/helper arg1 arg2" usage exists in practice. And 
| considering user would still be able to supply 'bridge' argument, I wonder if 
| we are breaking compatibility.
| 
| | The safest option is to put in a place a deprecation saying we'll
| | drop use of shell in future, only implementing the aggressive
| | option in a later release.
| 
| ie. for Qemu > v4.0.0? How do we do this?
| 
| | Perhaps from your POV, the easy thing is to avoid this entire
| | question - just leave the code calling shell, but switch to
| | g_strdup_printf instead of snprintf.
| 
| Okay, this will be for Qemu <= v4.0.0?
| 

@Dan:...ping!?
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

