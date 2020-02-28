Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C70DC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF6524677
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vj7c/rKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF6524677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7lzm-0004Ej-Tn
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 15:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7lz9-0003lm-E5
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7lz5-00051M-Ob
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:11:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44936
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7lz5-00050T-Ja
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582920702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UrH3TJLvEpDLWDZgcWrZri7XODPQnK280EQRKLNtbJQ=;
 b=Vj7c/rKbx9d3iLuheXPU+1IqBpnyCdQYxqZtjz6VMfpfLEdvBPNTrTrZq6fcFGS3Mgm53l
 1JIJMfI0+IGYPj77i/+b/YRZ51QyvVexWGcI/RMcqOoZMcuwCn1vqRNUPC+iD39cBvIasX
 CAzzADAr/24iRMC0ZqT7fe0GagGD3S0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-FYW_L3u4OMmokH0lMjcWSA-1; Fri, 28 Feb 2020 15:11:40 -0500
X-MC-Unique: FYW_L3u4OMmokH0lMjcWSA-1
Received: by mail-qt1-f199.google.com with SMTP id e8so3879693qtg.9
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 12:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=amuiEVHcWOkaK4KGtdX1nppvYmYBPjXukIrO1DA9TiI=;
 b=E1EgRyxrpAAP0hVOe7a4is9tB8KVkiod1WUStAjXTwTEG3auineoalRKoB1g0FWVHD
 U0GDlbkKG0+sOupDm+IkdSxmHolz+q242ik/GUsfTLSCZUjFnSGXZ3y856I3MgYFcPbD
 /sWlqnp620yn+hiovPCJ0l3nCBFslKd2kqMzSw3do83b9hr8VwyKPk/B8V3i1Z3PqgnG
 bd+RX9Q4F8rSOeRNuZAUnRWhCwOQOrOPzPmIG6ARxOF4zh3IEa5xyYbVm45Vdguu+SBI
 hB3b9cnP/H8WY0iCjTQ1F26uyFVpEUlPNa3Rb/cT2bmxmGdu2APL7tZxXsXqSjU42gzl
 ZPkg==
X-Gm-Message-State: APjAAAXEpFIUqlKuxPJq4pKn4uKRn1gmLIpWad66r5RbK7vpjcFDUD4o
 FmwLp3jrTy5QAOOxqiPlOgC0Ld88jJBrjX95OcRVUG5eE7m+MYFqXGZ6ZkS4fkox68y43xySB8H
 s5nm3xvf3yHWhEMk=
X-Received: by 2002:aed:3324:: with SMTP id u33mr5698187qtd.322.1582920700014; 
 Fri, 28 Feb 2020 12:11:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVOLIrCRt3r420gw5R3LUCAWZtT8tGDULxEgGtI8wQIR2jftxx9/NnQdMj8xBRoadEw2mG5w==
X-Received: by 2002:aed:3324:: with SMTP id u33mr5698166qtd.322.1582920699790; 
 Fri, 28 Feb 2020 12:11:39 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id u49sm4429395qtj.42.2020.02.28.12.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 12:11:39 -0800 (PST)
Date: Fri, 28 Feb 2020 15:11:37 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 13/15] util: oslib: Resizeable anonymous allocations
 under POSIX
Message-ID: <20200228201137.GZ180973@xz-x1>
References: <20200227101205.5616-1-david@redhat.com>
 <20200227101205.5616-14-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200227101205.5616-14-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 11:12:03AM +0100, David Hildenbrand wrote:
> Introduce qemu_anon_ram_alloc_resizeable() and qemu_anon_ram_resize().
> Implement them under POSIX and make them return NULL under WIN32.
>=20
> Under POSIX, we make use of resizeable mmaps. An implementation under
> WIN32 is theoretically possible AFAIK and can be added later.
>=20
> In qemu_anon_ram_free(), rename the size parameter to max_size, to make
> it clearer that we have to use the maximum size when freeing resizeable
> anonymous allocations.
>=20
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Stefan Weil <sw@weilnetz.de>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


