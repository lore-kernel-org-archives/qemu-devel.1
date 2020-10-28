Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21411C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73DC9247B3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTYblMnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DC9247B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXn6T-0001e1-7I
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXn4w-0008Nc-WE
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXn4u-00054Q-SV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603897765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TuiVtNguQra0eLMsr68EROyM/KDeIRmQbKhB0emqH7M=;
 b=hTYblMnjtIWKdNV+BxiV9cNsNBvoQXgkOSJ80M6gtkBBswHqV/oLz3ILN7WiS2cohgLgAM
 TXNDmRtW+q886K11oLXNRTvGknYQzxXKMAvULF/AOdrVKryWjoEUaCpvNYCNVImNz2QpZK
 mMPVrIQF2HkoEMEaDkOAtnVu31Luk5g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-JqalDS7bMy64KDuVWX0Jzw-1; Wed, 28 Oct 2020 11:09:23 -0400
X-MC-Unique: JqalDS7bMy64KDuVWX0Jzw-1
Received: by mail-wm1-f71.google.com with SMTP id u207so1873612wmu.4
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 08:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TuiVtNguQra0eLMsr68EROyM/KDeIRmQbKhB0emqH7M=;
 b=q9oq8YNJPrUhkKgkj0znuravuFVlSi95Rga8hwBAmvdlJkI6aeL1uJH54hVgd2zTP1
 rNaRCNWAfptyXqJRF+0n5h8V1bNZZMFkdTvcYVR9DiGlEwnahmrW4Rpx9Khu0uHzB9Re
 nidvOAcpi2TogK7jtBwRzPLrlmc77m49z7AtEGOiqDitM6kiovIGLftFbmKRGVHHMjSB
 qvvTzVskxUZky7XVy07DOKvIfRDac45nMqSTAfa6y7WhefdTBA7zEZ5Vd6MFkNwP0Gbf
 aY+hlEUvKrnGVksDXvwjBaZdN037Dvh+VLAAARJlzy2vgJrEXpfmjfVltk33/VNrlPx6
 7fGg==
X-Gm-Message-State: AOAM5306lmO5NEHoxBtbt8PjzktoWT/8FHP06k0InK94n5+VMOz0+3/y
 rK0QC4gqb6mso/T6w56t50aoyv66GMa3zRCJD+1r93/LqRayl8vQ5hz4LuJIr55mubP6xtuK2y6
 uJSd4ayzghbVWDxE=
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr9545757wrp.122.1603897761988; 
 Wed, 28 Oct 2020 08:09:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5DdJfaWfJu9vwWjClIPEQqej1KhrGdoWiBq/rbN03InBOFBH4MQ7i9eig+S9v/rsKQBQCzw==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr9545720wrp.122.1603897761678; 
 Wed, 28 Oct 2020 08:09:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id e13sm7534862wrt.57.2020.10.28.08.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 08:09:20 -0700 (PDT)
Subject: Re: [PATCH 0/4] qemu-storage-daemon: QAPIfy --chardev the stupid way
To: Kevin Wolf <kwolf@redhat.com>
References: <20201026101005.2940615-1-armbru@redhat.com>
 <d00ef574-b2c4-887c-6a37-79f6cf6eeae0@redhat.com>
 <87a6w63kbw.fsf@dusky.pond.sub.org> <20201028114625.GA7355@merkur.fritz.box>
 <53ba80fe-8e4c-88c6-181d-f3b33bf3e9bc@redhat.com>
 <20201028145937.GB7355@merkur.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8103b738-aff7-fc50-67ac-59fd1262c06a@redhat.com>
Date: Wed, 28 Oct 2020 16:09:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028145937.GB7355@merkur.fritz.box>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: marcandre.lureau@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/10/20 15:59, Kevin Wolf wrote:
>> Making more use of QOM will make this a non-problem.  You'll just use
>> object-add and -object and, when you figure out the QOM schema, it will
>> just work.
>
> Yes, but figuring out the QOM schema (or rather, what the interface
> represented by the schema should look like) is the hard part.

I don't disagree with that, but it's a problem you have to solve anyway,
isn't it?  Once you figure out how to introspect QOM classes, that would
apply just as well to character devices.

On the other hand, creating character devices with -object does solve
another problem, namely the distinction between "early" and "late"
objects in vl.c, in a way that QAPIfied -chardev doesn't solve.

Paolo


