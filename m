Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B95C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575BB20870
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nt3wXzGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575BB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9BQ1-0000Yq-A5
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 12:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j9BPF-000074-Lw
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j9BPD-0007vG-RN
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:32:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28106
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j9BPD-0007uQ-J8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583256750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zpMMesB/yojyzxDJRZJzyLnS7D3dOaUA+VpQ5BLtPDE=;
 b=Nt3wXzGrmr6MkzYfXS52yiPYtlPGc+ZqiO90Cwgmx+cpmbARoVqvX1z5IbuLeabXZwwg/D
 Y2RcAjgN4FOd+WYKmlT59oohEHOPQf4bTQZ7ZyMDhDqLZ3a1nzPp8R97rIx1Wdc2Jq2S8/
 CoN94W3oWUxpbMZJY6jqdAwqyH2nx/A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-xOdFFvj5MaST8zuGzY6LNg-1; Tue, 03 Mar 2020 12:32:28 -0500
X-MC-Unique: xOdFFvj5MaST8zuGzY6LNg-1
Received: by mail-qt1-f200.google.com with SMTP id a29so2665388qtb.18
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 09:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+tIL4rkYPHIP5p+UUYjkiUmSIG5VK1bnvU7HzcO4dVU=;
 b=iwtsMw7Ixiwg2oVC1xusNujrZlMkuUAczxUdhLalllt6CAqK+jmQz9mim7+7VZu2lX
 D0fAW/FRXMvY6GZj7z9lRvT28pPf3H7chyKocH+dUo6LhoU14hRuzPs7U0Pb8wKV6qn/
 OAWTgWTL+B9vUwRoZj0i8+8GcAtjPvnblqeBo0dNhYRaKUjdaIZJfjRHrZBap0Cg3x4G
 +olgblBNGoVyvL0dML4Vnzd/uECDMv1Xn71AwWPg5fNvcXu+koiMidYDtjsPfwCDYXMX
 AFmVLg3ytoMeyhnIKsrpjDMjitIwqZtLp0tKilvCHA+iawIUD5J5Rli9hf88YZyQD26x
 rNoA==
X-Gm-Message-State: ANhLgQ2Kzd7f5F25h6mjWyZiVFwJVtBkw3m9JWcppkWl9mw8wvdg1jDX
 JXATsZOAvzu1GLpheaAaNpTGnb9EBuygh1vbTG+2NH2z3Lt0BiK8dESSW0AI0b6iw2/F4OGRiw4
 i6nnidqe20ylhqjo=
X-Received: by 2002:a37:4d8b:: with SMTP id a133mr5184457qkb.14.1583256747289; 
 Tue, 03 Mar 2020 09:32:27 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtvhigpLGKWaBY++6QQu8xFe0E4anIrWrMGRFLNrkWX3afo9eXiCz0of6fJMiVFjYkJimqytw==
X-Received: by 2002:a37:4d8b:: with SMTP id a133mr5184425qkb.14.1583256746975; 
 Tue, 03 Mar 2020 09:32:26 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id v6sm3998092qkg.102.2020.03.03.09.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 09:32:26 -0800 (PST)
Date: Tue, 3 Mar 2020 12:32:24 -0500
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 0/9] KVM: Dirty ring support (QEMU part)
Message-ID: <20200303173224.GD464129@xz-x1>
References: <20200205141749.378044-1-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205141749.378044-1-peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 05, 2020 at 09:17:40AM -0500, Peter Xu wrote:
> This is still RFC because the kernel counterpart is still under
> review.  However please feel free to read into the code a bit if you
> want; they've even got rich comments so not really in WIP status
> itself.  Any kind of comments are greatly welcomed.
>=20
> For anyone who wants to try (we need to upgrade kernel too):
>=20
> KVM branch:
>   https://github.com/xzpeter/linux/tree/kvm-dirty-ring
>=20
> QEMU branch for testing:
>   https://github.com/xzpeter/qemu/tree/kvm-dirty-ring
>=20
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> KVM dirty ring is a new interface to pass over dirty bits from kernel
> to the userspace.  Instead of using a bitmap for each memory region,
> the dirty ring contains an array of dirtied GPAs to fetch, one ring
> per vcpu.
>=20
> There're a few major changes comparing to how the old dirty logging
> interface would work:
>=20
> - Granularity of dirty bits
>=20
>   KVM dirty ring interface does not offer memory region level
>   granularity to collect dirty bits (i.e., per KVM memory
>   slot). Instead the dirty bit is collected globally for all the vcpus
>   at once.  The major effect is on VGA part because VGA dirty tracking
>   is enabled as long as the device is created, also it was in memory
>   region granularity.  Now that operation will be amplified to a VM
>   sync.  Maybe there's smarter way to do the same thing in VGA with
>   the new interface, but so far I don't see it affects much at least
>   on regular VMs.
>=20
> - Collection of dirty bits
>=20
>   The old dirty logging interface collects KVM dirty bits when
>   synchronizing dirty bits.  KVM dirty ring interface instead used a
>   standalone thread to do that.  So when the other thread (e.g., the
>   migration thread) wants to synchronize the dirty bits, it simply
>   kick the thread and wait until it flushes all the dirty bits to the
>   ramblock dirty bitmap.
>=20
> A new parameter "dirty-ring-size" is added to "-accel kvm".  By
> default, dirty ring is still disabled (size=3D=3D0).  To enable it, we
> need to be with:
>=20
>   -accel kvm,dirty-ring-size=3D65536
>=20
> This establishes a 64K dirty ring buffer per vcpu.  Then if we
> migrate, it'll switch to dirty ring.

Ping?

I'd like to know whether there's any high level comment about all
these... Considering that the kernel counterpart is still during
review, I guess we don't need to spend much time on that much,
assuming it'll be a ring of dirty addresses.  The rest should be
irrelevant to kernel so I'd glad to know if there's comments on those
parts.

Thanks,

--=20
Peter Xu


