Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787F6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD33205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIPYQDne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD33205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvWJ-0008Ud-CA
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYvVF-0007Jj-9A
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:49:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57069
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYvVE-0003pU-Ga
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589392147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZsWeclbG4prq5TIaY9LwoCrwhAF4vEQkonWU7xUK1U=;
 b=bIPYQDne+FEhMjdtKqxg0b3l3F89/qd/u/5AzeHUklMGcpY7nmDXyvQDAEY1/LP7PJwf4N
 VmlgncyGfCZO8gigGB/9G7ua+gwXUP/jSZT1614kNkNF5kb0zcfw9wse8+9Yr0rq2pw4fw
 YneUUuiyPlRLbkpME3uwCz38qYmhMVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-9i38PSqFN8Cv_RNcln8cAQ-1; Wed, 13 May 2020 13:49:03 -0400
X-MC-Unique: 9i38PSqFN8Cv_RNcln8cAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BA66835B8B;
 Wed, 13 May 2020 17:49:02 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9E5F18A75;
 Wed, 13 May 2020 17:49:01 +0000 (UTC)
Subject: Re: [PATCH v3 0/4] Additional parameters for qemu_img map
To: Eyal Moscovici <eyal.moscovici@oracle.com>
References: <20200513133629.18508-1-eyal.moscovici@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3a55d6a6-ce3c-6eb4-fddf-baab00be4f11@redhat.com>
Date: Wed, 13 May 2020 12:49:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513133629.18508-1-eyal.moscovici@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, liran.alon@oracle.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 8:36 AM, Eyal Moscovici wrote:
> Hi,
> 
> The following series adds two parameters to qemu-img map:
> 1. start-offset: mapping starting offset.
> 2. max-length: the length of the mapping.
> 
> These parameters proved useful when mapping large disk spread across
> long store file chains. It allows us to bound the execution time of each
> qemu-img map execution as well as recover from failed mapping
> operations. In addition the map operation can divided to
> multiple independent tasks.
> 
> V3 changes:
> 1. Add cvtnum_full and made cvtnum a wrapper function.
> 2. Keep the original boundaries checks.
> 3. Tone down error messages.

While this does not directly touch NBD code, I find it quite handy for 
my tests of incremental backups over NBD (since I frequently use 
x-dirty-bitmap coupled with qemu-img map to read bitmaps, and subsetting 
the output is indeed nice), so I'll queue this through my NBD tree.  It 
may be another week or so before I send a pull request including this 
and other collected patches.

Congratulations on your first qemu contribution!

>  qemu-img.c                 | 76 +++++++++++++++++---------------------
>  tests/qemu-iotests/049.out |  8 ++--
>  2 files changed, 38 insertions(+), 46 deletions(-)

This series diffstat is off; later in the series, in 4/4, I see:

>  docs/tools/qemu-img.rst |  2 +-
>  qemu-img-cmds.hx        |  4 ++--
>  qemu-img.c              | 22 +++++++++++++++++++++-
>  3 files changed, 24 insertions(+), 4 deletions(-)

What I don't see is any iotest coverage of the new options, to ensure 
they don't regress.  Either a new iotest, or an enhancement to an 
existing iotest.  If you feel up to the task, post a 5/4 patch; if not, 
I'll probably enhance 223 (my x-dirty-bitmap reading code mentioned above).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


