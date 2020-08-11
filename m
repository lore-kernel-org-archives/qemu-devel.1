Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2020BC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E433420774
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+qrA6bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E433420774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5WpQ-0000OS-7t
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 12:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k5WnX-0006rU-8Q
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:06:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34870
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k5WnV-0006nc-Js
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597162004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d0sjJws5v+8djRTVBR129UfCP51zE3dPqIX8S0HEne4=;
 b=g+qrA6bw6GqVTmsGDBGd+tVAuQCWDRMYX2yovroVXrwFGzgPr9yWkGGJydvWy0jsi6aAwd
 TcxwkuOopXu5KsrvziwpjGvle/B36y/JmtYUdkPzxzsHgKA6D2B310o5RkwBteVUUoEx7H
 a/kzlYViTKPlbd5c2nR/GRCX6QococA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Qp5ZDHsvMoOi-pNDWTlr_Q-1; Tue, 11 Aug 2020 12:06:42 -0400
X-MC-Unique: Qp5ZDHsvMoOi-pNDWTlr_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6E00106B242;
 Tue, 11 Aug 2020 16:06:41 +0000 (UTC)
Received: from gondolin (ovpn-113-33.ams2.redhat.com [10.36.113.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 072985D9D7;
 Tue, 11 Aug 2020 16:06:40 +0000 (UTC)
Date: Tue, 11 Aug 2020 18:06:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2] CODING_STYLE.rst: flesh out our naming conventions.
Message-ID: <20200811180638.7323b2bd.cohuck@redhat.com>
In-Reply-To: <3dfae8bc-7f8d-1b1c-c805-5eab4e8fbb19@redhat.com>
References: <20200810105147.10670-1-alex.bennee@linaro.org>
 <3dfae8bc-7f8d-1b1c-c805-5eab4e8fbb19@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 06:40:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Aug 2020 17:55:08 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Alex,
>=20
> On 8/10/20 12:51 PM, Alex Benn=C3=A9e wrote:
> > Mention a few of the more common naming conventions we follow in the
> > code base including common variable names and function prefix and
> > suffix examples.
> >=20
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >=20
> > --- =20
> ...
> > +Function Naming Conventions
> > +---------------------------
> > +
> > +The ``qemu_`` prefix is used for utility functions that are widely
> > +called from across the code-base. This includes wrapped versions of
> > +standard library functions (e.g. qemu_strtol) where the prefix is
> > +added to the function name to alert readers that they are seeing a
> > +wrapped version; otherwise avoid this prefix.
> > +
> > +If there are two versions of a function to be called with or without a
> > +lock held, the function that expects the lock to be already held
> > +usually uses the suffix ``_locked``. =20
>=20
> And if there is only one version? I'm looking at:
>=20
>   /* With q->lock */
>   static void nvme_kick(NVMeQueuePair *q)
>   {
>   ...
>   }
>=20
> Should the style be enforced here and this function renamed
> nvme_kick_locked()?
>=20
> In this particular case, I think so, because we also have:
>=20
>   /* With q->lock */
>   static void nvme_put_free_req_locked(...)
>   {
>   ...
>   }
>=20
>   /* With q->lock */
>   static void nvme_wake_free_req_locked(NVMeQueuePair *q)
>   {
>   ...
>   }
>=20
> For more cases:
>=20
> $ git grep -A1 -i '\/\*.*with.*lock'
>=20
>=20

I'm not sure we really want to encode calling conventions into function
names, beyond being able to distinguish between lock/no-lock versions.
Just appending _locked does not really tell us *which* lock is supposed
to be held, that needs to be documented in a comment anyway.


