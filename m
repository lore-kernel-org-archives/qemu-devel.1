Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2A6C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3263020675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vz18Ys64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3263020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVtBZ-0003gx-CC
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 04:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jVtAi-0003AU-2o
 for qemu-devel@nongnu.org; Tue, 05 May 2020 04:43:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49589
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jVtAh-0008D2-8X
 for qemu-devel@nongnu.org; Tue, 05 May 2020 04:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588668202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUnxUnogNznM7VYV4Db5b/OxVJf17/kLaamaZWjC8jg=;
 b=Vz18Ys648X382drtIdmDWKhpmq4+VVxLcooV0lsbL9x9eiEygw6cTALmWbIMmaiOzU6zrM
 sGmMw4KrdiZnUrM1ZKbpTabcS+cJclpdYrjk/DZ2mgfEaOzuOc6RHxOpf6cKKfNB51SSaj
 4wZ/+Ns+Ph/5/xtpL/Bjx6CcW4rdq7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-MsxAbxV9OteqYr9ttSPseg-1; Tue, 05 May 2020 04:43:18 -0400
X-MC-Unique: MsxAbxV9OteqYr9ttSPseg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741F1872FEA;
 Tue,  5 May 2020 08:43:17 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C16D310016EB;
 Tue,  5 May 2020 08:43:12 +0000 (UTC)
Date: Tue, 5 May 2020 10:43:10 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v5 7/7] qemu-img: Deprecate use of -b without -F
Message-ID: <20200505084310.GA2232710@angien.pipo.sk>
References: <20200403175859.863248-1-eblake@redhat.com>
 <20200403175859.863248-8-eblake@redhat.com>
 <20200505081103.GC5759@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200505081103.GC5759@linux.fritz.box>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
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
Cc: qemu-block@nongnu.org, kchamart@redhat.com, libvir-list@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 05, 2020 at 10:11:03 +0200, Kevin Wolf wrote:
> Am 03.04.2020 um 19:58 hat Eric Blake geschrieben:
> > Creating an image that requires format probing of the backing image is
> > inherently unsafe (we've had several CVEs over the years based on
> > probes leaking information to the guest on a subsequent boot, although
> > these days tools like libvirt are aware of the issue enough to prevent
> > the worst effects).  However, if our probing algorithm ever changes,
> > or if other tools like libvirt determine a different probe result than
> > we do, then subsequent use of that backing file under a different
> > format will present corrupted data to the guest.  Start a deprecation
> > clock so that future qemu-img can refuse to create unsafe backing
> > chains that would rely on probing.  Most warnings are intentionally
> > emitted from bdrv_img_create() in the block layer, but qemu-img
> > convert uses bdrv_create() which cannot emit its own warning without
> > causing spurious warnings on other code paths.  In the end, all
> > command-line image creation or backing file rewriting now performs a
> > check.
> >=20
> > However, there is one time where probing is safe: if we probe raw,
> > then it is safe to record that implicitly in the image (but we still
> > warn, as it's better to teach the user to supply -F always than to
> > make them guess when it is safe).
>=20
> You're not stating it explicitly, but I guess the thing that you mean
> that is actually unsafe is if you have a raw image, always pass
> format=3Draw to QEMU (so the guest could write e.g. a qcow2 header), but
> then create a backing file without -F, so it will be probed. This is as
> bad as specifying format=3Draw only sometimes.
>=20
> I don't like the idea of responding to this by making raw images more
> convenient to use than actual image formats.
>=20
> How about we approach it the other way around: The troublemaker is raw,
> so let's require specifying raw explicitly, and record the probed format
> implicitly in other cases. This is a bit weaker in the immediate effect
> in that it doesn't protect you when you actually deal with a malicious
> image, but in normal use it will point out where your scripts or
> management software is too careless. The final result should be that
> management tools are fixed and you'll be safe, while manual users who
> can usually trust their guests aren't inconvenienced too much.

That is definitely better than just probing. In my opinion though the
format should always be specified explicitly. No favorism of 'raw' or
any other format. In libvirt we fill-in that the format of the image is
'raw' unless the user specifies something else rather than reporting an
error. This causes continuous grief for users who forget to set the
format. (one example is that if you create a fully-allocated qcow2 image
but use it as raw and install your VM, you'll never notice until you
want to use qcow2 features. Users usually notice once they try to create
a sparse image though due to the size difference)


