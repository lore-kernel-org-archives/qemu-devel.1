Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBBEC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DB621850
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DB621850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiOch-0004RE-I5
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 15:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37090)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hiMg4-0002G5-SG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hiMg0-0007Xa-Gi
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:34:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hiMfz-0007Nw-UL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:34:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so1649477wmj.5
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 10:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=dnzxj1IkEQS5+Ji3niIKm++yqjlRY68EvWHVomKWYJc=;
 b=Jypopi23Cql0uou5bNPSZadXNQW0/fmKczJiNehwq28yBCbHU1Qd3XeQGtkKcDIKNf
 xMq/KUvL+obaI9gRsvjSIvmZoX7NcTLGtLV7ELft2bKd0e8UbiPJCf98/9hrn0bVm683
 P8PbabZ7ouAhBpEu1XkvREj3WKoooh4Bu2d+qvkzl5keQGRhSu+31IRmHprHF6XhVh6M
 IeR7gi3ZFP3ExmwS0OXqGYbhZM1Ct7xe9LrWMWWNqXBGDhWEYtwyIX5dys1cCFbGOUhY
 yZcmi+fNlFnNH+fz4Areo8/n+Bkl/IDYuhqejjkBKTbTDRJkza8UkxU/jWCGNGccNNZd
 EFhw==
X-Gm-Message-State: APjAAAWD95W//IVv+YH8NpVH3Gyn+MnnVxQ4WBmcYk1wpyef11yJ7WSN
 uZX5IhZ0qvFR5JUSeWP3Z16g0rowEVQHDA==
X-Google-Smtp-Source: APXvYqyrfqVPGpvFPbJFCfOizBpfdOTh+7MTufC9fXR1o5/m61ya+sxAmkuvpy+n+YCgXR5MEG0Zsg==
X-Received: by 2002:a1c:2d8b:: with SMTP id t133mr4144929wmt.57.1562088874028; 
 Tue, 02 Jul 2019 10:34:34 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id s188sm2176721wmf.40.2019.07.02.10.34.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 10:34:33 -0700 (PDT)
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
Date: Tue, 02 Jul 2019 19:34:20 +0200
Message-ID: <87a7dwnxwj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, maran.wilson@oracle.com,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 2 Jul 2019 at 13:14, Sergio Lopez <slp@redhat.com> wrote:
>>
>> Microvm is a machine type inspired by both NEMU and Firecracker, and
>> constructed after the machine model implemented by the latter.
>>
>> It's main purpose is providing users a KVM-only machine type with fast
>> boot times, minimal attack surface (measured as the number of IO ports
>> and MMIO regions exposed to the Guest) and small footprint (specially
>> when combined with the ongoing QEMU modularization effort).
>>
>> Normally, other than the device support provided by KVM itself,
>> microvm only supports virtio-mmio devices. Microvm also includes a
>> legacy mode, which adds an ISA bus with a 16550A serial port, useful
>> for being able to see the early boot kernel messages.
>
> Could we use virtio-pci instead of virtio-mmio? virtio-mmio is
> a bit deprecated and tends not to support all the features that
> virtio-pci does. It was introduced mostly as a stopgap while we
> didn't have pci support in the aarch64 virt machine, and remains
> for legacy "we don't like to break existing working setups" rather
> than as a recommended config for new systems.

Using virtio-pci implies keeping PCI and ACPI support, defeating a
significant part of microvm's purpose.

What are the issues with the current state of virtio-mmio? Is there a
way I can help to improve the situation?

Sergio.



--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0blZwACgkQ9GknjS8M
AjXaYxAAtABbPa3VQU4zYsUMyKT6FGtUrPXe2oPg51ZR+/pasmBp4zwfkmhLxILY
yleJZMWk6KJc2eKDEwWNY8II/lszUexUQIYVuj3AH9TUw53NQcwiKcyy59m9QHe+
hCQ+defFEfcK85zDbxHleW/zgkfSR61n+IEdJ5UzdEedZiVOcS/7BWqnXvNv18WV
4U3VqYMLAiqAoDfVxNKfcBN84DqHzeLWOVeZPeeNKHfPqTGXKtx01pyLrCz6N9Ud
Ddi2l+g8JhSVyG+n1IzczzpuGTFH6bN6sSrUjxV4bNR2sgAir3f+H1ofqXQSaI9P
Zmr2lpwCLl8QYTcUPMq7Xg/WB1+hIhMdqAgctC2j0CMl3dC6NKFZkPYu0DVhjFCx
dGivq0OWUckkxUyQph7IRUTzJkfQ2r6Z9Azb9S0G+dH01qG2R1pUN1GZNz9Jm3UE
grCJYGt0WbB7rPt59a5W6mFxnCPRcx1BzMmnuFif/9Y2IQ+RY48Jv/XSbkvI8e8z
PQTMVZgwoyVKc1n4v/uBAN8aDAKG4+ZRUXdOIXgH+IOCj+ruGWYB1UZ+lsBptcm0
aB0VGLNmkj+/rQNDRlCkSkVNIFaZSA2mhFPAYLqiMKr7whzWGB440MZnnGtzDUOO
ax0O/KfqPZUXTEDQLOcCQ7kjuu+nWjldfJfBpyIoQZNaQgEFHDw=
=lAaz
-----END PGP SIGNATURE-----
--=-=-=--

