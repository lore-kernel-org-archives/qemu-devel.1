Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29440C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 04:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F052089E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 04:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=extremeground.com header.i=@extremeground.com header.b="3N+YWKFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F052089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=extremeground.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haY2S-0002v5-VX
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 00:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50185)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <gary@extremeground.com>) id 1haY0P-0002Gs-5p
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 00:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gary@extremeground.com>) id 1haXlQ-0002Z3-MO
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 23:48:01 -0400
Received: from ahs5.r4l.com ([158.69.52.156]:52455)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gary@extremeground.com>)
 id 1haXlQ-0002Vc-G0
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 23:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=extremeground.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+JFdWZBnN5PWuryjHsJDVe7jHlQzglUpTXz1gm5bBPU=; b=3N+YWKFmdFvgjkFAgDZ+B13paK
 0Pb399XjS1jRU+ZMRQPQ5NTM618JteFKv+c1vfR31uwgR1kAO4cTblmJZBjNsMHB0jwnWpIRc+80M
 YrVr68Zl/RPFQRrYFB0vrH+ewLztX0zfnUxW9DfLTg/Glhzq5mWw96YRmUrgFTzVD4yeNzo3bJt+3
 +p4/v2r6M7kJ/9sWSoeDGn8ol5xWNtNm/j11Z+JYD8DgCXMkifArCU/YjaVloSYY/a9NUAMDZTIwi
 m/XF3v5z3GtAoHquyBYNn41bBMa6wEcqPSV3nWTLSTawF5aJnwvJ23F1twdPSpAjHpvaPt+l1H4Ka
 0GVMAfSQ==;
Received: from cpeac202ed5e073-cmac202ed5e070.cpe.net.cable.rogers.com
 ([99.237.87.227]:38962 helo=[192.168.1.20])
 by ahs5.r4l.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.92) (envelope-from <gary@extremeground.com>)
 id 1haXlJ-0002BO-EU; Mon, 10 Jun 2019 23:47:53 -0400
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <abb7990e-0331-67a4-af92-05276366478c@extremeground.com>
 <20190610121941.GI14257@stefanha-x1.localdomain>
 <dc7a70ea-c94f-e975-df44-b0199da698e2@extremeground.com>
 <ab3e81c2-f0ce-2ef5-bbe7-948a87463b59@extremeground.com>
 <edf57b3a-660c-0964-2455-9461b9aa2711@redhat.com>
 <33b31422-1198-783a-cb15-8687a3f30199@extremeground.com>
 <0cd5c326-4d69-92fd-406d-d9fb8b08ccfc@redhat.com>
From: Gary Dale <gary@extremeground.com>
Message-ID: <04663a04-8009-f2c5-bad0-a2a42d6f0549@extremeground.com>
Date: Mon, 10 Jun 2019 23:47:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0cd5c326-4d69-92fd-406d-d9fb8b08ccfc@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - ahs5.r4l.com
X-AntiAbuse: Original Domain - nongnu.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - extremeground.com
X-Get-Message-Sender-Via: ahs5.r4l.com: authenticated_id:
 gary@extremeground.com
X-Authenticated-Sender: ahs5.r4l.com: gary@extremeground.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 158.69.52.156
Subject: Re: [Qemu-devel] kvm / virsh snapshot management
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-06-10 8:10 p.m., Eric Blake wrote:
> On 6/10/19 6:00 PM, Gary Dale wrote:
>
>>>> Any ideas on what I'm doing wrong?
>>> Do you know for sure whether you have internal or external snapshots?
>>> And at this point, your questions are starting to wander more into
>>> libvirt territory.
>>>
>> Yes. I'm using internal snapshots. From your other e-mail, I gather that
>> the (only) benefit to blockcommit with internal snapshots would be to
>> reduce the size of the various tables recording changed blocks. Without
>> a blockcommit, the L1 tables get progressively larger over time since
>> they record all changes to the base file. Eventually the snapshots could
>> become larger than the base image if I don't do a blockcommit.
> Not quite. Blockcommit requires external images. It says to take this
> image chain:
>
> base <- active
>
> and change it into this shorter chain:
>
> base
>
> by moving the cluster from active into base.  There is no such thing as
> blockcommit on internal snapshots, because you don't have any backing
> file to push into.
>
> With internal snapshots, the longer an L1 table is active, the more
> clusters you have to change compared to what was the case before the
> snapshot was created - every time you change an existing cluster, the
> refcount on the old cluster decreases and the change gets written into a
> new cluster with refcount 1.  Yes, you can reach the point where there
> are more clusters with refcount 1 associated with your current L1 table
> than there are clusters with refcount > 1 that are shared with one or
> more previous internal snapshots. But they are not recording a change to
> the base file, rather, they are recording the current state of the file
> where an internal snapshot says to not forget the old state of the file.
>   And yes, a qcow2 file with internal snapshots can require more disk
> space than the amount of space exposed to the guest.  But that's true
> too with external snapshots (the sum of the space required by all images
> in the chain may be larger than the space visible to the guest).


OK. I think I'm getting it now. Thanks for your help. I just wish there 
was some consistent documentation that explained all this. The Red Hat 
stuff seems to assume that you understand it only applies to external 
snapshots and the virsh man page seems to do the same.


