Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE3C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59D22177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSBvoR0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59D22177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBE5z-00029K-2x
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBE5Q-0001ik-Fe
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:20:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43457
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBE5O-00031G-5U
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598520045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVfqujiv4NoNGtDo53U2kioxibVaTcU+jJqIejDIvlg=;
 b=YSBvoR0ZAPAdA7PlqZShejr+sXXrkGoU64lKlhMnUZ9ttNDxKyam0aMlc5svsrZnn7zQvd
 ub+jMNhZ/jbOG7oo5vIktlSYrEr0iWQ/Ro5Kw0K9IJHGKNWHdJ0meXY0q55VptpdFV5wB6
 V4PP/QiWBAS97C+SIH9kzFM3pNZ7UhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-MR_otvD5P9Gc67AAXakvvQ-1; Thu, 27 Aug 2020 05:20:43 -0400
X-MC-Unique: MR_otvD5P9Gc67AAXakvvQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FB4A189E614;
 Thu, 27 Aug 2020 09:20:42 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B848110013C1;
 Thu, 27 Aug 2020 09:20:37 +0000 (UTC)
Subject: Re: [PATCH] pc-bios: s390x: Add a comment to the io and external new
 PSW setup
To: Janosch Frank <frankja@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <033b0db7-7b7d-6eb0-9018-bcc342f13509@de.ibm.com>
 <20200715140820.3401-1-frankja@linux.ibm.com>
 <3216babd-433b-4ec7-5333-43a75df2e331@de.ibm.com>
 <d493a0c2-c0df-4ed5-27af-34a9fc82927d@linux.ibm.com>
 <2e6134fb-3e34-4d3a-1bf8-1665ceffef38@de.ibm.com>
 <cd2c8bb2-413f-b6b9-ae16-e79e838b503d@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <741c77bc-1f0d-c613-9c74-832f797db5aa@redhat.com>
Date: Thu, 27 Aug 2020 11:20:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cd2c8bb2-413f-b6b9-ae16-e79e838b503d@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/07/2020 10.05, Janosch Frank wrote:
> On 7/22/20 9:39 AM, Christian Borntraeger wrote:
>>
>>
>> On 22.07.20 09:24, Janosch Frank wrote:
>>> On 7/22/20 8:43 AM, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 15.07.20 16:08, Janosch Frank wrote:
>>>>> Normally they don't need to be set up before waiting for an interrupt
>>>>> but are set up on boot. The BIOS however might overwrite the lowcore
>>>>> (and hence the PSWs) when loading a blob into memory and therefore
>>>>> needs to set up those PSWs more often.
>>>>
>>>> Now when I read the new comment this actually inidicates a bug. 
>>>> When do we restore the original content? If the loaded program
>>>> does have interrupt handlers in the original image and relies on that
>>>> then we are broken, no?
>>>
>>> I haven't seen references to a save/restore functionality for those
>>> PSWs. And I also think it's not that easy to do because we have multiple
>>> ways of loading data and if we want to print when loading we might end
>>> up overwriting and then saving the written value for a later restore.
>>>
>>> I need to have a closer look at how virtio works, but wouldn't we have a
>>> chicken - egg problem with IO interrupts for IO that writes the prefix?
>>>
>>> The BIOS often has "interesting" solutions to problems.
>>> If you have a quick fix, be my guest and send it. If not I'd put it on
>>> my todo list or let Stefan make it a proper dev item.
>>
>> Maybe a global fixup table in BIOS memory that restores all the memory that
>> we messed with when we hand over control? Can you at least change the comment
>> here to add a fixme?
> 
> Sure

Hi Janosch!

Did you ever send a new version of this patch with the FIXME added? I
can't find it right now... Or shall I add a FIXME when picking this up?
(If so, could you please suggest a text?)

 Thomas


