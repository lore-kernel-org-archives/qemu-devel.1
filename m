Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2BFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F192075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2Os+bWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F192075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6zC-0001o4-8J
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jb6u8-00020h-U3
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:23:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59339
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jb6u3-0000H4-Od
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589912627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQxhzkHnAklO3xlJCYrDvR3Lpxd85JN/EtaRMzTsUK0=;
 b=B2Os+bWirkIk1BK/OPhnefnHWGRBk1n+vJSzLA6unbVY6+1rrXWLFTb2MjAMkXebzTxrh9
 rU6XHo1TTfpTRmWr+eqETgonR2YBjOB4rp3Wd4LobzdI6Un/v+TUFl5XysbZQqII63/P5i
 8/X8XEkqu9og0DdkCXs7pP3cgQ/rA4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-BF9AGZQMOcq4usfjydkNlA-1; Tue, 19 May 2020 14:23:41 -0400
X-MC-Unique: BF9AGZQMOcq4usfjydkNlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EA0B39343;
 Tue, 19 May 2020 18:23:40 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D07210016EB;
 Tue, 19 May 2020 18:23:39 +0000 (UTC)
Subject: Re: [PULL v2 7/7] qemu-img: Add bitmap sub-command
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200519161840.810320-1-eblake@redhat.com>
 <20200519161840.810320-8-eblake@redhat.com>
 <9171373f-3761-ca77-3e3b-f7dbeaf84590@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <af9095ed-e47a-2414-c074-54e752377209@redhat.com>
Date: Tue, 19 May 2020 13:23:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9171373f-3761-ca77-3e3b-f7dbeaf84590@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 12:52 PM, Eric Blake wrote:
> On 5/19/20 11:18 AM, Eric Blake wrote:
>> Include actions for --add, --remove, --clear, --enable, --disable, and
>> --merge (note that --clear is a bit of fluff, because the same can be
> 
>> +        case 'g':
>> +            granularity = cvtnum(optarg);
>> +            if (granularity < 0) {
>> +                error_report("Invalid granularity specified");
>> +                return 1;
>> +            }
> 
> Phooey. I forgot to commit my changes before creating the tag. v3 pull 
> request coming up :(

For the record, I've now made it harder for myself to repeat this 
mistake, by doing:

$ cat > .git/hooks/sendemail-validate <<\EOF
#!/bin/sh
git diff-files --quiet --ignore-submodules -- ||
   { echo "You have unstaged changes."; exit 1; }
git diff-index --cached --quiet HEAD --ignore-submodules -- ||
   { echo "Your index contains uncommitted changes."; exit 1; }
$ chmod +x .git/hooks/sendemail-validate

[thanks to John Snow for advice on IRC]

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


