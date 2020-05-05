Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFF8C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A740206CC
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHijol3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A740206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVsgM-0007yU-Ad
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 04:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVsfa-0007QE-VX
 for qemu-devel@nongnu.org; Tue, 05 May 2020 04:11:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39478
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVsfZ-0000pM-5P
 for qemu-devel@nongnu.org; Tue, 05 May 2020 04:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588666271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rsqncIaGWzVkJyHcMMSQAXbPLbuknw6DfQpMtN3C0wg=;
 b=DHijol3JBHdP+npi9t497Kb3rk2wdlNKEo6BAlf8Ykd9eckpoSMPXbQR08kVKWMk7RhKYS
 r+q/iXHhmkk8Y6YswlrSodEmnysmramFzc4MmLbxU4+bCOLtGd0aPjm1pNYBRzY6I4v58C
 RglVgvpRe8WMA4xjKhLN39CDLLARAzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-ZL5lA0QuPy2fzrHwlij2Xg-1; Tue, 05 May 2020 04:11:10 -0400
X-MC-Unique: ZL5lA0QuPy2fzrHwlij2Xg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF8C1107ACCD;
 Tue,  5 May 2020 08:11:08 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C33F05C1B2;
 Tue,  5 May 2020 08:11:04 +0000 (UTC)
Date: Tue, 5 May 2020 10:11:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 7/7] qemu-img: Deprecate use of -b without -F
Message-ID: <20200505081103.GC5759@linux.fritz.box>
References: <20200403175859.863248-1-eblake@redhat.com>
 <20200403175859.863248-8-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200403175859.863248-8-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, kchamart@redhat.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.04.2020 um 19:58 hat Eric Blake geschrieben:
> Creating an image that requires format probing of the backing image is
> inherently unsafe (we've had several CVEs over the years based on
> probes leaking information to the guest on a subsequent boot, although
> these days tools like libvirt are aware of the issue enough to prevent
> the worst effects).  However, if our probing algorithm ever changes,
> or if other tools like libvirt determine a different probe result than
> we do, then subsequent use of that backing file under a different
> format will present corrupted data to the guest.  Start a deprecation
> clock so that future qemu-img can refuse to create unsafe backing
> chains that would rely on probing.  Most warnings are intentionally
> emitted from bdrv_img_create() in the block layer, but qemu-img
> convert uses bdrv_create() which cannot emit its own warning without
> causing spurious warnings on other code paths.  In the end, all
> command-line image creation or backing file rewriting now performs a
> check.
>=20
> However, there is one time where probing is safe: if we probe raw,
> then it is safe to record that implicitly in the image (but we still
> warn, as it's better to teach the user to supply -F always than to
> make them guess when it is safe).

You're not stating it explicitly, but I guess the thing that you mean
that is actually unsafe is if you have a raw image, always pass
format=3Draw to QEMU (so the guest could write e.g. a qcow2 header), but
then create a backing file without -F, so it will be probed. This is as
bad as specifying format=3Draw only sometimes.

I don't like the idea of responding to this by making raw images more
convenient to use than actual image formats.

How about we approach it the other way around: The troublemaker is raw,
so let's require specifying raw explicitly, and record the probed format
implicitly in other cases. This is a bit weaker in the immediate effect
in that it doesn't protect you when you actually deal with a malicious
image, but in normal use it will point out where your scripts or
management software is too careless. The final result should be that
management tools are fixed and you'll be safe, while manual users who
can usually trust their guests aren't inconvenienced too much.

Kevin


