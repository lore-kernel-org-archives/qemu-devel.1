Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C2EC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3CCB2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIQKUnDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CCB2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCoyR-0001wj-Qa
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCoxQ-0001TZ-1N
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCoxO-0001lA-LY
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:22:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27836
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCoxO-0001kL-H8
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584123769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5pc1o0CYSnkcwssMQCSspofANKey0GbbhNPo8ipDNc=;
 b=WIQKUnDFJ0STG9M9kVQJH4BWJEkb2nK/Y6NdGgRIsdcWknEcEHSQZHremwUjwlBQTbTWJX
 UoUflCEzPvHn7hwv5REp3Ogt9q4ddDF0XkMrKoznOT+6NcMEyaE6tFfWJRJEa9DJBRJoUL
 /yWsmnXqtGaJNUFCxXjaeKijLCyRp3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-peoWszRbOG6Bf0xYD_6o1A-1; Fri, 13 Mar 2020 14:22:48 -0400
X-MC-Unique: peoWszRbOG6Bf0xYD_6o1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 200EA190A7A3;
 Fri, 13 Mar 2020 18:22:47 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B076E5C1B5;
 Fri, 13 Mar 2020 18:22:43 +0000 (UTC)
Subject: Re: [PATCH v4 7/7] qemu-img: Deprecate use of -b without -F
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200312192822.3739399-1-eblake@redhat.com>
 <20200312192822.3739399-8-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7a5735a8-0003-150a-a332-635a7349f767@redhat.com>
Date: Fri, 13 Mar 2020 13:22:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312192822.3739399-8-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 kchamart@redhat.com, libvir-list@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 2:28 PM, Eric Blake wrote:
> Creating an image that requires format probing of the backing image is
> inherently unsafe (we've had several CVEs over the years based on
> probes leaking information to the guest on a subsequent boot, although
> these days tools like libvirt are aware of the issue enough to prevent
> the worst effects).  However, if our probing algorithm ever changes,
> or if other tools like libvirt determine a different probe result than
> we do, then subsequent use of that backing file under a different
> format will present corrupted data to the guest.  Start a deprecation
> clock so that future qemu-img can refuse to create unsafe backing
> chains that would rely on probing.  The warnings are intentionally
> emitted from the block layer rather than qemu-img (thus, all paths
> into image creation or rewriting perform the check).
> 
> However, there is one time where probing is safe: if we probe raw,
> then it is safe to record that implicitly in the image (but we still
> warn, as it's better to teach the user to supply -F always than to
> make them guess when it is safe).
> 
> iotest 114 specifically wants to create an unsafe image for later
> amendment rather than defaulting to our new default of recording a
> probed format, so it needs an update.  While touching it, expand it to
> cover all of the various warnings enabled by this patch.  iotest 290
> also shows a change to qcow messages; note that the fact that we now
> make a probed format of 'raw' explicit now results in a double
> warning, but no one should be creating new qcow images so it is not
> worth cleaning up.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   docs/system/deprecated.rst | 19 +++++++++++++++++++

Squash this in per Kashyap's v3 review comments:

diff --git i/docs/system/deprecated.rst w/docs/system/deprecated.rst
index b541d52c7dc0..54a50c45e190 100644
--- i/docs/system/deprecated.rst
+++ w/docs/system/deprecated.rst
@@ -388,18 +388,19 @@ qemu-img backing file without format (since 5.0.0)
  The use of ``qemu-img create``, ``qemu-img rebase``, or ``qemu-img
  convert`` to create or modify an image that depends on a backing file
  now recommends that an explicit backing format be provided.  This is
-for safety: if qemu probes a different format than what you thought,
+for safety: if QEMU probes a different format than what you thought,
  the data presented to the guest will be corrupt; similarly, presenting
  a raw image to a guest allows a potential security exploit if a future
-probe sees a non-raw image based on guest writes.  To avoid the
-warning message, or even future refusal to create an unsafe image, you
-must pass ``-o backing_fmt=`` (or the shorthand ``-F`` during create)
-to specify the intended backing format.  You may use ``qemu-img rebase
--u`` to retroactively add a backing format to an existing image.
-However, be aware that there are already potential security risks to
-blindly using ``qemu-img info`` to probe the format of an untrusted
-backing image, when deciding what format to add into an existing
-image.
+probe sees a non-raw image based on guest writes.
+
+To avoid the warning message, or even future refusal to create an
+unsafe image, you must pass ``-o backing_fmt=`` (or the shorthand
+``-F`` during create) to specify the intended backing format.  You may
+use ``qemu-img rebase -u`` to retroactively add a backing format to an
+existing image.  However, be aware that there are already potential
+security risks to blindly using ``qemu-img info`` to probe the format
+of an untrusted backing image, when deciding what format to add into
+an existing image.

  ``qemu-img convert -n -o`` (since 4.2.0)
  ''''''''''''''''''''''''''''''''''''''''

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


