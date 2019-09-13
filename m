Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0379BC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA4920640
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA4920640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8m0k-0000tt-VR
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1i8lzp-0008R9-Om
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1i8lzn-0002kS-Dk
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:52:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51586)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1i8lzn-0002kF-8K
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:52:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DBA8E3082128;
 Fri, 13 Sep 2019 13:52:17 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08041600C6;
 Fri, 13 Sep 2019 13:52:16 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>
References: <faeb030e6a1044f0fd88208edfdb1c5fafe5def9.1567171655.git.mprivozn@redhat.com>
 <87k1accq91.fsf@dusky.pond.sub.org>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <e57985a8-6974-e2b4-a622-3b7eca50660c@redhat.com>
Date: Fri, 13 Sep 2019 15:52:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87k1accq91.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 13 Sep 2019 13:52:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] qapi/qmp-dispatch: Fix error class for
 reporting disabled commands
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
Cc: lcapitulino@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/19 2:52 PM, Markus Armbruster wrote:
> Michal Privoznik <mprivozn@redhat.com> writes:
> 
>> If a command is disabled an error is reported. But due to usage
>> of error_setg() the class of the error is GenericError which does
>> not help callers in distinguishing this case from a case where a
>> qmp command fails regularly due to other reasons. Use
>> CommandNotFound error class which is much closer to the actual
>> root cause.
>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>> ---
> 
> I'd like to tweak the commit message a bit:
> 
>    qmp-dispatch: Use CommandNotFound error for disabled commands
> 
>    If a command is disabled an error is reported.  But due to usage of
>    error_setg() the class of the error is GenericError which does not
>    help callers in distinguishing this case from a case where a qmp
>    command fails regularly due to other reasons.
> 
>    We used to use class CommandDisabled until the great error
>    simplification (commit de253f1491 for QMP and commit 93b91c59db for
>    qemu-ga, both v1.2.0).
> 
>    Use CommandNotFound error class, which is close enough.
> 
> Objections?
> 

None, thanks for taking care of this.

Michal

