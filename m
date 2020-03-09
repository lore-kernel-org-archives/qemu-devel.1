Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA070C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A617021655
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4nJM8hM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A617021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJvV-0000jk-Pm
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jBJuE-00085o-JF
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jBJuC-0001oP-9s
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:01:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jBJuA-0001lB-Lt
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583766077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7b272g9GVQ61MfTMLnehTAsHJkzwkwhOS2K38V+C1e0=;
 b=K4nJM8hMGWirGV7/6/K0PBjvcP+SalGBR+CO9YCcIAy9dr+HdzeAotofCJruZq/KP/0TFt
 f66mc1Az4rba2aclXpetRhdLtqoXn2LqeKWEVYfvi6bkyXolXByuv228xmcUVR0gJXr0vW
 ZMVNKnsspNQjR/WByuICPboeewMRwn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-J4LJHbnMMhGR3cDjVxSwPA-1; Mon, 09 Mar 2020 11:01:13 -0400
X-MC-Unique: J4LJHbnMMhGR3cDjVxSwPA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 569F4800D5A;
 Mon,  9 Mar 2020 15:01:12 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4F905C28E;
 Mon,  9 Mar 2020 15:01:11 +0000 (UTC)
Subject: Re: [PATCH v8 1/9] qemu-binfmt-conf.sh: enforce safe style consistency
To: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org
References: <20200307172248.GA9@afee69d503a7>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1ba522c6-cae8-9e1f-ebf4-696076d2ca45@redhat.com>
Date: Mon, 9 Mar 2020 10:01:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307172248.GA9@afee69d503a7>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/7/20 11:22 AM, Unai Martinez-Corral wrote:
> Spaces are added before '; then', for consistency.

For consistency with what?  This is not our prevailing style; as 
evidenced by this pre-patch search:

$ git grep 'if \[.*\];' | wc
     274    2186   18170
$ git grep 'if \[.*\] ;' | wc
      25     256    1573

and you are diverging from the dominant pattern.

> 
> All the tests are prefixed with 'x', in order to avoid risky comparisons
> (i.e. a user deliberately trying to provoke a syntax error).

This part, however, is good.  Since one part is controversial, you may 
want to split this into two patches, or even drop the reformatting part.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


