Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B023C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC3820936
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eftTfU6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC3820936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLAEs-0001QC-SU
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 15:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLAE0-0000zi-MF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 15:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLADz-000698-4u
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 15:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600888482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HrFQxLFKN+xhNX4fDGeA0mDgysAqqRjT+cKROj9eyyQ=;
 b=eftTfU6FD2RSWvVZFMuvH/6xiaWYr8AEQhh37vGo/YIgFbUbUqWv74qCLr5+hpbNgJWY63
 vgMIv0TgMhW1jkPrQSoQwUGGK/OvnslcGO1R3gF/t6HyYEY80RQme3076nYwBQfKmLqZmn
 bjd1MTd9vTLJE1ko0uDZbIcR37voUIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-TG0bFKxtOo6HK8L1fpLDBA-1; Wed, 23 Sep 2020 15:14:38 -0400
X-MC-Unique: TG0bFKxtOo6HK8L1fpLDBA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2553D802B67;
 Wed, 23 Sep 2020 19:14:37 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB5EF5D990;
 Wed, 23 Sep 2020 19:14:36 +0000 (UTC)
Date: Wed, 23 Sep 2020 15:14:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 35/38] qapi/types.py: remove one-letter variables
Message-ID: <20200923191436.GX3312949@habkost.net>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-36-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-36-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 05:00:58PM -0400, John Snow wrote:
> "John, if pylint told you to jump off a bridge, would you?"
> Hey, if it looked like fun, I might.
> 
> Now that this file is clean, enable pylint checks on this file.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
[...]
> @@ -148,11 +148,12 @@ def gen_object(name: str, ifcond: List[str],
>      objects_seen.add(name)
>  
>      ret = ''
> -    if variants:
> -        for v in variants.variants:
> -            if isinstance(v.type, QAPISchemaObjectType):
> -                ret += gen_object(v.type.name, v.type.ifcond, v.type.base,
> -                                  v.type.local_members, v.type.variants)
> +    for variant in variants.variants if variants else ():

I'm not sure I like this weird expression, but I believe asking
for a 120-patch cleanup series to be respun because of a tiny
style issue would be counterproductive, so:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> +        obj = variant.type
> +        if not isinstance(obj, QAPISchemaObjectType):
> +            continue
> +        ret += gen_object(obj.name, obj.ifcond, obj.base,
> +                          obj.local_members, obj.variants)
>  
>      ret += mcgen('''
>  
> -- 
> 2.26.2
> 

-- 
Eduardo


