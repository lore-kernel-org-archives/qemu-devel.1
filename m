Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AC1C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C142D2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ox9VHari"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C142D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYD60-0005kl-RQ
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYD4z-0004HB-Un
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:23:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50809
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYD4y-0008SP-Mv
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589221383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnM/QhtVGCKMsu19tI9TO6UKM0NRWRfikWzARs25Nhw=;
 b=Ox9VHariS9UX4l8pMNBnj6YjP3mIVay2BM/YLQnZfV1LmsKIRdeCaqLNWpB9PRsGojs0yZ
 sizBKPmVSKETWkuqh9YyHCp2kyYpWACzXE1d6L5lcHLphChD03h6BUmdweSPhSejugXxpH
 55umW+w926u87ZaoVKapTn4dHZa8bC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-pE8PgBh2MdOKk1qehpv95Q-1; Mon, 11 May 2020 14:23:01 -0400
X-MC-Unique: pE8PgBh2MdOKk1qehpv95Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3EF2800687;
 Mon, 11 May 2020 18:23:00 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71E7C5D782;
 Mon, 11 May 2020 18:23:00 +0000 (UTC)
Subject: Re: [PATCH v3 6/9] qemu-img: Add bitmap sub-command
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200508180340.675712-1-eblake@redhat.com>
 <20200508180340.675712-7-eblake@redhat.com>
 <ce9731fd-d137-f5d2-6dc4-071a0b9e0b97@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bf472c11-e3b6-caee-7aa7-7803f762612d@redhat.com>
Date: Mon, 11 May 2020 13:22:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ce9731fd-d137-f5d2-6dc4-071a0b9e0b97@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/20 6:10 AM, Max Reitz wrote:
> On 08.05.20 20:03, Eric Blake wrote:
>> Include actions for --add, --remove, --clear, --enable, --disable, and
>> --merge (note that --clear is a bit of fluff, because the same can be
>> accomplished by removing a bitmap and then adding a new one in its
>> place, but it matches what QMP commands exist).  Listing is omitted,
>> because it does not require a bitmap name and because it was already
>> possible with 'qemu-img info'.  A single command line can play one or
>> more bitmap commands in sequence on the same bitmap name (although all
>> added bitmaps share the same granularity, and and all merged bitmaps
>> come from the same source file).  Merge defaults to other bitmaps in
>> the primary image, but can also be told to merge bitmaps from a
>> distinct image.
> 
> For the record: Yes, my comment was mostly about my confusion around the
> {}.  So just replacing them by () would have pacified me.
> 
> But this is more fun, of course.
> 

>> +++ b/docs/tools/qemu-img.rst
>> @@ -281,6 +281,29 @@ Command description:
> 
> [...]
> 
>> +  Additional options ``-g`` set a non-default *GRANULARITY* for
> 
> sets?

Or maybe:

Additional options include ``-g`` which sets a non-default *GRANULARITY* 
for ``--add``, and ``-b`` and ``-F`` which select an alternative source 
file for all *SOURCE* bitmaps used by ``--merge``.

And in writing this, I just realized - even though you _can_ use --add 
more than once in a command line, the command is still limited to 
operating on a single bitmap name, so unless you write contortions like:

qemu-img bitmap --add --remove --add -g 1024 file.qcow2 bitmapname

there will normally be at most one --add operation for a -g to be used 
with (because otherwise the second --add will fail when attempting to 
create an already-existing bitmap name).

> 
> With that fixed (or maybe not, you know that better than me):
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


