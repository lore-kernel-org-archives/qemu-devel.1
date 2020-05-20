Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE4FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F9E207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F9E207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbP0T-0002Oh-CC
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jbOzn-0001J0-P8
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:42:55 -0400
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:42128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jbOzm-00054D-LM
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:42:55 -0400
Received: from player779.ha.ovh.net (unknown [10.110.103.121])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id C986016899B
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 15:42:43 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id 96976128804B6;
 Wed, 20 May 2020 13:42:37 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0061255c64c-454e-42b8-a9bb-9173243bdfbc,D4AE9CB3A4750E3488E7135F1D4D455A9A9A4933)
 smtp.auth=groug@kaod.org
Date: Wed, 20 May 2020 15:42:36 +0200
From: Greg Kurz <groug@kaod.org>
To: no-reply@patchew.org
Subject: Re: [PATCH 0/2] revert 9pfs reply truncation, wait for free room to
 reply
Message-ID: <20200520154236.3edf3cbc@bahia.lan>
In-Reply-To: <158996146074.24632.17962896571801369435@45ef0f9c86ae>
References: <alpine.DEB.2.21.2005191651130.27502@sstabellini-ThinkPad-T480s>
 <158996146074.24632.17962896571801369435@45ef0f9c86ae>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3734328519024744824
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddtledgieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeuffetkefgtedtvdeuiefgffeghfevgeeuuedvgeduveffhffhhfeggfefteehveenucffohhmrghinhepphgrthgthhgvfidrohhrghenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.79.46; envelope-from=groug@kaod.org;
 helo=10.mo179.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 09:42:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: anthony.perard@citrix.com, sstabellini@kernel.org, qemu_oss@crudebyte.com,
 qemu-devel@nongnu.org, paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 00:57:42 -0700 (PDT)
no-reply@patchew.org wrote:

> Patchew URL: https://patchew.org/QEMU/alpine.DEB.2.21.2005191651130.27502@sstabellini-ThinkPad-T480s/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: alpine.DEB.2.21.2005191651130.27502@sstabellini-ThinkPad-T480s
> Subject: [PATCH 0/2] revert 9pfs reply truncation, wait for free room to reply
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 1fcf375 xen/9pfs: yield when there isn't enough room on the ring
> 8e197ec Revert "9p: init_in_iov_from_pdu can truncate the size"
> 
> === OUTPUT BEGIN ===
> 1/2 Checking commit 8e197ec8340d (Revert "9p: init_in_iov_from_pdu can truncate the size")
> 2/2 Checking commit 1fcf3751db74 (xen/9pfs: yield when there isn't enough room on the ring)
> ERROR: memory barrier without comment
> #41: FILE: hw/9pfs/xen-9p-backend.c:203:
> +    smp_wmb();
> 
> ERROR: memory barrier without comment
> #56: FILE: hw/9pfs/xen-9p-backend.c:213:
> +    smp_wmb();
> 
> ERROR: memory barrier without comment
> #68: FILE: hw/9pfs/xen-9p-backend.c:302:
> +    smp_rmb();
> 

Indeed some comments would definitely provide better understanding.

> total: 3 errors, 0 warnings, 50 lines checked
> 
> Patch 2/2 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/alpine.DEB.2.21.2005191651130.27502@sstabellini-ThinkPad-T480s/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

