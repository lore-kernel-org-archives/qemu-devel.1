Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C671C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225372072F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+MwT24h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225372072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigfp-0001Uz-Fe
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jigej-0000t0-QU
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:59:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54646
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jigeh-0002Ub-H9
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591718354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IvX4MY1gsw11baoE9fVtL/Xc+0OA1/v+Fa1wl7rhwsU=;
 b=R+MwT24hrwHYiQ79tvkyexV9iekB34EAKy6HAWydxzYB/TiBVkJ0K28le4cs9sV2FogONI
 wVa0lH9TlrroClQ9UjYDJpBlODHe5/RVGKI7/vprdT2odYBLiulJj8wjCcmj/V6QMAm/CD
 8H2UJ3Oj9diVFuwKSOJrmAFR8Vh7V5Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-lrt8VkHtMfKzGiFoSjXQZA-1; Tue, 09 Jun 2020 11:59:10 -0400
X-MC-Unique: lrt8VkHtMfKzGiFoSjXQZA-1
Received: by mail-wr1-f71.google.com with SMTP id o1so8726382wrm.17
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 08:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IvX4MY1gsw11baoE9fVtL/Xc+0OA1/v+Fa1wl7rhwsU=;
 b=kCBy9X5mj4qdxhSn+r/N7+VW8uLlPvAPW/N4bL/3Whtb4X4jne9mQ/2QF3kRVJ02zP
 BPiSrcdXB8+iXPsZ0fTqvo6NZjD9GTNaDvT3M6/7pli0XuKrZiT97rKlsHTEdxF0ng7M
 +zGUXIZ1xfRW3b8gJchPt6mAvw9HFPZBt+eYpIumBs2xDrAQUdB5WUpIbbePv3G4i1qq
 qDXl3vt38lwOGp/ZjWwzYeuL+yB41hnncnpuJhxiPoiTOR81MvW3kse3RbuBq8zsYvhM
 3kEwm/gUe8BvNY6nidNUzswwLYE/4eJEAKimilc0fb1ywOpR2R1pgMu/XX0zm1sIeEMK
 EhBg==
X-Gm-Message-State: AOAM531YGTgKhX4TLCARgTs2rwI1uPSyOINh53p0OzoI6I6JEWgRwmiB
 lZzFkLnT8fQFxdKMRqns3fMthBwr3KdsneWu1mu+f66Jl7eUU9jsDjvtmAiCzxDaACblYE3/xNB
 /YWTPYRcvRHkoUiw=
X-Received: by 2002:a1c:9687:: with SMTP id y129mr4778372wmd.30.1591718349373; 
 Tue, 09 Jun 2020 08:59:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyibN2lbUyKDvxytVLjKnsF4xx+IbA9pINaacVnINFW4dpxhMVQxcHP1bSrEeNrEprQ5mFQQA==
X-Received: by 2002:a1c:9687:: with SMTP id y129mr4778326wmd.30.1591718349147; 
 Tue, 09 Jun 2020 08:59:09 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id j18sm3992059wrn.59.2020.06.09.08.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 08:59:08 -0700 (PDT)
Date: Tue, 9 Jun 2020 11:59:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 00/20] virtio-mem: Paravirtualized memory hot(un)plug
Message-ID: <20200609115814-mutt-send-email-mst@kernel.org>
References: <20200603144914.41645-1-david@redhat.com>
 <20200609091034-mutt-send-email-mst@kernel.org>
 <08385823-d98f-fd9d-aa9d-bc1bd6747c29@redhat.com>
MIME-Version: 1.0
In-Reply-To: <08385823-d98f-fd9d-aa9d-bc1bd6747c29@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, teawater <teawaterz@linux.alibaba.com>,
 Janosch Frank <frankja@linux.ibm.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Richard Henderson <rth@twiddle.net>, Eric Farman <farman@linux.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 09, 2020 at 03:26:08PM +0200, David Hildenbrand wrote:
> On 09.06.20 15:11, Michael S. Tsirkin wrote:
> > On Wed, Jun 03, 2020 at 04:48:54PM +0200, David Hildenbrand wrote:
> >> This is the very basic, initial version of virtio-mem. More info on
> >> virtio-mem in general can be found in the Linux kernel driver v2 posting
> >> [1] and in patch #10. The latest Linux driver v4 can be found at [2].
> >>
> >> This series is based on [3]:
> >>     "[PATCH v1] pc: Support coldplugging of virtio-pmem-pci devices on all
> >>      buses"
> >>
> >> The patches can be found at:
> >>     https://github.com/davidhildenbrand/qemu.git virtio-mem-v3
> > 
> > So given we tweaked the config space a bit, this needs a respin.
> 
> Yeah, the virtio-mem-v4 branch already contains a fixed-up version. Will
> send during the next days.

BTW. People don't normally capitalize the letter after ":".
So a better subject is
  virtio-mem: paravirtualized memory hot(un)plug

and so on for all patches.

> -- 
> Thanks,
> 
> David / dhildenb


