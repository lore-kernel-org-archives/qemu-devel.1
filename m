Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0BAC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CA320833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CA320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54890 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFy8-0000Mg-C2
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:58:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1hRFkm-0005Zs-KV
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1hRFki-0004Ab-Ow
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:44:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1hRFkg-00045X-Pj
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:44:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92513308623C
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 12:44:48 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 14B6410027BB;
	Thu, 16 May 2019 12:44:47 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
	<20190311220843.4026-23-armbru@redhat.com>
	<76d4a7b2-3c13-beea-2dc0-4fda7025030b@redhat.com>
	<878sv6tyjy.fsf@dusky.pond.sub.org>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <ea01ee11-8888-444d-1f51-387dc73464f5@redhat.com>
Date: Thu, 16 May 2019 14:44:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <878sv6tyjy.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Thu, 16 May 2019 12:44:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 22/27] vl: Create block backends before
 setting machine properties
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/16/19 1:43 PM, Markus Armbruster wrote:
<snip/>

>> Actually, there is more problems with this. Trying to run a guest with
>> persistent reservations fails after this patch is applied (git bisect
>> points me to this commit). My command line is:
>>
>> qemu.git $ ./x86_64-softmmu/qemu-system-x86_64 \
>> -monitor stdio \
>> -object pr-manager-helper,id=pr-helper0,path=/tmp/pr-helper0.sock
>> -drive
>> file=/dev/mapper/crypt,file.pr-manager=pr-helper0,format=raw,if=none,id=drive-scsi0-0-0-2
>> \
>> -device
>> scsi-block,bus=scsi0.0,channel=0,scsi-id=0,lun=2,drive=drive-scsi0-0-0-2,id=scsi0-0-0-2
>>
>> Honestly, I have no idea how to fix it, so I'm just raising this issue
>> here. Do you want me to open a bug or something?
> 
> Let's skip the bug filing bureaucracy and go straight to debugging.

Agreed.

> 
> Actual and expected behavior of your reproducer, please :)
> 

Actual is that qemu fails to parse cmd line:


qemu-system-x86_64: -drive 
file=/dev/mapper/crypt,file.pr-manager=pr-helper0,format=raw,if=none,id=drive-scsi0-0-0-2: 
No persistent reservation manager with id 'pr-helper0'


Which obviously is not correct, because pr-helper0 is specified.
Expected result is that qemu suceeds in parsing the cmd line and starts 
the guest. To test it you don't need /dev/mapper/* really, I mean, if 
qemu fails with a different error message (e.g. it can't open the disk 
or EPERM or whatever), it's a sign it got past the cmd line parsing 
successfuly.

Michal

