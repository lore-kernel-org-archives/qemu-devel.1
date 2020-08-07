Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AB4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A162320748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dh00QGoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A162320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zD1-0003oA-Q8
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3zAm-0001BE-GF
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:00:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42741
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3zAj-00066Q-3l
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596794420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=x9C7C0FiFVlgFFp1StzlYByhCTsIFBMDmA9pbX/o7SE=;
 b=dh00QGoZv9vOMSkmvp5VnhXF++D5CKeiM9rgDbbloEqenj7CaGxSDpEEgH+11RDdgKDyfC
 Y3gtUzwjvv5v+clHMYhRbHC1JhGMv8lEquTnZxUWtD8sQd6kn0xpS3QlYEHEVBj90kUj/r
 klP7IHwXhaSz1dc1GV+9HPYMF2o3gwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-bOxDi757NGq3aUcohnTAvg-1; Fri, 07 Aug 2020 06:00:15 -0400
X-MC-Unique: bOxDi757NGq3aUcohnTAvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE8051800D4A;
 Fri,  7 Aug 2020 10:00:13 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-31.ams2.redhat.com [10.36.113.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F6EC87A7E;
 Fri,  7 Aug 2020 10:00:07 +0000 (UTC)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
 <9c894412-b156-607e-1ea9-9e9ba14cbf1a@redhat.com>
 <6f6e9c9b-fdf6-951e-9112-3913fe44c455@redhat.com>
 <ac18da61-6f54-b9d4-7591-e1296f9d3a32@redhat.com>
 <353ff6f7-c67f-7665-b631-967512417fa2@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fa3570e7-1f2a-c44c-91f2-411c1f51e6ef@redhat.com>
Date: Fri, 7 Aug 2020 12:00:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <353ff6f7-c67f-7665-b631-967512417fa2@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/2020 11.52, Thomas Huth wrote:
> On 07/08/2020 11.49, Thomas Huth wrote:
>> On 07/08/2020 11.45, Thomas Huth wrote:
>>> On 07/08/2020 11.31, Paolo Bonzini wrote:
>>>> On 07/08/20 10:51, Thomas Huth wrote:
>>>>> 2) With --meson=git added, I also do not get much further:
>>>>>  "./ui/meson.build:77:0: ERROR: Program 'keycodemapdb/tools/keymap-gen'
>>>>> not found"
>>>>>
>>>>>  https://gitlab.com/huth/qemu/-/jobs/675546229
>>>>>
>>>>> Any idea what's going wrong here?
>>>>
>>>> This is also a submodule not being initialized,
>>>> ui/keycodemapdb/tools/keymap-gen comes from a submodule.
>>>
>>> Ok. I've added a hack to my configure script to checkout the submodules,
>>> but still, it does not compile yet:
>>>
>>>  ../tools/virtiofsd/meson.build:1:0: ERROR: Unknown variable
>>> "libvhost_user".
>>>  https://gitlab.com/huth/qemu/-/jobs/675665455
>>
>> At least the Debian container started to compile, but then fails here:
>>
>>  ../hw/display/virtio-gpu.c:43:10: fatal error: virglrenderer.h: No such
>> file or directory
>>  https://gitlab.com/huth/qemu/-/jobs/675665451
> 
> And yet another error, this time on Travis with --disable-system :
> 
>  ../hw/display/meson.build:42:22: ERROR: Unknown variable
> "config_all_devices".
>  https://travis-ci.com/github/huth/qemu/jobs/369657010#L1035

FreeBSD fails since dbus-daemon is not found:

 https://cirrus-ci.com/task/6446150314098688?command=main#L203

macOS now stops because the qemu_nbd variable is not set:

 https://cirrus-ci.com/task/5038775430545408?command=main#L207

 Thomas


