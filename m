Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023B3C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F41206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnA8EcYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F41206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVhJ-0002vd-UW
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYVgJ-0001uF-DL
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:14:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41068
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYVgI-0001oz-J5
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589292889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cqIZziXjDq6xngfpi8QxBKaFsu/zeS2KJd4tmFTWG9g=;
 b=DnA8EcYuVIfzhsqk5pBulKhqRayP657xP+VNouAdAlnQTFVTa6NTwfey+ecFmLhNCujr2Z
 1EupOBzAKDTlp2W1l+g+hfU+PiBWXbpNkgXrCvU5W+1eE9Acf+fWTeBCmKbUHL2/wceicq
 IUkWCwZ8uRSLUndxllp6MXSTwJgMCM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-cRU_kbLSMyG9PxEpD_q0fA-1; Tue, 12 May 2020 10:14:45 -0400
X-MC-Unique: cRU_kbLSMyG9PxEpD_q0fA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBF1CEC1A0;
 Tue, 12 May 2020 14:14:43 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D837F7840A;
 Tue, 12 May 2020 14:14:42 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] qemu-img: remove check that cvtnum value > MAX_INT
To: Eyal Moscovici <eyal.moscovici@oracle.com>
References: <59b0896d-85ad-08b5-fcc1-36adad7501a4@redhat.com>
 <20200506213459.44743-1-eyal.moscovici@oracle.com>
 <20200506213459.44743-2-eyal.moscovici@oracle.com>
 <f4131818-f606-2b30-ef69-d9612fb66a80@redhat.com>
 <d136e935-d8af-1710-c1c4-5bc6bc3b9303@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a0bf26ee-076e-443c-d56a-96f585922d09@redhat.com>
Date: Tue, 12 May 2020 09:14:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d136e935-d8af-1710-c1c4-5bc6bc3b9303@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, liran.alon@oracle.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 4:39 AM, Eyal Moscovici wrote:

>>> +++ b/qemu-img.c
>>> @@ -4307,7 +4307,7 @@ static int img_bench(int argc, char **argv)
>>>               int64_t sval;
>>>                 sval = cvtnum(optarg);
>>> -            if (sval < 0 || sval > INT_MAX) {
>>> +            if (sval < 0) {
>>>                   error_report("Invalid buffer size specified");
>>
>> INT_MAX is smaller than cvtnum's check for INT64_MAX.  This code 
>> change allows larger buffer sizes, which is probably not a good idea.
> I was the most hesitant about this patch because of the size difference. 
> I decided to submit it because the type is int64 which pairs better with 
> the MAX_INT64 check and I couldn't find a concrete reason to cap the 
> variable at MAX_INT. Do you a concrete reason? Because the max size 
> should rerally come into effect on very fringe cases and if you are 
> asking for a really big buffer you should know the risks.

The commit message does not call out a change in behavior.  If you are 
sure that you want a change in behavior, then justify that: mention that 
your patch specifically changes the behavior to allow larger buffers, 
and why that is okay.  Otherwise, it looks like your patch is accidental 
in its behavior change, which costs reviewer time.

In this particular case, I see no reason to allow larger buffers.  That 
is, the existing limits made sense (benchmarking anything larger than 
the maximum qcow2 cluster size of 2M is unlikely to produce useful 
results, let alone something as large as 2G, so allowing > 2G is not 
helping the user).  So even if your commit message did a good job of 
explaining that the change was intentional, it is a tough sell why we 
need it.  If all your commit is intended to do is refactoring, then it 
should not be changing behavior.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


