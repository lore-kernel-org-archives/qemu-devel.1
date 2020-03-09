Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B23C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA2F208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcmhozFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA2F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKu1-0007w7-OQ
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jBKfW-0001Ul-6Q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:50:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jBKfU-0004mw-Ou
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:50:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59034
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jBKfU-0004mh-KI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583769012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vvvQ/1gvSSy3w9iEGsDplJQWxDpJfkvOXWkqxfR7ks8=;
 b=hcmhozFOShYCRXirkmm4npIpaW9enyaF66RYDA3vADfxNeGOndHePxWL641aUZujfni9nI
 7RBm3j1zgUY0ECaKb5r3kKzoNQvROOU640G+KIAbSgRgvUpRyP0vY5cOmsqKIz2BeLNZmv
 UIRZZTTdIpWWviioYR07xdUwVAoiqu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253--u-dNmUzPjGYkZ28cFuQjg-1; Mon, 09 Mar 2020 11:50:08 -0400
X-MC-Unique: -u-dNmUzPjGYkZ28cFuQjg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA37780256C;
 Mon,  9 Mar 2020 15:50:06 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DDBF5272D1;
 Mon,  9 Mar 2020 15:50:02 +0000 (UTC)
Subject: Re: [PATCH v3 1/4] block: Add trivial backing_fmt support to qcow,
 sheepdog, vmdk
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-2-eblake@redhat.com>
 <20200309152112.GC6478@linux.fritz.box> <20200309153624.GK3033513@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <04b776d3-8c35-d00a-5ff0-d55b76cf4969@redhat.com>
Date: Mon, 9 Mar 2020 10:50:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309153624.GK3033513@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, pkrempa@redhat.com,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 libvir-list@redhat.com, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, mreitz@redhat.com,
 "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Liu Yuan <namei.unix@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 10:36 AM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Mar 09, 2020 at 04:21:12PM +0100, Kevin Wolf wrote:
>> Am 06.03.2020 um 23:51 hat Eric Blake geschrieben:
>>> For qcow2 and qed, we want to encourage the use of -F always, as these
>>> formats can suffer from data corruption or security holes if backing
>>> format is probed.  But for other formats, the backing format cannot be
>>> recorded.  Making the user decide on a per-format basis whether to
>>> supply a backing format string is awkward, better is to just blindly
>>> accept a backing format argument even if it is ignored by the
>>> contraints of the format at hand.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> I'm not sure if I agree with this reasoning. Accepting and silently
>> ignoring -F could give users a false sense of security. If I specify a
>> -F raw and QEMU later probes qcow2, that would be very surprising.
>=20
> And if the user specifies "-F raw" and we probe qcow2, and the user
> does not realize this, they can become silently reliant on always
> probing qcow2. If we then honour the "-F raw" option in a later
> QEMU release, we'll break the behaviour they've relied on.
>=20
> IMHO, we must not accept "-F fmt" unless we're in a position to
> honour it.

So I'm thinking:

qemu-img create -f qcow -b backing.qcow -F qcow img.qcow   =3D> okay

qemu-img create -f qcow -b backing.raw -F raw img.qcow   =3D> okay,=20
slightly risky (if backing.raw is ever changed to be non-raw), but then=20
again, backing files tend to be read-only (do we even support commit on=20
qcow images, or do we limit that to qcow2?)

qemu-img create -f qcow -b backing.qcow -F raw img.qcow   =3D> fails, due=
=20
to mismatch

qemu-img create -u -f qcow -b anything -F anything img.qcow $size  =3D>=20
fails: we can't write -F into the image, nor can we open anything to=20
probe its type to check that -F was correct

qemu-img create -f qcow -b backing.qcow img.qcow   =3D> warns, but okay=20
(we did not get -F, but the probe works out)

qemu-img create -f qcow -b backing.raw img.qcow    =3D> likewise warns

qemu-img create -f qcow -b backing.qcow2 img.qcow   =3D> error; new qcow=20
images (which you should avoid where possible anyways) must be backed by=20
only raw or qcow, going forward

Other scenarios?  Do the above ideas look reasonable?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


