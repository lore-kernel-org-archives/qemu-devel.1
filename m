Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB87C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E7E206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9z+nQAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E7E206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxv1-0001OU-GR
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1juxuQ-0000om-Lc
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:50:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54815
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1juxuP-0003HA-9v
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594644612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zqXH1ORjcDYtWDuUstpRMDPSFKuiAEl7C96w2+INf8U=;
 b=J9z+nQAlqsetGS0a0La70Zdgl9xeCFkKYZMdgmhxca6yGw9uLoTp/5C8h6E0A58WSw849h
 b8ympPAlUzfcXzLOFglRiKXC0IFF7Wz5qKDGhHzkg6pLXBjp8fSMqumumnS2q+0SBP/sHT
 iDPMABdHbqVnLV/6pckaqdi4mbtDqZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-j-GVEVH-N6-EcvRcQz3MNQ-1; Mon, 13 Jul 2020 08:50:10 -0400
X-MC-Unique: j-GVEVH-N6-EcvRcQz3MNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A23419200C3;
 Mon, 13 Jul 2020 12:50:08 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-91.ams2.redhat.com [10.36.114.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1CAD5BAD5;
 Mon, 13 Jul 2020 12:50:06 +0000 (UTC)
Date: Mon, 13 Jul 2020 14:50:05 +0200
From: Kevin 'Max' Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] fixup! iotests: Specify explicit backing format where
 sensible
Message-ID: <20200713125005.GA10318@linux.fritz.box>
References: <20200709121713.283092-1-kwolf@redhat.com>
 <20200713114031.137846-1-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200713114031.137846-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 "open list:Block layer core" <qemu-block@nongnu.org>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.07.2020 um 13:40 hat Eric Blake geschrieben:
> Max spotted that I didn't test -qed...
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

I guess I have a new name now... :-)

Kevin^WMax


