Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B365C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F3020714
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9pHCVu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F3020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJ5z-0002PH-F0
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 10:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jFJ5K-0001zY-PO
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jFJ5J-00042e-PX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:57:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36275)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jFJ5J-00042E-MF
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584716237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHak6LAq0ZQ5K614OM/3hwbMpLmgWbl48+flHPHwe2Q=;
 b=L9pHCVu3zu+5xWG9vfOYJlmZYuOmuCUZ/XLnVD8IdnL+w96vVP/5UwqMd0u7tuDm1a+CCC
 y7N13beaDDKRBrwxW8q3r5eAZnCDoCQwZ1cXQmCAyLkl1A7citpfHmn8vzFooM1lHeuIGH
 uCRPMck9EvjmoMb9XKgJIP+dwsiehHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-xgbIPjlJNkmfmr4DVGLKmw-1; Fri, 20 Mar 2020 10:57:12 -0400
X-MC-Unique: xgbIPjlJNkmfmr4DVGLKmw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EDE48017CE;
 Fri, 20 Mar 2020 14:57:11 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1ECEC5C1A5;
 Fri, 20 Mar 2020 14:57:11 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH v3] qga: Support enum names in guest-file-seek
To: Peter Maydell <peter.maydell@linaro.org>
References: <1455053236-22735-1-git-send-email-eblake@redhat.com>
 <CAFEAcA9_yGg4cDc4rxVUeemaPQk_qn9=BqrT_Ck8hB3EK5F92w@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <55a50784-acfe-495c-f67a-9d5407c8c19b@redhat.com>
Date: Fri, 20 Mar 2020 09:57:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9_yGg4cDc4rxVUeemaPQk_qn9=BqrT_Ck8hB3EK5F92w@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/20/20 8:49 AM, Peter Maydell wrote:
> On Tue, 9 Feb 2016 at 21:27, Eric Blake <eblake@redhat.com> wrote:
>>
>> Magic constants are a pain to use, especially when we run the
>> risk that our choice of '1' for QGA_SEEK_CUR might differ from
>> the host or guest's choice of SEEK_CUR.  Better is to use an
>> enum value, via a qapi alternate type for back-compatibility.
>>

> Hi; dragging up this patch from 2016 to say that Coverity
> has just noticed that there's some C undefined behaviour
> in it (CID 1421990):

Wow, took us a long time to find that!

> 
>> +/* Convert GuestFileWhence (either a raw integer or an enum value) into
>> + * the guest's SEEK_ constants.  */
>> +int ga_parse_whence(GuestFileWhence *whence, Error **errp)
>> +{
>> +    /* Exploit the fact that we picked values to match QGA_SEEK_*. */
>> +    if (whence->type == QTYPE_QSTRING) {
>> +        whence->type = QTYPE_QINT;
>> +        whence->u.value = whence->u.name;
> 
> Here whence->u.value and whence->u.name are two different
> fields in a union generated by QAPI:
> 
> typedef enum QGASeek {
>      QGA_SEEK_SET,
>      QGA_SEEK_CUR,
>      QGA_SEEK_END,
>      QGA_SEEK__MAX,
> } QGASeek;
> 
> struct GuestFileWhence {
>      QType type;
>      union { /* union tag is @type */
>          int64_t value;
>          QGASeek name;
>      } u;
> };
> 
> So u.value and u.name overlap in storage. The C standard
> says that this assignment is only valid if the overlap is
> exact and the two objects have qualified or unqualified
> versions of a compatible type. In this case the enum
> type is likely not the same size as an int64_t, and so
> we have undefined behaviour.

You are (well, Coverity is) absolutely right!  Patch coming up.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


