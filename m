Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE8ECA9EC9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 04:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B552083E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 04:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUBgIvJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B552083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQOES-00056p-3F
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 00:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iQODM-0004Rg-Sc
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 00:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iQODK-00074U-JD
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 00:07:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22333
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iQODK-00070q-8E
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 00:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572581224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t2daL2lc+mNiG+yNduCCQfg4NqVO8/KVSabnd9S96eQ=;
 b=BUBgIvJvn50gE/DEH9wgDDdrHyhMj0MQjFEAPJgbOJaRtYOGjE+yRaSkLw98sIzNsUBrRm
 NGC9zQ11ONBrWISpNSTIuuycBFppcGDeAm3MlhGyoVMpirN+2l9Z6n1wtelOvwG8KHTD8m
 NLmriRXW2bPlg4sAwzqLPHEYU3Dy0a4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-wb7xTze-OJunsXE2ygvBAQ-1; Fri, 01 Nov 2019 00:07:02 -0400
Received: by mail-qt1-f199.google.com with SMTP id u26so8667367qtq.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 21:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=nLOJHIiZAsXpj22dreqdeOji5yeBZe3vA+QI7NJTGo0=;
 b=KlBlpCWmWmXjkXQP1cpjyJiRRr+Xnn6jSGlB8KZLdYUUtkqDCdXJGLvNWS/Gh0mXQ5
 3lSQI2kK4th9ikIEdzeYt3FwurBUG/qWda1GLv2Pd/PLDhmWn3AOK8fUeyvi09olVTkB
 KBesJ/DTxFq+Gs9i9gK112nf6DqikrG1gixCw1uHRtoyn+bTywPGuufNTN/DOZV5DzCv
 PA1+b0PZSv8DWuQf6i5MwbIdA0idVXXDnA5V1AJ7HXLyQL+vOBCPg6WPvHt+UvXVSMma
 oA8taQwZOXn2KaB/350PZ7unZO+QUSwpUtIc+psNqPhc6qic+pfygePgO6kWJTNkpkkv
 RuYg==
X-Gm-Message-State: APjAAAUpWr9hpPHsEa6z/mB1VIqYsBjQDd6VRwL+CuVPHdDnbTdA1pYa
 dmJ+fLh2MsHJETNeNdB9KIi8ykIJnM8RMvfmAbO+CHeZyMp29ea4yTRrKpnKSqU5EtcsQwz1A1F
 v/f6FcozPRqxO8DU=
X-Received: by 2002:a37:4350:: with SMTP id q77mr3913285qka.266.1572581221295; 
 Thu, 31 Oct 2019 21:07:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw1BeMvLF0sK2BlgbFLBvSd4pkntwJxqQyejDLAl6jlWjl5fLfUZ/mCvGVhGUDp+E4au0gs9Q==
X-Received: by 2002:a37:4350:: with SMTP id q77mr3913266qka.266.1572581220997; 
 Thu, 31 Oct 2019 21:07:00 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id k40sm3600997qta.76.2019.10.31.21.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2019 21:06:59 -0700 (PDT)
Date: Fri, 1 Nov 2019 00:06:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org
Subject: Re: presentation at kvm forum and pagefaults
Message-ID: <20191031234601-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-MC-Unique: wb7xTze-OJunsXE2ygvBAQ-1
X-Mimecast-Spam-Score: 1
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Regarding the presentation I gave at the kvm forum
on pagefaults.

Two points:


1. pagefaults are important not just for migration.
They are important for performance features such as
autonuma and huge pages, since this relies on moving
pages around.
Migration can maybe be solved by switch to software but
this is not a good solution for numa and thp  since
at a given time some page is likely being moved.




2.  For devices such as networking RX order in which buffers are
used *does not matter*.
Thus if a device gets a fault in response to attempt to store a buffer
into memory, it can just re-try, using the next buffer in queue instead.

This works because normally buffers can be used out of order by device.

The faulted buffer will be reused by another buffer when driver notifies
device page has been faulted in.

Note buffers are processed by buffer in the order in which they have
been used, *not* the order in which they have been put in the queue.  So
this will *not* cause any packet reordering for the driver.

Packets will only get dropped if all buffers are swapped
out, which should be rare with a large RX queue.


As I said at the forum, a side buffer for X packets
to be stored temporarily is also additionally possible. But with the above
it is no longer strictly required.


This conflicts with the IN_ORDER feature flag, I guess we will have to
re-think this flag then. If we do feel we need to salvage IN_ORDER as is,
maybe device can use the buffer with length 0 and driver will re-post it
later, but I am not I am not sure about this since involving the VF
driver seems inelegant.


--=20
MST


