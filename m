Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AF4C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BA02054F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPV6SPPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BA02054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5T8-0007ZP-6D
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1if5MT-0001gt-4R
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1if5MR-0004zz-M3
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:01:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1if5MR-0004yu-H7
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576083675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jGH2WxoQ5eUGnr8ZWjZsY/+FUNqTYhp5iCq8fgcFwPY=;
 b=FPV6SPPqJKmt7IOiCCta55mczG30l92VZ4rFGG3msVxUXvgmETERBJk5rVa1CM5W64lqix
 ZRstmrsWUhFuoIh3wcreKxtQZWhFQvgq9tPI/I+/XM+Z+Gtg26A/nTfAjJlITDVlubxvzO
 AgUFJNOoAeUmTNQHMDaXNPO5dUtRo8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388--0pb-_NIOlCO4Vn37QV3Og-1; Wed, 11 Dec 2019 12:01:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A2A8800D5A;
 Wed, 11 Dec 2019 17:01:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-181.ams2.redhat.com
 [10.36.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4774C1001938;
 Wed, 11 Dec 2019 17:01:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8EA8D11386A7; Wed, 11 Dec 2019 18:01:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] object: Improve documentation of interfaces
References: <157607116183.174911.9764813135617350231.stgit@bahia.lan>
Date: Wed, 11 Dec 2019 18:01:03 +0100
In-Reply-To: <157607116183.174911.9764813135617350231.stgit@bahia.lan> (Greg
 Kurz's message of "Wed, 11 Dec 2019 14:32:41 +0100")
Message-ID: <875zimu78w.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: -0pb-_NIOlCO4Vn37QV3Og-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz <groug@kaod.org> writes:

> QOM interfaces allow a limited form of multiple inheritance, at the
> condition of being stateless. That is, they cannot be instantiated
> and a pointer to an interface shouldn't be dereferenceable in any way.
> This is achieved by making the QOM instance type an incomplete type,
> which is, as mentioned by Markus Armbruster, the closest you can get
> to abstract class in C.
>
> Incomplete types are widely used to hide implementation details, but
> people usually expect to find at least one place where the type is
> fully defined. The fact that it doesn't happen with QOM interfaces is
> quite disturbing, especially since it isn't documented anywhere as
> recently discussed in this thread:
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg01579.html
>
> Amend the documentation in the object.h header file to provide more
> details about why and how to implement QOM interfaces using incomplete
> types.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  include/qom/object.h |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 128d00c77fd6..5cf98d2c4350 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -200,8 +200,14 @@ typedef struct InterfaceInfo InterfaceInfo;
>   *
>   * Interfaces allow a limited form of multiple inheritance.  Instances a=
re
>   * similar to normal types except for the fact that are only defined by
> - * their classes and never carry any state.  You can dynamically cast an=
 object
> - * to one of its #Interface types and vice versa.
> + * their classes and never carry any state.  As a consequence, a pointer=
 to
> + * an interface instance should always be of incomplete type in order to=
 be
> + * sure it cannot be dereferenced.  That is, you should define the
> + * 'typedef struct SomethingIf SomethingIf' so that you can pass around
> + * 'SomethingIf *si' arguments, but not define a 'struct SomethingIf { .=
.. }'.
> + * The only things you can validly do with a 'SomethingIf *' are to pass=
 it as
> + * an argument to a method on its corresponding SomethingIfClass, or to
> + * dynamically cast it to an object that implements the interface.
>   *
>   * # Methods #
>   *

Reviewed-by: Markus Armbruster <armbru@redhat.com>


