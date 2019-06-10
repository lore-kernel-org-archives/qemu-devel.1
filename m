Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD14C4321A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 23:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C7C20645
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 23:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=extremeground.com header.i=@extremeground.com header.b="t/Eq574K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C7C20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=extremeground.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50224 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haTJ0-0007hW-C9
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 19:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52274)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <gary@extremeground.com>) id 1haTHJ-0007BN-GJ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 19:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gary@extremeground.com>) id 1haTHC-0001Rv-Jj
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 19:00:33 -0400
Received: from ahs5.r4l.com ([158.69.52.156]:38757)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gary@extremeground.com>)
 id 1haTH8-0001OY-Nn
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 19:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=extremeground.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JlrcWl1eK+Q+zlhb6QH4rHkppolRedg6FPwBpwo9jkM=; b=t/Eq574KAU18MSvNwjIqy4nLkI
 82XGQkRO0vZvdb60QtQ62QbfkhW6ezVPBzLRjMtstc79SRX1gbpTsfBYyHcc7JY/fVBk+Zumy6Vxt
 BpgdQC+tdqYrjKajr14kojAO8pmTRH9ufV1/lxfgcz5eols2ifdjtJTzBAjYqQJjrWOGvD4TwO/gf
 zWUqhCACFOL0NV0SfpcCmuvzyyj8qfanJp3o2STF6kZlJfFjSRyktvXvgVWVtIJeg64sdfIq1vxsv
 RjZ+CE7Cs51+TvKC47ZKWi/F94//TpAt+Bd8zDf/ibQfJVuK16eyGAoBwJr/6i8kc9Q6GyW/CTnCB
 vgpEfwvQ==;
Received: from cpeac202ed5e073-cmac202ed5e070.cpe.net.cable.rogers.com
 ([99.237.87.227]:36588 helo=[192.168.1.20])
 by ahs5.r4l.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.92) (envelope-from <gary@extremeground.com>)
 id 1haTH4-0003Mk-BV; Mon, 10 Jun 2019 19:00:22 -0400
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <abb7990e-0331-67a4-af92-05276366478c@extremeground.com>
 <20190610121941.GI14257@stefanha-x1.localdomain>
 <dc7a70ea-c94f-e975-df44-b0199da698e2@extremeground.com>
 <ab3e81c2-f0ce-2ef5-bbe7-948a87463b59@extremeground.com>
 <edf57b3a-660c-0964-2455-9461b9aa2711@redhat.com>
From: Gary Dale <gary@extremeground.com>
Message-ID: <33b31422-1198-783a-cb15-8687a3f30199@extremeground.com>
Date: Mon, 10 Jun 2019 19:00:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <edf57b3a-660c-0964-2455-9461b9aa2711@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2019-06-10 6:07 p.m., Eric Blake wrote:
> On 6/10/19 4:27 PM, Gary Dale wrote:
>
>> Trying this against a test VM, I ran into a roadblock. My command line
>> and the results are:
>>
>> # virsh blockcommit stretch "/home/secure/virtual/stretch.qcow2" --top
>> stretchS3 --delete --wait
>> error: unsupported flags (0x2) in function qemuDomainBlockCommit
>>
>> I get the same thing when the path to the qcow2 file isn't quoted.
> That's a libvirt limitation - the --delete flag is documented from the
> generic API standpoint, but not (yet) implemented for the qemu driver
> within libvirt. For now, you have to omit --delete from your virsh
> command line, and then manually 'rm' the unused external file after the
> fact.
Which is not possible since I'm using internal snapshots.
>
>> I noted in
>> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/virtualization_administration_guide/sub-sect-domain_commands-using_blockcommit_to_shorten_a_backing_chain
>> that the options use a single "-".
> Sounds like a bug in that documentation.

Yes, and the man page also seems to be wrong. The section on blockcommit 
begins:

blockcommit domain path [bandwidth] [--bytes] [base] [--shallow] [top] 
[--delete]
        [--keep-relative] [--wait [--async] [--verbose]] [--timeout 
seconds] [--active]
        [{--pivot | --keep-overlay}]
            Reduce the length of a backing image chain, by committing 
changes at the top of the
            chain (snapshot or delta files) into backing images. By 
default, this command
            attempts to flatten the entire chain.

In addition to "[base]" actually being "[--base base]" and "[top]" being 
"[--top top]", the description of what it does only applies to external 
snapshots. Similar things are wrong in the blockpull section.

>
>> However the results for that were:
>> # virsh blockcommit stretch /home/secure/virtual/stretch.qcow2 -top
>> stretchS3 -delete -wait
>> error: Scaled numeric value '-top' for <--bandwidth> option is malformed
>> or out of range
>>
>> which looks like virsh doesn't like the single dashes and is trying to
>> interpret them as positional options.
>>
>> I also did a
>>
>> # virsh domblklist stretch
>> Target     Source
>> ------------------------------------------------
>> vda        /home/secure/virtual/stretch.qcow2
>> hda        -
>>
>> and tried using vda instead of the full path in the blockcommit but got
>> the same error.
>>
>> Any ideas on what I'm doing wrong?
> Do you know for sure whether you have internal or external snapshots?
> And at this point, your questions are starting to wander more into
> libvirt territory.
>
Yes. I'm using internal snapshots. From your other e-mail, I gather that 
the (only) benefit to blockcommit with internal snapshots would be to 
reduce the size of the various tables recording changed blocks. Without 
a blockcommit, the L1 tables get progressively larger over time since 
they record all changes to the base file. Eventually the snapshots could 
become larger than the base image if I don't do a blockcommit.

