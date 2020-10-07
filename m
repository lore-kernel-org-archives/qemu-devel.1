Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BA2C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6636B208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFc+sFU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6636B208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQAcF-0002sU-1G
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 10:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQAaR-0001I9-Vm
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQAaQ-0004mC-9W
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602081510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cwtyi5mke1eoDt0pN1WLFuvGiEoew0Jn49X+l4Xx2yQ=;
 b=ZFc+sFU3LGH1KNrRRSqDtCgmM1c0J1L+zqFlFgVmmazKx4GuWP/CYCoXd4TDJhusKx/QZR
 fprmYmHRJPzGBolsNaC29qSzhrrDMzOs8bpjntU+P5kfnWHUpspAIRHFIXRaWJJvvmRZsX
 EVKM8stCYKrvhejy1kpuB3c6tbZV8Zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-OtaPScuwNhyW3v7AXBN-7w-1; Wed, 07 Oct 2020 10:38:25 -0400
X-MC-Unique: OtaPScuwNhyW3v7AXBN-7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B9A38B7CED;
 Wed,  7 Oct 2020 14:38:11 +0000 (UTC)
Received: from localhost (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3844527CD2;
 Wed,  7 Oct 2020 14:37:39 +0000 (UTC)
Date: Wed, 7 Oct 2020 15:37:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v10 10/19] multi-process: introduce proxy object
Message-ID: <20201007143738.GD113587@stefanha-x1.localdomain>
References: <cover.1601923020.git.elena.ufimtseva@oracle.com>
 <20a943d22c931bc5d435d3356568df9a80fb8d8e.1601923020.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20a943d22c931bc5d435d3356568df9a80fb8d8e.1601923020.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2020 at 11:50:58AM -0700, elena.ufimtseva@oracle.com wrote:
> +static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
> +{
> +    PCIProxyDev *dev = PCI_PROXY_DEV(device);
> +    int fd;
> +
> +    if (dev->fd) {
> +        fd = monitor_fd_param(cur_mon, dev->fd, errp);
> +        if (fd == -1) {
> +            error_prepend(errp, "proxy: unable to parse fd: ");
> +            return;
> +        }
> +        proxy_set_socket(dev, fd, errp);
> +    } else {
> +        error_setg(errp, "fd parameter not specified for %s",
> +                   DEVICE(device)->id);
> +        return;
> +    }
> +
> +    error_setg(&dev->migration_blocker, "%s does not support migration",
> +               TYPE_PCI_PROXY_DEV);
> +    if (migrate_add_blocker(dev->migration_blocker, errp)) {
> +        error_free(dev->migration_blocker);
> +        error_free(*errp);
> +        dev->migration_blocker = NULL;
> +        error_setg(errp, "Failed to set migration blocker");
> +    }
> +
> +    qemu_mutex_init(&dev->io_mutex);
> +    qio_channel_set_blocking(dev->ioc, true, NULL);
> +}
> +
> +static void pci_proxy_dev_exit(PCIDevice *pdev)
> +{
> +    PCIProxyDev *dev = PCI_PROXY_DEV(pdev);
> +
> +    qio_channel_close(dev->ioc, NULL);

Call migrate_del_blocker() and delete dev->migration_blocker?

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl990rIACgkQnKSrs4Gr
c8iKXQgAvNitEGxV4bl76bkIjKxOOew658kEv4tUX6MdnbtlRr9oPWs1sIiXL78q
GiZHiQWWc2vpeSr6lmR9GjtMeJvO9ppAorhg6Rjc3x+b3728s1mNYBJXEIYXX6ZQ
9ilPLlfrfjW58Tvi08AjOqAvXwe1EDz646503j1qaGioG2fBK6nC1jrrxg06XQzd
39buV/PN/K1NGzNY+AJbNyKNZWTymaS+/Q7c0KzVBGT48nykdMWTaY62yTMnVxjV
b0iqW6So3CY2wR9RcFr5UKzEhb5pmqXhRL3zwDZO0p0LNlXzz8XCwdJPS0ehetPt
rAy2VaQQD3ttHMYfHFxpBFiB8/PcHQ==
=X3N7
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--


