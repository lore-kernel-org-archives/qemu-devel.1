Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C26BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA03205CB
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="K41l9OHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA03205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE8E9-0006dg-Hv
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 05:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kE89Z-0000SS-LM; Fri, 04 Sep 2020 05:37:05 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:36991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kE89X-0006Lq-4t; Fri, 04 Sep 2020 05:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=1z5xYG6tjkfa9+JGnhMVMjqiWC8EYbFQr72JoXcNoZI=; 
 b=K41l9OHeS9fKAziOuHsgfdx8dHRNY43fWTUXtQ0P1gZLcgWyh5Fvnv7AT4VK7bYQwOhSUfl1J0WSBoblN2I/bvHjQ8CwdfIObHQMRjaBGtGlKdalByPaqPJ+13eF2rQftlVHtaTWvz016JPmnoKWpgIJfN9ZK4ro5yiGDRjD+ph4Ohxlc87l7LuN9haxPgGdC4gO4aHJFoOZLhi7rdKeT1zVI7ULXKD8RQ5iYhrnXV1Fbvkj8J7TF6aJQSZS1RE/NybfTDDbw1Cn8kCVWZiO4yAIDIAbnE23o0NwNL9mwFkrS+A/+jXs4wd6ZUymb5I65psG5iyXHmm5+EzR2ud6Dg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kE899-0000kX-M9; Fri, 04 Sep 2020 11:36:39 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kE899-00020S-CH; Fri, 04 Sep 2020 11:36:39 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/3] qcow2: Rewrite the documentation of
 qcow2_alloc_cluster_offset()
In-Reply-To: <9355b4ef-be80-b8eb-6697-24125caea920@redhat.com>
References: <cover.1599150873.git.berto@igalia.com>
 <bb5bd06f07c5a05b0818611de0d06ec5b66c8df3.1599150873.git.berto@igalia.com>
 <9355b4ef-be80-b8eb-6697-24125caea920@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 04 Sep 2020 11:36:39 +0200
Message-ID: <w51blilano8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 05:36:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 04 Sep 2020 11:28:18 AM CEST, Max Reitz wrote:
>> + * If any clusters or subclusters were allocated then @m contains a
>> + * list with the information of all the affected regions. Note that
>> + * this can happen regardless of whether this function succeeds or
>> + * not. The caller is responsible for updating the L2 metadata of the
>> + * allocated clusters (on success) or freeing them (on failure), and
>> + * for clearing the contents of @m afterwards in both cases.
>
> It=E2=80=99s too bad that preallocate_co() doesn=E2=80=99t do that then, =
isn=E2=80=99t it...

I was planning to have a closer look at that function next week.

Berto

