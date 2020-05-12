Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2673CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9FF20736
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1kJkAJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9FF20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXSk-0004Jp-PQ
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYXRn-0002Sn-KW
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:07:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44740
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYXRm-000529-N5
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589299675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4XboVtiWrVzbUvsXXEsRphA4+a67ogMFb83jkQCD2qA=;
 b=b1kJkAJcMUbrVH3gxwlzLveOfq9oSW/+1djAcjU9MU5/REQhtAhyYTtoRM2vMETOekyQyV
 4FVHw9N5Qnz+KAcXNZhbLzzkTXZanO+B+QVGZzbNA13oLuUOhWorInvZYp02qud/Dy4uar
 xP0YaEFgsmVJz+LVvzh9QaOE70Q2p7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-e85e6NATMgSxSgT4sZ3ZGQ-1; Tue, 12 May 2020 12:07:51 -0400
X-MC-Unique: e85e6NATMgSxSgT4sZ3ZGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ECD7107B267;
 Tue, 12 May 2020 16:07:49 +0000 (UTC)
Received: from localhost (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 238E8196AE;
 Tue, 12 May 2020 16:07:42 +0000 (UTC)
Date: Tue, 12 May 2020 17:07:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 24/36] multi-process: Retrieve PCI info from
 remote process
Message-ID: <20200512160741.GN300009@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <edd1d0741c6be69831dbaa8f9ef2321bce3169e3.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <edd1d0741c6be69831dbaa8f9ef2321bce3169e3.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="McpcKDxJRrEJVmOH"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--McpcKDxJRrEJVmOH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2020 at 09:13:59PM -0700, elena.ufimtseva@oracle.com wrote:
> @@ -291,3 +299,79 @@ const MemoryRegionOps proxy_default_ops = {
>          .max_access_size = 1,
>      },
>  };
> +
> +static void probe_pci_info(PCIDevice *dev)
> +{
> +    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
> +    DeviceClass *dc = DEVICE_CLASS(pc);
> +    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
> +    MPQemuLinkState *mpqemu_link = pdev->mpqemu_link;
> +    MPQemuMsg msg, ret;
> +    uint32_t orig_val, new_val, class;
> +    uint8_t type;
> +    int i, size;
> +    char *name;
> +
> +    memset(&msg, 0, sizeof(MPQemuMsg));
> +    msg.bytestream = 0;
> +    msg.size = 0;
> +    msg.cmd = GET_PCI_INFO;
> +    mpqemu_msg_send(&msg, mpqemu_link->dev);
> +
> +    mpqemu_msg_recv(&ret, mpqemu_link->dev);
> +
> +    pc->vendor_id = ret.data1.ret_pci_info.vendor_id;
> +    pc->device_id = ret.data1.ret_pci_info.device_id;
> +    pc->class_id = ret.data1.ret_pci_info.class_id;
> +    pc->subsystem_id = ret.data1.ret_pci_info.subsystem_id;
> +

Why introduce the GET_PCI_INFO/RET_PCI_INFO messages when the same
information can already be fetched using PCI_CONFIG_READ?

> +    config_op_send(pdev, 11, &class, 1, PCI_CONFIG_READ);

Please use constants like PCI_CLASS_DEVICE instead of magic numbers.

> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
> index 14e4be2bd0..102c736705 100644
> --- a/include/io/mpqemu-link.h
> +++ b/include/io/mpqemu-link.h
> @@ -48,6 +48,8 @@ typedef enum {
>      BAR_WRITE,
>      BAR_READ,
>      SET_IRQFD,
> +    GET_PCI_INFO,
> +    RET_PCI_INFO,

Ah, I see reply messages are being used after all. I suggest dropping
the eventfd wait mechanism and using reply messages instead. Otherwise
you need to duplicate the wait timeout for reply messages. Using
temporary eventfds is more complex and maybe also slower.

--McpcKDxJRrEJVmOH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66yc0ACgkQnKSrs4Gr
c8hk4Af+ItLllGjEPUnrQazh7dblLguGMdCHzgZ0k/nDV3y/rWtBK5VBCrNCUpek
UaZHtl9WbMjsoYFR3gK9DwwqcTZfrJpblHcsksQmqHst7FWmzmWU28ZWlsl/HvDK
SHEpKbZqGLtL5kLccy0XFDoe+6OJrGWYIjOzsmZjwr1VQTvoF1na9z+CURxvrgkB
Sp/kZadeJDJMjnrhz5uuytJhecqolqPr4fEVXMQwQe3K7LDNexfZ1nDH54nkdkPB
N0l9FB6v7/D3FL+jpHGAxR+KwR0JXj5BU7USrT7LPzhFmutOlK/sFABjMaLdGjPG
TZKSrVwokI+xeGAP1n9SyKbh8qXNwA==
=TRwN
-----END PGP SIGNATURE-----

--McpcKDxJRrEJVmOH--


