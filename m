Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86672C5B578
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 04:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CF720843
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 04:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CF720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjbxa-0004eF-AG
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 00:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52383)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hjbvT-0003pN-1r
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 00:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hjbvR-0005IY-WD
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 00:03:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44860)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hjbvP-0005GR-Js; Sat, 06 Jul 2019 00:03:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C66D4308FF23;
 Sat,  6 Jul 2019 04:03:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A95A861993;
 Sat,  6 Jul 2019 04:03:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7ABCF1132ABF; Sat,  6 Jul 2019 06:03:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-2-jsnow@redhat.com>
 <87sgrkin5j.fsf@dusky.pond.sub.org>
 <5a6527dc-15ff-9dbc-8e47-7d5b250fe4ea@redhat.com>
Date: Sat, 06 Jul 2019 06:03:35 +0200
In-Reply-To: <5a6527dc-15ff-9dbc-8e47-7d5b250fe4ea@redhat.com> (John Snow's
 message of "Fri, 5 Jul 2019 12:37:33 -0400")
Message-ID: <87zhlrg67c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Sat, 06 Jul 2019 04:03:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 01/18] qapi/block-core: Introduce
 BackupCommon
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 7/5/19 10:14 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> drive-backup and blockdev-backup have an awful lot of things in common
>>> that are the same. Let's fix that.
>>>
>>> I don't deduplicate 'target', because the semantics actually did change
>>> between each structure. Leave that one alone so it can be documented
>>> separately.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  qapi/block-core.json | 103 ++++++++++++++-----------------------------
>>>  1 file changed, 33 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 0d43d4f37c..7b23efcf13 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -1315,32 +1315,23 @@
>>>    'data': { 'node': 'str', 'overlay': 'str' } }
>>>  
>>>  ##
>>> -# @DriveBackup:
>>> +# @BackupCommon:
>>>  #
>>>  # @job-id: identifier for the newly-created block job. If
>>>  #          omitted, the device name will be used. (Since 2.7)
>>>  #
>>>  # @device: the device name or node-name of a root node which should be copied.
>>>  #
>>> -# @target: the target of the new image. If the file exists, or if it
>>> -#          is a device, the existing file/device will be used as the new
>>> -#          destination.  If it does not exist, a new file will be created.
>>> -#
>>> -# @format: the format of the new destination, default is to
>>> -#          probe if @mode is 'existing', else the format of the source
>>> -#
>>>  # @sync: what parts of the disk image should be copied to the destination
>>>  #        (all the disk, only the sectors allocated in the topmost image, from a
>>>  #        dirty bitmap, or only new I/O).
>> 
>> This is DriveBackup's wording.  Blockdev lacks "from a dirty bitmap, ".
>> Is this a doc fix?
>
> Yes.

Worth mentioning in the commit message?

>>>  #
>>> -# @mode: whether and how QEMU should create a new image, default is
>>> -#        'absolute-paths'.
>>> -#
>>> -# @speed: the maximum speed, in bytes per second
>>> +# @speed: the maximum speed, in bytes per second. The default is 0,
>>> +#         for unlimited.
>> 
>> This is Blockdev's wording.  DriveBackup lacks "the default is 0, for
>> unlimited."  Is this a doc fix?
>
> Yes.

Worth mentioning in the commit message?

[...]

