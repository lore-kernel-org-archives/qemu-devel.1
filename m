Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2C8C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 21:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84014214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 21:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axi0PGlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84014214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0BF1-00088o-Ml
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 16:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j0BDx-0006ik-Ar
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j0BDv-00031j-JP
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:31:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60134
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j0BDv-00030F-FK
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581111098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LV5yZOsCNcOVNwOZ+xxdoqGuGudtGoUWyic/Jn4ffo8=;
 b=axi0PGlW5K/PXw+sdYvXIdxxnGDFVmUTJzHtR9/abnOdpylzRQwBVhTK2ut+wTpLSDCIF+
 NnIrRGb9s5I3fes1lkYtbtu/Gdyvqj65hTrCUlNL0quF25XYP/MgQcfF1B0y+IFJukYVLB
 odCJRlU7pZvGlhvJzjvdZiN72mlx4j8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-wxfmn8UbNu6nhM1v3F3dDQ-1; Fri, 07 Feb 2020 16:31:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1941BDB61;
 Fri,  7 Feb 2020 21:31:32 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6C6E5DA7D;
 Fri,  7 Feb 2020 21:31:23 +0000 (UTC)
Subject: Re: qmp-shell for GSoC/Outreachy?
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com> <20200127143505.GD5669@linux.fritz.box>
 <20200127202925.GE3419@work-vm> <20200128105932.GC6431@linux.fritz.box>
 <20200205130946.GC5768@dhcp-200-226.str.redhat.com>
 <a45df5ab-3cad-0fbe-901f-4bc1ba28d38e@redhat.com>
 <20200205194944.GP3210@work-vm> <877e10xdd6.fsf@dusky.pond.sub.org>
 <20200206181836.GK3655@work-vm>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3035d327-51e2-bc2b-ff62-4eabd617334b@redhat.com>
Date: Fri, 7 Feb 2020 15:31:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206181836.GK3655@work-vm>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: wxfmn8UbNu6nhM1v3F3dDQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 12:18 PM, Dr. David Alan Gilbert wrote:

>>
>> Pain points of JSON include having to count parenthesises and having to
>> quote so bloody much.  Additional QMP pain points include long names and
>> excessive nesting.
> 
> Some other pet hates:
>    a) Number formats are awful for our uses
>    b) Lack of room for comments

Both permitted in JSON5.  Converting valid JSON5 into the stricter JSON 
is lossy when it comes to comments, but as comments don't affect machine 
meaning, maybe all the more it requires is an argument to 
qmp_capabilities stating whether the rest of the session will stick to 
strict JSON or prefer JSON5.

>> We could make quoting optional for certain string literals.

Hmm - JSON5 makes quoting optional for keys in { key:value }, but not 
values.

And one of the reasons why my QAPIfication of netdev was NOT committed 
was that the original code allowed both "item":1 and "item":"1" in the 
QemuOpts world, and we were torn on whether letting QMP accept both 
integer and string-that-parses-as-integer was acceptable.

>>  Simple
>> enough for literals that can only be a string, like abc.  For literals
>> that could be something else like 123 or true, omitting quotes creates
>> ambiguity.  When the schema accepts only one of the possible types, the
>> ambiguity goes away.  Complexity stays, however.

Do we even allow an alternate that permits both a string and a number at 
once? I thought you tightened qapi to reject that because of the 
potential for ambiguity.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


