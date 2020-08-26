Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E8FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B752078A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhBHUitW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B752078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxYd-0007bV-6F
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kAxXc-0006iQ-Va
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kAxXb-00083j-1I
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598456445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2KmRj2LQf0Y/KS5UhVapOYxCaH2OuIwNgQAyeUbaYc=;
 b=AhBHUitWI7d4tQckFDp+ToDDTDkpMhKlmdL2CvDPQuSAeiVWZFXTB+7klR/LZO7ih2VXGO
 d5nV7pKzhvGSYutfRKmoWC3qGI8qvSW96Is7Na47FY2gaI3dguZNrpkGrNxgPwjHNOtLf7
 gPMzxAC/5A9z745zSWsE+PgS2HI7LjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-8M1_1IX4Ona8E5TsgmwlKQ-1; Wed, 26 Aug 2020 11:40:43 -0400
X-MC-Unique: 8M1_1IX4Ona8E5TsgmwlKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A001A100746B;
 Wed, 26 Aug 2020 15:40:42 +0000 (UTC)
Received: from [10.10.112.89] (ovpn-112-89.rdu2.redhat.com [10.10.112.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D744477C1C;
 Wed, 26 Aug 2020 15:40:41 +0000 (UTC)
Subject: Re: Contributor wanting to get started with simple contributions
To: Rohit Shinde <rohit.shinde12194@gmail.com>, qemu-devel@nongnu.org
References: <CA+Ai=tAypbso9yMy0jtyzbeHCweQ1FPgDaJ8=bXxFvBA6pZyLA@mail.gmail.com>
 <CA+Ai=tBJqLB7yDbd-kqzDhr+d+65K9r3DQsZrB2kGi9wF8BaiA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2a80090b-295b-4f57-df3e-5923506cce80@redhat.com>
Date: Wed, 26 Aug 2020 11:40:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+Ai=tBJqLB7yDbd-kqzDhr+d+65K9r3DQsZrB2kGi9wF8BaiA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 23:30:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/24/20 10:26 PM, Rohit Shinde wrote:
> Hey John,
> 

Hi Rohit!

> I sent this email a couple of weeks ago to the qemu mailing list since I 
> didn't really know who to approach.
> 

Sorry, I didn't see a mail. The volume is quite high and I missed it. 
For Python issues, the usual suspects are:

Me (Lately),
Markus Armbruster (Primarily around the QAPI parser),
Cleber Rosa (Primarily around VM tests),
Eduardo Habkost (In general).

> I am interested in contributing to the python-qemu package. I have quite 
> a bit of experience in Python, but no experience in packaging libraries. 

I must admit I am also quite new to packaging python, but I'm learning 
as I go. For now, we do not have any published package so we do not need 
to maintain any kind of stable API, but there are many places in the 
QEMU source tree that rely on the python packages and must keep working.

> Whatever you mentioned in the reply to my comment on the bug, was pretty 
> interesting. I would like to get started with at least ensuring that all 
> python code is flake8/pylint compliant.
> 

OK! I have some patches in progress, let me clean them up for post-5.1 
and I will CC you when I send them. I have been on PTO for a little 
while and was focused on another project, so they have to be resurrected 
a little bit.

I will likely continue to be distracted by other projects, so if you are 
able to help with some of the Python refactoring/redevelopment that will 
be a good help.

> Do let me know what you think of this.
> 

Sure, stay tuned.

> Thanks,
> Rohit.
> 

> On Thu, Aug 13, 2020 at 7:18 AM Rohit Shinde 
> <rohit.shinde12194@gmail.com <mailto:rohit.shinde12194@gmail.com>> wrote:
> 
>     Hello everyone,
> 
>     I am a hobby programmer (working as an SDE in the industry) and I
>     have been observing qemu for quite a while. I have always wanted to
>     contribute but I couldn't manage my time. I am good at Java and
>     Python but quite a bit rusty with C++ and C (although working with
>     it will not be a problem, I might have to google more than usual).
>     On the theory side, I have a good grasp of data structures and
>     algorithms and a decent understanding of OS and Compilers.
> 
>     I have built qemu from source and I have my machine setup for
>     git-publish via email.
> 
>     I would like to start contributing with one of the bite sized tasks
>     mentioned in the wiki page. The one that interests me and which I
>     think is the easiest are the sections on "Compiler Driven Cleanup"
>     and "Dead Code Removal". I think this is a good way to get
>     introduced to the codebase.
> 
>     I plan to stay and become a long term contributor. Is there any CS
>     theory that I would need to know other than what I mentioned above?
>     Is it possible to "learn on the go"?
> 
>     I realize this is quite a long email and I would like to thank
>     everyone in advance for reading this!
> 
>     Regards,
>     Rohit.
> 


