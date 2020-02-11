Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17219C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 14:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D755A206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 14:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fy6y88df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D755A206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1WcL-0006Un-1v
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 09:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1Wbh-00061F-E3
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1Wbg-00070q-3S
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:33:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58471
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1Wbg-000700-0K
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581431623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bz6LXVsoI66LuUac2rYRL3fWGQcpAXi7rFujqid6psU=;
 b=Fy6y88dfQnZKjqVdDdDBD5xt/uPdElSbVamLTol9MuwiG+P870+mEdDvNLER+JboyWsG81
 nDcijzofSXDu3+GZA0m/louztprJTzN723ZnFkMahwWcbEhy1ZlriKnZGiHxD2KpvyS1wb
 cnZ5ML2JA5jK7XIBRDHx/SF4EUZurm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-0TpUnLkwOsaXtrymsb3Cig-1; Tue, 11 Feb 2020 09:33:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B74F800EB2;
 Tue, 11 Feb 2020 14:33:31 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34A1189F35;
 Tue, 11 Feb 2020 14:33:26 +0000 (UTC)
Subject: Re: Cross-project NBD extension proposal: NBD_INFO_INIT_STATE
To: "Richard W.M. Jones" <rjones@redhat.com>
References: <a4394fde-f459-dcb5-1698-013e1e24c388@redhat.com>
 <20200210221234.GH3888@redhat.com>
 <cc6e1e2e-d3a9-c498-354b-d382b5623ca0@redhat.com>
 <20200210225255.GJ3888@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6ac74a99-67b6-3c41-873f-174237412605@redhat.com>
Date: Tue, 11 Feb 2020 08:33:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210225255.GJ3888@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 0TpUnLkwOsaXtrymsb3Cig-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, "nbd@other.debian.org" <nbd@other.debian.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 4:52 PM, Richard W.M. Jones wrote:
> On Mon, Feb 10, 2020 at 04:29:53PM -0600, Eric Blake wrote:
>> On 2/10/20 4:12 PM, Richard W.M. Jones wrote:
>>> On Mon, Feb 10, 2020 at 03:37:20PM -0600, Eric Blake wrote:
>>>> For now, only 2 of those 16 bits are defined: NBD_INIT_SPARSE (the
>>>> image has at least one hole) and NBD_INIT_ZERO (the image reads
>>>> completely as zero); the two bits are orthogonal and can be set
>>>> independently, although it is easy enough to see completely sparse
>>>> files with both bits set.
>>>
>>> I think I'm confused about the exact meaning of NBD_INIT_SPARSE.  Do
>>> you really mean the whole image is sparse; or (as you seem to have
>>> said above) that there exists a hole somewhere in the image but we're
>>> not saying where it is and there can be non-sparse parts of the image?
>>
>> As implemented:
>>
>> NBD_INIT_SPARSE - there is at least one hole somewhere (allocation
>> would be required to write to that part of the file), but there may
>> b allocated data elsewhere in the image.  Most disk images will fit
>> this definition (for example, it is very common to have a hole
>> between the MBR or GPT and the first partition containing a file
>> system, or for file systems themselves to be sparse within the
>> larger block device).
> 
> I think I'm still confused about why this particular flag would be
> useful for clients (I can completely understand why clients need
> NBD_INIT_ZERO).
> 
> But anyway ... could a flag indicating that the whole image is sparse
> be useful, either as well as NBD_INIT_SPARSE or instead of it?  You
> could use it to avoid an initial disk trim, which is something that
> mke2fs does:
> 
>    https://github.com/tytso/e2fsprogs/blob/0670fc20df4a4bbbeb0edb30d82628ea30a80598/misc/mke2fs.c#L2768

I'm open to suggestions on how many initial bits should be provided.  In 
fact, if we wanted, we could have a pair mutually-exclusive bits, 
advertising:
00 - no information known
01 - image is completely sparse
10 - image is completely allocated
11 - error

The goal of providing a 16-bit answer (or we could mandate 32 or 64 
bits, if we think we will ever want to extend that far) was to make it 
easier to add in whatever other initial-state extensions that someone 
could find useful.  Until we're happy with the design, the size or any 
given bit assignment is not locked down; once we do start committing any 
of this series, we've locked in what interoperability will demand but 
still have spare bits as future extensions.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


