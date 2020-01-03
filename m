Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B544AC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 15:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818BA222C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 15:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V24T1xMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818BA222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inOsy-0008G3-KE
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 10:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1inOsA-0007Mc-Ky
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1inOs9-0008Eh-Kp
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:28:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50310
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1inOs9-0008Am-FM
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578065300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKW5JgzXq9/DDcVgW5e7YzOajK/YRbDXw0aOg/5m8CA=;
 b=V24T1xMqXOTdlRTaP45xqs2xPUoVzsMoF9Gc/fimyLnD9cLrv5elXAFrCJIuTDID5PibdG
 GR3FPnOR47TQ947xKjZiw4OGttrmZan/LvuqfBw9lC1CrRxe+EZauuj9PIT5AFrECXBJUE
 36hZC79ErfoPkDCfLeuNNOkdHwU+h0w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-cZfFwbpMMUeLB8CaJK5SNA-1; Fri, 03 Jan 2020 10:28:17 -0500
Received: by mail-qv1-f71.google.com with SMTP id di5so13588030qvb.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 07:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WdjhFPltw3/cRaBDdvpq7k3opO3CseO9beCeTDxXYvU=;
 b=acTm8daMhh3hOnXZgNTWjImx6hrcKVRJmL4WZL1pa+zo6wwJk6E+UJg9iy7TtEWacX
 ZSLwj2MyR8yfufw0igApC8eZGhCUihVbwLUtYVh/MoxfDmUrFBCbXDZhANW8due+tgro
 M8DA1LVt3kbRtQE5/QHc8kdcuGNOlhLqT2yO1qQ9WTkbdXjqLQAZDtVEADzkMHkYC8PF
 JNUq/73FYaVkjHwejj9G/MyiW1HBANRSkUaVqZ9Dhr/swvnmNA+J2UTFlm/H8W/sto1m
 p1Qks5bnyVQ9MbTlbfV/GX5fJpPVvZGpoZVagOyHEr1EnK3wCOXUAJb4pSMixZoNIK/V
 ZHvg==
X-Gm-Message-State: APjAAAWv3pz9VcILdoL2ww9UfpaDLLuMoholmjRD9X4KUia3HGTfnDEr
 jm9Y2HC0Tg0W/vDk4beon8HmgYvSadwInhgfmtiGt8UuBCzbREhmzWgFAz2uXRVZgiuMyl6F/nv
 jWUcpM7A4KolNlIE=
X-Received: by 2002:ac8:3fb6:: with SMTP id d51mr65721556qtk.288.1578065297259; 
 Fri, 03 Jan 2020 07:28:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxo1jsXAoPo6npNyTNbwMFJEV+lJa1WGGt882BfrtVr9MSDPh5OMLaYqNFu42VdSxa0GyCchw==
X-Received: by 2002:ac8:3fb6:: with SMTP id d51mr65721540qtk.288.1578065297101; 
 Fri, 03 Jan 2020 07:28:17 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id 68sm16715621qkj.102.2020.01.03.07.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2020 07:28:15 -0800 (PST)
Date: Fri, 3 Jan 2020 10:28:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 0/2] intel_iommu: two fixes to intel scalable vIOMMU
Message-ID: <20200103152814.GA157597@xz-x1>
References: <1578058086-4288-1-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1578058086-4288-1-git-send-email-yi.l.liu@intel.com>
X-MC-Unique: cZfFwbpMMUeLB8CaJK5SNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: kevin.tian@intel.com, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, yi.y.sun@intel.co
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 03, 2020 at 09:28:04PM +0800, Liu Yi L wrote:
> These two fixes are found in vSVA implementation, and could be
> upstreamed separately. Please feel free give your comments.

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


