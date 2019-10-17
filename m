Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C61ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4462089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4462089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7ue-0001kM-IZ
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iL79B-00086I-OG
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iL799-0001O5-KL
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:53:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iL793-0001KW-7M; Thu, 17 Oct 2019 10:52:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C54B307D985;
 Thu, 17 Oct 2019 14:52:52 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E11CE600C4;
 Thu, 17 Oct 2019 14:52:51 +0000 (UTC)
Subject: Re: [PATCH v2 01/23] iotests: Introduce $SOCK_DIR
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191017133155.5327-1-mreitz@redhat.com>
 <20191017133155.5327-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b8251992-a52b-f605-e45e-edf381394130@redhat.com>
Date: Thu, 17 Oct 2019 09:52:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191017133155.5327-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 17 Oct 2019 14:52:52 +0000 (UTC)
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 8:31 AM, Max Reitz wrote:
> Unix sockets generally have a maximum path length.  Depending on your
> $TEST_DIR, it may be exceeded and then all tests that create and use
> Unix sockets there may fail.
> 
> Circumvent this by adding a new scratch directory specifically for
> Unix socket files.  It defaults to a temporary directory (mktemp -d)
> that is completely removed after the iotests are done.
> 
> (By default, mktemp -d creates a /tmp/tmp.XXXXXXXXXX directory, which
> should be short enough for our use cases.)
> 
> Use mkdir -p to create the directory (because it seems right), and do
> the same for $TEST_DIR (because there is no reason for that to be
> created in any different way).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/check | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)

> @@ -116,10 +117,14 @@ set_prog_path()
>   if [ -z "$TEST_DIR" ]; then
>           TEST_DIR=$PWD/scratch
>   fi
> +mkdir -p "$TEST_DIR" || _init_error 'Failed to create TEST_DIR'

This one seems fine. We are either using the user's name (and if it is 
pre-existing, not fail) or using a well-known name (if someone else 
slams in files into that directory in parallel with our test run, oh 
well).  But at least the well-known name is a directory that is probably 
already accessible only to the current user, not world-writable.

>   
> -if [ ! -e "$TEST_DIR" ]; then
> -        mkdir "$TEST_DIR"
> +tmp_sock_dir=false
> +if [ -z "$SOCK_DIR" ]; then
> +    SOCK_DIR=$(mktemp -d)
> +    tmp_sock_dir=true
>   fi
> +mkdir -p "$SOCK_DIR" || _init_error 'Failed to create SOCK_DIR'

Thinking about this again: if the user passed in a name, we probably 
want to use it no matter whether the directory already exists (mkdir -p 
makes sense: either the directory did not exist, or the user is in 
charge of passing us a directory that they already secured).  But if we 
generate our own name in a world-writable location in /tmp, using mkdir 
-p means someone else can race us to the creation of the directory, and 
potentially populate it in a way to cause us a security hole while we 
execute our tests.

I would be a bit more comfortable with:

tmp_sock_dir=false
tmp_sock_opt=-p
if [ -z "$SOCK_DIR" ]; then
     SOCK_DIR=$(mktemp -d)
     tmp_sock_dir=true
     tmp_sock_opt=      # disable -p for our generated name
fi
mkdir $tmp_sock_opt "$SOCK_DIR" || _init_error 'Failed to create SOCK_DIR'

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

