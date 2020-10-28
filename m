Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A99C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9308D247E0
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITE7kZ/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9308D247E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnxp-00014K-Ib
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 12:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXntG-0004vO-3b
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXntD-0003ym-F3
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603900889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SEiAjCTzyJ3YbxZ5VkmhgkiaPzMUi2d4b1ZTmbN/Mc=;
 b=ITE7kZ/wKhY3JwDTFu9+pqIIIc6DGtymXPU+KyvFz85Vv3maZzsgtirWOyou2h5ewgrxRE
 8+9bAT3TE/QIA2HUZSN8sBTOzK/j4nv0lWlOqCgrfuuwqiQadkLlafkDZ6seFoaiRgTuD4
 Lm3m5suw7U6pY0TlNlQMPyFZPSnMWcQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-dUirDyEqNbqErQkuoZ4Y-Q-1; Wed, 28 Oct 2020 12:01:27 -0400
X-MC-Unique: dUirDyEqNbqErQkuoZ4Y-Q-1
Received: by mail-wr1-f71.google.com with SMTP id 31so16345wrg.12
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 09:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2SEiAjCTzyJ3YbxZ5VkmhgkiaPzMUi2d4b1ZTmbN/Mc=;
 b=YaadAni3sVNTWsjaJmS+Uh5eSM5BHg3ksJu6ss0L82l25dhctzDD2Inr18hJpGK0kn
 AtUh1TRDS78xGk/Zs62sdG6u+c2kI0GRiO25ngL2TRQq5OH2PHIRWXFuAYyVw9LA+itT
 Mz7IMi1A6Jj3E8WUB7+WSwiian1ENscU43F3FjoITXWd1ChsUiFndTQ3Yl3IGvJjxgNy
 PvMudFD/NSxK5/hkZWKOAjPhOXfyi0OmFA0+SXDK4jng9q01rdJ2/S26NjOwKFDKooOV
 KlM/BAwG3N2YUL9X/m3vE6A37Fm8LEGeVOJyRe3K6mFWQ7BYwA68ZsZ7YIUcXNp/oBUi
 vtvg==
X-Gm-Message-State: AOAM533vQ3m1IA1qska7c2raGvhUyLyVKnXHBhPR3iAatJbZlm3C4xNH
 M2AYY4F3QydFU2JnChzZox3L13rtkZ3tZIDeSE8D3f8ohe2vcmovg+KbNDSzeFRIo2VpcgUm4KH
 EH99wdwdVcuu4dYk=
X-Received: by 2002:adf:a51d:: with SMTP id i29mr10030744wrb.409.1603900886660; 
 Wed, 28 Oct 2020 09:01:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXgP7I/taOD/0/A6d5gQR5Uai5RlDgvIif8qRtHiByu/kHSDux5+6xdtjK4pXwwtWQBFhUdQ==
X-Received: by 2002:adf:a51d:: with SMTP id i29mr10030721wrb.409.1603900886385; 
 Wed, 28 Oct 2020 09:01:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id l26sm26216wmi.39.2020.10.28.09.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 09:01:25 -0700 (PDT)
Subject: Re: [PATCH 0/4] qemu-storage-daemon: QAPIfy --chardev the stupid way
To: Kevin Wolf <kwolf@redhat.com>
References: <20201026101005.2940615-1-armbru@redhat.com>
 <d00ef574-b2c4-887c-6a37-79f6cf6eeae0@redhat.com>
 <87a6w63kbw.fsf@dusky.pond.sub.org> <20201028114625.GA7355@merkur.fritz.box>
 <53ba80fe-8e4c-88c6-181d-f3b33bf3e9bc@redhat.com>
 <20201028145937.GB7355@merkur.fritz.box>
 <8103b738-aff7-fc50-67ac-59fd1262c06a@redhat.com>
 <20201028153946.GC7355@merkur.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e95c354e-64c6-b014-36fa-37a93bf32d1f@redhat.com>
Date: Wed, 28 Oct 2020 17:01:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028153946.GC7355@merkur.fritz.box>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 28/10/20 16:39, Kevin Wolf wrote:
>> I don't disagree with that, but it's a problem you have to solve anyway,
>> isn't it?  Once you figure out how to introspect QOM classes, that would
>> apply just as well to character devices.
> Yes, it's the problem I tried to address with my series, and Markus with
> this alternative series. We need to do this either way.

Right, I appreciate that QOMifying chardev would only be a solution if
QOM introspection gets into 6.0.  This is why I only brought it up
because neither of these series will be ready in time for 5.2.

So maybe QOMifying chardev wouldn't make it a non-problem; it would make
it someone else's (Eduardo's) problem.

> you need to know what these properties should look like

True that.  But I think the existing QAPI structures do help for that.

> If you don't wait for the QAPI work, you'll have solved the problem of
> having two separate ways to describe chardev options by making it three
> separate ways. Technically this might fulfill the condition of not
> having two separate ways, but it's not really what we had in mind. :-)

Actually four ways (-chardev, chardev-add, -object, object-add) but two
of them would be implemented by the same code and qsd would be able to
standardize on them.

Paolo


