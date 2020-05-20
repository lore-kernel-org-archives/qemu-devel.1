Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9C0C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8484820709
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdW6xYXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8484820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRbT-0004jo-Ns
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbRaL-0003y1-To
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:28:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20180
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbRaL-00016r-7G
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589992128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BBZjUY8icn0goV0DvA5D98N6qa9Lrwi7PhJKO85t6JE=;
 b=PdW6xYXXX718W6i5EOtgLsF3vu2vquYEzrIQhFQ9rD1xTL6fX7YyzmY26hAJfqg1fTU6kn
 oqrDSlwpKK+zf0wyn7mjSUHst8FaiW6mjFLTaNwGRBwJsMRwP6rz+BK0xGAadL606+m1QD
 DMNQ0lp2KAZkBMLKJMmHsquo2PgnNbs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-CFxjPPNtOYmJM9J0808mVw-1; Wed, 20 May 2020 12:28:46 -0400
X-MC-Unique: CFxjPPNtOYmJM9J0808mVw-1
Received: by mail-wr1-f69.google.com with SMTP id i9so1633997wrx.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 09:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BBZjUY8icn0goV0DvA5D98N6qa9Lrwi7PhJKO85t6JE=;
 b=kEyYfKCilTFb+IxNAuzTov1kkKeprtdDrhMUy6zu/1idH+lXBgtflkBoAO63hXms0G
 zQyuNZ7VEKiTU440zcltdMt42hyloTvPTWK2ji4klm1U46hltSdXuBbZDT2PJswE+c9w
 2JANEuvTELGI7uk+3EhvrZPcX/R877DMAg8Y7hTVzbF6rnQH55XeUNOcU8smtN++YC7d
 hBttuAmSooH0Z0AGVBPOmuujcZUsvnmlWAveFrzuZNn8yDdcyKfR3bR+ktz1GMbw+6sl
 fCb6y1RQzK5OMLDApCob0Kya1DZlGp+7JEfh8IR/NCwYTKDJdPvrLGYay4AyJJ4cDUYM
 P9fA==
X-Gm-Message-State: AOAM530oTD44SPaB+tjtOLpLDpZq6Z5UJXrwPvQ1h1s2ohMul49DIBcq
 5eMeLHHsSKyDGR/C5OjLdw6wmAOeRA5gxq/S/ZOFyyqsQRhudJ78+Oarg/xvqGbY9RBTKiVXteP
 ReBaWqoDhUv0MpWc=
X-Received: by 2002:a1c:2e46:: with SMTP id u67mr5155387wmu.156.1589992125304; 
 Wed, 20 May 2020 09:28:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt3JwMfOBClPx27+NPomZTTvNAEsu8b5k+3QHAvMz/E8PNKC5niy1R94y5lWvH6f5tz/u+XA==
X-Received: by 2002:a1c:2e46:: with SMTP id u67mr5155379wmu.156.1589992125117; 
 Wed, 20 May 2020 09:28:45 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id s8sm3185108wrt.69.2020.05.20.09.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 09:28:44 -0700 (PDT)
Subject: Re: [PATCH 03/55] qdev: New qdev_new(), qdev_realize(), etc.
To: Markus Armbruster <armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-4-armbru@redhat.com>
 <9b329adc-8110-c108-996a-3b7d8463d042@redhat.com>
 <871rnft498.fsf@dusky.pond.sub.org>
 <c3c59472-9f2a-f30a-deed-36192840a892@redhat.com>
 <871rner7ki.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75f22571-138a-337b-a1c3-e715b1622bae@redhat.com>
Date: Wed, 20 May 2020 18:28:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <871rner7ki.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/05/20 16:42, Markus Armbruster wrote:
> If something goes
> wrong there, we execute
> 
>     fail:
>         error_propagate(errp, local_err);
>         if (unattached_parent) {
>             /*
>              * Beware, this doesn't just revert
>              * object_property_add_child(), it also runs bus_remove()!
>              */
>             object_unparent(OBJECT(dev));
>             unattached_count--;
>         }
> 
> and bus_remove() drops the reference count to zero.

Whoa whoa...  I didn't expect this from a failure to realize.

I think we should move the whole /machine/unattached dance into
qdev_realize, and just assert that a device being realized already has a
parent.  Then the ref/unref _will_ be unnecessary.  In the meanwhile, I
agree to either keep it or move it inside device_set_realized.

Thanks,

Paolo


