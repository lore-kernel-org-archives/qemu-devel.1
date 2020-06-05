Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8601CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 21:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509BD206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 21:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnYexZk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509BD206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhKH8-0004CK-Iu
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 17:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jhKG2-0002mM-Vd
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 17:52:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47265
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jhKG0-0003fa-Sk
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 17:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591393927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5dMG9qIndKHUEPY36afaIz6UnK796I7mplnX5vGor4=;
 b=EnYexZk2wbfc2vnN8BD/fovCsjqeNpciv750niUhCFewgRol+s1rwvADrH1AqJ+KeE/GYS
 EriX0eQmpYAmmDTjEOMohzteO5lMj71KimRfoo8L4mPZbwpmeFgxUx6HXvrWxcqH8z2QFf
 a3ZptLyiq9Vz61ixPKhCrbC6r1Rr9K0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-lyk5S5TPMjiBkRJ277rwxw-1; Fri, 05 Jun 2020 17:51:41 -0400
X-MC-Unique: lyk5S5TPMjiBkRJ277rwxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E862A8018AB;
 Fri,  5 Jun 2020 21:51:40 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74BE419C58;
 Fri,  5 Jun 2020 21:51:34 +0000 (UTC)
Subject: Re: [PATCH RFC v2 0/5] block: add block-dirty-bitmap-populate job
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514034922.24834-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d36e7081-4de9-4f35-d1f1-b780e75739c9@redhat.com>
Date: Fri, 5 Jun 2020 16:51:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514034922.24834-1-jsnow@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 16:19:25
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 vsementsov@virtuozzo.com, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 10:49 PM, John Snow wrote:
> Hi,
> 
> This is a new (very small) block job that writes a pattern into a
> bitmap. The only pattern implemented is the top allocation information.
> 
> This can be used to "recover" an incremental bitmap chain if an external
> snapshot was taken without creating a new bitmap first: any writes made
> to the image will be reflected by the allocation status and can be
> written back into a bitmap.
> 
> This is useful for e.g. libvirt managing backup chains if a user creates
> an external snapshot outside of libvirt.
> 
> v2:
>   - Addressed some, but not all feedback
>   - Rebased on latest 'job-runner' series; but it's not clear if it
>     should be kept.

Message-id for that series? I'm not finding a message with a subject 
containing a literal 'job-runner', but am not sure which subject to look 
for instead.

I also couldn't find an obvious tag or branch at 
https://github.com/jnsnow/qemu/branches where you might have stashed 
this including prerequisites.

>   - This version doesn't address all of the feedback from v1,
>     but I am posting it to the list as an RFC.

I'm happy to try and take over these patches to prepare a v3, but only 
if I can get them to build by finding the prerequisites :)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


