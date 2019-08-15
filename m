Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE8DC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FAE62084D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAE62084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyGdV-00059D-H9
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 10:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1hyGcR-0004cm-T4
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hyGcL-0002YV-Uq
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:20:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hyGcA-0002TR-Il; Thu, 15 Aug 2019 10:20:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D2068317528E;
 Thu, 15 Aug 2019 14:20:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15BD043FD2;
 Thu, 15 Aug 2019 14:20:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A50251EB6C82; Thu, 15 Aug 2019 16:18:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <d0635a23-7f99-9cf7-500c-af668e8ca370@redhat.com>
 <20190815091039.GA7415@linux.fritz.box>
Date: Thu, 15 Aug 2019 16:18:16 +0200
In-Reply-To: <20190815091039.GA7415@linux.fritz.box> (Kevin Wolf's message of
 "Thu, 15 Aug 2019 11:10:39 +0200")
Message-ID: <87y2zuy0k7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 15 Aug 2019 14:20:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/13] RFC: luks/encrypted qcow2 key
 management
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
Cc: Fam Zheng <fam@euphon.net>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 14.08.2019 um 23:08 hat Eric Blake geschrieben:
>> On 8/14/19 3:22 PM, Maxim Levitsky wrote:
>> 
>> > This is an issue that was raised today on IRC with Kevin Wolf. Really thanks
>> > for the idea!
>> > 
>> > We agreed that this new qmp interface should take the same options as
>> > blockdev-create does, however since we want to be able to edit the encryption
>> > slots separately, this implies that we sort of need to allow this on creation
>> > time as well.
>> > 
>> > Also the BlockdevCreateOptions is a union, which is specialized by the driver name
>> > which is great for creation, but for update, the driver name is already known,
>> > and thus the user should not be forced to pass it again.
>> > However qmp doesn't seem to support union type guessing based on actual fields
>> > given (this might not be desired either), which complicates this somewhat.
>> 
>> Does the idea of a union type with a default value for the discriminator
>> help?  Maybe we have a discriminator which defaults to 'auto', and add a
>> union branch 'auto':'any'.  During creation, if the "driver":"auto"
>> branch is selected (usually implicitly by omitting "driver", but also
>> possible explicitly), the creation attempt is rejected as invalid
>> regardless of the contents of the remaining 'any'.  But during amend
>> usage, if the 'auto' branch is selected, we then add in the proper
>> "driver":"xyz" and reparse the QAPI object to determine if the remaining
>> fields in 'any' still meet the specification for the required driver branch.
>> 
>> This idea may still require some tweaks to the QAPI generator, but it's
>> the best I can come up with for a way to parse an arbitrary JSON object
>> with unknown validation, then reparse it again after adding more
>> information that would constrain the parse differently.
>
> Feels like this would be a lot of code just to allow the client to omit
> passing a value that it knows anyway. If this were a human interface, I
> could understand the desire to make commands less verbose, but for QMP I
> honestly don't see the point when it's not trivial.

Seconded.

