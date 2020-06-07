Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDD6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 06:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2384D20659
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 06:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQibfn+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2384D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhpCd-0006qb-D9
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 02:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jhpC0-0006QG-HM
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 02:54:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32084
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jhpBz-0003i6-BS
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 02:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591512841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=kpew86T1YAdyVa3wuvfXHlkwVzBlgp9eOzni6o619Dc=;
 b=bQibfn+doX1UeMpoC6bo4gXcgCW5522yjye2iqDPvt26E5GgJTMT7lO8CT20/gIcAMttnx
 wPp8X4GVdYTJTRiC3BszwFFXEyIeGemkQr8VAh8/1xfJRKDNUIgDzQSWG8nf7tOcuaipvY
 Y3xwUpBFoQBhrsgXyY59QiqvJwKIo0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-uWEUXpb-MnWxj7QOCGD7Mg-1; Sun, 07 Jun 2020 02:53:58 -0400
X-MC-Unique: uWEUXpb-MnWxj7QOCGD7Mg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C74D31005510;
 Sun,  7 Jun 2020 06:53:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE1CF5D9DA;
 Sun,  7 Jun 2020 06:53:53 +0000 (UTC)
Subject: Re: [PATCH v5 0/2] Makefile: libfdt: build only the strict necessary
To: David Gibson <dgibson@redhat.com>
References: <20200518160319.18861-1-cfontana@suse.de>
 <1f70e2fb-a1f4-29af-c9e6-38b178fa26ca@suse.de>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9f1d9711-c87d-f554-2718-f69b3babbf54@redhat.com>
Date: Sun, 7 Jun 2020 08:53:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1f70e2fb-a1f4-29af-c9e6-38b178fa26ca@suse.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/07 01:20:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Philippe Mathieu-Daude <philmd@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Alex Bennee <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi David,

could you maybe take this through your ppc tree?

 Thanks,
  Thomas


On 01/06/2020 13.28, Claudio Fontana wrote:
> Hello all,
> 
> is this queued somewhere?
> 
> Thanks,
> 
> Claudio
> 
> On 5/18/20 6:03 PM, Claudio Fontana wrote:
>> v4 -> v5:
>>
>> * include the dtc submodule update commit in the 1/2 patch
>>
>> v3 -> v4: NB! only useful when updating to latest dtc (not in QEMU yet)
>>
>> * changed the approach to leverage new upstream dtc Makefile,
>>   needs dtc submodule update to include upstream dtc commit
>>   85e5d839847af54efab170f2b1331b2a6421e647.
>>
>> * LIBFDT_srcdir does not exist anymore in upstream dtc: it is also
>>   not used anymore.
>>
>> * LIBFDT_lib: need to avoid building libfdt.so at least for now, so pass as
>>   empty to avoid building the .so. This is to avoid breaking existing
>>   trees with objects already compiled without -fPIC.
>>
>> * clean: no need to make dtc clean target, every artifact is captured by
>>   global clean rule
>>
>> v2 -> v3:
>>
>> * changed into a 2 patch series; in the second patch we remove the old
>>   compatibility gunks that were meant for removal some time after 4.1.
>>
>> * renamed the libfdt PHONY rule to dtc/all, with the intent to make
>>   existing working trees forward and backward compatible across the change.
>>
>> v1 -> v2:
>>
>> * fix error generated when running UNCHECKED_GOALS without prior configure,
>>   for example during make docker-image-fedora. Without configure, DSOSUF is
>>   empty, and the module pattern rule in rules.mak that uses this variable
>>   can match too much; provide a default in the Makefile to avoid it.
>>
>> * only attempt to build the archive when there is a non-empty list of objects.
>>   This could be done in general for the %.a: pattern in rules.mak, but maybe
>>   there are valid reasons to build an empty .a?
>>
>> * removed some intermediate variables that did not add much value
>>   (LIBFDT_srcdir, LIBFDT_archive)
>>
>> Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src subdir),
>> and with docker-image-fedora, docker-test-debug@fedora that failed before.
>>
>> Claudio Fontana (2):
>>   Makefile: libfdt: build only the strict necessary
>>   Makefile: remove old compatibility gunks
>>
>>  Makefile  | 32 ++++++++++++++++----------------
>>  configure |  6 +-----
>>  rules.mak |  2 ++
>>  3 files changed, 19 insertions(+), 21 deletions(-)
>>
> 
> 


