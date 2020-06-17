Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208B9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26DA214DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoN7DdJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26DA214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYV7-0007Dx-4Z
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jlYUR-0006Kc-Tm
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:52:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36326
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jlYUP-0008LZ-Ex
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592401947;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mZDXU7aTxy7XvV0+iL47Qkn6zzxtfkSaHrYp+NE1YGo=;
 b=VoN7DdJxPY9VVFObaTVooarCUOIfzeRWoywmTZWnIhLTN9YOBrBDHaqdm+T9jK541ueWAQ
 sVu8RdVzYuFurGFTXZG1aXYv6YRLmFmJ3Cj9cS0VSvUzyOZcm1Uebw20g3Xwkv3EYlYVVv
 A5G5pE1eckcvgw0xw6cMoO978CZ/vCo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-rVioeB8dOJKkKGcAJWYpSQ-1; Wed, 17 Jun 2020 09:52:26 -0400
X-MC-Unique: rVioeB8dOJKkKGcAJWYpSQ-1
Received: by mail-wr1-f70.google.com with SMTP id a4so1212612wrp.5
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 06:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=mZDXU7aTxy7XvV0+iL47Qkn6zzxtfkSaHrYp+NE1YGo=;
 b=aEGsmgt1pzMdjdSYorVcAspPf8oo5XHTSlJadw7qmo9KPxYBv9kl2qi0/8if+Tl6gF
 xICgz6+nzzL6NXffpD+q6W/Wzq0R4nGKbLslB+yEaf0egp3vocU1GoeCioaUPR6Xw4xn
 cpw8dmTW9hsrE+ein37taq8riMyuwc34p3whq3xKzQLZsoh/K1YRV2DcKC0Hdq/E+pbU
 jUuq4rzI6rMaONMHtUB6g+Z6JGhHiCBOOEoLkLSKM0gYDO+VXw7N9lEP58bAjBp9JLti
 lMGFblWK5I1JYlhci1QB98xmPcaSpy0EZ5JGndH/NOTguQR7ChpXlWEauqQ12f2pVvTw
 IfVQ==
X-Gm-Message-State: AOAM531FmJIMHy5RIc1Z1GLDvIMCtML8FoSRlkOnRtbz2wyZTafWXxpB
 0ykXhcVySxudN0rJBgB9sHDNR+MDEF8lqhlv4p6n3hZgXV55eeIuCMPnNvpdNQbaL/frPzSo1vG
 sraR39WccipJUe/o=
X-Received: by 2002:a1c:7dd5:: with SMTP id y204mr8204874wmc.182.1592401944810; 
 Wed, 17 Jun 2020 06:52:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwH4Rx1y1wpUblX4pFi5nJP3Pok0zu7Qh9qgSdiO0uaRfy+ME3QcrgirFBxY0AxHa2yzWIvw==
X-Received: by 2002:a1c:7dd5:: with SMTP id y204mr8204861wmc.182.1592401944584; 
 Wed, 17 Jun 2020 06:52:24 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id a6sm33279637wrn.38.2020.06.17.06.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 06:52:24 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] migration: fix multifd_send_pages() next channel
In-Reply-To: <20200617113154.593233-1-lvivier@redhat.com> (Laurent Vivier's
 message of "Wed, 17 Jun 2020 13:31:54 +0200")
References: <20200617113154.593233-1-lvivier@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 17 Jun 2020 15:52:23 +0200
Message-ID: <878sgl7qaw.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Reply-To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> wrote:
> multifd_send_pages() loops around the available channels,
> the next channel to use between two calls to multifd_send_pages() is stored
> inside a local static variable, next_channel.
>
> It works well, except if the number of channels decreases between two calls
> to multifd_send_pages(). In this case, the loop can try to access the
> data of a channel that doesn't exist anymore.
>
> The problem can be triggered if we start a migration with a given number of
> channels and then we cancel the migration to restart it with a lower number.
> This ends generally with an error like:
> qemu-system-ppc64: .../util/qemu-thread-posix.c:77: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.
>
> This patch fixes the error by capping next_channel with the current number
> of channels before using it.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


