Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ACDC47256
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C49214D8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RC7GvynS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C49214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWLuw-0008U5-Au
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 11:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jWLuL-0007z5-U1; Wed, 06 May 2020 11:24:25 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:47462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jWLuJ-0000Tb-8C; Wed, 06 May 2020 11:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=QJ65CQ3oJ/uJwgh69th3Gvh/HobHcXzPLhfboKR90gw=; 
 b=RC7GvynSQ2hqp7y02H0DD7EwE4F+6w4KyQpPSZq6Gyy3Uq3bHTA1SPoP9+sUnDR752LBZzH2z72zcGv5WMuJY4rmirbn+BzaJfZ9h55VujZf4DOajifusQbWOBRUBgyF2VJsp7qfVS7QjS8hKnclWTc5gIiOsEGq9ClwM2FHph4kqndRy3cMUaVWJ3hNoXyNWWuuNtGpUfUD3UNg+CV2zURcXjPCxWohsoa6AVdJJbW5+iLvyXMAgTAlWNXBbTdxjFlFxprrSZQv69szF0qjfOtl/skwqtjzPZDFk7z1OElG3lWiiwux2wQlBu1GRXNGAWeQRZ+2dlLhUuI4EQhDXw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jWLuE-0006iC-UR; Wed, 06 May 2020 17:24:18 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jWLuE-0002u3-KE; Wed, 06 May 2020 17:24:18 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 07/31] qcow2: Document the Extended L2 Entries feature
In-Reply-To: <w51d07h9kdf.fsf@maestria.local.igalia.com>
References: <cover.1588699789.git.berto@igalia.com>
 <ad59735f252161ec7ed2f08b30cd517cbfb1d360.1588699789.git.berto@igalia.com>
 <52c059ee-8a80-89af-dbab-ffea3976421e@redhat.com>
 <w51d07h9kdf.fsf@maestria.local.igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 06 May 2020 17:24:18 +0200
Message-ID: <w51a72l9jdp.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 11:02:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 06 May 2020 05:02:52 PM CEST, Alberto Garcia wrote:
>>> -                    With version 2, this is always 0.
>>> +                    With version 2 or with extended L2 entries (see the next
>>> +                    section), this is always 0.
>>
>> In your cover letter, you said you changed things to tolerate this
>> bit being set even with extended L2 entries.  Does this sentence need
>> a tweak?
>
> Not a bad idea.

I just had a look at what happens with v2 images. There the bit is
actually checked and the image is marked corrupt, but that only seems to
happen in qcow2_get_host_offset(). You can write to a cluster that has
that bit set and QEMU won't complain (the bit is however cleared).

'qemu-img check' does not detect any inconsistency either.

As I said in my cover letter maybe it's worth preparing a separate
series that adds a QCOW2_CLUSTER_INVALID type and includes all these
cases.

Berto

