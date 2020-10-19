Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26413C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6278C223EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKB3mU3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6278C223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUbt8-0004jC-8e
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 16:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kUbsR-0004AZ-LZ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kUbsO-0004Nh-QC
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603139727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTUu9QvrNkYv40O6iKHau2L0wvTijiBSehqfHgFDpiI=;
 b=EKB3mU3ErLNRZWjqlMdXFvCdotqNQ//caEzubnHCNZcuQvZvwauYmBUHE7EUjIXC8fILoe
 y3OQwUIHsP43E20tcVcdp1hohL805u/onL2ks03evs2rNcXtQ9YN3mtIQ2KrHQ+jhe+DLu
 MEj/zWB4cgor8lliZYHU4WD1l0EgK+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-nkYYGVQrP7ivY44r9cMAVA-1; Mon, 19 Oct 2020 16:35:22 -0400
X-MC-Unique: nkYYGVQrP7ivY44r9cMAVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6291A8049CB;
 Mon, 19 Oct 2020 20:35:21 +0000 (UTC)
Received: from [10.3.112.28] (ovpn-112-28.phx2.redhat.com [10.3.112.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EED7710013C1;
 Mon, 19 Oct 2020 20:35:20 +0000 (UTC)
Subject: Re: [PATCH 6/30] semihosting: Fix Lesser GPL version number
To: Chetan Pant <chetan4windows@gmail.com>, qemu-trivial@nongnu.org
References: <20201016143509.26692-1-chetan4windows@gmail.com>
 <20201016144243.26817-1-chetan4windows@gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9a927711-58b5-c891-9713-dd735ec9fb59@redhat.com>
Date: Mon, 19 Oct 2020 15:35:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016144243.26817-1-chetan4windows@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 15:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 9:42 AM, Chetan Pant wrote:
> There is no "version 2" of the "Lesser" General Public License.

Meta-comment: Looking in the archives, I see some odd threading going on:

https://lists.gnu.org/archive/html/qemu-devel/2020-10/threads.html#04020

You sent 1/30 and 2/30 as independent threads, then deeply threaded 
3-8/30, but I don't see a 0/30 cover letter, nor 9-30/30.

When you use deep threading, it gets awkward to read replies in mailers 
that group by thread depth before date:

+ 1/30
  \+ re: 1/30
+ 2/30
  \+ re: 1/30
+ 3/30
| + 4/30
| | + 5/30
| | | + 6/30
| | | | + 7/30
| | | | | + 8/30
| | | | |  \+ re: 8/30
| | | |  \+ re: 7/30
| | |  \+ re: 6/30
| |  \+ re: 5/30
|  \+ re: 4/30
  \+ re: 3/30

instead of the more typical

+ 0/30
| + 1/30
|  \+ re: 1/30
| + 2/30
|  \+ re: 2/30
| + 3/30
|  \+ re: 3/30
| + 4/30
|  \+ re: 4/30
...
| + 30/30
|  \+ re: 30/30
  \+ re: 0/30

Figuring out how to make your mailer thread properly will make it easier 
to interact with your future patches.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


