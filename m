Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED51C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C3720838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SypXxC4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C3720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04YZ-0004wp-6Q
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j04Xl-00048T-F5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j04Xk-0008Uq-AZ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:23:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44186
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j04Xk-0008RZ-61
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581085419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EevnAQJ5IKPyh7YVauQ+hCE6GxObs6mxrun1TNykQlA=;
 b=SypXxC4/Yj/oekypMRgUp8oohA5YhHRmh0ZALsDL0VLKUKNebCec7A4owNH0COybNvUYRG
 RBUXN835cZEWdBmkHfDmo4bMTJuuTlVEVZgb1TD3L3XfOSWdYbMU+ebcAVY23hATykX2NJ
 yHe+7rK3x8s2VjTS4MK503hG2ZCSh+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-tu9ihoc6Oby4ubDlwz62Hw-1; Fri, 07 Feb 2020 09:23:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46D878CCDAC;
 Fri,  7 Feb 2020 14:23:29 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD13C863C7;
 Fri,  7 Feb 2020 14:23:04 +0000 (UTC)
Subject: Re: [PATCH 12/29] qapi: Explicitly put "foo: dropped in n.n" notes
 into Notes section
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-13-peter.maydell@linaro.org>
 <87mu9usod1.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <eb9f66e2-f409-b75e-329a-158db405ecf9@redhat.com>
Date: Fri, 7 Feb 2020 08:23:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87mu9usod1.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: tu9ihoc6Oby4ubDlwz62Hw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 4:06 AM, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> A handful of QAPI doc comments include lines like
>> "ppcemb: dropped in 3.1". The doc comment parser will just
>> put these into whatever the preceding section was; sometimes
>> that's "Notes", and sometimes it's some random other section,
>> as with "NetClientDriver" where the "'dump': dropped in 2.12"
>> line ends up in the "Since:" section.
>>
>> Put all of these explicitly into Notes: sections (either
>> preexisting or new), with the right indentation, and
>> standardising on quoting of the symbol with ''.
>>

> 
> I'm not sure the "dropped in" notes are worth their keep.  One, they are
> too incomplete to be of much use.  Two, I think qemu-deprecated.texi is
> a better home for this kind of information.  Easier to consume for the
> people who need to know.  In particular, they can watch the sausage
> being made by getting themselves added to MAINTAINERS section
> "Incompatible changes".

We first started adding dropped-in notes at least as early as commit 
912092b (part of v2.10.0), with the 'altgr'/'altgr_r' members of 
QKeyCode.  We did not have qemu-deprecated.texi until commit 44c67847 
(v3.0.0), so the markings originally made sense.

But now that we have a better place for someone to look up "why is my 
QAPI command not working? oh, qemu-deprecated documents that it was 
removed, AND tells me details such as why it was useless or what to use 
in its place", I don't see the need to burden QAPI docs with a mere 
"this old form with no further documentation used to exist, but you 
can't use it now, and furthermore this tidbit of information didn't 
teach you anything useful about what _does_ work with this command" line.

> 
> If we decide we want to document "dropped in" in the schema, then we
> need to make an effort to reconstruct the missing ones.  Also, members
> names should use @name markup, not 'name'.
> 
> Cc'ing people ratted out by git-log -S'dropped in'.

I'm all in favor of stopping the use of 'dropped in' in QAPI source 
files, and sticking to qemu-deprecated.texi instead.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


