Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED71C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 12:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62DA20776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 12:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9boU4EL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62DA20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeeEj-0000TQ-UN
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 08:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeeDr-00089O-Tl
 for qemu-devel@nongnu.org; Fri, 29 May 2020 08:34:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44918
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeeDq-0004QK-FY
 for qemu-devel@nongnu.org; Fri, 29 May 2020 08:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590755688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ur/uMkjug693XVEcYP+tBiaI7x1hq+68V8HJb6khhko=;
 b=D9boU4ELIJI3WM/X11ZyTdgpCRFhYnzkFn/ujXobYCzH5AxJkio0L3KM8AIVGcydQC/mVJ
 kwLGrFWr58+4gekYGnrrZtw/xCsnK/66OUsHDm2BvIaNe3r7KXYz+PHVNfKKVZa5mXPY+3
 ynsZUv62zdCE4Aly++lz9GndClF2EN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-mkz-vZ2wMoedyr6lF2FGDQ-1; Fri, 29 May 2020 08:34:42 -0400
X-MC-Unique: mkz-vZ2wMoedyr6lF2FGDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 150F1107B7C8;
 Fri, 29 May 2020 12:34:41 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6033878901;
 Fri, 29 May 2020 12:34:40 +0000 (UTC)
Subject: Re: [PULL v3 7/7] qemu-img: Add bitmap sub-command
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200519175707.815782-1-eblake@redhat.com>
 <20200519175707.815782-8-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ef1e6101-cd54-2bcb-6f19-8f9e43eac4c2@redhat.com>
Date: Fri, 29 May 2020 07:34:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519175707.815782-8-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:34:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 12:57 PM, Eric Blake wrote:
> Include actions for --add, --remove, --clear, --enable, --disable, and
> --merge (note that --clear is a bit of fluff, because the same can be
> accomplished by removing a bitmap and then adding a new one in its
> place, but it matches what QMP commands exist).  Listing is omitted,
> because it does not require a bitmap name and because it was already
> possible with 'qemu-img info'.  A single command line can play one or
> more bitmap commands in sequence on the same bitmap name (although all
> added bitmaps share the same granularity, and and all merged bitmaps
> come from the same source file).  Merge defaults to other bitmaps in
> the primary image, but can also be told to merge bitmaps from a
> distinct image.

While backporting this, I noticed:

> +++ b/docs/tools/qemu-img.rst
> @@ -281,6 +281,30 @@ Command description:
>     For write tests, by default a buffer filled with zeros is written. This can be
>     overridden with a pattern byte specified by *PATTERN*.
> 
> +.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP

Here, it is spelled --merge SOURCE,

> +  ``--merge`` to merge the contents of *SOURCE_BITMAP* into *BITMAP*.

but here, it is spelled SOURCE_BITMAP,

> +
> +  Additional options include ``-g`` which sets a non-default
> +  *GRANULARITY* for ``--add``, and ``-b`` and ``-F`` which select an
> +  alternative source file for all *SOURCE* bitmaps used by
> +  ``--merge``.

and once again SOURCE.  I'll submit a followup patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


