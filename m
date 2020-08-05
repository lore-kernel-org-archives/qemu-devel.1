Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EF2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE5620792
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKZJFi0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE5620792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Ekh-00063g-AJ
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3Ejz-0005GQ-FL
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:25:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45690
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3Ejx-00061p-JV
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596615936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifyhUygCUGMHX27Am0awgTJFCAed/iMW03SOlSQMNhQ=;
 b=bKZJFi0CGYA3ECJ5Pl0cfAQ72Qea5R1U8avDzoXEz59hdyyGe11xK/yVh6A2ig6i/ianTm
 UB3KoqtzcmjB0eRDg/jNXi4CkqJrSdG1r8f5PgYWkMSd8JPgAmBC62dQymzTHXXz1MKCJ4
 419d8ZXgj7kqQdX3dfteTYSiI0YH7BU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-hzTGpdfsPma1JEU0rVG-Sw-1; Wed, 05 Aug 2020 04:25:34 -0400
X-MC-Unique: hzTGpdfsPma1JEU0rVG-Sw-1
Received: by mail-wm1-f69.google.com with SMTP id g72so2172849wme.4
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 01:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ifyhUygCUGMHX27Am0awgTJFCAed/iMW03SOlSQMNhQ=;
 b=lXu90Fa7Jd5sA+IR82p2mTOumQ/J6jTpAIvS71RbAW73D6D1UkAm2P4nnXsm93voYI
 /5tZugTTob9P4xNlw8xpYHzJxPfzHn5z/qnAspQLH6lc1zLSSV4J6NycOR5KXf9+rFfj
 mIlS7Z7FM4nrdYLxYPDbIAnwCAFpaBk/pXY8sEB65xGG3jABej341sV9LpQxS9H+r560
 z6bvcTgABPlWPQHdLwpDVIBL1CZ1z3fTwUpCXdj5MrNxCaZKK6V3nhmjeli2qBil368g
 /vAQXnohf5lfE6C9yGmE/HFQiUi2gooJiDVLefhFO5WweAWKzGZNBvEgTy7hTPSSztX1
 DwAg==
X-Gm-Message-State: AOAM532QM7Jt1dZXX5qiZuCcK0V5VxUZc1OUG/gDwXSPm7utCkljp6sM
 GNAsDptL5YWIb5roVMM1VQiyySRmHHPrs40wgjCUBZNFIqWmjuC1tUrbVBCZwWnAqWz1M2yhvPa
 mui8yhDKSvXuZVHQ=
X-Received: by 2002:a1c:b443:: with SMTP id d64mr2461316wmf.68.1596615933715; 
 Wed, 05 Aug 2020 01:25:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc6SjFM5AhIzFRawrG/4xY1d8XgyPgQJJmbCX1E8KTWsdX2iqnz6vdo0en2tn69epQ06qwhQ==
X-Received: by 2002:a1c:b443:: with SMTP id d64mr2461266wmf.68.1596615932979; 
 Wed, 05 Aug 2020 01:25:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id w132sm1775157wma.32.2020.08.05.01.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 01:25:32 -0700 (PDT)
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
To: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <87d048i1m2.fsf@dusky.pond.sub.org>
 <83bbe0b0-c5e0-e3b7-5ba1-5946098370d5@redhat.com>
 <87ft94klyl.fsf@dusky.pond.sub.org>
 <490a0786-73f3-411e-4dfe-8c2ae90de251@redhat.com>
 <87y2mvhg3k.fsf@dusky.pond.sub.org>
 <facfef76-d880-82dd-f862-a64f8f487ba2@redhat.com>
 <87k0yeg7mc.fsf@dusky.pond.sub.org>
 <6e5df5fc-94f8-ee8e-0c14-f56135de25e4@redhat.com>
 <87o8np5ysp.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9f83eb93-5389-7aad-3031-0777de0c35b0@redhat.com>
Date: Wed, 5 Aug 2020 10:25:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87o8np5ysp.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/08/20 09:36, Markus Armbruster wrote:
> There's also the longer term pain of having to work around git-blame
> unable to see beyond the flag day.

Do you really use "git blame" that much?  "git log -S" does more or less
the same function (in a different way) and is not affected as much by
large code movement and transformation patches.

Paolo


