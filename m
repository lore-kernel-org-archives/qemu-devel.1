Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35006C4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E42207C4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1moOXSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E42207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcUH-0000ti-OW
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLcEU-0006rg-CB
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 21:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLcER-0004nX-AU
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 21:09:05 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600996142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xb71NDI91Nw7FvUlU7JDiKXXQ6YzL1rzkQcv7u1Y6q0=;
 b=U1moOXSlRpe89blAjdkj6KGijPd3gGzuwc9lEWgb83rUnBZsCLErz3fv741kVa3NVliNQ+
 90iUDdTXeWE14HXsURN2P+nBF5UKRNS1o5H28XBkL70L1Zyrb+HfS/ai6mQD2RLgtENRnz
 gczpVXsOgroseaN8NWk+LLfcDVkoSVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-fBsSYKlDPvG_F8tOZMbr-Q-1; Thu, 24 Sep 2020 21:08:59 -0400
X-MC-Unique: fBsSYKlDPvG_F8tOZMbr-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A113D2FD02;
 Fri, 25 Sep 2020 01:08:58 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C93A5577A;
 Fri, 25 Sep 2020 01:08:58 +0000 (UTC)
Date: Thu, 24 Sep 2020 21:08:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 04/16] qapi/expr.py: Add assertion for union type
 'check_dict'
Message-ID: <20200925010857.GM3717385@habkost.net>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-5-jsnow@redhat.com>
 <20200923195322.GE3312949@habkost.net>
 <a296d090-634d-f6f4-7aa7-fa6f510eb7f9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a296d090-634d-f6f4-7aa7-fa6f510eb7f9@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 08:47:31PM -0400, John Snow wrote:
> On 9/23/20 3:53 PM, Eduardo Habkost wrote:
> > On Tue, Sep 22, 2020 at 05:13:01PM -0400, John Snow wrote:
> > > mypy isn't fond of allowing you to check for bool membership in a
> > > collection of str elements. Guard this lookup for precisely when we were
> > > given a name.
> > > 
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >   scripts/qapi/expr.py | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> > > index f6b55a87c1..67892502e9 100644
> > > --- a/scripts/qapi/expr.py
> > > +++ b/scripts/qapi/expr.py
> > > @@ -166,7 +166,9 @@ def check_type(value, info, source,
> > >           raise QAPISemError(info,
> > >                              "%s should be an object or type name" % source)
> > > -    permit_upper = allow_dict in info.pragma.name_case_whitelist
> > > +    permit_upper = False
> > > +    if isinstance(allow_dict, str):
> > > +        permit_upper = allow_dict in info.pragma.name_case_whitelist
> > 
> > Well, this keeps existing behavior, so:
> > 
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> > 
> > But: what exactly is the meaning of allow_dict=False,
> > allow_dict=True, and allow_dict being a string?
> > 
> > 
> 
> allow_dict = True -- allows the type to be an object describing the type.
> 
> allow_dict: str -- allows the type to be an object (like True), but also
> passes a name in for the purposes of validating the name with the pragma
> whitelist(!)

What.

-- 
Eduardo


