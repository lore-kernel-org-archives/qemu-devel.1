Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D5C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EACD20855
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKzm506j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EACD20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXlCA-0007NB-0B
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXlAJ-00063f-Jm
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXlA7-00062b-A8
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:02:21 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38529)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXlA7-00060u-2x
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:02:15 -0500
Received: by mail-wr1-x443.google.com with SMTP id i12so4077653wro.5
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 04:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=isNco7UUUHtyAv20LsiGNSNfh0c6XsrJPF3qavcxgKs=;
 b=gKzm506jvVwx2XQare4aBEVWuNu5hsxrKRuWgd29Kk8/xYETmZtGDgNewZHSW5YAKM
 F1Lf/MvHiZ3Jm2v1pvWi4X/hNUCChYXtrT0EdrYWoHjgzslx2JaDx0gBeQsmCJuzQPvS
 IAHnDJhd03SJUAez8wgu+MGUnJO2X4elQ3NlqDqLqMHiI8pJ3mW4NWC1goUv39zf6/Kx
 v5AxOsoXsBk3SIA9pzlcxa3RjT53/VzCVrpAVRYZxZ9n/1jZb0/dRz0kxFOZPWrwXr0n
 J9lUJ3NDsTe5h4EmhRngfdk8t8MQ1Rw0WxktoqZPEBv2ZXEcfGum8LjA2ZXLWugTarBT
 kO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=isNco7UUUHtyAv20LsiGNSNfh0c6XsrJPF3qavcxgKs=;
 b=fresbhuss8/Zo23Ezk1/zW82U2UKL6oChuF6EHoSMQqpTTvRiKInY8X2qLC39xyKeF
 7Xg9kChwZrEynylyuZWJDisNMY1zhh2ncjviLr2VubqRkH4cp0OXihA4wJKDL2565Qta
 lnv5IYnL8xPrjpU/PuO9Wdrs+kjPQLgMivXBgyNCctj3lNrRRrBV41sM5NkQ1sLzCE4G
 /n4RXsrvwZm/v1JBIxVb0sN3c+67kpll+nlG10r+yoac26B8xHKQyac02SvH6mPQQX+K
 WkXCDPQ/T/p2xeBaQeIsa5UQZ0sKn3QW3IewV4smlZv7z1HwudmdktH1wV7Jykg2+PsB
 UHDg==
X-Gm-Message-State: APjAAAXltYz8KtlXGYOaoLYwN4mJpGtsp61rOEeIaoTxuydP8OSM5lz4
 m0xQjemG8+k+J9vTwRssncQ=
X-Google-Smtp-Source: APXvYqzHNwwelqjLnZ13Pl0Sf7iIZ/DJgGpnp9GieurHS0iVfxVmcx7cIw8IfWb+qCr32FSyu0ENRQ==
X-Received: by 2002:a5d:4609:: with SMTP id t9mr10347539wrq.178.1574337732697; 
 Thu, 21 Nov 2019 04:02:12 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id m13sm2674109wmc.41.2019.11.21.04.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 04:02:11 -0800 (PST)
Date: Thu, 21 Nov 2019 12:02:10 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 18/49] multi-process: create IOHUB object to
 handle irq
Message-ID: <20191121120210.GM439743@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <4a2836f10199fd0dcc30bceab963e99d6d77d89d.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iKKZt69u2Wx/rspf"
Content-Disposition: inline
In-Reply-To: <4a2836f10199fd0dcc30bceab963e99d6d77d89d.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--iKKZt69u2Wx/rspf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:08:59AM -0400, Jagannathan Raman wrote:

I don't know the interrupt code well enough to decide whether it's
necessary to do so much work and tie the protocol to the KVM API.  The
main QEMU process already has the KVM API code and the ability to deal
with these things.  I was expecting something much simpler, like
protocol messages that pass a single eventfd for raising an interrupt
and no state tracking interrupt levels.

> +static void intr_resample_handler(void *opaque)
> +{
> +    ResampleToken *token = opaque;
> +    RemoteIOHubState *iohub = token->iohub;
> +    uint64_t val;
> +    int pirq, s;
> +
> +    pirq = token->pirq;
> +
> +    s = read(event_notifier_get_fd(&iohub->resamplefds[pirq]), &val,
> +             sizeof(uint64_t));

Please use event_notifier_test_and_clear().

> +
> +    assert(s >= 0);
> +
> +    qemu_mutex_lock(&iohub->irq_level_lock[pirq]);
> +
> +    if (iohub->irq_level[pirq]) {
> +        event_notifier_set(&iohub->irqfds[pirq]);
> +    }
> +
> +    qemu_mutex_unlock(&iohub->irq_level_lock[pirq]);
> +}
> +
> +void process_set_irqfd_msg(PCIDevice *pci_dev, MPQemuMsg *msg)

This function doesn't handle the case where SET_IRQFD is sent multiple
times for the same interrupt gracefully.

> +{
> +    RemMachineState *machine = REMOTE_MACHINE(current_machine);
> +    RemoteIOHubState *iohub = machine->iohub;
> +    ResampleToken *token;
> +    int pirq = remote_iohub_map_irq(pci_dev, msg->data1.set_irqfd.intx);
> +
> +    assert(msg->num_fds == 2);
> +
> +    event_notifier_init_fd(&iohub->irqfds[pirq], msg->fds[0]);
> +    event_notifier_init_fd(&iohub->resamplefds[pirq], msg->fds[1]);

event_notifier_cleanup() is missing.

> +
> +    token = g_malloc0(sizeof(ResampleToken));

I couldn't find a g_free() and wonder if this needs to be malloced at
all.

--iKKZt69u2Wx/rspf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WfMEACgkQnKSrs4Gr
c8iX6AgAxP49vnwBfDp93tN+hr7w1tNYZtTv/74c6u47IojlRjhpX2SulgQo4TFg
ZKteYDy/oYZBV9IMh8IhVXeza509rR++/9pbwakDI9Pn8o/6fbD5d56ulscpE015
nFLdr6sc+rfi6bDXSxMqIqdoZM0C1QtjcmrM2Ciksvdk2fJd5fNMNgGKvO9/V657
RR2oB3Tgw0N3X99we6YhNhPFp+ilpDv5EVXH6vAVWEkZsaSVbQywjrZjanWKD0Kv
ik9Bdg5rwGUn9OR75ItGk4SHrlx7eRGRCoLgJDtfd38FGP2UV/Y5MJ+Ffd75M8xr
4kVWQjcYDA6EHZhPNNvlXwWJ56kFcg==
=QPh+
-----END PGP SIGNATURE-----

--iKKZt69u2Wx/rspf--

