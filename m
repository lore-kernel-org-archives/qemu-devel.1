Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4D4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 18:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087812082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 18:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jP8W741o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087812082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixEOW-0005gl-4K
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 13:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ixENo-0005Fo-L0
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:17:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ixENn-00043Q-IE
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:17:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53046
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ixENl-0003yY-NT
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580408257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V54R5OyIAANKLLFHTdK7oupeo5dz5zy0D9i2dK3v2po=;
 b=jP8W741ol4h0x1GWnQXEcwHMN7xesRzLyOJjozjvPusFggQ+puLfJIeHfQtjZjzn1j+6VX
 CesffOhpSpbr5Lv6e0R/iczvIZLjihJnWI7s5SDlvveb+FizGFX6C2O0Xxk9KBeF/yGspD
 0MRE/UuuT66oxZyWs+NL0AFtrVP1oaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-f9YnQjznOjeD5qSNENlxAg-1; Thu, 30 Jan 2020 13:17:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A766133656D;
 Thu, 30 Jan 2020 18:17:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-40.gru2.redhat.com
 [10.97.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3696987B14;
 Thu, 30 Jan 2020 18:17:24 +0000 (UTC)
Subject: Re: [PATCH 3/6] tests/boot_linux_console: fix extract_from_deb()
 comment
To: Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net, philmd@redhat.com
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-4-git-send-email-liam.merwick@oracle.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <bb024f2d-96ca-a7b4-6f17-42f1ecac6610@redhat.com>
Date: Thu, 30 Jan 2020 16:17:23 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1580142994-1836-4-git-send-email-liam.merwick@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: f9YnQjznOjeD5qSNENlxAg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, slp@redhat.com,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/27/20 2:36 PM, Liam Merwick wrote:
> The second param in extract_from_deb() is 'path' not 'file'
>
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>   tests/acceptance/boot_linux_console.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 8daf6461ffac..43bc928b03a2 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -40,7 +40,7 @@ class BootLinuxConsole(Test):
>           Extracts a file from a deb package into the test workdir
>   
>           :param deb: path to the deb archive
> -        :param file: path within the deb archive of the file to be extracted
> +        :param path: path within the deb archive of the file to be extracted

Well noted!

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

>           :returns: path of the extracted file
>           """
>           cwd = os.getcwd()


