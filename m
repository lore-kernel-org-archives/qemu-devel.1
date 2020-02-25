Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE87C35E0C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A82F2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSC5xNzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A82F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dSd-0001dY-ME
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j6dR6-0008CD-Ff
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:51:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j6dR5-0001Qt-H4
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:51:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j6dR5-0001Qn-CW
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582649515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRzWKrl1OaCouDwvB8nFbvefQg5ZgFD5UdVeG5bno0Q=;
 b=gSC5xNznMpf5tLZa+/a+2TZ0ls4n023ihBR3KlFpAW16k3xE64tXdV5HrhwtyuSxZ9qsBQ
 QIj6Iv3IUi3M8aUeH0b4sfkB/qqSzCSI/tYDNYHr48VC7EA45QgrbIpmxASVcLjSqLQYOm
 5R47+gs7u6N3o727c0AFjrNFRH2nuzY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-PEPGWk_zOqG6bgyG09EfxA-1; Tue, 25 Feb 2020 11:51:53 -0500
X-MC-Unique: PEPGWk_zOqG6bgyG09EfxA-1
Received: by mail-wr1-f69.google.com with SMTP id o6so62037wrp.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 08:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mRzWKrl1OaCouDwvB8nFbvefQg5ZgFD5UdVeG5bno0Q=;
 b=CjFZ5fzjds+Is3Rud0LTXhb712Xd4sILU1KIfmnkKEaDI4Heha1xb2sU7q1ghNo2/Y
 7+09DqoPYEUbmXkHqKAZYaoC+NxbVzBQ4BY7H1DelHpo2nLZPbfXdbi127V0vbdfWZs6
 aXPyIq257mKeey4hu4HPWOLACdBWFynejL/jJ8gXIz+OjDKzQ1cpu/6DfDev74PBWBqK
 xuOXvmNPs78rG5E39T/ZaoZXU56dVrU18G5IDLC69Qnsj2KUadHFvgJ1QqTM5ppJkh07
 4YcT2tPA8+LzQA1EiAg6F+tBqlDG7HdJ0TMDcQTMVlF15W1qVW3VDK1Xhrx+pLDYi0uh
 NaBQ==
X-Gm-Message-State: APjAAAXK4hWqEDEkXxHGR/o3w24/7Y6TPupEqv9snfxHYX5cEe8cOsBb
 FBR+lPxFwvLcdSAawq6pLNHyXMKaDC83+DhIeffUs0PIemnaJ28vs+iawCh4Wqk8tkK0JdCgTmU
 0t1ZOIC6+5myqt7w=
X-Received: by 2002:adf:edd0:: with SMTP id v16mr34951wro.357.1582649512278;
 Tue, 25 Feb 2020 08:51:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzD+uore7H+YmP1yGXxjHnX7PGPTMRsDiblpG8CAjDASJKhEVu4jZQ2GS8RrKR/6Nc47QnXQQ==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr34940wro.357.1582649512008;
 Tue, 25 Feb 2020 08:51:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6?
 ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
 by smtp.gmail.com with ESMTPSA id l2sm4811077wme.1.2020.02.25.08.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 08:51:51 -0800 (PST)
Subject: Re: [PATCH] Memory: Only call ramblock_ptr when needed in
 qemu_ram_writeback
To: Anthony PERARD <anthony.perard@citrix.com>,
 Juan Quintela <quintela@redhat.com>
References: <20191219154214.GE1267@perard.uk.xensource.com>
 <20191219154323.325255-1-anthony.perard@citrix.com>
 <87immc190v.fsf@trasno.org> <20200225160203.GD2193@perard.uk.xensource.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4097573f-f3d6-bf08-f0da-80d72afcc6c9@redhat.com>
Date: Tue, 25 Feb 2020 17:51:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225160203.GD2193@perard.uk.xensource.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
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
Cc: Beata Michalska <beata.michalska@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/02/20 17:02, Anthony PERARD wrote:
> On Thu, Dec 19, 2019 at 07:10:24PM +0100, Juan Quintela wrote:
>> Anthony PERARD <anthony.perard@citrix.com> wrote:
>>> It is possible that a ramblock doesn't have memory that QEMU can
>>> access, this is the case with the Xen hypervisor.
>>>
>>> In order to avoid to trigger an assert, only call ramblock_ptr() when
>>> needed in qemu_ram_writeback(). This should fix migration of Xen
>>> guests that was broken with bd108a44bc29 ("migration: ram: Switch to
>>> ram block writeback").
>>>
>>> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
>>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>
>> This is exec.c, nothing related to migration.
>>
>> Paolo, are you taking this one?
>> It could even go through the trivial one.
> 
> Hi,
> 
> I'm going to send a pull request for the xen queue with this patch.
> Unless that's an issue?

No, absolutely.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


