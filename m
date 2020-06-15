Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DC5C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DAB5207D4
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mc7VwHDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAB5207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkvth-0001XL-Hc
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 16:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jkvsk-0000jW-HJ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:39:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28862
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jkvsh-0000EQ-MJ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592253537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GScIE0T57EzY0KODXhaabdjUxQFXnaCqRSQsDm3R8lo=;
 b=Mc7VwHDi3n/s7+g5WysOJmJaKibTTgp0TdKK1/Oo0T/L4mjHX7Lex66odlsbF5l6oA2TfQ
 REwSCW7TwZ2cZdz3p4nxsr63X4CIfK2U91xqmQdu6Ku30aNp5lRglG5f1xq57kZIutximg
 jXeOeC+Ka3aEihkdM1PsQmWJzz0FHdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-yQNXFTlvPHaZR_IygzOELA-1; Mon, 15 Jun 2020 16:38:41 -0400
X-MC-Unique: yQNXFTlvPHaZR_IygzOELA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB7241091320;
 Mon, 15 Jun 2020 20:38:40 +0000 (UTC)
Received: from [10.3.112.27] (ovpn-112-27.phx2.redhat.com [10.3.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 021D419C79;
 Mon, 15 Jun 2020 20:38:39 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] nbd/server: Avoid long error message assertions
 CVE-2020-10761
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200610163741.3745251-1-eblake@redhat.com>
 <20200610163741.3745251-2-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1b590b1f-08b8-678f-c53d-794ca3dea812@redhat.com>
Date: Mon, 15 Jun 2020 15:38:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610163741.3745251-2-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 15:33:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, xuwei@redhat.com, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>, ppandit@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 11:37 AM, Eric Blake wrote:

> We may later want to further sanitize the user-supplied strings we
> place into our error messages, such as scrubbing out control
> characters, but that is less important to the CVE fix, so it can be a
> later patch to the new nbd_sanitize_name.
> 

> +static char *
> +nbd_sanitize_name(const char *name)
> +{
> +    if (strnlen(name, 80) < 80) {
> +        return g_strdup(name);
> +    }
> +    /* XXX Should we also try to sanitize any control characters? */
> +    return g_strdup_printf("%.80s...", name);

Max pointed out off-list that this can take a valid UTF-8 name from the 
client and truncate it mid-character to make our reply NOT valid UTF-8, 
which is a (minor) violation of the NBD protocol.  We have not yet 
implemented strict UTF-8 enforcement in qemu (neither our client nor 
server code takes pains to only send UTF-8, nor validates that incoming 
strings are valid UTF-8); and while the server would previously echo 
non-UTF-8 (where the client violated protocol first), this is now a case 
where the server can be coerced into violating protocol first.  I guess 
I may end up doing a followup patch that adds incoming validation and in 
the process avoids chopping a multi-byte character, but that's just as 
easy to fold in with my question about sanitizing control characters.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


