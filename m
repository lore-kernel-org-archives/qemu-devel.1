Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94082C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 21:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48FD72465B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 21:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIEq1GTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FD72465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuNLm-0002Kl-Ag
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 16:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iuNKs-0001gM-H9
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 16:14:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iuNKq-0004pP-7h
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 16:14:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32336
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iuNKq-0004mE-11
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 16:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579727685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZONaJQW6ixWtyG8u3GwluaKwmNpCLKbcqSmMNoJmmdo=;
 b=QIEq1GTBo3wQAK/Q64ZdEQQD7uBaCL1oKa7Fs28Odfm2n1EMh9AMpqhIQYSSJd+QZVuyxD
 1dHmTgOsyrAdaoJ/HfU2Jl5vi2RTDzMOA2UPIx9ZEnZ+i9ppy/e+krSv6Yr4Fqx7iifd/p
 ort17rQNqMw3kxqdlkepxfBoybEiAF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-rJMd3JHpPVyyQdEayRp3iA-1; Wed, 22 Jan 2020 16:14:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B726ADBA3;
 Wed, 22 Jan 2020 21:14:40 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E0BF19C70;
 Wed, 22 Jan 2020 21:14:40 +0000 (UTC)
Subject: Re: [PATCH v4 06/11] tests/virtio-9p: added splitted readdir test
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <f6394833fa66bf6a73d204db34302732a5f6b98a.1579567020.git.qemu_oss@crudebyte.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5dac4bf8-64aa-708e-d546-1eaea85bd792@redhat.com>
Date: Wed, 22 Jan 2020 15:14:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f6394833fa66bf6a73d204db34302732a5f6b98a.1579567020.git.qemu_oss@crudebyte.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: rJMd3JHpPVyyQdEayRp3iA-1
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 6:16 PM, Christian Schoenebeck wrote:
> The previous, already existing readdir test simply used a 'count'
> parameter big enough to retrieve all directory entries with a
> single Treaddir request.
> 
> In this new 'splitted' readdir test, directory entries are

English is weird; the past tense of 'split' is 'split', not 'splitted'

> retrieved, splitted over several Treaddir requests by picking small

and again

> 'count' parameters which force the server to truncate the response.
> So the test client sends as many Treaddir requests as necessary to
> get all directory entries. Currently this test covers actually two
> tests: a sequence of Treaddir requests with count=512 and then a
> subsequent test with a sequence of Treaddir requests with count=256.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>   tests/qtest/virtio-9p-test.c | 91 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 91 insertions(+)
> 

>   
> +/* readdir test where overall request is splitted over several messages */

and again

> +static void fs_readdir_split(void *obj, void *data, QGuestAllocator *t_alloc)
> +{
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


