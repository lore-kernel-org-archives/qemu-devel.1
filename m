Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93FFC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A69221EB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFjaX+MX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A69221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL5NM-0007Np-Sg
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 10:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL5MT-0006vG-B4
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 10:03:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL5MP-00010w-T0
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 10:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600869783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aHdfTwytP6nc6Z+YZfPEmWVuegUsBYowfPYYZP5hdDw=;
 b=ZFjaX+MXwQ0sHEZMXuA1W2dUnPfz8DRdok2EW71gp6ce9KKbZ5CYbnw/fpZehdN/7v5nvv
 hkdmyT9bkTpmwTmXvVRb64MEpt2KhZOsU1rGIDgf1fBNVPUENjEs5mYHr7R+0/E3jJNHtF
 iDfN9saTcwf6UXIxwxpXguv34nEwwc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-NslpL85kNBKoHRIVmRxIUg-1; Wed, 23 Sep 2020 10:02:59 -0400
X-MC-Unique: NslpL85kNBKoHRIVmRxIUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D21F1007475;
 Wed, 23 Sep 2020 14:02:57 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBAA675120;
 Wed, 23 Sep 2020 14:02:47 +0000 (UTC)
Date: Wed, 23 Sep 2020 15:02:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v9 07/20] multi-process: define transmission functions in
 remote
Message-ID: <20200923140246.GB62770@stefanha-x1.localdomain>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
 <20200827181231.22778-8-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200827181231.22778-8-elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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

--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 27, 2020 at 11:12:18AM -0700, elena.ufimtseva@oracle.com wrote:
> TODO: Avoid the aio_poll by entering the co-routines
> from the higher level to avoid aio_poll.

The monitor is unresponsive during the aio_poll() loop. Is this a
blocker for you?

Running all mpqemu communication in a coroutine as mentioned in this
TODO is a cleaner solution. Then this patch will be unnecessary.

> +static void coroutine_fn mpqemu_msg_send_co(void *data)
> +{
> +    MPQemuRequest *req = (MPQemuRequest *)data;
> +    Error *local_err = NULL;
> +
> +    mpqemu_msg_send(req->msg, req->ioc, &local_err);
> +    if (local_err) {
> +        error_report("ERROR: failed to send command to remote %d, ",
> +                     req->msg->cmd);
> +        req->finished = true;
> +        req->error = -EINVAL;
> +        return;

local_err is leaked.

> +    }
> +
> +    req->finished = true;
> +}
> +
> +void mpqemu_msg_send_in_co(MPQemuRequest *req, QIOChannel *ioc,
> +                                  Error **errp)
> +{
> +    Coroutine *co;
> +
> +    if (!req->ioc) {
> +        if (errp) {
> +            error_setg(errp, "Channel is set to NULL");
> +        } else {
> +            error_report("Channel is set to NULL");
> +        }

The caller should provide an errp if they are interested in the error
message. Duplicating error messages is messy.

> +static void coroutine_fn mpqemu_msg_recv_co(void *data)
> +{
> +    MPQemuRequest *req = (MPQemuRequest *)data;
> +    Error *local_err = NULL;
> +
> +    mpqemu_msg_recv(req->msg, req->ioc, &local_err);
> +    if (local_err) {
> +        error_report("ERROR: failed to send command to remote %d, ",
> +                     req->msg->cmd);
> +        req->finished = true;
> +        req->error = -EINVAL;
> +        return;

local_err is leaked.

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rVYYACgkQnKSrs4Gr
c8i9kggAtu1A+1ZzpZQJ1UI5T5JC7a8gpuVF8I+Gcycs3yazxFehpBlxXbCLMGaA
HAmMo5UOdvvgQhRenwn/dBiXT8TmQ+UrIt2Whq4SqG/5hBSaco8Ks0PRv6cAFeIw
Q+D4gWrZ3aKB4lDeV/y5hJBCl4lIgJnFfQCN8y+fAlGj+ZZWBeTmTp55LfatAwxn
Drl4V7cRZqdlLtH6STY8StsA44fumu27jIs8m87V0aW7kEaDqarjSTXJxuKhGboP
SKRnHDLSfM3mY2IJ1aN1uBFmQdNMdfRf2zWoavW5khUKW2eGMAdQ/Gc8FTZEQFoC
IwXRMlD1PC/KyjfHmCHjdu+LBKbtbw==
=M+mF
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--


