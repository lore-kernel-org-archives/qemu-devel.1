Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4772C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 11:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B02206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 11:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B02206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfid5-0004cr-PV
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 07:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jficX-0004Cv-W7
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 07:28:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:40824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jficW-0005gU-WA
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 07:28:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 238D1AC7D;
 Mon,  1 Jun 2020 11:28:44 +0000 (UTC)
Subject: Re: [PATCH v5 0/2] Makefile: libfdt: build only the strict necessary
To: David Gibson <david@gibson.dropbear.id.au>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe Mathieu-Daude <philmd@redhat.com>
References: <20200518160319.18861-1-cfontana@suse.de>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <1f70e2fb-a1f4-29af-c9e6-38b178fa26ca@suse.de>
Date: Mon, 1 Jun 2020 13:28:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200518160319.18861-1-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 22:17:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <laurent@vivier.eu>, Alex Bennee <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello all,

is this queued somewhere?

Thanks,

Claudio

On 5/18/20 6:03 PM, Claudio Fontana wrote:
> v4 -> v5:
> 
> * include the dtc submodule update commit in the 1/2 patch
> 
> v3 -> v4: NB! only useful when updating to latest dtc (not in QEMU yet)
> 
> * changed the approach to leverage new upstream dtc Makefile,
>   needs dtc submodule update to include upstream dtc commit
>   85e5d839847af54efab170f2b1331b2a6421e647.
> 
> * LIBFDT_srcdir does not exist anymore in upstream dtc: it is also
>   not used anymore.
> 
> * LIBFDT_lib: need to avoid building libfdt.so at least for now, so pass as
>   empty to avoid building the .so. This is to avoid breaking existing
>   trees with objects already compiled without -fPIC.
> 
> * clean: no need to make dtc clean target, every artifact is captured by
>   global clean rule
> 
> v2 -> v3:
> 
> * changed into a 2 patch series; in the second patch we remove the old
>   compatibility gunks that were meant for removal some time after 4.1.
> 
> * renamed the libfdt PHONY rule to dtc/all, with the intent to make
>   existing working trees forward and backward compatible across the change.
> 
> v1 -> v2:
> 
> * fix error generated when running UNCHECKED_GOALS without prior configure,
>   for example during make docker-image-fedora. Without configure, DSOSUF is
>   empty, and the module pattern rule in rules.mak that uses this variable
>   can match too much; provide a default in the Makefile to avoid it.
> 
> * only attempt to build the archive when there is a non-empty list of objects.
>   This could be done in general for the %.a: pattern in rules.mak, but maybe
>   there are valid reasons to build an empty .a?
> 
> * removed some intermediate variables that did not add much value
>   (LIBFDT_srcdir, LIBFDT_archive)
> 
> Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src subdir),
> and with docker-image-fedora, docker-test-debug@fedora that failed before.
> 
> Claudio Fontana (2):
>   Makefile: libfdt: build only the strict necessary
>   Makefile: remove old compatibility gunks
> 
>  Makefile  | 32 ++++++++++++++++----------------
>  configure |  6 +-----
>  rules.mak |  2 ++
>  3 files changed, 19 insertions(+), 21 deletions(-)
> 


