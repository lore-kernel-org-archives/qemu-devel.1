Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0EDC10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 07:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBCB72146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 07:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvnTevKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCB72146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvXM-0000Vq-4B
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 03:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBvWa-0008Jq-3w
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBvWZ-0005nG-8l
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:11:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57791
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBvWZ-0005mw-5O
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583910686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K86sjCcsrj3JZLgqEbXg7dRp2slyYmk11vUIV/ZyqOQ=;
 b=IvnTevKOFLqRUHKctzs4cFrCrz4+SDrTVZAhJqcDOZxN35ZiMbnisnwmET1wJzFH6KOHnN
 CjJ8nuEJjEOzUuJ5zsjv2lAmKwevuLcxqGH4fyYH9BxRjt5Kim/r2SPLlllTZLcudC/h45
 wCJ091Ip/e3CUoLZgXyYLuYV9rS4ALg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-XLkOJSqEMymiTNTb9vE78Q-1; Wed, 11 Mar 2020 03:11:23 -0400
X-MC-Unique: XLkOJSqEMymiTNTb9vE78Q-1
Received: by mail-qt1-f198.google.com with SMTP id b10so579417qto.21
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 00:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YmH5wolq5pK+MJrgDi9QJAUA3jnnRoA4qZTnJTdyncw=;
 b=NOsFANJXEWtDjf/A7ceIWy1TmigVmJOX0bJOA4D36posC227v8hl+iKgZZok+v1sMp
 F8RD2HJxfCClK/ljzuVSrBX0maqOlgemViq9mzysups9docQHpOiTApKmja8lIGd07Tu
 JWqRbrbMFsFOztkpYRNpS20jyPFFDyU8dN1QI9V4SoTGYRQ3iRYiLrKNkvW9NBDjFpYC
 51znvgKjQf+i5cgBiCPFbjsi93DEFlLBRaFv697dfgaWBmsidQsYH6WhySOaVDbAfX7Y
 lLBJNRTOukqzgqbEKjX6/tsRmO4LG+lV9uvTh03t+U8+1T0WLE57iMpIFpCbUTStnNKQ
 O9mQ==
X-Gm-Message-State: ANhLgQ3mGeMlnz9YMKua7RCs02qJKPkU4NFzL9rFWHmR7ahLlC2/Ne0v
 9I6KCkV31kTyyV7Z4srouVkQQCD/mnYqAEPsla3NUv6Yt5n2Tb2PzIT7JKnfi2zu74Q6yxLswTB
 PPR6cy0Y5UFITKTE=
X-Received: by 2002:a37:4fc3:: with SMTP id d186mr1543048qkb.100.1583910683423; 
 Wed, 11 Mar 2020 00:11:23 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvSO6fVv6tB7utTRDkKq0Dv0JhkBSyK1SaSCPskXOmuIaM8k/hRtN8BPjP5CyUO1R+i03adww==
X-Received: by 2002:a37:4fc3:: with SMTP id d186mr1543034qkb.100.1583910683204; 
 Wed, 11 Mar 2020 00:11:23 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id p16sm3901542qkj.5.2020.03.11.00.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 00:11:22 -0700 (PDT)
Date: Wed, 11 Mar 2020 03:11:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 1/2] spapr: Disable legacy virtio devices for
 pseries-5.0 and later
Message-ID: <20200311030812-mutt-send-email-mst@kernel.org>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200305043009.611636-2-david@gibson.dropbear.id.au>
 <20200310115611.GE3234052@redhat.com>
 <20200311005857.GS660117@umbus.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200311005857.GS660117@umbus.fritz.box>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: pair@us.ibm.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, aik@ozlabs.ru,
 groug@kaod.org, qemu-devel@nongnu.org, paulus@samba.org, clg@kaod.org,
 mdroth@us.ibm.com, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 11:58:57AM +1100, David Gibson wrote:
> Note that several things that I believe are now in the PCIe spec, but
> really derive more from PC legacy considerations, don't apply at all
> for PAPR.  e.g. there's no meaningful distinction between integrated
> and slotted devices, multiple independent host bridges is routine and
> doesn't require any (virtual) hardware visible domain numbers.

Domain numbers are a Linux thing, not a PCIe thing. On x86 they come
from ACPI segment numbers. As such they aren't usually hardware
visible on x86, they are supplied by firmware.

--=20
MST


