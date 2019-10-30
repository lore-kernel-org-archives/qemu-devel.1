Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E47CA9EC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 22:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C99221924
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 22:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Fd3MVmDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C99221924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPwhZ-0004za-O5
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 18:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iPwbQ-00008y-Is
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 18:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iPwbP-0002Pn-9I
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 18:38:08 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:41341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iPwbO-0002HB-W3; Wed, 30 Oct 2019 18:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=hzyijGYwLJgcsPfh/wa1Nq5ESKn4g+Q0YHchS6mHYgA=; 
 b=Fd3MVmDDGQdLJ4Q0YOEt7wVZTcXUViNd26nKgUDMwO8gtOWOdoLODx5y3zWMNMmzvH0diRGxEWFevOlT2zecw81acfLDahlgyARi7z1J5MymHfa96Vj75xe3wZPzO/wafCc05IiRZqnbeoJMScy0AE4YJwxQefC7Ksn8bx0kmLIeWGCpUB2p6Fdd+WgTmb44Nhmlq2qApKuGIY26LK83gDfHl+FOFgm88EuHGZvDKOSEjlEHDl23enTrUk0OSmPpQrkeelXXe2MnUEX5s8Nv52ziYswwkizsnIlpVJ/n9m+bhEFAB+bPZXIhWRx2qgDF2pnKnRR/AiytUPXA7FK+Vw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iPwbK-0006VX-3J; Wed, 30 Oct 2019 23:38:02 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iPwbK-0006r0-0o; Wed, 30 Oct 2019 23:38:02 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 05/26] qcow2: Document the Extended L2 Entries
 feature
In-Reply-To: <0c738172-732f-eee0-3396-5a9576a4addf@redhat.com>
References: <cover.1572125022.git.berto@igalia.com>
 <57cddd5db9c79406fba70a9bf46c436f6fc9ccd3.1572125022.git.berto@igalia.com>
 <0c738172-732f-eee0-3396-5a9576a4addf@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 30 Oct 2019 23:38:01 +0100
Message-ID: <w51y2x1eu5y.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 30 Oct 2019 05:23:30 PM CET, Max Reitz wrote:
>> +Subcluster Allocation Bitmap (for standard clusters):
>> +
>> +    Bit  0 -  31:   Allocation status (one bit per subcluster)
>> +
>> +                    1: the subcluster is allocated. In this case the
>> +                       host cluster offset field must contain a valid
>> +                       offset.
>> +                    0: the subcluster is not allocated. In this case
>> +                       read requests shall go to the backing file or
>> +                       return zeros if there is no backing file data.
>> +
>> +                    Bits are assigned starting from the most significan=
t one.
>> +                    (i.e. bit x is used for subcluster 31 - x)
>
> I seem to remember that someone proposed this bit ordering to you, but
> I wonder why.  So far everything in qcow2 starts from the least
> significant bit, for example refcounts (=E2=80=9CIf refcount_bits implies=
 a
> sub-byte width, note that bit 0 means the least significant bit in
> this context=E2=80=9D), feature bits, and sub-byte structure descriptions=
 in
> general (which you reference directly with =E2=80=9Cbit x=E2=80=9D).
>
> Soo...  What=E2=80=99s the reason for doing it the other way around here?

The reason is that I thought that it would be better for debugging
purposes. If I do an hexdump of the L2 table to see what's going on then
starting from the most significant bit gives me a better visual image of
what subclusters are allocated.

In other words, if the first two subclusters are allocated I think this
representation

               11000000 00000000 00000000 00000000  (c0 00 00 00)

is more natural than this one

               00000000 00000000 00000000 00000011  (00 00 00 03)

But I don't have a very strong opinion so I'm open to changing it.

Berto

