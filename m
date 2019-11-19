Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32587C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFCF7222B0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JezTq0Tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCF7222B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX4Rx-0003aZ-Ki
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 09:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iX4Gk-0007ZB-SP
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:14:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iX4Gh-0005lQ-TV
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:14:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37003
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iX4Gh-0005kk-I1
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574172849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0Qs8W37DwO3DW6+z2souvY6iSbz4VMSbVtKZlZQ2As=;
 b=JezTq0Tj0eA5rhh+gOOe43es/LV8rqyqvNo8U5P6pSZrZlq2PXPe+SFjIcCkLdjPb3lrcQ
 /Q4OG4CKQ7PJ1i2/zGF5uBRE22Qnsx92CK1U6DN9Q94cBaJzI99gQbHXHjvo+BUu0TvykQ
 shun/nJ5OWTamDSqJwihzaPxhx2Th1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-yEWClf3oNOyrX5MLlM-evg-1; Tue, 19 Nov 2019 09:14:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 748AF107B008;
 Tue, 19 Nov 2019 14:14:02 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E5074D;
 Tue, 19 Nov 2019 14:14:01 +0000 (UTC)
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Taylor Simpson <tsimpson@quicinc.com>, laurent@vivier.eu,
 riku.voipio@iki.fi, qemu-devel@nongnu.org
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <811eb939-d793-a03a-4ea9-0579d8babe52@redhat.com>
Date: Tue, 19 Nov 2019 08:14:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: yEWClf3oNOyrX5MLlM-evg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 5:58 PM, Taylor Simpson wrote:

In addition to what others have said, you have an atypical and long=20
subject line. You'll want to rewrite it to match more typical subject=20
lines (around 65 characters) then a blank line then the additional=20
details.  'git shortlog -30' might give you some ideas on how to do it;=20
you'll probably want to use 'hexagon:' as your prefix.

> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---

>   31 files changed, 2184 insertions(+)

That's a big patch.  How much of it is copied verbatim from elsewhere=20
and how much is new code? Splitting the patch along those lines makes=20
review of the non-copied portion easier.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


