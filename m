Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AACAC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB7C21929
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB7C21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYkr-0006P0-F9
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iIYk5-0005iR-O3
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iIYk4-0007Bk-Ko
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:44:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iIYk2-000759-8j; Thu, 10 Oct 2019 09:44:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C36A3086E23;
 Thu, 10 Oct 2019 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C7B5100EBA5;
 Thu, 10 Oct 2019 13:44:25 +0000 (UTC)
Date: Thu, 10 Oct 2019 15:44:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 02/11] qcrypto-luks: extend the create options for
 upcoming encryption key management
Message-ID: <20191010134423.GC7616@localhost.localdomain>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-3-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912223028.18496-3-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 10 Oct 2019 13:44:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.09.2019 um 00:30 hat Maxim Levitsky geschrieben:
> Now you can specify which slot to put the encryption key to
> Plus add 'active' option which will let  user erase the key secret
> instead of adding it.
> Check that active=true it when creating.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index b2a4cff683..9b83a70634 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -190,6 +190,20 @@
>  #                  Currently defaults to 'sha256'
>  # @hash-alg: the master key hash algorithm
>  #            Currently defaults to 'sha256'
> +#
> +# @active: Should the new secret be added (true) or erased (false)
> +#          (amend only, since 4.2)
> +#
> +# @slot: The slot in which to put/erase the secret
> +#        if not given, will select first free slot for secret addtion
> +#        and erase all matching keyslots for erase. except last one
> +#        (optional, since 4.2)
> +#
> +# @unlock-secret: The secret to use to unlock the image
> +#        If not given, will use the secret that was used
> +#        when opening the image.
> +#        (optional, for amend only, since 4.2)
> +#
>  # @iter-time: number of milliseconds to spend in
>  #             PBKDF passphrase processing. Currently defaults
>  #             to 2000. (since 2.8)

This approach doesn't look right to me. BlockdevCreateOptions should
describe the state of the image after the operation. You're describing
an update instead (and in a way that doesn't allow you to change
everything that you may want to change, so that you need to call the
operation multiple times).

I imagined the syntax of a blockdev-amend QMP command similar to
x-blockdev-reopen: Describe the full set of options that you want to
have in effect after the operation; if you don't want to change some
option, you just specify it again with its old value.

Specifically for luks, this probably means that you have a @slots, which
is a list that contains at least the secret for each slot, or JSON null
for a slot that should be left empty.

With the same approach, you don't have to make 'size' optional in later
patches, you can just require that the current size is re-specified. And
later, blockdev-amend could actually allow changing the size of images
if you provide a different value.

Kevin

