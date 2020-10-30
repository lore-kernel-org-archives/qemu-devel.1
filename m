Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F774C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39182071A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CY2kivLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39182071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYW3f-0007tT-39
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kYW2B-0006J8-Bl
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kYW28-00068p-Um
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604070579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOZt6gxI+IVMLLEFOLbTS64ENO3Fu4D2rK5pOM1i+ds=;
 b=CY2kivLCvCULu5ngw1wp7a+UdkhZq/gacS3Cqd0GN3WMvB14WSbkzmlPAJu57jBH2xz3er
 5umMn/LETQ50j0Pbv6xfcmBnLc6X3x7JVLjMAn084EH8nQLERV9u1XqZ+jA1jzcI7wp8F1
 WHe/lTDj7O6HkHn1ZEkBY7LQiL9GFwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-jQ6TNSlaPPajkNu1vmu3jg-1; Fri, 30 Oct 2020 11:09:36 -0400
X-MC-Unique: jQ6TNSlaPPajkNu1vmu3jg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDEC118C9F4F;
 Fri, 30 Oct 2020 15:09:10 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B46C5C1CF;
 Fri, 30 Oct 2020 15:09:10 +0000 (UTC)
Subject: Re: QEMU release tagging script?
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <e8b378a2-144c-e915-3e5e-c84c9e9a17b5@redhat.com>
 <CAFEAcA8cc_C6aKkO0n=Z_b3ais6AE0VSvZD1TZweAzhocm6aTg@mail.gmail.com>
 <926ca0d9-840a-f850-19b1-cd22c25c0daa@redhat.com>
 <20201030135111.GB104289@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c7ad4722-8dd0-8ba4-d84f-9a92920439c3@redhat.com>
Date: Fri, 30 Oct 2020 11:09:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030135111.GB104289@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 9:51 AM, Daniel P. Berrangé wrote:
> On Fri, Oct 30, 2020 at 09:47:04AM -0400, John Snow wrote:
>> On 10/30/20 9:38 AM, Peter Maydell wrote:
>>> On Fri, 30 Oct 2020 at 13:32, John Snow <jsnow@redhat.com> wrote:
>>>> Is there a script that's public that you use for tagging the QEMU
>>>> release? I see make-release in scripts/, but that's for creating the
>>>> tarballs after the tagging has been done.
>>>
>>> I use this script:
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/qemu-tag-release
>>>
>>
>> Thanks!
>>
>>>> I am looking into being able to cut releases for our Python QMP library,
>>>> but due to constraints in the Python packaging ecosystem I have not yet
>>>> been able to solve, it requires its own VERSION file.
>>>>
>>>> It would be nice if when 5.2.0 is tagged that "0.5.2.0" could be written
>>>> into ./python/VERSION as well.
>>>
>>> I'm pretty strongly against having the version hardcoded
>>> anywhere except the top level VERSION file. Everything else
>>> should read the information from there.
>>>
>>
>> Yeah, I know. I don't want to do it either, but I don't see an alternative
>> that works with Python packaging tooling right now.
>>
>> The problem is that whenever you run an install, (which runs a python
>> "build"), the source is copied out into a temp directory where it loses all
>> access to the parent directory and any knowledge of .git.
>>
>> Perhaps someone has a solution, but I've not found one yet. The authors of
>> pip are aware of the problem and are working on a solution, but we don't
>> have one yet.
> 
> What does the  copying logic do when it sees a symlink ?   Can you keep
> a "VERSION" file in the python subdir that is a symlink to the top level
> "VERSION" file, such that when python copies the source files to the temp
> dir, it deep copies the symlink content.
> 

It either doesn't copy the symlink at all, or it shallow copies and 
breaks the link:

FileNotFoundError: [Errno 2] No such file or directory: 'QEMU_VERSION'

So I am meekly asking for the concession of adding an extra step to the 
qemu-tag-release script.

--js


