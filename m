Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88003C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D4F24954
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1jlIcOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D4F24954
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZRX-0003T2-GT
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 07:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jVZQR-0002Ql-9Y
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:38:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27514
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jVZQQ-00074S-GC
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588592297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EGJ0U6EiPshaog/EIJUxrcwcS68yY9pnastgfSsfyAM=;
 b=K1jlIcOx+rMxL7s0YgPOkW1QRIrvo8Zxs9lS1tUYT8bBLAGI4wBfRSEbo/cntivmSQ4rD+
 AqSSdMTg0kSc2RXzwKITtyJ0c2NQF/V+vfG46LisFRrgiyeWZkaSVATSw7op2JRa9lSHW/
 yfvNLZyrFiX9MsyddKPo4L2ulGKXwWk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-XqSaPcZAMKOSIjCqU3hHrw-1; Mon, 04 May 2020 07:38:15 -0400
X-MC-Unique: XqSaPcZAMKOSIjCqU3hHrw-1
Received: by mail-wr1-f70.google.com with SMTP id y4so5551588wrt.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 04:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=IWYhX6G9isojKRwBypffrCH3NPzaiUCAZVggMhcLl98=;
 b=SxgT1Qx6h7zq0qvkGYTNp4oXrvcn4gqEphUQeUXOaiv+A4tQsdnoHhPh6VcHk9GBb8
 27hTVw/KB4PRvkdcqf4Jv3ZghV/R/NxrbP6hQ4xcZi1GX/NYQu31Py7cCuCIKbOfYOSn
 Vy7tRy3d0pe5Fqs1sSRDJ8WulioOkm7RviebrhNttK7CMNQvR/1nFZ81rX/L5aZV3E7j
 j/3vAfgSH2jqC9cGzWIc0b38B5A1zWRL4D2wHPudIcIy7d+4UHk3l8J0yXHByjYCs1b3
 L4L8o7HoIzVUEqewcQfCiOpJ8dNZAaFjuTjvXHEg+1KFXlsL0J4iOWlRNnDN8Wyr9J7Q
 Sycg==
X-Gm-Message-State: AGi0PuapM/bDL5nx9Q/XeSuK6bKcCVfsXpCDliqHSjcOQd/w2xkC2zgA
 bLya7PbxmEhhSgrUa65NrPmG8TDnj/nJ6dEVQcmsP9Cxjyf2x2QwBsA3H8ndpUUQqQkx0d+syjG
 TD71t3H+TIk5m2a4=
X-Received: by 2002:adf:e943:: with SMTP id m3mr18153186wrn.248.1588592294476; 
 Mon, 04 May 2020 04:38:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypJcZv5d4PUBp64fJoEJZtNISg1vlkrOuq0ei2xoaBXNsScUG6C2wNTtaFiWiNQJjXibmzK9Kg==
X-Received: by 2002:adf:e943:: with SMTP id m3mr18153161wrn.248.1588592294277; 
 Mon, 04 May 2020 04:38:14 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
 by smtp.gmail.com with ESMTPSA id z1sm12483743wmf.15.2020.05.04.04.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 04:38:13 -0700 (PDT)
Subject: Re: [PATCH 0/4] RFC/WIP: Fix scsi devices plug/unplug races w.r.t
 virtio-scsi iothread
To: Stefan Hajnoczi <stefanha@gmail.com>, Maxim Levitsky <mlevitsk@redhat.com>
References: <20200416203624.32366-1-mlevitsk@redhat.com>
 <20200504105949.GD354891@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8bb0f2e6-fae8-794b-7954-f9c4add34eee@redhat.com>
Date: Mon, 4 May 2020 13:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200504105949.GD354891@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dztgX3BXh7YSPBAaNsD88VLCYdQtvqqxs"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dztgX3BXh7YSPBAaNsD88VLCYdQtvqqxs
Content-Type: multipart/mixed; boundary="nZGmD2b5I8JhOKb1l0TlxHNsnr4nqbNyv"

--nZGmD2b5I8JhOKb1l0TlxHNsnr4nqbNyv
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/05/20 12:59, Stefan Hajnoczi wrote:
> Regarding drive_del, I guess the issue here is that this HMP command's
> semantics need to include not synchronize_rcu() but some kind of
> drain_call_rcu() operation as well that ensures deletion has completed?

Good idea, this would be Linux's rcu_barrier().

It would be a pity though that we have to do this instead of just having
the test rely on the DEVICE_DELETED event.

> drain_call_rcu() can be implemented by invoking call_rcu(temp,
> drain_call_rcu_cb, rcu) where drain_call_rcu_cb() sets a QemuEvent that
> the caller is waiting on. This way the caller can be sure that all
> previously queued call_rcu() callbacks have completed. call_rcu_thread()
> needs to be tweaked to avoid g_usleep() and instead use a timed wait so
> that drain_call_rcu() can immediately wake up the thread.

This was actually intentional in order to let some RCU callbacks pile up
(based on the observation, or the hope, that RCU data structures are
written rarely).  But the overall delay would be 50 ms so I don't think
it's a big deal to keep the unconditional sleep. The synchronize_rcu()
call could be on the order of 50 ms if --enable-membarrier is in use.

Another thing to care about is that call_rcu needs the iothread lock, so
you need to release it around the qemu_event_wait() call.

Paolo


--nZGmD2b5I8JhOKb1l0TlxHNsnr4nqbNyv--

--dztgX3BXh7YSPBAaNsD88VLCYdQtvqqxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl6v/qQACgkQv/vSX3jH
roMC/Qf8DlSug1g03bMD5HmaYx2GUEL2g7SG23EGMfccAI9pDMCRmsmJMVQER3JZ
0gXQxASw+NVqlocNoVtCSZL5KKbuURT1g3qbekJbL2n0XFxrGOqI8HXdtcjxTLNu
12M7iNZDUKzqeEmTK45SPCU2DU7FdGSRX6glkfnOxMkgUtQthGSnbUqe7wQjVjwu
S+UEhogVYLONHggcMMaP0frgTBOlNaGsqECdno9CyxZuzYLOoMjOvgUHG8Q8fnZP
Ls5ivmfF0gzOtaD5so1209eR7c2lMvoX8qCvPQ8THPypO9R5OfKoTqWq1XW3GPuK
TvH6AdvPOCSSw0c2vUvThrk5vretfg==
=BS/q
-----END PGP SIGNATURE-----

--dztgX3BXh7YSPBAaNsD88VLCYdQtvqqxs--


