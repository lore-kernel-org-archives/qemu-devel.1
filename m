Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A4FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 09:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D2FC214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 09:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJ+jsB0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2FC214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieyNu-0007uk-Md
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 04:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1ieyN5-0007Oq-5o
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 04:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1ieyN3-0005q2-VM
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 04:33:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32459
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1ieyN3-0005mx-P4
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 04:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576056804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zvhr2UY3EN+rj+DXia9AKEtkdQC8DNC/UHTMClkTKg=;
 b=PJ+jsB0jO8D7R2pvWQOR0wN3mvxs2AljGjUzuGXknS8HBAmLwrGEOlhcGTkEUgPYSbk2nm
 4StdxXhMFt/MJk+GmxxY/q9tOfxOJFssXUcKCOSHlr1BH5R3wQKWieNNoUr1ecE58Je54V
 KngAdbgWISrdyUNpjdbc3B2/5m8NH3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-FmznTT3IOUexStZEl6RT4A-1; Wed, 11 Dec 2019 04:33:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A41F7801E74;
 Wed, 11 Dec 2019 09:33:21 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5303C60567;
 Wed, 11 Dec 2019 09:33:20 +0000 (UTC)
Date: Wed, 11 Dec 2019 10:33:17 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Insufficiently documented deprecated command arguments
Message-ID: <20191211093317.GB2441258@angien.pipo.sk>
References: <87tv67wa9y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87tv67wa9y.fsf@dusky.pond.sub.org>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: FmznTT3IOUexStZEl6RT4A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 11, 2019 at 09:12:41 +0100, Markus Armbruster wrote:
> I went through the QAPI schema looking for deprecated stuff not
> mentioned in qemu-deprecated.texi.  Here's what I found:
>=20
>     Commit b33945cfff "block: Accept device model name for
>     blockdev-open/close-tray" (v2.8.0) deprecated blockdev-open-tray,
>     blockdev-close-tray argument @device.

Libvirt uses these commands only in 'blockdev' mode. We use the qom
name/path [1] as the value for @id field. We never used @device.

>     Commit 70e2cb3bd7 "block: Accept device model name for
>     blockdev-change-medium" (v2.8.0) deprecated blockdev-change-medium
>     argument @device.

Same as above.

>     Commit 7a9877a026 "block: Accept device model name for
>     block_set_io_throttle" (v2.8.0) deprecated block_set_io_throttle
>     argument @device.

This one is more complex. The command is used both in 'blockdev' and in
'drive' mode:

In 'drive' mode we pass the alias of the 'drive' as the @device
argument.

In 'blockdev' mode we pass the qom name as @id

>     Commit c01c214b69 "block: remove all encryption handling APIs"
>     (v2.10.0) deprecated query-named-block-nodes result field
>     encryption_key_missing and query-block result field
>     inserted.encryption_key_missing.

We don't extract or use the 'encryption_key_missing' at all.


>     Commit c42e8742f5 "block: Use JSON null instead of "" to disable
>     backing file" (v2.10.0) deprecated blockdev-add empty string
>     argument @backing.

This is used in 'blockdev' mode only and we always pass the JSON null or
a node name string.

>     These were missed in commit eb22aeca65 "docs: document deprecation
>     policy & deprecated features in appendix" (v2.10.0).
>=20
>     Commit 3c605f4074 "commit: Add top-node/base-node options" (v3.1.0)
>     deprecated block-commit arguments @base and @top.

This command also has two modes:

In 'drive' mode we pass in path strings as @base and @ top.

In 'blockdev' mode we pass in nodenames as @base-node and @top-node.

Starting from qemu-4.2 libvirt uses 'blockdev' mode for VMs unless an SD
card is configured as we didn't convert to the '-device' approach for
those as AFAIK not everything is possible to be converted.

> I can update qemu-deprecated.texi for these.
>=20
> Now my question: I wonder whether we want to remove any of them right
> away.

Feel free to delete any unused ones. I'm afraid that -drive mode will
need to be supported for a while until we can convert the sd-cards too.


[1]: The qom name used by libvirt is generated is generated here:

https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dblob;f=3Dsrc/qemu/qemu_alias.c=
;h=3D93bdcb7548757de547b2ccb01d0a2af16d5a7cc6;hb=3DHEAD#l224


